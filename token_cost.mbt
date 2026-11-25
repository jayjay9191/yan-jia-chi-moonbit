///|
#derive(FromJson)
pub(all) struct TokenRateBand {
  min_input_tokens : Int64
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
  let rates : Array[(@bigint.BigInt, @bigint.BigInt)] = []
  for band in ordered {
    let input = band.input
    let output = band.output
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
    if band.min_input_tokens <= previous ||
      input.tier.trim().is_empty() ||
      input.tier != output.tier ||
      labels.contains(input.tier) {
      raise InvalidObservation(
        "token tiers require unique cutoffs and matching unique labels",
      )
    }
    guard input.unit is Some(MillionInputTokens) &&
      output.unit is Some(MillionOutputTokens) &&
      input.billing is Some(Usage) &&
      output.billing is Some(Usage) &&
      input.amount_minor is Some(in_minor) &&
      output.amount_minor is Some(out_minor) else {
      raise InvalidObservation(
        "token tiers require both input and output prices",
      )
    }
    labels[input.tier] = true
    rates.push(
      (
        @bigint.BigInt::from_int64(in_minor),
        @bigint.BigInt::from_int64(out_minor),
      ),
    )
    previous = band.min_input_tokens
  }
  let lines : Array[TokenCostLine] = []
  let mut total = @bigint.BigInt::from_int(0)
  for row in usage {
    if row.input_tokens < 0L || row.output_tokens < 0L || row.requests <= 0L {
      raise InvalidObservation(
        "token counts must be nonnegative and requests positive",
      )
    }
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
    let (in_rate, out_rate) = rates[lo]
    let cost = (
        @bigint.BigInt::from_int64(row.input_tokens) * in_rate +
        @bigint.BigInt::from_int64(row.output_tokens) * out_rate
      ) *
      @bigint.BigInt::from_int64(row.requests)
    total = total + cost
    lines.push({
      usage: row,
      tier: ordered[lo].input.tier,
      cost_millionths_minor: cost.to_string(),
    })
  }
  {
    product: first.product,
    plan: first.plan,
    currency: first.currency,
    capture: first.capture,
    observed_on: first.observed_on,
    source: first.source,
    cost_millionths_minor: total.to_string(),
    lines,
  }
}
