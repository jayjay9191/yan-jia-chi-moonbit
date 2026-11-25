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

///|
test "token rate rectangles separate both lengths and expose overlaps and gaps" {
  let base : QuoteObservation = {
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
    amount_minor: Some(200L),
  }
  let short : TokenRateWindow = {
    min_input_tokens: 0L,
    max_input_tokens: Some(32000L),
    min_output_tokens: 0L,
    max_output_tokens: Some(200L),
    input: base,
    output: {
      ..base,
      unit: Some(MillionOutputTokens),
      amount_minor: Some(800L),
    },
  }
  let longer = {
    ..short,
    min_output_tokens: 200L,
    max_output_tokens: None,
    input: { ..base, tier: "long-output", amount_minor: Some(300L), },
    output: { ..short.output, tier: "long-output", amount_minor: Some(1400L), },
  }
  let rows : Array[TokenUsage] = [
    { input_tokens: 1000L, output_tokens: 199L, requests: 1L, },
    { input_tokens: 1000L, output_tokens: 200L, requests: 1L, },
  ]
  let actual = estimate_token_window_cost([longer, short], rows)
  assert_eq(actual.lines.map(row => row.tier), ["short", "long-output"])
  assert_eq(actual.cost_millionths_minor, "939200")
  assert_true(
    try {
      ignore(
        estimate_token_window_cost(
          [short, { ..longer, min_output_tokens: 199L, }],
          [],
        ),
      )
      false
    } catch {
      InvalidObservation(message) => message.contains("overlap")
    },
  )
  assert_true(
    try {
      ignore(
        estimate_token_window_cost([short, longer], [
          { ..rows[0], input_tokens: 32000L, },
        ]),
      )
      false
    } catch {
      InvalidObservation(message) => message.contains("no token rate")
    },
  )
}

///|
test "cache hits subtract from ordinary input without changing the rate window" {
  let input : QuoteObservation = {
    capture: "synthetic-cache",
    observed_on: "2026-11-25",
    source: "https://example.com/pricing",
    product: "test-api",
    plan: "test-model",
    currency: "CNY",
    unit: Some(MillionInputTokens),
    billing: Some(Usage),
    tier: "large",
    scope: "public-standard",
    amount_minor: Some(400L),
  }
  let rates : Array[CachedTokenRateWindow] = [
    {
      window: {
        min_input_tokens: 1000L,
        max_input_tokens: None,
        min_output_tokens: 0L,
        max_output_tokens: None,
        input,
        output: {
          ..input,
          unit: Some(MillionOutputTokens),
          amount_minor: Some(1600L),
        },
      },
      cache_hit_minor: 80L,
    },
  ]
  let usage : CachedTokenUsage = {
    usage: { input_tokens: 1000L, output_tokens: 10L, requests: 2L, },
    cached_input_tokens: 900L,
  }
  let result = estimate_cached_token_window_cost(rates, [usage])
  assert_eq(result.cost.total, "256000")
  assert_eq(result.cost.uncached_input, "80000")
  assert_eq(result.cost.cache_hit, "144000")
  assert_eq(result.cost.output, "32000")
  assert_eq(result.lines[0].tier, "large")
  assert_true(
    try {
      ignore(
        estimate_cached_token_window_cost(rates, [
          { ..usage, cached_input_tokens: 1001L, },
        ]),
      )
      false
    } catch {
      InvalidObservation(message) => message.contains("cached input")
    },
  )
}
