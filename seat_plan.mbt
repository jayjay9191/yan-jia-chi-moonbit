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
fn validate_seat_counts(
  seat_demand : Array[Int32],
) -> Unit raise PricingAnalysisError {
  if seat_demand.length() != 12 ||
    seat_demand.any(count => count < 0 || count > 1000000) {
    raise InvalidAnalysis(
      "须提供 12 个月的席位数，每月 0 至 1,000,000",
    )
  }
}

///|
fn quoted_seat_rates(
  raw : String,
  plan : String,
) -> (String, Int64, Int64) raise PricingAnalysisError {
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
  (currency_code(monthly.currency), per_month, per_year)
}

///|
fn seat_cost_at(
  demand : Array[Int32],
  reserve : Int32,
  month : Int64,
  year : Int64,
) -> Int64 {
  demand.fold(init=reserve.to_int64() * year, (total, requested) => {
    total +
    (if requested > reserve {
      (requested - reserve).to_int64() * month
    } else {
      0L
    })
  })
}

///|
fn seat_peak(demand : Array[Int32]) -> Int32 {
  demand.fold(init=0, (peak, count) => if count > peak { count } else { peak })
}

///|
fn seat_breakpoint_optimum(
  demand : Array[Int32],
  month : Int64,
  year : Int64,
) -> (Int32, Int64) {
  // Between demand levels the cost is linear in reserved seats.
  let mut reserved = 0
  let mut best = seat_cost_at(demand, 0, month, year)
  for candidate in demand {
    let cost = seat_cost_at(demand, candidate, month, year)
    if cost < best || (cost == best && candidate < reserved) {
      best = cost
      reserved = candidate
    }
  }
  (reserved, best)
}

///|
/// Compare static annual seats plus month-by-month overflow against pure billing options.
pub fn plan_seat_costs(
  raw : String,
  plan : String,
  seat_demand : Array[Int32],
) -> SeatCostPlan raise PricingAnalysisError {
  validate_seat_counts(seat_demand)
  let (currency, month, year) = quoted_seat_rates(raw, plan)
  let (annual_seats, best_total) = seat_breakpoint_optimum(
    seat_demand, month, year,
  )
  {
    currency,
    annual_seats,
    seat_demand: seat_demand.copy(),
    monthly_seats: seat_demand.map(requested => {
      if requested > annual_seats {
        requested - annual_seats
      } else {
        0
      }
    }),
    monthly_only: seat_cost_at(seat_demand, 0, month, year),
    annual_only: seat_peak(seat_demand).to_int64() * year,
    best_total,
  }
}

///|
#derive(ToJson)
pub(all) struct SeatRiskScenario {
  cost : Int64
  known_demand_optimum : Int64
  peak_monthly_seats : Int32
  regret : Int64
}

///|
#derive(ToJson)
pub(all) struct SeatRiskPlan {
  currency : String
  annual_seats : Int32
  max_optimal_annual_seats : Int32
  annual_commitment : Int64
  worst_regret : Int64
  scenarios : Array[SeatRiskScenario]
}

///|
/// Minimize the largest excess cost over each scenario's unconstrained optimum.
/// An upfront budget limits annual seats in the quoted currency's hundredths.
/// A monthly cap limits the number of overflow seats that can be bought each month.
pub fn plan_seat_risk(
  raw : String,
  plan : String,
  scenarios : Array[Array[Int32]],
  annual_budget? : Int64,
  monthly_cap? : Int32,
) -> SeatRiskPlan raise PricingAnalysisError {
  if scenarios.length() < 2 || scenarios.length() > 16 {
    raise InvalidAnalysis("须提供 2 至 16 组席位需求情景")
  }
  for demand in scenarios {
    validate_seat_counts(demand)
  }
  let (currency, month, year) = quoted_seat_rates(raw, plan)
  let optima = scenarios.map(demand => {
    seat_breakpoint_optimum(demand, month, year).1
  })
  let worst = reserve => {
    let mut largest = 0L
    for i in 0..<scenarios.length() {
      let add = seat_cost_at(scenarios[i], reserve, month, year) - optima[i]
      if add > largest {
        largest = add
      }
    }
    largest
  }
  let peaks = scenarios.map(seat_peak)
  let peak = peaks.fold(init=0, (largest, requested) => {
    if requested > largest {
      requested
    } else {
      largest
    }
  })
  let cap = monthly_cap.unwrap_or(peak)
  if cap < 0 {
    raise InvalidAnalysis("每月补位上限不能为负数")
  }
  let mut lo = if peak > cap { peak - cap } else { 0 }
  let mut hi = peak
  if annual_budget is Some(budget) {
    if budget < 0L {
      raise InvalidAnalysis("年付预付预算不能为负数")
    }
    if year > 0L && budget / year < hi.to_int64() {
      hi = (budget / year).to_int()
    }
  }
  if lo > hi {
    raise InvalidAnalysis(
      "预付预算最多可预留 \{hi} 席；要满足每月补位上限至少需预留 \{lo} 席",
    )
  }
  let upper_limit = hi
  // The two constraints truncate the integer interval without changing convexity.
  // Maximum of convex scenario regrets is convex. Search the first nonnegative discrete slope.
  while lo < hi {
    let mid = lo + (hi - lo) / 2
    if worst(mid) <= worst(mid + 1) {
      hi = mid
    } else {
      lo = mid + 1
    }
  }
  let best_regret = worst(lo)
  let mut last = lo
  hi = upper_limit
  // To the right of the first minimum the regret cannot decrease.
  while last < hi {
    let mid = last + (hi - last + 1) / 2
    if worst(mid) == best_regret {
      last = mid
    } else {
      hi = mid - 1
    }
  }
  {
    currency,
    annual_seats: lo,
    max_optimal_annual_seats: last,
    annual_commitment: lo.to_int64() * year,
    worst_regret: best_regret,
    scenarios: Array::makei(scenarios.length(), i => {
      let cost = seat_cost_at(scenarios[i], lo, month, year)
      let requested = peaks[i]
      {
        cost,
        known_demand_optimum: optima[i],
        regret: cost - optima[i],
        peak_monthly_seats: if requested > lo {
          requested - lo
        } else {
          0
        },
      }
    }),
  }
}
