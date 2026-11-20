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
