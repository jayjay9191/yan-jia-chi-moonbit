"""Independently check quote identity and signed price deltas against public observations."""
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "quote-observations.json"
BASIS = ("product", "plan", "currency", "unit", "billing", "tier", "scope")


def as_json(row):
    return json.dumps(dict(row, amount_minor=None if row["amount_minor"] is None
                           else str(row["amount_minor"])), ensure_ascii=True, separators=(",", ":"))


def compare(before, after, ok=True):
    result = subprocess.run(
        ["moon", "run", "cmd/main", "--", "compare-observations",
         as_json(before), as_json(after)],
        cwd=ROOT, capture_output=True, encoding="utf-8", timeout=60)
    assert result.returncode == (0 if ok else 2), result.stdout + result.stderr
    return json.loads(result.stdout) if ok else result.stderr


def estimate(rates, usage, ok=True, command="estimate-token-cost"):
    args = [json.dumps(obj, ensure_ascii=True, separators=(",", ":")) for obj in (rates, usage)]
    result = subprocess.run(
        ["moon", "run", "cmd/main", "--", command, *args],
        cwd=ROOT, capture_output=True, encoding="utf-8", timeout=60)
    assert result.returncode == (0 if ok else 2), result.stdout + result.stderr
    return json.loads(result.stdout) if ok else result.stderr

def group(inputs, outputs, requests):
    return dict(input_tokens=str(inputs), output_tokens=str(outputs), requests=str(requests))

def verify_token_cost(rows):
    # Reuse the recorded GLM price evidence. 32,000 is the example's
    # configured interpretation of 32K; 31,000 and 33,000 avoid that ambiguity.
    quotes = {(case["after"]["tier"], case["after"]["unit"]): case["after"]
              for case in rows if case["after"]["plan"] == "GLM-5.1"}
    bands = []
    for cutoff, tier in ((32000, "input-length-[32K,infinity)"), (0, "input-length-[0,32K)")):
        bands.append(dict(min_input_tokens=str(cutoff),
                          input=json.loads(as_json(quotes[tier, "MillionInputTokens"])),
                          output=json.loads(as_json(quotes[tier, "MillionOutputTokens"]))))

    workloads = [group(31000, 1000, 1000), group(33000, 1000, 1000)]
    actual = estimate(bands, workloads)
    assert actual["currency"] == "CNY" and actual["plan"] == "GLM-5.1"
    assert actual["source"] == quotes[bands[0]["input"]["tier"], "MillionInputTokens"]["source"]
    expected = (1000 * (31000 * 600 + 1000 * 2400),
                1000 * (33000 * 800 + 1000 * 2800))
    assert [int(row["cost_millionths_minor"]) for row in actual["lines"]] == list(expected)
    assert int(actual["cost_millionths_minor"]) == sum(expected) == 50_200_000_000
    boundary = estimate(bands, [group(31999, 1, 1), group(32000, 1, 1)])
    assert [line["tier"] for line in boundary["lines"]] == [bands[1]["input"]["tier"],
                                                            bands[0]["input"]["tier"]]
    limit = 2**63 - 1
    large = estimate(bands, [group(limit, limit, limit)])
    assert int(large["cost_millionths_minor"]) == limit**2 * (800 + 2800)
    assert "nonnegative" in estimate(bands, [group(-1, 0, 1)], ok=False)
    assert "positive" in estimate(bands, [group(1, 0, 0)], ok=False)
    missing_amount = {key: value for key, value in bands[1]["output"].items()
                      if key != "amount_minor"}
    assert "both input and output" in estimate(
        [dict(bands[1], output=missing_amount)], workloads, ok=False)
    assert "complete capture" in estimate(
        [dict(bands[1], output=dict(bands[1]["output"], observed_on="2026-11-18"))], workloads, ok=False)
    assert estimate(bands, [])["cost_millionths_minor"] == "0"
    print("PASS GLM-5.1 mixed workload CNY 502.00; configured cutoff and large integer costs verified")


def verify_token_windows():
    # Public GLM-4.7 uncached rates observed 2026-11-25. K is configured
    # as decimal here; the three example workloads avoid ambiguous cutoffs.
    source = "https://docs.bigmodel.cn/cn/guide/start/pricing"
    quote = dict(capture="glm-4.7-pricing-20261125", observed_on="2026-11-25",
                 source=source, product="bigmodel-api", plan="GLM-4.7",
                 currency="CNY", billing="Usage", scope="public-standard")
    short, long_output, long_input = "short", "long-output", "long-input"

    def rate(tier, in_min, in_max, out_min, out_max, input_minor, output_minor):
        window = dict(min_input_tokens=str(in_min), max_input_tokens=str(in_max),
                      min_output_tokens=str(out_min),
                      input=dict(quote, unit="MillionInputTokens", tier=tier,
                                 amount_minor=str(input_minor)),
                      output=dict(quote, unit="MillionOutputTokens", tier=tier,
                                  amount_minor=str(output_minor)))
        if out_max is not None:
            window["max_output_tokens"] = str(out_max)
        return window

    rates = [rate(long_output, 0, 32000, 200, None, 300, 1400),
             rate(long_input, 32000, 200000, 0, None, 400, 1600),
             rate(short, 0, 32000, 0, 200, 200, 800)]
    command = "estimate-token-windows"
    cases = [(31000, 100), (31000, 300), (33000, 1000),
             (31999, 199), (31999, 200), (32000, 199), (199999, 300)]

    def independent(inputs, outputs):
        if inputs >= 32000:
            return long_input, inputs * 400 + outputs * 1600
        if outputs >= 200:
            return long_output, inputs * 300 + outputs * 1400
        return short, inputs * 200 + outputs * 800

    for ordering in (rates, list(reversed(rates))):
        result = estimate(ordering, [group(i, o, 1000) for i, o in cases], command=command)
        expected = [independent(i, o) for i, o in cases]
        assert result["source"] == source
        assert [(line["tier"], int(line["cost_millionths_minor"]))
                for line in result["lines"]] == [(tier, 1000 * cost) for tier, cost in expected]
        assert int(result["cost_millionths_minor"]) == 1000 * sum(cost for _, cost in expected)
        assert 1000 * sum(cost for _, cost in expected[:3]) == 30_800_000_000
    assert "overlap" in estimate([dict(rates[0], min_output_tokens="199"), *rates[1:]],
                                 [], ok=False, command=command)
    assert "nonempty" in estimate([dict(rates[2], max_output_tokens="0")],
                                  [], ok=False, command=command)
    assert "no token rate" in estimate(rates, [group(1, 0, 1), group(200000, 1, 1)],
                                       ok=False, command=command)
    print("PASS GLM-4.7 input/output rate card: CNY 308 for the three workload groups; "
          "configured boundaries, reordered windows, overlap and coverage gap verified")


    cache_command = "estimate-token-cache"
    cache_rates = [{"window": row, "cache_hit_minor": str(rate)}
                   for row, rate in zip(rates, (60, 80, 40), strict=True)]
    workloads = [dict(usage=group(i, o, 1000), cached_input_tokens=str(hits))
                 for (i, o), hits in zip(cases[:3], (20000, 0, 33000), strict=True)]
    cache = estimate(cache_rates, workloads, command=cache_command)
    assert cache["source"] == source and cache["capture"] == quote["capture"]
    expected_breakdowns = []
    for (i, o), hits, (in_rate, hit_rate, out_rate) in zip(
            cases[:3], (20000, 0, 33000), ((200, 40, 800), (300, 60, 1400), (400, 80, 1600)),
            strict=True):
        undisc = (i - hits) * in_rate * 1000
        hit = hits * hit_rate * 1000
        output = o * out_rate * 1000
        expected_breakdowns.append(dict(uncached_input=undisc, cache_hit=hit, output=output,
                                        total=undisc + hit + output))
    actual = [{key: int(value) for key, value in line["cost"].items()} for line in cache["lines"]]
    assert actual == expected_breakdowns
    assert [line["tier"] for line in cache["lines"]] == [short, long_output, long_input]
    assert {key: int(value) for key, value in cache["cost"].items()} == {
        key: sum(cost[key] for cost in expected_breakdowns) for key in expected_breakdowns[0]}
    assert int(cache["cost"]["total"]) == 17_040_000_000
    zero_hits = [dict(row, cached_input_tokens="0") for row in workloads]
    assert int(estimate(cache_rates, zero_hits, command=cache_command)["cost"]["total"]) == 30_800_000_000
    assert "cache-hit rate" in estimate([dict(cache_rates[0], cache_hit_minor="-1")],
                                        [], ok=False, command=cache_command)
    assert "cached input" in estimate(cache_rates, [dict(workloads[0], cached_input_tokens="31001")],
                                      ok=False, command=cache_command)
    max_i64 = 2**63 - 1
    unlimited = {key: value for key, value in rates[1].items() if key != "max_input_tokens"}
    enormous = estimate([dict(window=unlimited, cache_hit_minor="80")],
                        [dict(usage=group(max_i64, max_i64, max_i64), cached_input_tokens=str(max_i64))],
                        command=cache_command)
    assert int(enormous["cost"]["cache_hit"]) == max_i64**2 * 80
    assert int(enormous["cost"]["output"]) == max_i64**2 * 1600
    assert int(enormous["cost"]["total"]) == max_i64**2 * 1680
    print("PASS GLM-4.7 cache split: CNY 170.40; all-hit, zero-hit, mixed and overflow-of-input checked")


def main():
    rows = json.loads(DATA.read_bytes())
    for case in rows:
        before, after = case["before"], case["after"]
        missing = [name for name in BASIS
                   if not before.get(name) or not after.get(name)]
        if before["amount_minor"] is None or after["amount_minor"] is None:
            missing.append("amount_minor")
        mismatch = [name for name in BASIS if before.get(name) != after.get(name)]
        verdict = "evidence-gap" if missing else "scope-mismatch" if mismatch else "comparable"
        assert verdict == case["expected"], case["label"]
        output = compare(before, after)
        assert output["status"] == verdict, (case["label"], output)
        print(f"{case['label']}: {verdict}")
        delta = output.get("delta_minor")
        if verdict == "comparable":
            assert int(delta) == after["amount_minor"] - before["amount_minor"]
        else:
            assert delta is None and output["reasons"], output
    base = rows[-1]["before"]
    right = rows[-1]["after"]
    assert "currency" in compare(dict(base, currency="US"), right, ok=False)
    assert "amount" in compare(dict(base, amount_minor=-1), right, ok=False)
    assert "date" in compare(dict(base, observed_on="2026-02-30"), right, ok=False)
    assert "source" in compare(dict(base, source="http://example.com"), right, ok=False)
    assert compare(dict(base, capture=right["capture"]), right)["status"] == "evidence-gap"
    first = rows[0]
    after = first["after"]
    reduced = dict(after, amount_minor=after["amount_minor"] - 1)
    assert int(compare(first["before"], reduced)["delta_minor"]) == -1
    monthly = dict(after, billing="Annual")
    assert compare(first["before"], monthly)["reasons"] == ["billing"]
    print(f"PASS {len(rows)} public quote pairs and seven validation boundaries")
    verify_token_cost(rows)
    verify_token_windows()


if __name__ == "__main__":
    main()
