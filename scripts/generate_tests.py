#!/usr/bin/env python3
"""从 data/pricing.json 生成 pricing_generated_test.mbt。

每条工具一行断言：核验状态、货币、可达性、计费周期归类。
断言来自 JSON（唯一事实源），不是手抄的数字——JSON 一变，
重新生成，测试跟着变；手抄的期望值反而会悄悄过期。

跑法（项目根目录）：
    python3 scripts/generate_tests.py
然后跑 moon fmt && moon test。
"""

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
JSON_PATH = ROOT / "data" / "pricing.json"
OUT_PATH = ROOT / "pricing_generated_test.mbt"

HEADER = """///|
/// 由 scripts/generate_tests.py 从 data/pricing.json 生成，不要手改。
/// 每个工具一条测试：状态、货币、可达性、计费周期归类、记录键、核验会话。
/// 黑盒测试：只用公开 API（status_text 读状态，不构造枚举值）。
"""

STATUS_TEXT = {
    "verified": "已核验",
    "partial": "部分核验",
    "unverified": "未核验到",
}


def billing_category(billing: str) -> str:
    if billing == "":
        return ""
    if billing.startswith("按量"):
        return "按量"
    if billing.startswith("月/年"):
        return "月/年"
    if billing.startswith("按年"):
        return "按年"
    if billing.startswith("按月"):
        return "按月"
    return "其他"


def mbt_str(s: str) -> str:
    out = []
    for ch in s:
        if ch == "\\":
            out.append("\\\\")
        elif ch == '"':
            out.append('\\"')
        elif ch == "\n":
            out.append("\\n")
        elif ch == "\t":
            out.append("\\t")
        elif ord(ch) < 0x20:
            out.append("\\u{%04x}" % ord(ch))
        else:
            out.append(ch)
    return '"' + "".join(out) + '"'


def main() -> int:
    with open(JSON_PATH, encoding="utf-8") as f:
        data = json.load(f)
    tools = data["tools"]
    parts = [HEADER.rstrip("\n"), ""]
    for t in tools:
        name = t["name"]
        parts.append("///|")
        parts.append(f"test \"generated: {name} status\" {{")
        parts.append("  match @ai-pricing-verifier.tool_by_name(" + mbt_str(name) + ") {")
        parts.append("    Some(t) => {")
        parts.append(
            "      assert_eq(@ai-pricing-verifier.status_text(t.status), "
            + mbt_str(STATUS_TEXT[t["status"]])
            + ")"
        )
        parts.append(
            "      assert_eq(t.currency, " + mbt_str(t["currency"]) + ")"
        )
        parts.append(
            "      assert_eq(t.reachable, " + mbt_str(t["reachable"]) + ")"
        )
        parts.append(
            "      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "
            + mbt_str(billing_category(t["billing"]))
            + ")"
        )
        parts.append(
            "      assert_eq(t.verified_at, " + mbt_str(t["verified_at"]) + ")"
        )
        parts.append(
            "      assert_eq(t.key, " + mbt_str(t["key"]) + ")"
        )
        parts.append(
            "      assert_eq(t.session, " + mbt_str(t["session"]) + ")"
        )
        parts.append("    }")
        parts.append("    None => assert_true(false)")
        parts.append("  }")
        parts.append("}")
        parts.append("")
    OUT_PATH.write_text("\n".join(parts), encoding="utf-8")
    print(f"已生成 {OUT_PATH}：{len(tools)} 条测试")
    return 0


if __name__ == "__main__":
    sys.exit(main())
