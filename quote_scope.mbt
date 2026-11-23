///|
#derive(FromJson, ToJson, Eq)
pub(all) enum QuoteUnit {
  Account
  Seat
  MillionInputTokens
  MillionOutputTokens
}

///|
#derive(FromJson, ToJson, Eq)
pub(all) enum BillingCycle {
  Monthly
  Annual
  Usage
}

///|
/// An attributed observation of one priced option. A subscription amount is
/// the charge per selected billing period and unit. A usage amount is the
/// charge per usage unit. All amounts use the currency's minor unit.
#derive(FromJson, ToJson)
pub(all) struct QuoteObservation {
  capture : String
  observed_on : String
  source : String
  product : String
  plan : String
  currency : String
  unit : QuoteUnit?
  billing : BillingCycle?
  tier : String
  scope : String
  amount_minor : Int64?
}

///|
#derive(ToJson)
pub(all) struct QuoteScopeVerdict {
  before_capture : String
  after_capture : String
  status : String
  reasons : Array[String]
  delta_minor : Int64?
}

///|
pub suberror QuoteObservationError {
  InvalidObservation(String)
}

///|
fn validate_observation(
  row : QuoteObservation,
) -> Unit raise QuoteObservationError {
  if row.observed_on != "" && !is_valid_date(row.observed_on) {
    raise InvalidObservation("observed_on must be a valid date")
  }
  if row.source != "" &&
    (!row.source.has_prefix("https://") || row.source.length() <= 8) {
    raise InvalidObservation("source must be a public HTTPS address")
  }
  if row.currency != "" &&
    (
      row.currency.length() != 3 ||
      row.currency.iter().any(c => c < 'A' || c > 'Z')
    ) {
    raise InvalidObservation("currency must be a three-letter uppercase code")
  }
  if row.amount_minor is Some(n) && n < 0L {
    raise InvalidObservation("amount_minor must be nonnegative")
  }
  if row.unit is Some(unit) && row.billing is Some(cycle) {
    let meters = unit is MillionInputTokens || unit is MillionOutputTokens
    if meters != (cycle is Usage) {
      raise InvalidObservation(
        "usage billing requires a token unit, and subscription billing an account or seat",
      )
    }
  }
}

///|
/// Compare two separate observations. Missing provenance or scope prevents
/// a price delta. Different periods, currencies and usage tiers are reported.
pub fn compare_quote_observations(
  before : QuoteObservation,
  after : QuoteObservation,
) -> QuoteScopeVerdict raise QuoteObservationError {
  validate_observation(before)
  validate_observation(after)
  let identity = [
    ("product", before.product, after.product),
    ("plan", before.plan, after.plan),
    ("currency", before.currency, after.currency),
    ("tier", before.tier, after.tier),
    ("scope", before.scope, after.scope),
  ]
  let missing : Array[String] = []
  let differences : Array[String] = []
  for item in identity {
    let (name, a, b) = item
    if a.trim().is_empty() || b.trim().is_empty() {
      missing.push(name)
    } else if a != b {
      differences.push(name)
    }
  }
  for
    field in [
      ("capture", before.capture, after.capture),
      ("observed_on", before.observed_on, after.observed_on),
      ("source", before.source, after.source),
    ] {
    let (name, a, b) = field
    if a.trim().is_empty() || b.trim().is_empty() {
      missing.push(name)
    }
  }
  if before.capture != "" && before.capture == after.capture {
    missing.push("independent_capture")
  }
  if before.observed_on != "" &&
    after.observed_on != "" &&
    date_to_days(after.observed_on) < date_to_days(before.observed_on) {
    raise InvalidObservation(
      "after observation date precedes before observation",
    )
  }
  match (before.unit, after.unit) {
    (Some(a), Some(b)) => if a != b { differences.push("unit") }
    _ => missing.push("unit")
  }
  match (before.billing, after.billing) {
    (Some(a), Some(b)) => if a != b { differences.push("billing") }
    _ => missing.push("billing")
  }
  let amounts = match (before.amount_minor, after.amount_minor) {
    (Some(a), Some(b)) => Some(b - a)
    _ => {
      missing.push("amount_minor")
      None
    }
  }
  let (status, reasons, delta_minor) = if !missing.is_empty() {
    ("evidence-gap", missing, None)
  } else if !differences.is_empty() {
    ("scope-mismatch", differences, None)
  } else {
    ("comparable", [], amounts)
  }
  {
    before_capture: before.capture,
    after_capture: after.capture,
    status,
    reasons,
    delta_minor,
  }
}
