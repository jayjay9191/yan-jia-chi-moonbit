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
