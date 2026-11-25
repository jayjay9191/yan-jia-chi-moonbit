///|
test "review sample reports a precise annual change and the original evidence" {
  let a = "Basic $10/月按月、$8/月按年；Standard $30/$24"
  let b = "Basic $10/月按月、$8/月按年；Standard $30/$25"
  let result = @lib.compare_quote_snapshots(a, b)
  assert_eq(result.changes.length(), 1)
  let changed = result.changes[0]
  assert_eq(changed.plan, "Standard")
  assert_true(changed.annual)
  assert_eq(changed.before_source, Some("Standard $30/$24"))
  assert_eq(changed.after_source, Some("Standard $30/$25"))
  assert_eq(changed.year_delta, Some(1200L))
  let quote = "Pro $10/用户/月；Pro $96/用户/年"
  let reserve = @lib.plan_seat_risk(quote, "Pro", [
    Array::make(12, 2),
    Array::make(12, 8),
  ])
  assert_eq((reserve.annual_seats, reserve.worst_regret), (3, 12000L))
}

///|
test "review sample withholds price changes when an input contradicts itself" {
  let result = @lib.compare_quote_snapshots(
    "Basic $10/月；Basic $11/月", "Basic $12/月",
  )
  assert_true(!result.before_issues.is_empty())
  assert_true(result.after_issues.is_empty())
  assert_true(result.changes.is_empty())
}

///|
test "review respects the upfront budget before minimizing regret" {
  let quote = "Pro $10/用户/月；Pro $96/用户/年"
  let cases = [Array::make(12, 2), Array::make(12, 8)]
  let limited = @lib.plan_seat_risk(quote, "Pro", cases, annual_budget=25000L)
  assert_eq(
    (limited.annual_seats, limited.annual_commitment, limited.worst_regret),
    (2, 19200L, 14400L),
  )
  assert_eq(limited.scenarios.map(row => row.regret), [0L, 14400L])
  let no_prepaid = @lib.plan_seat_risk(quote, "Pro", cases, annual_budget=0L)
  assert_eq(
    (
      no_prepaid.annual_seats,
      no_prepaid.annual_commitment,
      no_prepaid.worst_regret,
    ),
    (0, 0L, 19200L),
  )
  let invalid = Ok(@lib.plan_seat_risk(quote, "Pro", cases, annual_budget=-1L)) catch {
    err => Err(err)
  }
  assert_true(invalid is Err(_))
}

///|
test "review enforces monthly overflow and rejects an impossible combination" {
  let quote = "Pro $10/用户/月；Pro $96/用户/年"
  let cases = [Array::make(12, 2), Array::make(12, 8)]
  let capacity = @lib.plan_seat_risk(
    quote,
    "Pro",
    cases,
    annual_budget=38400L,
    monthly_cap=4,
  )
  assert_eq(
    (capacity.annual_seats, capacity.annual_commitment, capacity.worst_regret),
    (4, 38400L, 19200L),
  )
  assert_eq(capacity.scenarios.map(row => row.peak_monthly_seats), [0, 4])
  let impossible = Ok(
    @lib.plan_seat_risk(
      quote,
      "Pro",
      cases,
      annual_budget=38399L,
      monthly_cap=4,
    ),
  ) catch {
    err => Err(err)
  }
  assert_true(impossible is Err(_))
}

///|
test "review retains all tied optimal integer reserves within budget" {
  let quote = "Pro $10/用户/月；Pro $60/用户/年"
  let cases = [Array::make(12, 2), Array::make(12, 7)]
  let tie = @lib.plan_seat_risk(quote, "Pro", cases)
  assert_eq(
    (tie.annual_seats, tie.max_optimal_annual_seats, tie.worst_regret),
    (4, 5, 18000L),
  )
  let clipped = @lib.plan_seat_risk(quote, "Pro", cases, annual_budget=29999L)
  assert_eq(
    (
      clipped.annual_seats,
      clipped.max_optimal_annual_seats,
      clipped.worst_regret,
    ),
    (4, 4, 18000L),
  )
}

///|
test "review recovers every seat count within a stated regret limit" {
  let quote = "Pro $10/用户/月；Pro $60/用户/年"
  let cases = [Array::make(12, 2), Array::make(12, 7)]
  let allowed = @lib.plan_seat_risk(quote, "Pro", cases, regret_limit=24000L)
  guard allowed.allowance is Some(allowance) &&
    allowance.feasible_seats is Some(seats) else {
    abort("expected feasible seat interval")
  }
  assert_eq((seats.minimum, seats.maximum), (3, 6))
  let impossible = @lib.plan_seat_risk(quote, "Pro", cases, regret_limit=17999L)
  guard impossible.allowance is Some(info) else {
    abort("expected assessed limit")
  }
  assert_true(info.feasible_seats is None)
  assert_eq(impossible.worst_regret, 18000L)
}

///|
test "review trades expected cost against the worst-case limit without rounding" {
  let quote = "Pro $10/用户/月；Pro $60/用户/年"
  let cases = [Array::make(12, 2), Array::make(12, 7)]
  let plan = @lib.plan_seat_risk(quote, "Pro", cases, regret_limit=24000L, scenario_weights=[
    1, 3,
  ])
  guard plan.weighted_plan is Some(choice) else {
    abort("expected weighted choice")
  }
  assert_eq(
    (plan.annual_seats, choice.annual_seats, choice.worst_regret),
    (4, 6, 24000L),
  )
  assert_eq((choice.cost_numerator, choice.weight_total), (180000L, 4))
  let impossible = @lib.plan_seat_risk(
    quote,
    "Pro",
    cases,
    regret_limit=17999L,
    scenario_weights=[1, 3],
  )
  assert_true(impossible.weighted_plan is None)
  let invalid = Ok(
    @lib.plan_seat_risk(quote, "Pro", cases, scenario_weights=[1, 256]),
  ) catch {
    err => Err(err)
  }
  assert_true(invalid is Err(_))
}

///|
test "review detects dominated seats and risk-tiebreaks an identical expected cost" {
  let quote = "Pro $10/用户/月；Pro $60/用户/年"
  let cases = [Array::make(12, 2), Array::make(12, 7)]
  let biased = @lib.plan_seat_risk(quote, "Pro", cases, regret_limit=24000L, scenario_weights=[
    1, 3,
  ])
  guard biased.weighted_plan is Some(choice) else {
    abort("expected weighted plan")
  }
  assert_eq((choice.pareto_seats.minimum, choice.pareto_seats.maximum), (5, 6))
  let flat = @lib.plan_seat_risk(quote, "Pro", cases, regret_limit=24000L, scenario_weights=[
    1, 1,
  ])
  guard flat.weighted_plan is Some(tied) else { abort("expected flat plan") }
  assert_eq((tied.pareto_seats.minimum, tied.pareto_seats.maximum), (4, 5))
  assert_eq((tied.annual_seats, tied.worst_regret), (4, 18000L))
}

///|
test "review an empty demand curve has exact zero weighted cost" {
  let quote = "Pro $10/用户/月；Pro $60/用户/年"
  let plan = @lib.plan_seat_risk(
    quote,
    "Pro",
    [Array::make(12, 0), Array::make(12, 0)],
    scenario_weights=[1, 255],
  )
  guard plan.weighted_plan is Some(weighted) else {
    abort("expected a zero-seat plan")
  }
  assert_eq(
    (weighted.annual_seats, weighted.cost_numerator, weighted.weight_total),
    (0, 0L, 256),
  )
}

///|
test "review partial scenario weights change the optimal tail-risk decision" {
  let quote = "Pro $10/用户/月；Pro $60/用户/年"
  let demand = [Array::make(12, 2), Array::make(12, 7)]
  let plan = @lib.plan_seat_risk(
    quote,
    "Pro",
    demand,
    regret_limit=24000L,
    scenario_weights=[1, 3],
    tail_weight=2,
  )
  guard plan.tail_plan is Some(tail) else { abort("expected tail optimizer") }
  assert_eq(
    (tail.annual_seats, tail.regret_numerator, tail.weight, tail.worst_regret),
    (5, 30000L, 2, 18000L),
  )
  assert_eq(plan.weighted_plan.unwrap().annual_seats, 6)
  let three = @lib.plan_seat_risk(
    quote,
    "Pro",
    demand,
    regret_limit=24000L,
    scenario_weights=[1, 3],
    tail_weight=3,
  )
  assert_eq(three.tail_plan.unwrap().annual_seats, 6)
  assert_eq(three.tail_plan.unwrap().regret_numerator, 36000L)
}

///|
test "review tail attribution exposes both tied reserves and a partial scenario weight" {
  let quote = "Pro $10/用户/月；Pro $60/用户/年"
  let cases = [Array::make(12, 2), Array::make(12, 7)]
  let plan = @lib.plan_seat_risk(
    quote,
    "Pro",
    cases,
    regret_limit=24000L,
    scenario_weights=[1, 3],
    tail_weight=2,
  )
  let tail = plan.tail_plan.unwrap()
  assert_eq((tail.optimal_seats.minimum, tail.optimal_seats.maximum), (5, 6))
  assert_eq(
    tail.contributions.map(item => {
      (item.scenario_index, item.regret, item.used_weight)
    }),
    [(0, 18000L, 1), (1, 12000L, 1)],
  )
  let clipped = @lib.plan_seat_risk(
    quote,
    "Pro",
    cases,
    annual_budget=30000L,
    scenario_weights=[1, 3],
    tail_weight=2,
  ).tail_plan.unwrap()
  assert_eq(
    (clipped.optimal_seats.minimum, clipped.optimal_seats.maximum),
    (5, 5),
  )
  let equal_regrets = @lib.plan_seat_risk(
    quote,
    "Pro",
    [cases[0], Array::make(12, 6)],
    scenario_weights=[1, 1],
    tail_weight=1,
  ).tail_plan.unwrap()
  assert_eq(equal_regrets.annual_seats, 4)
  assert_eq(equal_regrets.contributions[0].scenario_index, 0)
}

///|
test "review stress weights reverse the preferred tail plan but preserve a joint optimum" {
  let quote = "Pro $10/用户/月；Pro $60/用户/年"
  let scenarios = [Array::make(12, 2), Array::make(12, 7)]
  let plan = @lib.plan_seat_risk(
    quote,
    "Pro",
    scenarios,
    regret_limit=24000L,
    scenario_weights=[1, 3],
    tail_weight=3,
    stress_weights=[3, 1],
  )
  assert_eq(plan.tail_plan.unwrap().annual_seats, 6)
  let stress = plan.stress_tail_plan.unwrap()
  assert_eq((stress.annual_seats, stress.optimal_seats.maximum), (4, 5))
  assert_eq(
    (stress.baseline_numerator, stress.stress_numerator, stress.weight),
    (54000L, 42000L, 3),
  )
  let identical = @lib.plan_seat_risk(
    quote,
    "Pro",
    scenarios,
    regret_limit=24000L,
    scenario_weights=[1, 3],
    tail_weight=3,
    stress_weights=[1, 3],
  ).stress_tail_plan.unwrap()
  assert_eq(
    (
      identical.annual_seats,
      identical.baseline_numerator,
      identical.stress_numerator,
    ),
    (6, 36000L, 36000L),
  )
}

///|
test "review real price evidence keeps a gap separate from a documented reduction" {
  let tana = @lib.tool_by_name("Tana").unwrap()
  let trace = @lib.quote_evidence_chain(tana)
  assert_eq(trace.sessions.map(row => row.available), [false, true, true, false])
  let bridge = trace.links.filter(link => link.kind == "adjacent-sessions")
  assert_eq(bridge.map(link => (link.status, link.comparable_options)), [
    ("gap", 0),
    ("unchanged", 1),
    ("gap", 0),
  ])
  let changed = trace.links
    .iter()
    .find_first(link => {
      link.kind == "within-session" && link.after_session == "20261115-R3"
    })
    .unwrap()
  assert_eq(changed.changes[0].year_delta, Some(-4800L))
  assert_true(changed.changes[0].after_source.unwrap().contains("$15"))
  let midjourney = @lib.quote_evidence_chain(
    @lib.tool_by_name("Midjourney").unwrap(),
  )
  assert_true(
    midjourney.links.any(link => {
      link.kind == "adjacent-sessions" &&
      link.after_session == "20261123-R6" &&
      link.comparable_options == 8 &&
      link.status == "unchanged"
    }),
  )
}

///|
test "structured quote scope forbids numeric deltas on ambiguous evidence" {
  let before : @lib.QuoteObservation = {
    capture: "a",
    observed_on: "2026-11-18",
    source: "https://example.com/price",
    product: "Example",
    plan: "Standard",
    currency: "USD",
    unit: Some(Seat),
    billing: Some(Annual),
    tier: "flat",
    scope: "public",
    amount_minor: Some(12000L),
  }
  let after = {
    ..before,
    capture: "b",
    observed_on: "2026-11-23",
    amount_minor: Some(11500L),
  }
  let match_scope = @lib.compare_quote_observations(before, after)
  assert_eq(
    (match_scope.status, match_scope.delta_minor),
    ("comparable", Some(-500L)),
  )
  let mismatch = @lib.compare_quote_observations(before, {
    ..after,
    billing: Some(Monthly),
  })
  assert_eq((mismatch.status, mismatch.delta_minor), ("scope-mismatch", None))
  assert_eq(mismatch.reasons, ["billing"])
  let gap = @lib.compare_quote_observations(before, {
    ..after,
    product: "",
    amount_minor: None,
  })
  assert_eq((gap.status, gap.delta_minor), ("evidence-gap", None))
  assert_eq(gap.reasons, ["product", "amount_minor"])
}

///|
test "precise token costing preserves a fractional total beyond Int64 coefficients" {
  let input : @lib.QuoteObservation = {
    capture: "synthetic-scaled",
    observed_on: "2026-11-25",
    source: "https://example.com/pricing",
    product: "Synthetic Provider",
    plan: "Text",
    currency: "USD",
    unit: Some(MillionInputTokens),
    billing: Some(Usage),
    tier: "flat",
    scope: "standard",
    amount_minor: None,
  }
  let quote : @lib.PreciseCachedTokenRateWindow = {
    window: {
      min_input_tokens: 0L,
      max_input_tokens: None,
      min_output_tokens: 0L,
      max_output_tokens: None,
      input,
      output: { ..input, unit: Some(MillionOutputTokens), },
    },
    input_rate_minor: "0.000001",
    cache_hit_rate_minor: "0.000009",
    output_rate_minor: "0.5",
  }
  let bill = @lib.estimate_precise_cached_token_window_cost([quote], [
    {
      usage: {
        input_tokens: 2L,
        output_tokens: 0L,
        requests: 9223372036854775807L,
      },
      cached_input_tokens: 1L,
    },
  ])
  assert_eq(bill.cost.total, "92233720368547.75807")
  assert_eq(bill.cost.cache_hit, "83010348331692.982263")
  assert_eq(bill.cost.uncached_input, "9223372036854.775807")
  assert_eq(bill.cost.output, "0")
  assert_eq(bill.lines[0].cost.total, bill.cost.total)
}
