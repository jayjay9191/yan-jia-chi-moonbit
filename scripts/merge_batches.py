#!/usr/bin/env python3
"""合并扩量批次 + 第一次复核结果到 data/pricing.json。

用法（项目根目录）：
    python3 scripts/merge_batches.py [--reverify-only]

步骤：
1. 读 data/pricing.json（唯一事实源）。
2. 给原始 20 条分配记录键 APV-0001..0020（按 JSON 顺序，追加不重排）
   与核验会话 20261108-LXM。
3. 应用 2026-11-15 第一次复核（会话 20261115-R1）：复核原始 20 条中
   带价的 11 条——6 条直接确认无变动并把 verified_at 更新到 2026-11-15，
   1 条涨价（智谱 GLM-5.1），4 条未看到价（原价不动、verified_at 不动）。
   复核结论来自实际重开官方页的记录，见 docs/verification-process.md。
4. 合并 /tmp/batch_*.json（A～F 批，文件不存在就跳过）：
   - 每条记录分配 key（按 A→F 顺序续排）与 session（20261115-A～F）；
   - history 默认为空；
   - 应用已确认的修正（见 BATCH_FIXES，如 D 批 Tabnine 降级为部分核验）。
5. 写盘前用 Python 镜像一遍 MoonBit 的全部验证规则（validate.mbt），
   有问题就报错退出、不写盘。
6. 写回 pricing.json，然后跑：
   python3 scripts/generate_data.py && python3 scripts/generate_tests.py

注意：本脚本不联网、不改状态口径；找不到价的记录保持“未核验到”留空。
"""

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PRICING_JSON = ROOT / "data" / "pricing.json"
BATCH_DIR = Path("/tmp")
BATCH_LETTERS = ["A", "B", "C", "D", "E", "F"]

RECHECK_DATE = "2026-11-15"
RECHECK_SESSION = "20261115-R1"

# 2026-11-15 第一次复核结论（实际重开官方页所得）。
# "bump": True = 价格确认无变动，verified_at 更新到复核日；
# "bump": False = 未看到价，原价与 verified_at 都不动。
REVERIFY = {
    "DeepSeek": {
        "bump": True,
        "change": "无变化",
        "note": "复核：价格与 2026-11-08 记录一致（flash $0.003/$0.006、$0.15/$0.30，输出 $0.6/$1.2；v4-pro $0.022/$0.044、$0.66/$1.32、$1.98/$3.96；Search/Fetch $0.75/1000 次）。",
    },
    "Claude / Anthropic": {
        "bump": True,
        "change": "无变化",
        "note": "复核：Pro $17/月（按年）/$20/月（按月）、Max $100/月、Ultra $200/月，与 2026-11-08 记录一致。",
    },
    "Grok / xAI": {
        "bump": True,
        "change": "无变化",
        "note": "复核：Plus $8/月、Premium $30/月、Super $100/月、Ultra $200/月、Team $30+/用户/月，与 2026-11-08 记录一致。",
    },
    "Midjourney": {
        "bump": True,
        "change": "无变化",
        "note": "复核：Basic $10/$8、Standard $30/$24、Pro $60/$48、Mega $120/$96，与 2026-11-08 记录一致。",
    },
    "Cursor": {
        "bump": True,
        "change": "无变化",
        "note": "复核：Plus $8/月、高级版 $30/月、Super $100/月、Ultra $200/月、Team $30+/用户/月，与 2026-11-08 记录一致（页面现为 Cursor+Grok 合并页）。",
    },
    "Copilot / Microsoft": {
        "bump": False,
        "change": "无变化",
        "note": "复核：含 Copilot 的 Business Premium $32/用户/月、Business Standard $23.50/用户/月与 2026-11-08 记录一致；附加价 $18/用户/月今日页未见。",
    },
    "智谱清言 / GLM": {
        "bump": True,
        "change": "涨价",
        "note": "复核：GLM-5.1 输入 ¥3.5→¥6（<32K）/¥8（≥32K）、输出 ¥12.5→¥24/¥28；GLM-5.3 不变（输入 ¥8、缓存命中 ¥2、输出 ¥28）；GLM-5.1-Flash 在今日价目表已无此名，同价 ¥0.8/¥2.8 现为 GLM-5.3-Flash。",
        "new_price": "API按量：GLM-5.3 输入 ¥8/1M tokens、缓存命中 ¥2、输出 ¥28；GLM-5.1 输入 ¥6/1M tokens（<32K）/¥8（≥32K）、输出 ¥24/¥28；GLM-5.3-Flash 输入 ¥0.8、输出 ¥2.8",
    },
    "Kimi / Moonshot AI": {
        "bump": False,
        "change": "未看到价",
        "note": "复核：首页仍无定价，platform.kimi.ai/docs/pricing 文本抓取无价目表；第三方指南引用的 Moonshot 官方价（kimi-k3.1-pro $2/$10 等）与 2026-11-08 记录一致，但非直接观测。",
    },
    "ChatGPT / OpenAI": {
        "bump": False,
        "change": "未看到价",
        "note": "复核：定价页文本抓取不含价格数字（JS 渲染）；多家第三方日文文章引用官方页与 2026-11-08 记录一致（Go JP¥1,400、Plus JP¥3,000、Pro JP¥16,800 起），但非直接观测。",
    },
    "Gemini / Google": {
        "bump": False,
        "change": "未看到价",
        "note": "复核：Google One 套餐页今日文本无任何价格（仅免费 15GB 显示 0 USD）。",
    },
    "海螺 AI / MiniMax": {
        "bump": False,
        "change": "未看到价",
        "note": "复核：首页今日未见定价，2026-11-08 的“低至 ¥42 每月”按钮未再出现。",
    },
}

# 批次合并时已确认的修正（key = 工具名）。
BATCH_FIXES = {
    # D 批：Tabnine 官方定价页已跳转至 Tricentis 联系页，实时页无价格；
    # $39/$59 只来自 2026-09-05 官网存档快照 → 降级为部分核验。
    "Tabnine": {
        "status": "partial",
        "note": "官网定价页已跳转至 Tricentis 联系页，实时页不显示价格；$39/$59 为 2026-09-05 官网定价页存档快照价，未在实时页确认。",
    },
    # D 批：v0 的价格直接来自官方文档页 v0.app/docs/pricing，注里写清来源。
    "v0": {
        "note": "官方文档页 v0.app/docs/pricing 直接给出定价：Plus $30/用户/月、Business $100/用户/月。",
    },
}

DATE_RE = re.compile(r"^\d{4}-\d{2}-\d{2}$")
CHANGES = {"无变化", "涨价", "降价", "下架", "新档位", "未看到价"}


def valid_date(s: str) -> bool:
    if not DATE_RE.match(s):
        return False
    y, m, d = int(s[0:4]), int(s[5:7]), int(s[8:10])
    if m < 1 or m > 12 or d < 1 or d > 31:
        return False
    leap = (y % 4 == 0 and y % 100 != 0) or y % 400 == 0
    days = [31, 29 if leap else 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    return d <= days[m - 1]


def mirror_validate(tools: list) -> list:
    """Python 镜像 validate.mbt 的全部 14 项检查，返回问题列表。"""
    issues = []
    seen_names = set()
    seen_keys = set()
    for t in tools:
        tag = f"《{t['name']}》"
        if not t.get("key"):
            issues.append(tag + "记录键 key 为空")
        elif t["key"] in seen_keys:
            issues.append("记录键 key 重复：" + t["key"])
        else:
            seen_keys.add(t["key"])
        if not t.get("session"):
            issues.append(tag + "核验会话 session 为空")
        if not t["name"]:
            issues.append(tag + "名字为空")
        elif t["name"] in seen_names:
            issues.append("名字重复：" + t["name"])
        else:
            seen_names.add(t["name"])
        if not t["pricing_url"].startswith("https://"):
            issues.append(tag + "定价页 URL 不是 https://")
        status = t["status"]
        if t["paid_price"] == "" and status != "unverified":
            issues.append(tag + "空价格 + 非未核验到 = 冒充")
        if t["paid_price"] != "" and status == "unverified":
            issues.append(tag + "有价格 + 未核验到 = 自相矛盾")
        if status == "unverified":
            if t["currency"] != "":
                issues.append(tag + "未核验到但货币非空")
            if t["billing"] != "":
                issues.append(tag + "未核验到但计费非空")
        else:
            if t["currency"] not in ("USD", "JPY", "CNY"):
                issues.append(tag + "货币不在 USD/JPY/CNY 内：" + t["currency"])
            elif t["currency"] == "USD" and "$" not in t["paid_price"]:
                issues.append(tag + "USD 价格里没有 $")
            elif t["currency"] in ("JPY", "CNY") and "¥" not in t["paid_price"]:
                issues.append(tag + "JPY/CNY 价格里没有 ¥")
            if t["billing"] == "":
                issues.append(tag + "已核验/部分核验但计费为空")
        if not valid_date(t["verified_at"]):
            issues.append(tag + "verified_at 格式不对：" + t["verified_at"])
        if t["reachable"] not in ("能打开", "打不开", "受限"):
            issues.append(tag + "reachable 不在三档内：" + t["reachable"])
        if t["reachable"] in ("打不开", "受限") and status != "unverified":
            issues.append(tag + "页面打不开/受限却标已核验/部分核验")
        if not t["free_tier"]:
            issues.append(tag + "免费版为空")
        if not t["student_discount"]:
            issues.append(tag + "学生优惠为空")
        for j, h in enumerate(t.get("history", [])):
            htag = f"{tag}第 {j + 1} 条变动轨迹"
            if not valid_date(h["date"]):
                issues.append(htag + "日期格式不对：" + h["date"])
            if h["change"] not in CHANGES:
                issues.append(htag + "变动类型不在 6 种以内：" + h["change"])
            if not h["session"]:
                issues.append(htag + "会话为空")
            if h["change"] in ("涨价", "降价"):
                if not h["old_price"] or not h["new_price"]:
                    issues.append(htag + "涨价/降价必须新旧价俱全")
                elif h["old_price"] == h["new_price"]:
                    issues.append(htag + "涨价/降价新旧价相同：假轨迹")
    return issues


def apply_reverify(tools: list) -> None:
    for t in tools:
        name = t["name"]
        if "key" not in t:
            t["key"] = ""
        if "session" not in t:
            t["session"] = "20261108-LXM"
        if "history" not in t:
            t["history"] = []
        if name in REVERIFY:
            # 幂等：同一会话的复核条目只记一次，重复跑脚本不重复追加
            if any(
                h.get("session") == RECHECK_SESSION for h in t["history"]
            ):
                continue
            r = REVERIFY[name]
            entry = {
                "date": RECHECK_DATE,
                "session": RECHECK_SESSION,
                "change": r["change"],
                "old_price": "",
                "new_price": "",
                "note": r["note"],
            }
            if r["change"] in ("涨价", "降价"):
                entry["old_price"] = t["paid_price"]
                entry["new_price"] = r["new_price"]
                t["paid_price"] = r["new_price"]
            t["history"].append(entry)
            if r["bump"]:
                t["verified_at"] = RECHECK_DATE


def merge_batches(tools: list) -> int:
    """合并 /tmp/batch_*.json，返回新增条数。"""
    existing = {t["name"] for t in tools}
    added = 0
    next_key = len(tools) + 1
    for letter in BATCH_LETTERS:
        path = BATCH_DIR / f"batch_{letter}.json"
        if not path.exists():
            print(f"跳过 {path}（不存在）")
            continue
        batch = json.loads(path.read_text(encoding="utf-8"))
        batch_tools = batch["tools"] if isinstance(batch, dict) else batch
        for t in batch_tools:
            name = t["name"]
            if name in existing:
                print(f"跳过重复工具：{name}（已在表里）")
                continue
            if name in BATCH_FIXES:
                fix = BATCH_FIXES[name]
                t.update(fix)
                print(f"修正：{name} → {fix}")
            t["key"] = f"APV-{next_key:04d}"
            t["session"] = f"20261115-{letter}"
            t.setdefault("history", [])
            tools.append(t)
            existing.add(name)
            next_key += 1
            added += 1
        print(f"合并 {letter} 批：{len(batch_tools)} 条，累计新增 {added} 条")
    return added


def main() -> int:
    reverify_only = "--reverify-only" in sys.argv
    data = json.loads(PRICING_JSON.read_text(encoding="utf-8"))
    tools = data["tools"]
    # 先给原始 20 条分配 key（按当前 JSON 顺序）
    for i, t in enumerate(tools):
        if not t.get("key"):
            t["key"] = f"APV-{i + 1:04d}"
    apply_reverify(tools)
    added = 0
    if not reverify_only:
        added = merge_batches(tools)
    issues = mirror_validate(tools)
    if issues:
        print(f"镜像校验发现 {len(issues)} 个问题，不写盘：")
        for issue in issues:
            print("  - " + issue)
        return 1
    PRICING_JSON.write_text(
        json.dumps(data, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    from collections import Counter

    print(f"写盘完成：共 {len(tools)} 条（新增 {added} 条）")
    print(f"状态：{dict(Counter(t['status'] for t in tools))}")
    print(f"history 总条数：{sum(len(t.get('history', [])) for t in tools)}")
    print("下一步：python3 scripts/generate_data.py && python3 scripts/generate_tests.py")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
