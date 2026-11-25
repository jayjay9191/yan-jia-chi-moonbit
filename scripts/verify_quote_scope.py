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

    def estimate(rates, usage, ok=True):
        args = [json.dumps(obj, ensure_ascii=True, separators=(",", ":")) for obj in (rates, usage)]
        result = subprocess.run(
            ["moon", "run", "cmd/main", "--", "estimate-token-cost", *args],
            cwd=ROOT, capture_output=True, encoding="utf-8", timeout=60)
        assert result.returncode == (0 if ok else 2), result.stdout + result.stderr
        return json.loads(result.stdout) if ok else result.stderr

    def group(inputs, outputs, requests):
        return dict(input_tokens=str(inputs), output_tokens=str(outputs), requests=str(requests))

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


if __name__ == "__main__":
    main()
