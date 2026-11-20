"""Exercise the public CLI and measured second-review cases."""
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]


def run(*args, success=True):
    result = subprocess.run(["moon", "run", "cmd/main", "--", *args], cwd=ROOT,
                            capture_output=True, text=True, encoding="utf-8", timeout=90)
    assert result.returncode == (0 if success else 2), result.stdout + result.stderr
    return result.stdout


def main():
    assert "用法" in run("help")
    tana = run("trajectory", "Tana")
    assert "-21%" in tana and "降价" in tana
    glm = run("trajectory", "智谱清言 / GLM")
    assert "逐档核对" in glm and "71%" not in glm and "129%" not in glm
    assert "已下架，停止复核，保留历史" in run("trajectory", "Tabnine")
    summary = run("trajectory-summary")
    for label, count in (("无变化", 368), ("新档位", 160), ("涨价", 1),
                         ("降价", 3), ("下架", 6), ("未看到价", 404)):
        assert f"{label}：{count}" in summary
    classes = run("classes", "Midjourney")
    assert "Midjourney：4类" in classes and classes.count("年付节省20%") == 4
    assert "矛盾/待核对：0" in classes
    assert "20261115-R1 | 0类 | 缺少" in classes
    assert "20261115-R3 | 4类" in classes and "20261118-R5 | 4类" in classes
    fresh = run("classes-quote", "Basic $10/月；Basic $96/年")
    assert "年付节省20%" in fresh and "矛盾/待核对：0" in fresh
    conflict = run("classes-quote", "Basic $96/年；Basic $96.01/年")
    assert "矛盾/待核对：1" in conflict and "9600 分与 9601 分" in conflict
    iso = run("classes-quote", "Basic USD 10/month; Basic USD 96/year")
    assert "年付节省20%" in iso and "矛盾/待核对：0" in iso
    invalid = run("classes-quote", "Basic -$10/月; Pro $1k/月")
    assert "输入报价：0类" in invalid and "矛盾/待核对：2" in invalid
    mixed = run("classes-quote", "Basic USD €10/月；Basic USD $96/年")
    assert "币种标记冲突" in mixed and "矛盾/待核对：1" in mixed and "年付节省20%" not in mixed
    reversed_pair = run("classes-quote", "Basic $8/月按年、$10/月按月；Standard $24/$30")
    assert "Standard | 2种写法 | 年付节省20%" in reversed_pair
    unlabelled = run("classes-quote", "Basic $10/月按月；Pro $8/月按年；Standard $30/$24")
    assert "简写缺少一致的月付/年付顺序：Standard $30/$24" in unlabelled
    ambiguous_cycle = run("classes-quote", "Basic USD 20/月/年")
    assert "计费周期冲突" in ambiguous_cycle and "输入报价：0类" in ambiguous_cycle
    real_cycle = run("classes-quote", "Basic USD 25/month; Basic USD 20/month billed annually")
    assert "年付节省20%" in real_cycle and "矛盾/待核对：0" in real_cycle
    starting = run("classes-quote", "Basic from $10/月; Basic $96/年")
    assert "报价下限" in starting and "Basic | 1种写法" in starting and "年付节省20%" not in starting
    sign = run("classes-quote", "Basic -USD $10/month; Basic $96/year")
    assert "Basic | 1种写法" in sign and "矛盾/待核对：1" in sign
    introductory = run("classes-quote", "Basic 首月 $10/月; Basic $96/年")
    assert "首期报价" in introductory and "未能计算年付节省率" in introductory
    machine = json.loads(run("classes-quote", "跨平台 $10/月；跨平台 $96/年", "--json"))
    assert machine["schema_version"] == 1 and machine["history"] is None and machine["issues"] == []
    assert machine["classes"] == [
        {"plan": "跨平台", "annual_saving": 20, "members": [
            {"plan": "跨平台", "quote": "$10/月", "source": "跨平台 $10/月"},
            {"plan": "跨平台", "quote": "$96/年", "source": "跨平台 $96/年"},
        ]},
    ]
    conditional = json.loads(run("classes-quote", "Basic 首月 $10/月；Basic $96/年", "--json"))
    assert conditional["classes"][0]["annual_saving"] is None and len(conditional["issues"]) == 1
    stored = json.loads(run("classes", "Midjourney", "--json"))
    assert len(stored["classes"]) == 4 and not stored["history"]["complete"]
    assert stored["history"]["observed_stable"]
    assert stored["history"]["sessions"][0]["class_count"] == 0
    assert "缺少" in stored["history"]["sessions"][0]["detail"]
    assert "前次证据不可用" in stored["history"]["sessions"][1]["detail"]
    assert "逐套餐、逐付款周期核对，金额和口径一致" in stored["history"]["sessions"][2]["detail"]
    assert run("classes-quote", "", "--json", success=False) == ""
    comparison = json.loads(run(
        "compare-quotes", "Basic $10/月；Basic $96/年；Pro $20/月",
        "Basic $11/月；Basic $8/月按年；Pro €20/月"))
    assert comparison["before_issues"] == comparison["after_issues"] == []
    changes = {entry["plan"]: entry for entry in comparison["changes"]}
    assert set(changes) == {"Basic", "Pro"}
    amount, basis = changes["Basic"], changes["Pro"]
    assert (amount["plan"], amount["kind"], amount["annual"]) == ("Basic", "amount-changed", False)
    assert (int(amount["before_year"]), int(amount["after_year"])) == (12000, 13200)
    assert (basis["kind"], basis.get("before_year"), basis.get("after_year")) == ("basis-changed", None, None)
    unsafe = json.loads(run("compare-quotes", "Basic $10/月；Basic $11/月", "Basic $12/月"))
    assert len(unsafe["before_issues"]) == 1 and unsafe["changes"] == []
    assert run("compare-quotes", "Basic $10/月", success=False) == ""
    print("PASS structured quote comparisons preserve matched billing options and mark incompatible evidence")
    queue = run("recheck-queue", "2026-11-20")
    assert len([line for line in queue.splitlines() if line.startswith("APV-")]) == 20
    for args in (("unknown-review-command",), ("trajectory",), ("trajectory", "missing"),
                 ("classes",), ("classes-quote",), ("classes-quote", " "),
                 ("recheck-queue", "2026-02-30"),
                 ("trajectory-summary", "unexpected")):
        run(*args, success=False)
    print("PASS measured trajectories, 942 category counts, four plan classes, R1 evidence gap and top20 queue")


if __name__ == "__main__":
    main()
