#!/usr/bin/env python3
"""从 data/pricing.json 生成 pricing_data.mbt。

JSON 是唯一数据源：改数据只改 data/pricing.json，改完跑：
    python3 scripts/generate_data.py
然后跑 moon fmt && moon test。

只用 Python 标准库。生成内容是确定性的：同一份 JSON 每次生成
字节一致（字段按固定顺序输出）。
"""

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
JSON_PATH = ROOT / "data" / "pricing.json"
OUT_PATH = ROOT / "pricing_data.mbt"

HEADER = """///|
/// 由 scripts/generate_data.py 从 data/pricing.json 生成，不要手改。
/// 改数据只改 JSON，改完跑：python3 scripts/generate_data.py
/// 数据来源：两批实测——
/// ① 2026-11-08 Lexmount 云平台真实任务挑战第二份作品提交材料 pricing.csv，
///    Lexmount Cloud Browser 实际打开各官网逐页核验（原始 20 条，会话 20261108-LXM）；
/// ② 2026-11-15 扩量批次（会话 20261115-A～F），逐个打开官方定价页核验。
/// 注意：“未核验到”是诚实的空白——没有价格就不写价格，绝不编造；
/// “部分核验”不要写成已核验，也不要丢掉已核验到的价。
/// 每条记录有唯一记录键 key（APV-0001 起按 JSON 顺序分配，追加不重排）
/// 与核验会话 session；history 只记真实发生过的复核事件。
/// 2026-11-15 第一次复核（会话 20261115-R1）：复核原始 20 条中带价的
/// 11 条，6 条直接确认无变动，1 条涨价（智谱 GLM-5.1），4 条未看到价。
"""

TOOL_FIELDS = [
    "key",
    "session",
    "name",
    "pricing_url",
    "free_tier",
    "paid_price",
    "currency",
    "billing",
    "student_discount",
    "reachable",
    "verified_at",
    "note",
    "status",
]

HISTORY_FIELDS = [
    "date",
    "session",
    "change",
    "old_price",
    "new_price",
    "note",
]

STATUS_MAP = {
    "verified": "PriceStatus::Verified",
    "partial": "PriceStatus::VerifiedPartial",
    "unverified": "PriceStatus::Unverified",
}


def mbt_str(s: str) -> str:
    """转义成 MoonBit 字符串字面量。"""
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


def emit_history(history: list) -> str:
    """history 数组：空为 []，否则每条一行 HistoryEntry 字面量。"""
    if not history:
        return "      history: [],"
    lines = ["      history: ["]
    for h in history:
        parts = ", ".join(f"{f}: {mbt_str(h[f])}" for f in HISTORY_FIELDS)
        lines.append(f"        {{ {parts} }},")
    lines.append("      ],")
    return "\n".join(lines)


def emit_tool(t: dict) -> str:
    if t["status"] not in STATUS_MAP:
        raise ValueError(f"未知的核验状态：{t['status']!r}")
    for field in TOOL_FIELDS:
        if field != "status" and field not in t:
            raise ValueError(f"缺少字段：{field!r}（工具 {t.get('name', '?')!r}）")
    lines = ["    {"]
    for field in TOOL_FIELDS:
        value = t[field]
        if field == "status":
            lines.append(f"      status: {STATUS_MAP[value]},")
        else:
            lines.append(f"      {field}: {mbt_str(value)},")
    lines.append(emit_history(t.get("history", [])))
    lines.append("    },")
    return "\n".join(lines)


def main() -> int:
    with open(JSON_PATH, encoding="utf-8") as f:
        data = json.load(f)
    tools = data["tools"]
    parts = [HEADER.rstrip("\n"), ""]
    parts.append("///|")
    parts.append("pub fn all_tools() -> Array[ToolPricing] {")
    parts.append("  [")
    parts.extend(emit_tool(t) for t in tools)
    parts.append("  ]")
    parts.append("}")
    parts.append("")
    OUT_PATH.write_text("\n".join(parts), encoding="utf-8")
    print(f"已生成 {OUT_PATH}：{len(tools)} 个工具")
    return 0


if __name__ == "__main__":
    sys.exit(main())
