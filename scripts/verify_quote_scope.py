"""Independently check quote identity and signed price deltas against public observations."""
import argparse
from decimal import Decimal
from itertools import product
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "quote-observations.json"
BASIS = ("product", "plan", "currency", "unit", "billing", "tier", "scope")


def as_json(row):
    return json.dumps(dict(row, amount_minor=None if row["amount_minor"] is None
                           else str(row["amount_minor"])), ensure_ascii=True, separators=(",", ":"))


def run_json(command, left, right, ok=True, target=None):
    backend = ["--target", target] if target else []
    result = subprocess.run(
        ["moon", "run", *backend, "cmd/main", "--", command, left, right],
        cwd=ROOT, capture_output=True, encoding="utf-8", timeout=60)
    assert result.returncode == (0 if ok else 2), result.stdout + result.stderr
    if ok:
        return json.loads(result.stdout)
    assert not result.stdout, result.stdout
    return result.stderr


def compare(before, after, ok=True):
    return run_json("compare-observations", as_json(before), as_json(after), ok=ok)


def estimate(rates, usage, ok=True, command="estimate-token-cost", target=None):
    args = [json.dumps(obj, ensure_ascii=True, separators=(",", ":")) for obj in (rates, usage)]
    return run_json(command, *args, ok=ok, target=target)

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


def verify_token_windows(full=False):
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
    precise_rates = []
    for row in cache_rates:
        window = row["window"]
        input_rate, output_rate = window["input"].copy(), window["output"].copy()
        precise_rates.append(dict(
            window=dict(window, input=input_rate, output=output_rate),
            input_rate_minor=input_rate.pop("amount_minor"),
            output_rate_minor=output_rate.pop("amount_minor"),
            cache_hit_rate_minor=row["cache_hit_minor"],
        ))
    assert estimate(precise_rates, workloads, command="estimate-token-cache-precise") == cache

    duplicate_usage = json.dumps(workloads).replace('"requests":', '"requests":"1", "requests":', 1)
    assert "duplicate" in run_json(cache_command, json.dumps(cache_rates), duplicate_usage, ok=False).lower()
    print("PASS GLM-4.7 cache split: CNY 170.40; legacy and precise outputs match exactly")

    if full:
        generated, expected, tiers = [], [], []
        for i, o, cache_mode, requests in product(
                (3, 31999, 32000, 199999), (0, 199, 200, 1024), (0, 1, 2), (1, 1001)):
            hits = i * cache_mode // 2
            generated.append(dict(usage=group(i, o, requests), cached_input_tokens=str(hits)))
            if i >= 32000:
                tier, ri, rc, ro = long_input, 400, 80, 1600
            elif o >= 200:
                tier, ri, rc, ro = long_output, 300, 60, 1400
            else:
                tier, ri, rc, ro = short, 200, 40, 800
            cost = dict(uncached_input=(i - hits) * ri * requests, cache_hit=hits * rc * requests,
                        output=o * ro * requests)
            expected.append(dict(cost, total=sum(cost.values())))
            tiers.append(tier)
        batch = estimate(list(reversed(cache_rates)), generated, command=cache_command)
        assert [line["tier"] for line in batch["lines"]] == tiers
        assert [{key: int(value) for key, value in line["cost"].items()}
                for line in batch["lines"]] == expected
        assert {key: int(value) for key, value in batch["cost"].items()} == {
            key: sum(row[key] for row in expected) for key in expected[0]}
        print(f"PASS {len(generated)} synthetic rate-boundary and cache workloads against integer arithmetic")


def verify_precise_token_rates(check_js=False):
    # OpenAI's rates are per million text tokens. Quotations below use USD cents.
    source = "https://developers.openai.com/api/docs/pricing.md"
    quote = dict(capture="openai-pricing-20261125", observed_on="2026-11-25",
                 source=source, product="OpenAI API", plan="gpt-6-luna",
                 currency="USD", billing="Usage", scope="Batch text")

    def rate(tier, lo, hi, input_minor, cache_minor, output_minor):
        window = dict(min_input_tokens=str(lo), min_output_tokens="0",
                      input=dict(quote, tier=tier, unit="MillionInputTokens"),
                      output=dict(quote, tier=tier, unit="MillionOutputTokens"))
        if hi is not None:
            window["max_input_tokens"] = str(hi)
        return dict(window=window, input_rate_minor=input_minor,
                    cache_hit_rate_minor=cache_minor, output_rate_minor=output_minor)

    # The fixture configures the official 272K boundary as 272,000 tokens.
    short, long = "short-context", "long-context"
    rates = [rate(long, 272001, None, "10", "1", "37.5"),
             rate(short, 0, 272001, "5", "0.5", "25")]
    samples = [(12000, 500, 10001, 101), (272000, 128, 271997, 3),
               (272001, 127, 271999, 1)]
    usage = [dict(usage=group(i, o, count), cached_input_tokens=str(hits))
             for i, o, hits, count in samples]
    command = "estimate-token-cache-precise"
    estimate_result = estimate(rates, usage, command=command)
    if check_js:
        assert estimate(rates, usage, command=command, target="js") == estimate_result
        print("PASS JavaScript and Native structured cost CLI outputs agree exactly")
    assert estimate_result["source"] == source and estimate_result["plan"] == "gpt-6-luna"
    expected = []
    for inputs, output, hits, count in samples:
        prices = ("0.05", "0.005", "0.25") if inputs <= 272000 else ("0.10", "0.01", "0.375")
        priced_tokens = (inputs - hits, hits, output)
        # USD per million tokens becomes millionths of a cent after multiplying by 100.
        expected.append(tuple(Decimal(price) * tokens * count * 100
                              for price, tokens in zip(prices, priced_tokens, strict=True)))
    assert [line["tier"] for line in estimate_result["lines"]] == [short, short, long]

    def breakdown(cost):
        parsed = tuple(Decimal(cost[key]) for key in ("uncached_input", "cache_hit", "output"))
        assert Decimal(cost["total"]) == sum(parsed)
        return parsed

    assert [breakdown(line["cost"]) for line in estimate_result["lines"]] == expected
    assert breakdown(estimate_result["cost"]) == tuple(map(sum, zip(*expected)))
    assert estimate_result["lines"][0]["cost"]["cache_hit"] == "505050.5"
    total_usd = Decimal(estimate_result["cost"]["total"]) / 100_000_000

    quote.update(plan="gpt-5-nano", scope="Standard text")
    nano = rate("flat", 0, None, "5", "0.5", "40")
    million = [dict(usage=group(5000, 0, 200), cached_input_tokens="5000")]
    assert estimate([nano], million, command=command)["cost"]["total"] == "500000"
    one_cached = [dict(usage=group(1, 0, 1), cached_input_tokens="1")]
    for price, total in (("0", "0"), ("0.000001", "0.000001"),
                         ("9223372036854.775807", "9223372036854.775807")):
        assert estimate([dict(nano, cache_hit_rate_minor=price)], one_cached,
                        command=command)["cost"]["total"] == total
    for bad in ("", "-0.5", " 0.5", "0.0000001", "0.5.1", "5.", "5e-1", "9223372036854.775808"):
        assert "rate" in estimate([dict(nano, cache_hit_rate_minor=bad)], one_cached,
                                  ok=False, command=command).lower()
    conflict = dict(nano, window=dict(nano["window"], input=dict(nano["window"]["input"],
                                                               amount_minor="1")))
    assert "amount_minor" in estimate([conflict], one_cached, ok=False, command=command)
    # A nested repeated field used to replace the earlier, materially different rate.
    serialized = json.dumps([nano]).replace('"cache_hit_rate_minor":', '"cache_hit_rate_minor":"0", "cache_hit_rate_minor":', 1)
    assert "duplicate" in run_json(command, serialized, json.dumps(one_cached), ok=False).lower()
    print(f"PASS OpenAI GPT-6 Luna Batch USD {total_usd}; GPT-5 nano Standard "
          "one million cache hits USD 0.005; exact rate and JSON boundaries checked")


def verify_optional_observation_fields(rows):
    # Keep the Tana history and source, then mask optional fields to check the CLI contract.
    case = next(case for case in rows if case["after"]["product"] == "tana-meetings")
    before = as_json(case["before"])
    after = json.loads(as_json(case["after"]))
    fields = ("unit", "billing", "amount_minor")
    masked = dict(after, **dict.fromkeys(fields))
    omitted = {key: value for key, value in after.items() if key not in fields}
    for target in ("native", "js"):
        command = "compare-observations"
        result = run_json(command, before, json.dumps(masked), target=target)
        assert result == run_json(command, before, json.dumps(omitted), target=target)
        assert result["status"] == "evidence-gap" and result.get("delta_minor") is None
        assert set(result["reasons"]) == {"product", *fields}
        required_null = json.dumps(dict(after, product=None))
        run_json(command, before, required_null, ok=False, target=target)
        repeated = json.dumps(masked).replace('"unit": null', '"unit": null, "unit": "Seat"', 1)
        assert "duplicate" in run_json(command, before, repeated, ok=False, target=target).lower()
    print("PASS optional observation nulls match omitted keys on Native and JavaScript")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--quick", action="store_true", help="verify GLM-4.7 windows, cache hits and OpenAI fractional rates")
    args = parser.parse_args()
    if not __debug__:
        parser.error("enable Python assertions (remove -O or PYTHONOPTIMIZE)")
    if args.quick:
        verify_token_windows()
        verify_precise_token_rates()
        return
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
    for source in ("http://example.com", "https:///pricing", "https://?table=1",
                   "https://:443/pricing", "https://example.com/bad path",
                   "https://name@example.com/pricing"):
        assert "source" in compare(dict(base, source=source), right, ok=False), source
    valid_source = "https://example.com:443/pricing?contact=team@example.com#rates"
    assert compare(dict(base, source=valid_source), dict(base, capture="second"))["status"] == "comparable"
    duplicate = as_json(base).replace('"amount_minor":', '"amount_minor":"0","amount_minor":', 1)
    assert "duplicate" in run_json("compare-observations", duplicate, as_json(right), ok=False).lower()
    assert compare(dict(base, capture=right["capture"]), right)["status"] == "evidence-gap"
    first = rows[0]
    after = first["after"]
    reduced = dict(after, amount_minor=after["amount_minor"] - 1)
    assert int(compare(first["before"], reduced)["delta_minor"]) == -1
    monthly = dict(after, billing="Annual")
    assert compare(first["before"], monthly)["reasons"] == ["billing"]
    print(f"PASS {len(rows)} public quote pairs and quote evidence boundaries")
    verify_optional_observation_fields(rows)
    verify_token_cost(rows)
    verify_token_windows(full=True)
    verify_precise_token_rates(check_js=True)


if __name__ == "__main__":
    main()
