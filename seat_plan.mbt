///|
#derive(ToJson)
pub(all) struct SeatCostPlan {
  currency : String
  annual_seats : Int32
  seat_demand : Array[Int32]
  monthly_seats : Array[Int32]
  monthly_only : Int64
  annual_only : Int64
  best_total : Int64
}

///|
/// Compare static annual seats plus month-by-month overflow against pure billing options.
/// The model assumes that both billing cycles can coexist at the supplied fixed rates.
pub fn plan_seat_costs(
  raw : String,
  plan : String,
  seat_demand : Array[Int32],
) -> SeatCostPlan raise PricingAnalysisError {
  if seat_demand.length() != 12 ||
    seat_demand.any(count => count < 0 || count > 1000000) {
    raise InvalidAnalysis(
      "须提供 12 个月的席位数，每月 0 至 1,000,000",
    )
  }
  let report = plan_classes(raw)
  if !report.issues.is_empty() {
    raise InvalidAnalysis(join_strings(report.issues, "；"))
  }
  let options = session_options(report.classes)
  guard options.get((plan, false)) is Some((monthly, _)) &&
    options.get((plan, true)) is Some((annual, _)) else {
    raise InvalidAnalysis("套餐缺少固定月付或年付报价：" + plan)
  }
  if !monthly.per_seat ||
    !annual.per_seat ||
    !currency_eq(monthly.currency, annual.currency) {
    raise InvalidAnalysis("月付和年付必须同币种、均按席位计价")
  }
  let (per_month, _) = subscription_cost(monthly, 1)
  let (_, per_year) = subscription_cost(annual, 1)
  let candidates = [0]
  let mut peak = 0
  let mut monthly_only = 0L
  for requested in seat_demand {
    if !candidates.contains(requested) {
      candidates.push(requested)
    }
    if requested > peak {
      peak = requested
    }
    monthly_only += requested.to_int64() * per_month
  }
  // Between monthly demand levels the model is linear in reserved seats.
  let mut annual_seats = 0
  let mut best_total = monthly_only
  for reserve in candidates {
    let mut total = reserve.to_int64() * per_year
    for requested in seat_demand {
      if requested > reserve {
        total += (requested - reserve).to_int64() * per_month
      }
    }
    if total < best_total || (total == best_total && reserve < annual_seats) {
      best_total = total
      annual_seats = reserve
    }
  }
  {
    currency: currency_code(monthly.currency),
    annual_seats,
    seat_demand: seat_demand.copy(),
    monthly_seats: seat_demand.map(requested => {
      if requested > annual_seats {
        requested - annual_seats
      } else {
        0
      }
    }),
    monthly_only,
    annual_only: peak.to_int64() * per_year,
    best_total,
  }
}
