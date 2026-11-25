///|
#derive(FromJson)
pub(all) struct TokenRateBand {
  min_input_tokens : Int64
  input : QuoteObservation
  output : QuoteObservation
}

///|
#derive(FromJson)
pub(all) struct TokenRateWindow {
  min_input_tokens : Int64
  max_input_tokens : Int64?
  min_output_tokens : Int64
  max_output_tokens : Int64?
  input : QuoteObservation
  output : QuoteObservation
}

///|
#derive(FromJson, ToJson)
pub(all) struct TokenUsage {
  input_tokens : Int64
  output_tokens : Int64
  requests : Int64
}

///|
#derive(ToJson)
pub(all) struct TokenCostLine {
  usage : TokenUsage
  tier : String
  cost_millionths_minor : String
}

///|
#derive(ToJson)
pub(all) struct TokenCostEstimate {
  product : String
  plan : String
  currency : String
  capture : String
  observed_on : String
  source : String
  cost_millionths_minor : String
  lines : Array[TokenCostLine]
}

///|
fn same_rate_capture(a : QuoteObservation, b : QuoteObservation) -> Bool {
  a.capture == b.capture &&
  a.observed_on == b.observed_on &&
  a.source == b.source &&
  a.product == b.product &&
  a.plan == b.plan &&
  a.currency == b.currency &&
  a.scope == b.scope
}

///|
priv struct TokenRate {
  label : String
  input_minor : @bigint.BigInt
  output_minor : @bigint.BigInt
}

///|
fn validate_token_rate(
  first : QuoteObservation,
  input : QuoteObservation,
  output : QuoteObservation,
  labels : Map[String, Bool],
) -> TokenRate raise QuoteObservationError {
  validate_observation(input)
  validate_observation(output)
  if !same_rate_capture(first, input) ||
    !same_rate_capture(input, output) ||
    input.capture.trim().is_empty() ||
    input.observed_on.is_empty() ||
    input.source.is_empty() ||
    input.product.trim().is_empty() ||
    input.plan.trim().is_empty() ||
    input.scope.trim().is_empty() ||
    input.currency.is_empty() {
    raise InvalidObservation(
      "token rate evidence must share a complete capture and scope",
    )
  }
  if input.tier.trim().is_empty() ||
    input.tier != output.tier ||
    labels.contains(input.tier) {
    raise InvalidObservation("token tiers require matching unique labels")
  }
  guard input.unit is Some(MillionInputTokens) &&
    output.unit is Some(MillionOutputTokens) &&
    input.billing is Some(Usage) &&
    output.billing is Some(Usage) &&
    input.amount_minor is Some(in_minor) &&
    output.amount_minor is Some(out_minor) else {
    raise InvalidObservation("token tiers require both input and output prices")
  }
  labels[input.tier] = true
  {
    label: input.tier,
    input_minor: @bigint.BigInt::from_int64(in_minor),
    output_minor: @bigint.BigInt::from_int64(out_minor),
  }
}

///|
/// Estimate uncached usage for one captured schedule. The caller supplies
/// explicit inclusive input-length cutoffs, starting at zero. A request uses
/// its selected band's rates for every token. Return exact millionths of the
/// currency's minor unit as decimal strings, without invoice rounding.
pub fn estimate_token_cost(
  bands : Array[TokenRateBand],
  usage : Array[TokenUsage],
) -> TokenCostEstimate raise QuoteObservationError {
  let ordered = bands.copy()
  ordered.sort_by((a, b) => a.min_input_tokens.compare(b.min_input_tokens))
  if ordered.is_empty() || ordered[0].min_input_tokens != 0L {
    raise InvalidObservation("token schedule must start at zero input tokens")
  }
  let first = ordered[0].input
  let labels : Map[String, Bool] = Map([])
  let mut previous = -1L
  let rates : Array[TokenRate] = []
  for band in ordered {
    if band.min_input_tokens <= previous {
      raise InvalidObservation("token tiers require unique cutoffs")
    }
    rates.push(validate_token_rate(first, band.input, band.output, labels))
    previous = band.min_input_tokens
  }
  price_token_usage(first, usage, row => {
    let mut lo = 0
    let mut hi = ordered.length()
    while lo + 1 < hi {
      let middle = lo + (hi - lo) / 2
      if ordered[middle].min_input_tokens <= row.input_tokens {
        lo = middle
      } else {
        hi = middle
      }
    }
    rates[lo]
  })
}

///|
fn below_token_limit(tokens : Int64, limit : Int64?) -> Bool {
  match limit {
    Some(value) => tokens < value
    None => true
  }
}

///|
/// Estimate uncached usage from non-overlapping input/output rate windows.
/// Each length interval is inclusive at its minimum and exclusive at its
/// optional maximum. An unpriced request invalidates the whole estimate.
pub fn estimate_token_window_cost(
  windows : Array[TokenRateWindow],
  usage : Array[TokenUsage],
) -> TokenCostEstimate raise QuoteObservationError {
  guard windows.get(0) is Some(first_window) else {
    raise InvalidObservation("token schedule requires at least one rate window")
  }
  let first = first_window.input
  let labels : Map[String, Bool] = Map([])
  let rates : Array[TokenRate] = []
  for i in 0..<windows.length() {
    let tier = windows[i]
    if tier.min_input_tokens < 0L ||
      tier.min_output_tokens < 0L ||
      !below_token_limit(tier.min_input_tokens, tier.max_input_tokens) ||
      !below_token_limit(tier.min_output_tokens, tier.max_output_tokens) {
      raise InvalidObservation(
        "token windows require nonnegative, nonempty intervals",
      )
    }
    // ponytail: pairwise checks are for small published rate cards; index large schedules if needed.
    for j in 0..<i {
      let other = windows[j]
      if below_token_limit(tier.min_input_tokens, other.max_input_tokens) &&
        below_token_limit(other.min_input_tokens, tier.max_input_tokens) &&
        below_token_limit(tier.min_output_tokens, other.max_output_tokens) &&
        below_token_limit(other.min_output_tokens, tier.max_output_tokens) {
        raise InvalidObservation("token rate windows overlap")
      }
    }
    rates.push(validate_token_rate(first, tier.input, tier.output, labels))
  }
  price_token_usage(first, usage, row => {
    guard windows.search_by(tier => {
        tier.min_input_tokens <= row.input_tokens &&
        below_token_limit(row.input_tokens, tier.max_input_tokens) &&
        tier.min_output_tokens <= row.output_tokens &&
        below_token_limit(row.output_tokens, tier.max_output_tokens)
      })
      is Some(index) else {
      raise InvalidObservation(
        "no token rate for input \{row.input_tokens}, output \{row.output_tokens}",
      )
    }
    rates[index]
  })
}

///|
fn price_token_usage(
  quote : QuoteObservation,
  usage : Array[TokenUsage],
  select_rate : (TokenUsage) -> TokenRate raise QuoteObservationError,
) -> TokenCostEstimate raise QuoteObservationError {
  let lines : Array[TokenCostLine] = []
  let mut total = @bigint.BigInt::from_int(0)
  for row in usage {
    if row.input_tokens < 0L || row.output_tokens < 0L || row.requests <= 0L {
      raise InvalidObservation(
        "token counts must be nonnegative and requests positive",
      )
    }
    let rate = select_rate(row)
    let cost = (
        @bigint.BigInt::from_int64(row.input_tokens) * rate.input_minor +
        @bigint.BigInt::from_int64(row.output_tokens) * rate.output_minor
      ) *
      @bigint.BigInt::from_int64(row.requests)
    total = total + cost
    lines.push({
      usage: row,
      tier: rate.label,
      cost_millionths_minor: cost.to_string(),
    })
  }
  {
    product: quote.product,
    plan: quote.plan,
    currency: quote.currency,
    capture: quote.capture,
    observed_on: quote.observed_on,
    source: quote.source,
    cost_millionths_minor: total.to_string(),
    lines,
  }
}
