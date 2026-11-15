#!/usr/bin/env python3
"""一次性导入：把 Lexmount 第二份作品的 pricing.csv 转成 data/pricing.json。

CSV 是原始核验记录（2026-11-08，Lexmount Cloud Browser 实际打开各官网逐页
记录），JSON 是本项目的唯一事实源。CSV 里的文字字段（免费版、付费价、学生
优惠、备注）由程序原样读取，不手工转抄；只有下面这张分类表是人工判断：

- status：付费价核验状态。已核验 = 官网价已完整记录（含仅 API 按量价的
  DeepSeek/Kimi/智谱，按原作者 index.html 的口径——原文说“能直接在官网
  看到完整付费定价的有 8 个”，就是这 8 个）；部分核验 = 只核验到一部分
  （Gemini 只在 Google One 页看到价、Copilot 只核验到商业版、海螺只见到
  “低至 ¥42 每月”起步价）；未核验到 = 付费价没看到（无定价页 / 需登录 /
  打不开 / 地区限制）。三档缺一不可：Gemini 等 3 条写“已核验”是夸大，
  写“未核验到”是丢掉已核验到的价格。
- currency：付费价的货币。未核验到的行 currency 为空——没有价格就不编货币。
- billing：计费周期原文（CSV“月/年”列）；未核验到的行为空。
- reachable：页面可达状态。豆包是“受限”（打开聊天页后跳转地区限制页），
  不是“能打开”也不是纯“打不开”。

未核验到的行：paid_price 置空（没有价格就不写价格），CSV 里“未显示”之类的
原文追加到 note 里（“付费版原文：…”），信息不丢、价格不编。

跑法（项目根目录，只需跑一次；以后改数据只改 JSON）：
    python3 scripts/csv_to_json.py
"""

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CSV_PATH = Path(
    "/home/hatch/workspace/goals/internradar/files/ai-pricing-verification/pricing.csv"
)
JSON_PATH = ROOT / "data" / "pricing.json"

VERIFIED_AT = "2026-11-08"

# 计费周期全部取值（CSV“月/年”列去重后）。解析时用它查表重组，
# 因为 ChatGPT/Gemini 行的付费价里有未加引号的千分位逗号。
KNOWN_BILLING = {
    "—",
    "按量",
    "按量，无月/年订阅",
    "按月",
    "月/年",
    "月/年均有",
    "按年",
    "按月，年付最高省16%",
    "按月（仅见“每月”）",
}

# 人工分类：工具名 -> (status, currency, billing, reachable)
# status: verified / partial / unverified
# currency: USD / JPY / CNY / ""（未核验到时为空）
# billing: "" 表示未核验到计费周期
# reachable: 能打开 / 打不开 / 受限
CLASSIFY = {
    "Qwen / 通义千问": ("unverified", "", "", "能打开"),
    "DeepSeek": ("verified", "USD", "按量，无月/年订阅", "能打开"),
    "豆包": ("unverified", "", "", "受限"),
    "Kimi / Moonshot AI": ("verified", "USD", "按量", "能打开"),
    "ChatGPT / OpenAI": ("verified", "JPY", "按月", "能打开"),
    "Claude / Anthropic": ("verified", "USD", "月/年均有", "能打开"),
    "Gemini / Google": ("partial", "JPY", "按月，年付最高省16%", "能打开"),
    "Grok / xAI": ("verified", "USD", "按月", "能打开"),
    "文心一言 / 百度": ("unverified", "", "", "能打开"),
    "讯飞星火": ("unverified", "", "", "打不开"),
    "智谱清言 / GLM": ("verified", "CNY", "按量", "能打开"),
    "腾讯元宝 / 混元": ("unverified", "", "", "能打开"),
    "Copilot / Microsoft": ("partial", "USD", "按年", "能打开"),
    "Perplexity": ("unverified", "", "", "打不开"),
    "Midjourney": ("verified", "USD", "月/年", "能打开"),
    "夸克 AI": ("unverified", "", "", "能打开"),
    "纳米 AI / 360": ("unverified", "", "", "打不开"),
    "海螺 AI / MiniMax": ("partial", "CNY", "按月（仅见“每月”）", "能打开"),
    "通义灵码": ("unverified", "", "", "能打开"),
    "Cursor": ("verified", "USD", "按月", "能打开"),
}


def parse_rows(csv_path: Path) -> list:
    """手工解析 pricing.csv。

    注意：CSV 本身有个小毛病——ChatGPT、Gemini 两行的千分位价格
    （JP¥1,400、JP¥1,450 等）没加引号，csv 模块会把一行多切出字段，
    直接用 DictReader 会让这两行的付费价/学生优惠/备注全错位。
    这里按字段位置解析：首尾字段（工具、URL、免费版、学生优惠、
    能否打开、备注）没有 ASCII 逗号，位置固定；中间的付费价和计费
    周期用计费周期查表（1 或 2 段）重组，剩下的拼回付费价。
    """
    lines = csv_path.read_text(encoding="utf-8").splitlines()
    header = lines[0].split(",")
    assert header[0] == "工具" and len(header) == 8, header
    rows = []
    for line in lines[1:]:
        if not line.strip():
            continue
        parts = line.split(",")
        if len(parts) < 8:
            raise ValueError(f"字段不足 8 个：{line!r}")
        name = parts[0].strip()
        url = parts[1].strip()
        free_tier = parts[2].strip()
        student = parts[-3].strip()
        reachable_raw = parts[-2].strip()
        note = parts[-1].strip()
        middle = parts[3:-3]
        billing = None
        paid_parts = None
        for take in (1, 2):
            if len(middle) >= take:
                cand = ",".join(middle[-take:])
                if cand in KNOWN_BILLING:
                    billing = cand
                    paid_parts = middle[:-take] if take < len(middle) else []
                    break
        if billing is None:
            raise ValueError(f"计费周期匹配不上：{line!r}")
        paid_raw = ",".join(paid_parts)
        rows.append(
            {
                "name": name,
                "url": url,
                "free_tier": free_tier,
                "paid_raw": paid_raw,
                "billing_csv": billing,
                "student": student,
                "reachable_raw": reachable_raw,
                "note": note,
            }
        )
    return rows


def main() -> int:
    rows = parse_rows(CSV_PATH)
    tools = []
    for row in rows:
        name = row["name"]
        if name not in CLASSIFY:
            raise ValueError(f"分类表里没有这个工具：{name!r}")
        status, currency, billing, reachable = CLASSIFY[name]
        # 交叉校验：分类表的 reachable 必须和 CSV 的能否打开原文一致
        # （能打开 ↔ 原文含“能打开”；打不开 ↔ 原文含“打不开”；
        # 受限 ↔ 原文含“地区限制”）。
        raw = row["reachable_raw"]
        if reachable == "能打开":
            assert "能打开" in raw, (name, raw)
        elif reachable == "打不开":
            assert "打不开" in raw, (name, raw)
        else:
            assert "地区限制" in raw, (name, raw)
        # 计费周期：分类表和 CSV 重组结果必须一致（CSV 里的“—”就是“无”，
        # 归一化为空串）。
        csv_billing = "" if row["billing_csv"] == "—" else row["billing_csv"]
        assert billing == csv_billing, (name, billing, row["billing_csv"])
        paid_raw = row["paid_raw"]
        note = row["note"]
        if status == "unverified":
            # 没有价格就不写价格；CSV 原文追加到备注里，不丢信息。
            paid_price = ""
            note = f"{note}（付费版原文：{paid_raw}）"
        else:
            paid_price = paid_raw
        tools.append(
            {
                "name": name,
                "pricing_url": row["url"],
                "free_tier": row["free_tier"],
                "paid_price": paid_price,
                "currency": currency,
                "billing": billing,
                "student_discount": row["student"],
                "reachable": reachable,
                "verified_at": VERIFIED_AT,
                "note": note,
                "status": status,
            }
        )
    if len(tools) != 20:
        raise ValueError(f"期望 20 条，实际 {len(tools)} 条")
    names = [t["name"] for t in tools]
    if len(set(names)) != len(names):
        raise ValueError("工具名有重复")
    data = {
        "source": "Lexmount 云平台真实任务挑战第二份作品提交材料 pricing.csv，"
        "2026-11-08 Lexmount Cloud Browser 实际打开各官网逐页核验；"
        "未用第三方汇总文章，未编造未看到的价格。",
        "verified_at": VERIFIED_AT,
        "tools": tools,
    }
    JSON_PATH.write_text(
        json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    print(f"已生成 {JSON_PATH}：{len(tools)} 个工具")
    return 0


if __name__ == "__main__":
    sys.exit(main())
