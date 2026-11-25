///|
test "usage cost applies the selected whole-request band and sums exact sub-minor amounts" {
  let low_in : QuoteObservation = {
    capture: "synthetic-capture",
    observed_on: "2026-11-23",
    source: "https://example.com/pricing",
    product: "test-api",
    plan: "test-model",
    currency: "CNY",
    unit: Some(MillionInputTokens),
    billing: Some(Usage),
    tier: "short",
    scope: "standard",
    amount_minor: Some(600L),
  }
  let low_out = {
    ..low_in,
    unit: Some(MillionOutputTokens),
    amount_minor: Some(2400L),
  }
  let high_in = { ..low_in, tier: "long", amount_minor: Some(800L), }
  let high_out = { ..low_out, tier: "long", amount_minor: Some(2800L), }
  let bands : Array[TokenRateBand] = [
    { min_input_tokens: 32000L, input: high_in, output: high_out, },
    { min_input_tokens: 0L, input: low_in, output: low_out, },
  ]
  let rows : Array[TokenUsage] = [
    { input_tokens: 31999L, output_tokens: 1L, requests: 2L, },
    { input_tokens: 32000L, output_tokens: 1L, requests: 1L, },
  ]
  let result = estimate_token_cost(bands, rows)
  assert_eq(result.cost_millionths_minor, "64006400")
  assert_eq(result.lines.map(row => row.tier), ["short", "long"])
  let bad = { ..high_out, capture: "other-capture", }
  assert_true(
    try {
      ignore(
        estimate_token_cost([bands[1], { ..bands[0], output: bad, }], rows),
      )
      false
    } catch {
      InvalidObservation(_) => true
    },
  )
  assert_true(
    try {
      ignore(estimate_token_cost([bands[0]], rows))
      false
    } catch {
      InvalidObservation(_) => true
    },
  )
  assert_true(
    try {
      ignore(estimate_token_cost([bands[1], bands[1]], rows))
      false
    } catch {
      InvalidObservation(_) => true
    },
  )
}
