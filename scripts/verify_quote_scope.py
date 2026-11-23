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


if __name__ == "__main__":
    main()
