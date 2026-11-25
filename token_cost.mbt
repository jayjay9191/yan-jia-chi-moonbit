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
  let (first, rates) = validate_window_schedule(windows)
  price_token_usage(first, usage, row => rates[find_token_window(windows, row)])
}

///|
fn validate_window_schedule(
  windows : Array[TokenRateWindow],
) -> (QuoteObservation, Array[TokenRate]) raise QuoteObservationError {
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
  (first, rates)
}

///|
fn find_token_window(
  windows : Array[TokenRateWindow],
  row : TokenUsage,
) -> Int32 raise QuoteObservationError {
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
  index
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
    validate_token_usage(row)
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

///|
fn validate_token_usage(row : TokenUsage) -> Unit raise QuoteObservationError {
  if row.input_tokens < 0L || row.output_tokens < 0L || row.requests <= 0L {
    raise InvalidObservation(
      "token counts must be nonnegative and requests positive",
    )
  }
}

///|
/// The cache-hit rate belongs to the same captured rate card as the window.
#derive(FromJson)
pub(all) struct CachedTokenRateWindow {
  window : TokenRateWindow
  cache_hit_minor : Int64
}

///|
/// Cached input is a subset of total request input.
#derive(FromJson, ToJson)
pub(all) struct CachedTokenUsage {
  usage : TokenUsage
  cached_input_tokens : Int64
}

///|
/// All fields encode millionths of the currency's minor unit as decimal strings.
/// Precise rates can yield a fractional part in that unit.
#derive(ToJson)
pub(all) struct TokenCostBreakdown {
  uncached_input : String
  cache_hit : String
  output : String
  total : String
}

///|
#derive(ToJson)
pub(all) struct CachedTokenCostLine {
  usage : CachedTokenUsage
  tier : String
  cost : TokenCostBreakdown
}

///|
#derive(ToJson)
pub(all) struct CachedTokenCostEstimate {
  product : String
  plan : String
  currency : String
  capture : String
  observed_on : String
  source : String
  cost : TokenCostBreakdown
  lines : Array[CachedTokenCostLine]
}

///|
fn token_cost_breakdown(
  uncached_input : @bigint.BigInt,
  cache_hit : @bigint.BigInt,
  output : @bigint.BigInt,
) -> TokenCostBreakdown {
  {
    uncached_input: uncached_input.to_string(),
    cache_hit: cache_hit.to_string(),
    output: output.to_string(),
    total: (uncached_input + cache_hit + output).to_string(),
  }
}

///|
/// Price the cached part of input at the cache-hit rate. Tier selection
/// uses total input and output. Cache storage, write and invoice fees are excluded.
pub fn estimate_cached_token_window_cost(
  windows : Array[CachedTokenRateWindow],
  usage : Array[CachedTokenUsage],
) -> CachedTokenCostEstimate raise QuoteObservationError {
  let schedule = windows.map(row => row.window)
  let (quote, rates) = validate_window_schedule(schedule)
  let cache_rates = windows.map(row => {
    @bigint.BigInt::from_int64(row.cache_hit_minor)
  })
  if windows.iter().any(row => row.cache_hit_minor < 0L) {
    raise InvalidObservation("cache-hit rate must be nonnegative")
  }
  let mut total_input = @bigint.BigInt::from_int(0)
  let mut total_cache = @bigint.BigInt::from_int(0)
  let mut total_output = @bigint.BigInt::from_int(0)
  let lines : Array[CachedTokenCostLine] = []
  for row in usage {
    let request = row.usage
    let cached = row.cached_input_tokens
    validate_token_usage(request)
    if cached < 0L || cached > request.input_tokens {
      raise InvalidObservation(
        "cached input must be between zero and total input",
      )
    }
    let index = find_token_window(schedule, request)
    let rate = rates[index]
    let count = @bigint.BigInt::from_int64(request.requests)
    let input = @bigint.BigInt::from_int64(request.input_tokens - cached) *
      rate.input_minor *
      count
    let cache = @bigint.BigInt::from_int64(cached) * cache_rates[index] * count
    let output = @bigint.BigInt::from_int64(request.output_tokens) *
      rate.output_minor *
      count
    total_input = total_input + input
    total_cache = total_cache + cache
    total_output = total_output + output
    lines.push({
      usage: row,
      tier: rate.label,
      cost: token_cost_breakdown(input, cache, output),
    })
  }
  {
    product: quote.product,
    plan: quote.plan,
    currency: quote.currency,
    capture: quote.capture,
    observed_on: quote.observed_on,
    source: quote.source,
    cost: token_cost_breakdown(total_input, total_cache, total_output),
    lines,
  }
}

///|
/// Quote observations in the window describe evidence and units.
/// Put prices in the three decimal rate fields instead of amount_minor.
#derive(FromJson)
pub(all) struct PreciseCachedTokenRateWindow {
  window : TokenRateWindow
  input_rate_minor : String
  cache_hit_rate_minor : String
  output_rate_minor : String
}

///|
const RATE_FRACTION_DIGITS : Int32 = 6

///|
fn precise_token_rate(value : String) -> Int64 raise QuoteObservationError {
  let (whole, fraction) = match value.split_once(".") {
    Some((whole, fraction)) if !fraction.is_empty() => (whole, fraction)
    Some(_) =>
      raise InvalidObservation(
        "token rate requires digits after the decimal point",
      )
    None => (value.clamped_view(), "".clamped_view())
  }
  if whole.is_empty() ||
    whole.iter().any(c => !c.is_ascii_digit()) ||
    fraction.length() > RATE_FRACTION_DIGITS ||
    fraction.iter().any(c => !c.is_ascii_digit()) {
    raise InvalidObservation(
      "token rates must be nonnegative decimals with at most six fractional digits",
    )
  }
  let coefficient = whole.to_owned() +
    fraction.pad_end(RATE_FRACTION_DIGITS, '0')
  @string.parse_int64(coefficient) catch {
    _ => raise InvalidObservation("token rate exceeds the fixed-point range")
  }
}

///|
fn unscale_token_cost(coefficient : String) -> String {
  let digits = coefficient.pad_start(RATE_FRACTION_DIGITS + 1, '0')
  let point = digits.length() - RATE_FRACTION_DIGITS
  let whole = digits.clamped_view(end=point).to_owned()
  let fraction = digits.clamped_view(start=point).trim_end(chars="0")
  if fraction.is_empty() {
    whole
  } else {
    whole + "." + fraction.to_owned()
  }
}

///|
fn unscale_token_breakdown(cost : TokenCostBreakdown) -> TokenCostBreakdown {
  {
    uncached_input: unscale_token_cost(cost.uncached_input),
    cache_hit: unscale_token_cost(cost.cache_hit),
    output: unscale_token_cost(cost.output),
    total: unscale_token_cost(cost.total),
  }
}

///|
/// Price decimal rates per million tokens as exact fixed-point coefficients.
/// Return amounts in millionths of a minor unit without rounding.
pub fn estimate_precise_cached_token_window_cost(
  windows : Array[PreciseCachedTokenRateWindow],
  usage : Array[CachedTokenUsage],
) -> CachedTokenCostEstimate raise QuoteObservationError {
  let scaled = windows.map(row => {
    let window = row.window
    if window.input.amount_minor is Some(_) ||
      window.output.amount_minor is Some(_) {
      raise InvalidObservation(
        "omit amount_minor when using decimal rate fields",
      )
    }
    {
      window: {
        ..window,
        input: {
          ..window.input,
          amount_minor: Some(precise_token_rate(row.input_rate_minor)),
        },
        output: {
          ..window.output,
          amount_minor: Some(precise_token_rate(row.output_rate_minor)),
        },
      },
      cache_hit_minor: precise_token_rate(row.cache_hit_rate_minor),
    }
  })
  let estimate = estimate_cached_token_window_cost(scaled, usage)
  {
    ..estimate,
    cost: unscale_token_breakdown(estimate.cost),
    lines: estimate.lines.map(line => {
      ..line,
      cost: unscale_token_breakdown(line.cost),
    }),
  }
}
