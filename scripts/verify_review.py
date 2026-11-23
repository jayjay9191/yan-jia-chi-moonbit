"""Exercise the public CLI and measured second-review cases."""
import json
from decimal import Decimal
import re
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]


def run(*args, success=True):
    result = subprocess.run(["moon", "run", "cmd/main", "--", *args], cwd=ROOT,
                            capture_output=True, text=True, encoding="utf-8", timeout=90)
    assert result.returncode == (0 if success else 2), result.stdout + result.stderr
    return result.stdout


def verify_real_quote_chain():
    tools = {entry["name"]: entry for entry in
             json.loads((ROOT / "data/pricing.json").read_text(encoding="utf-8"))["tools"]}
    for name in ("Tana", "Midjourney"):
        source = tools[name]
        history = source["history"]
        chain = json.loads(run("quote-chain", name))
        assert (chain["key"], chain["source_url"]) == (source["key"], source["pricing_url"])
        assert [row["session"] for row in chain["sessions"]] == [row["session"] for row in history]
        assert [row["date"] for row in chain["sessions"]] == [row["date"] for row in history]
        assert [row["available"] for row in chain["sessions"]] == [False, True, True, name == "Midjourney"]
        adjacent = [link for link in chain["links"] if link["kind"] == "adjacent-sessions"]
        assert len(adjacent) == 3
        assert all((link["before_session"], link["after_session"]) == (a["session"], b["session"])
                   for link, a, b in zip(adjacent, history, history[1:]))
        assert (adjacent[0]["status"], adjacent[0]["comparable_options"], adjacent[0]["changes"]) == ("gap", 0, [])
        if name == "Tana":
            assert history[0]["change"] == "未看到价" and not history[0]["new_price"]
            a, b = history[1]["old_price"], history[1]["new_price"]
            assert b == history[2]["new_price"]
            delta = int((Decimal(re.search(r"\$([\d.]+)", b)[1]) -
                         Decimal(re.search(r"\$([\d.]+)", a)[1])) * 1200)
            change_edge = next(link for link in chain["links"] if link["before_session"] == history[1]["session"]
                               and link["after_session"] == history[1]["session"])
            assert change_edge["kind"] == "within-session" and change_edge["comparable_options"] == 1
            assert change_edge["status"] == "changed"
            change, = change_edge["changes"]
            assert int(change["year_delta"]) == delta == -4800
            assert (change["before_source"], change["after_source"]) == (a, b)
            comparable = 1
        else:
            assert not history[0]["old_price"] and not history[0]["new_price"]
            def tariffs(raw):
                return [(plan, Decimal(month), Decimal(annual))
                        for plan, month, annual in re.findall(r"(Basic|Standard|Pro|Mega) \$([\d.]+)(?:/月按月、|/)\$([\d.]+)", raw)]
            first, last = tariffs(history[1]["old_price"]), tariffs(history[2]["new_price"])
            assert first == last and len(first) == 4
            comparable = 2 * len(first)
        assert (adjacent[1]["status"], adjacent[1]["comparable_options"], adjacent[1]["changes"]) == (
            "unchanged", comparable, [])
        expected = ("gap", 0, []) if name == "Tana" else ("unchanged", comparable, [])
        assert (adjacent[2]["status"], adjacent[2]["comparable_options"], adjacent[2]["changes"]) == expected
    print("PASS real quote chains recomputed from Tana and Midjourney source snapshots")


def main():
    verify_real_quote_chain()
    assert "用法" in run("help")
    tana = run("trajectory", "Tana")
    assert "-21%" in tana and "降价" in tana
    glm = run("trajectory", "智谱清言 / GLM")
    assert "逐档核对" in glm and "71%" not in glm and "129%" not in glm
    assert "已下架，停止复核，保留历史" in run("trajectory", "Tabnine")
    summary = run("trajectory-summary")
    for label, count in (("无变化", 370), ("新档位", 160), ("涨价", 1),
                         ("降价", 3), ("下架", 6), ("未看到价", 405)):
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
    assert (amount["before_year"], amount["after_year"], amount["year_delta"]) == ("12000", "13200", "1200")
    assert (amount["before_currency"], amount["after_currency"]) == ("USD", "USD")
    assert amount["before_per_seat"] is amount["after_per_seat"] is False
    assert (basis["kind"], basis.get("before_year"), basis.get("after_year")) == ("basis-changed", None, None)
    assert (basis["before_currency"], basis["after_currency"]) == ("USD", "EUR")
    assert "year_delta" not in basis
    unsafe = json.loads(run("compare-quotes", "Basic $10/月；Basic $11/月", "Basic $12/月"))
    assert len(unsafe["before_issues"]) == 1 and unsafe["changes"] == []
    assert run("compare-quotes", "Basic $10/月", success=False) == ""
    compact = json.loads(run(
        "compare-quotes", "Basic $10/月按月、$8/月按年；Standard $30/$24",
        "Basic $10/月按月、$8/月按年；Standard $30/$25"))
    parsed = compact["changes"][0]
    assert len(compact["changes"]) == 1 and parsed["annual"] and parsed["year_delta"] == "1200"
    assert (parsed["before_source"], parsed["after_source"]) == ("Standard $30/$24", "Standard $30/$25")
    pasted = json.loads(run(
        "compare-quotes", "Basic $10/月按月、$8/月按年；\r\n\r\nStandard $30/$24",
        "Basic $10/月按月、$8/月按年\nStandard $30/$25"))
    assert pasted == compact
    invalid_line = json.loads(run("compare-quotes", "Basic $10/月；；Basic $96/年\n", "Basic $11/月"))
    assert invalid_line["before_issues"] and invalid_line["changes"] == []
    print("PASS quote comparisons with clipboard line breaks, matched billing and source fragments")
    demand = "2,2,2,2,2,2,8,8,8,8,8,8"
    quote = "Pro $10/用户/月；Pro $96/用户/年"
    seats = json.loads(run("seat-plan", "Pro", demand, quote))
    assert seats["currency"] == "USD" and seats["annual_seats"] == 2
    assert seats["monthly_seats"] == [0] * 6 + [6] * 6
    assert (seats["monthly_only"], seats["annual_only"], seats["best_total"]) == ("60000", "76800", "55200")
    assert run("seat-plan", "Pro", "1,2", quote, success=False) == ""
    assert run("seat-plan", "Pro", demand, "Pro $10/月；Pro $96/年", success=False) == ""
    print("PASS seat cost plan finds the minimum exact cost across annual reservation breakpoints")
    low, high = (",".join([str(n)] * 12) for n in (2, 8))
    robust = json.loads(run("seat-risk", "Pro", low, high, quote))
    assert robust["currency"] == "USD" and robust["annual_seats"] == 3 and robust["worst_regret"] == "12000"
    assert [(item["cost"], item["known_demand_optimum"], item["regret"]) for item in robust["scenarios"]] == [
        ("28800", "19200", "9600"), ("88800", "76800", "12000")]
    assert run("seat-risk", "Pro", low, "2,8", quote, success=False) == ""
    assert robust["annual_commitment"] == "28800"
    # Enumerate every feasible reserve rather than reusing the solver's search.
    costs = [[reserve * 9600 + 12000 * max(demand - reserve, 0)
              for reserve in range(9)] for demand in (2, 8)]
    optima = [min(row) for row in costs]
    for budget in (0, 9599, 9600, 19200, 25000, 28800, 76800, 9223372036854775807):
        expected_regret, expected_reserve = min(
            (max(row[reserve] - optimum for row, optimum in zip(costs, optima)), reserve)
            for reserve in range(min(8, budget // 9600) + 1)
        )
        limited = json.loads(run("seat-risk", "Pro", low, high, quote, str(budget)))
        assert limited["annual_seats"] == expected_reserve
        assert limited["annual_commitment"] == str(expected_reserve * 9600)
        assert limited["worst_regret"] == str(expected_regret)
    assert run("seat-risk", "Pro", low, high, quote, "-1", success=False) == ""
    print("PASS robust seat planning matches enumeration at eight upfront budget limits")
    for budget in (38399, 38400, 76800):
        for cap in (0, 4, 8):
            feasible = [reserve for reserve in range(9)
                        if reserve * 9600 <= budget and max(8 - reserve, 0) <= cap]
            args = ("seat-risk", "Pro", low, high, quote, str(budget), "--monthly-cap", str(cap))
            if not feasible:
                assert run(*args, success=False) == ""
                continue
            expected_regret, expected_reserve = min(
                (max(row[reserve] - optimum for row, optimum in zip(costs, optima)), reserve)
                for reserve in feasible
            )
            limited = json.loads(run(*args))
            assert limited["annual_seats"] == expected_reserve
            assert int(limited["worst_regret"]) == expected_regret
            assert [x["peak_monthly_seats"] for x in limited["scenarios"]] == [
                max(2 - expected_reserve, 0), max(8 - expected_reserve, 0)]
    cap_only = json.loads(run("seat-risk", "Pro", low, high, quote, "--monthly-cap", "4"))
    assert cap_only["annual_seats"] == 4
    assert run("seat-risk", "Pro", low, high, quote, "--monthly-cap", "-1", success=False) == ""
    print("PASS combined cash and capacity limits match exhaustive search at nine constraint pairs")
    tie_quote = "Pro $10/用户/月；Pro $60/用户/年"
    seven = ",".join(["7"] * 12)
    for budget, cap in ((42000, 7), (29999, 7), (42000, 2), (24000, 3)):
        # Enumerate all feasible integer seats and compare the entire set of minimizers.
        seats = range(max(7 - cap, 0), min(7, budget // 6000) + 1)
        regrets = {i: max(max(i - 2, 0), max(7 - i, 0)) * 6000 for i in seats}
        best = min(regrets.values())
        winners = [i for i in seats if regrets[i] == best]
        result = json.loads(run("seat-risk", "Pro", low, seven, tie_quote,
                                str(budget), "--monthly-cap", str(cap)))
        assert list(range(result["annual_seats"], result["max_optimal_annual_seats"] + 1)) == winners
        assert int(result["worst_regret"]) == best
    print("PASS plateau endpoints and budget-clipped ties match every feasible integer")
    for budget, cap, limit in ((42000, 7, 24000), (29999, 7, 24000), (42000, 2, 24000),
                               (42000, 7, 18000), (42000, 7, 17999), (42000, 7, 42000)):
        valid = [i for i in range(8) if i * 6000 <= budget and 7 - i <= cap
                 and max(max(i - 2, 0), 7 - i) * 6000 <= limit]
        checked = json.loads(run("seat-risk", "Pro", low, seven, tie_quote,
                                 str(budget), "--monthly-cap", str(cap), "--regret-limit", str(limit)))
        assert int(checked["allowance"]["limit"]) == limit
        interval = checked["allowance"].get("feasible_seats")
        assert interval == (dict(minimum=valid[0], maximum=valid[-1]) if valid else None)
    assert run("seat-risk", "Pro", low, seven, tie_quote, "--regret-limit", "-1", success=False) == ""
    print("PASS regret limit feasibility and both endpoints match six exhaustive integer cases")
    mixed = ([1, 7, 0] * 4, [6, 2, 5] * 4)
    for weights, limit, budget, demands in [
        ((1, 3), 24000, 42000, ([2] * 12, [7] * 12)),
        ((3, 1), 24000, 42000, ([2] * 12, [7] * 12)),
        ((1, 1), 24000, 42000, ([2] * 12, [7] * 12)),
        ((1, 3), 24000, 29999, ([2] * 12, [7] * 12)),
        ((1, 3), 17999, 42000, ([2] * 12, [7] * 12)),
        ((1, 255), 42000, 42000, ([2] * 12, [7] * 12)),
        ((2, 5), 16000, 42000, mixed),
        ((5, 2), 38000, 42000, mixed),
    ]:
        all_costs = [[seats * 6000 + 1000 * sum(max(d - seats, 0) for d in demand)
                      for seats in range(max(map(max, demands)) + 1)] for demand in demands]
        choices = []
        for seats, costs in enumerate(zip(*all_costs)):
            worst = max(cost - min(route) for cost, route in zip(costs, all_costs))
            if seats * 6000 <= budget and worst <= limit:
                choices.append((sum(w * c for w, c in zip(weights, costs)), worst, seats))
        inputs = [",".join(map(str, demand)) for demand in demands]
        value = json.loads(run("seat-risk", "Pro", *inputs, tie_quote, str(budget),
                               "--regret-limit", str(limit), "--scenario-weights", ",".join(map(str, weights))))
        result = value.get("weighted_plan")
        if choices:
            cost, worst, seats = min(choices)
            assert (int(result["cost_numerator"]), result["annual_seats"], int(result["worst_regret"])) == (cost, seats, worst)
            assert result["weight_total"] == sum(weights)
            efficient = [
                n for c, r, n in choices
                if not any(c2 <= c and r2 <= r and (c2 < c or r2 < r) for c2, r2, _ in choices)
            ]
            lo, hi = (result["pareto_seats"][k] for k in ("minimum", "maximum"))
            assert list(range(lo, hi + 1)) == efficient
        else:
            assert result is None
    assert run("seat-risk", "Pro", low, seven, tie_quote, "--scenario-weights", "1,256", success=False) == ""
    print("PASS weighted optimum and both dominance objectives match eight exhaustive integer cases")
    for weights, tail, limit, budget, cap, demands in [
        *(([1, 3], tail, 24000, 42000, 7, ([2] * 12, [7] * 12)) for tail in (1, 2, 3, 4)),
        ([1, 3], 2, 17999, 42000, 7, ([2] * 12, [7] * 12)),
        ([2, 5], 4, 38000, 42000, 7, mixed),
        ([1, 3], 3, 24000, 30000, 2, ([2] * 12, [7] * 12)),
        ([1, 3], 3, 24000, 24000, 2, ([2] * 12, [7] * 12)),
    ]:
        costs = [[6000 * reserve + 1000 * sum(max(d - reserve, 0) for d in demand)
                  for reserve in range(max(map(max, demands)) + 1)] for demand in demands]
        candidates, robust_candidates = [], []
        stress_weights = weights[::-1]
        for reserve, totals in enumerate(zip(*costs)):
            regrets = [total - min(route) for total, route in zip(totals, costs)]
            worst = max(regrets)
            if worst <= limit and reserve * 6000 <= budget and max(map(max, demands)) - reserve <= cap:
                weighted_units = sorted((-regret, index) for index, (regret, weight)
                                        in enumerate(zip(regrets, weights)) for _ in range(weight))[:tail]
                baseline_sum = -sum(loss for loss, _ in weighted_units)
                candidates.append((baseline_sum, reserve, worst, weighted_units))
                stress_units = sorted((regret for regret, weight in zip(regrets, stress_weights)
                                       for _ in range(weight)), reverse=True)
                stress_sum = sum(stress_units[:tail])
                robust_candidates.append((max(baseline_sum, stress_sum), reserve, baseline_sum, stress_sum))
        inputs = [",".join(map(str, demand)) for demand in demands]
        command = ("seat-risk", "Pro", *inputs, tie_quote, str(budget), "--monthly-cap", str(cap),
                   "--regret-limit", str(limit), "--scenario-weights", ",".join(map(str, weights)),
                   "--tail-weight", str(tail))
        result = run(*command, success=budget // 6000 >= max(map(max, demands)) - cap)
        if not result:
            assert not candidates and not robust_candidates
            continue
        decision = json.loads(result)
        plan = decision.get("tail_plan")
        if candidates:
            numerator, reserve, worst, units = min(candidates)
            assert (int(plan["regret_numerator"]), plan["annual_seats"], int(plan["worst_regret"])) == (numerator, reserve, worst)
            tied = [seats for amount, seats, _, _ in candidates if amount == numerator]
            assert plan["optimal_seats"] == dict(minimum=min(tied), maximum=max(tied))
            expanded = [(-int(line["regret"]), line["scenario_index"])
                        for line in plan["contributions"] for _ in range(line["used_weight"])]
            assert plan["weight"] == tail and expanded == units
        else:
            assert plan is None
        stressed = json.loads(run(*command, "--stress-weights", ",".join(map(str, stress_weights))))
        robust = stressed.get("stress_tail_plan")
        if robust_candidates:
            worst_tail, reserve, baseline_sum, stress_sum = min(robust_candidates)
            tied = [seats for amount, seats, _, _ in robust_candidates if amount == worst_tail]
            assert robust["annual_seats"] == reserve and robust["weight"] == tail
            assert robust["optimal_seats"] == dict(minimum=min(tied), maximum=max(tied))
            assert (int(robust["baseline_numerator"]), int(robust["stress_numerator"])) == (baseline_sum, stress_sum)
        else:
            assert robust is None
    for flags in (("--stress-weights", "3,1"), ("--tail-weight", "3", "--stress-weights", "1,1"),
                  ("--tail-weight", "3", "--stress-weights", "0,4"), ("--tail-weight", "3", "--stress-weights", "4")):
        assert run("seat-risk", "Pro", low, seven, tie_quote, "--scenario-weights", "1,3", *flags, success=False) == ""
    print("PASS stress tails and tied reserves against independent exhaustive weight profiles")
    assert run("seat-risk", "Pro", low, seven, tie_quote, "--tail-weight", "2", success=False) == ""
    print("PASS eight weighted tails, tied intervals and scenario attribution against exhaustive seats")
    queue = run("recheck-queue", "2026-11-20")
    assert len([line for line in queue.splitlines() if line.startswith("APV-")]) == 20
    for args in (("unknown-review-command",), ("trajectory",), ("trajectory", "missing"),
                 ("classes",), ("classes-quote",), ("classes-quote", " "),
                 ("recheck-queue", "2026-02-30"),
                 ("trajectory-summary", "unexpected")):
        run(*args, success=False)
    print("PASS measured trajectories, 945 category counts, four plan classes, R1 evidence gap and top20 queue")


if __name__ == "__main__":
    main()
