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
pub(all) struct SeatReserveInterval {
  minimum : Int32
  maximum : Int32
}

///|
#derive(ToJson)
pub(all) struct SeatRiskAllowance {
  limit : Int64
  feasible_seats : SeatReserveInterval?
}

///|
#derive(ToJson)
pub(all) struct WeightedSeatPlan {
  annual_seats : Int32
  cost_numerator : Int64
  pareto_seats : SeatReserveInterval
  weight_total : Int32
  worst_regret : Int64
}

///|
#derive(ToJson)
pub(all) struct TailSeatContribution {
  scenario_index : Int32
  regret : Int64
  used_weight : Int32
}

///|
#derive(ToJson)
pub(all) struct TailSeatPlan {
  annual_seats : Int32
  optimal_seats : SeatReserveInterval
  regret_numerator : Int64
  weight : Int32
  worst_regret : Int64
  contributions : Array[TailSeatContribution]
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
  allowance : SeatRiskAllowance?
  weighted_plan : WeightedSeatPlan?
  tail_plan : TailSeatPlan?
}

///|
priv struct WeightedDemandKnot {
  demand : Int32
  weight : Int64
  weighted_demand : Int64
}

///|
priv struct WeightedDemandCurve {
  knots : Array[WeightedDemandKnot]
  month : Int64
  annual_weighted : Int64
}

///|
fn build_weighted_curve(
  scenarios : Array[Array[Int32]],
  weights : Array[Int32],
  month : Int64,
  year : Int64,
) -> WeightedDemandCurve {
  let observations : Array[(Int32, Int64)] = []
  let mut weight_total = 0L
  for i, scenario in scenarios {
    let weight = weights[i].to_int64()
    weight_total += weight
    for seats in scenario {
      if seats > 0 {
        observations.push((seats, weight))
      }
    }
  }
  observations.sort_by((a, b) => b.0.compare(a.0))
  let knots : Array[WeightedDemandKnot] = []
  let mut weight = 0L
  let mut weighted_demand = 0L
  for i, item in observations {
    weight += item.1
    weighted_demand += item.0.to_int64() * item.1
    if i + 1 == observations.length() || observations[i + 1].0 != item.0 {
      knots.push({ demand: item.0, weight, weighted_demand, })
    }
  }
  { knots, month, annual_weighted: year * weight_total, }
}

///|
fn WeightedDemandCurve::cost_at(
  self : WeightedDemandCurve,
  reserve : Int32,
) -> Int64 {
  let mut lo = 0
  let mut hi = self.knots.length()
  while lo < hi {
    let mid = lo + (hi - lo) / 2
    if self.knots[mid].demand > reserve {
      lo = mid + 1
    } else {
      hi = mid
    }
  }
  let annual = reserve.to_int64() * self.annual_weighted
  if lo == 0 {
    return annual
  }
  let knot = self.knots[lo - 1]
  annual +
  self.month * (knot.weighted_demand - reserve.to_int64() * knot.weight)
}

///|
/// Find the smallest minimizer of a discrete convex seat cost.
fn first_seat_min(
  cost : (Int32) -> Int64,
  lower : Int32,
  upper : Int32,
) -> Int32 {
  let mut lo = lower
  let mut hi = upper
  while lo < hi {
    let mid = lo + (hi - lo) / 2
    if cost(mid) <= cost(mid + 1) {
      hi = mid
    } else {
      lo = mid + 1
    }
  }
  lo
}

///|
/// Find the right endpoint of a convex level set, starting at a feasible minimizer.
fn last_seat_at_level(
  worst : (Int32) -> Int64,
  first : Int32,
  upper : Int32,
  limit : Int64,
) -> Int32 {
  let mut lo = first
  let mut hi = upper
  while lo < hi {
    let mid = lo + (hi - lo + 1) / 2
    if worst(mid) <= limit {
      lo = mid
    } else {
      hi = mid - 1
    }
  }
  lo
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
  regret_limit? : Int64,
  scenario_weights? : Array[Int32],
  tail_weight? : Int32,
) -> SeatRiskPlan raise PricingAnalysisError {
  if scenarios.length() < 2 || scenarios.length() > 16 {
    raise InvalidAnalysis("须提供 2 至 16 组席位需求情景")
  }
  for demand in scenarios {
    validate_seat_counts(demand)
  }
  // A scenario costs at most 12 * Int32::MAX * 1,000,000 hundredths.
  // Capping the total weight at 256 keeps the exact numerator in Int64.
  let mut weight_total = 0
  if scenario_weights is Some(weights) {
    if weights.length() != scenarios.length() ||
      weights.any(weight => weight < 1 || weight > 256) {
      raise InvalidAnalysis(
        "须为每个需求情景提供一个正整数权重，权重总和不超过 256",
      )
    }
    weight_total = weights.fold(init=0, (sum, weight) => sum + weight)
    if weight_total > 256 {
      raise InvalidAnalysis("情景权重总和不能超过 256")
    }
  }
  if tail_weight is Some(tail) && (tail <= 0 || tail > weight_total) {
    raise InvalidAnalysis(
      "尾部权重须大于 0 且不超过情景权重总和，并须提供情景权重",
    )
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
  let lower_limit = if peak > cap { peak - cap } else { 0 }
  let mut hi = peak
  if annual_budget is Some(budget) {
    if budget < 0L {
      raise InvalidAnalysis("年付预付预算不能为负数")
    }
    if year > 0L && budget / year < hi.to_int64() {
      hi = (budget / year).to_int()
    }
  }
  if lower_limit > hi {
    raise InvalidAnalysis(
      "预付预算最多可预留 \{hi} 席；要满足每月补位上限至少需预留 \{lower_limit} 席",
    )
  }
  if regret_limit is Some(limit) && limit < 0L {
    raise InvalidAnalysis("最坏额外成本上限不能为负数")
  }
  let upper_limit = hi
  // Maximum of the convex scenario regrets is convex, even on the truncated interval.
  let lo = first_seat_min(worst, lower_limit, upper_limit)
  let best_regret = worst(lo)
  let last = last_seat_at_level(worst, lo, upper_limit, best_regret)
  let allowance = regret_limit.map(limit => {
    let feasible_seats = if limit < best_regret {
      None
    } else if limit == best_regret {
      Some({ minimum: lo, maximum: last, })
    } else {
      // The sublevel set is an interval around an optimal reservation.
      let mut first = lower_limit
      let mut right = lo
      while first < right {
        let mid = first + (right - first) / 2
        if worst(mid) <= limit {
          right = mid
        } else {
          first = mid + 1
        }
      }
      Some({
        minimum: first,
        maximum: last_seat_at_level(worst, lo, upper_limit, limit),
      })
    }
    { limit, feasible_seats, }
  })
  let feasible = match allowance {
    Some(info) => info.feasible_seats
    None => Some({ minimum: lower_limit, maximum: upper_limit, })
  }
  let weighted_plan = scenario_weights.bind(weights => {
    feasible.map(interval => {
      let curve = build_weighted_curve(scenarios, weights, month, year)
      let weighted_cost = reserve => curve.cost_at(reserve)
      let weighted_first = first_seat_min(
        weighted_cost,
        interval.minimum,
        interval.maximum,
      )
      let cost_numerator = weighted_cost(weighted_first)
      let weighted_last = last_seat_at_level(
        weighted_cost,
        weighted_first,
        interval.maximum,
        cost_numerator,
      )
      // Outside the nearest ends of the two minimizing plateaus, a solution is dominated.
      // If the plateaus intersect, all seats in the intersection minimize both objectives.
      let pareto_seats : SeatReserveInterval = if weighted_last < lo {
        { minimum: weighted_last, maximum: lo, }
      } else if weighted_first > last {
        { minimum: last, maximum: weighted_first, }
      } else {
        {
          minimum: if lo > weighted_first {
            lo
          } else {
            weighted_first
          },
          maximum: if last < weighted_last {
            last
          } else {
            weighted_last
          },
        }
      }
      let annual_seats = if weighted_first > last {
        pareto_seats.maximum
      } else {
        pareto_seats.minimum
      }
      {
        annual_seats,
        pareto_seats,
        cost_numerator,
        weight_total,
        worst_regret: worst(annual_seats),
      }
    })
  })
  let tail_plan = match (tail_weight, scenario_weights, feasible) {
    (Some(weight), Some(weights), Some(interval)) => {
      fn tail_at(
        reserve : Int32,
        trace : Array[TailSeatContribution]?,
      ) -> Int64 {
        let ranked = Array::makei(scenarios.length(), i => {
          (seat_cost_at(scenarios[i], reserve, month, year) - optima[i], i)
        })
        ranked.sort_by((a, b) => {
          if a.0 == b.0 {
            a.1.compare(b.1)
          } else {
            b.0.compare(a.0)
          }
        })
        let mut remaining = weight
        let mut numerator = 0L
        for (regret, index) in ranked {
          let used = weights[index].min(remaining)
          if trace is Some(items) {
            items.push({ scenario_index: index, regret, used_weight: used, })
          }
          numerator += regret * used.to_int64()
          remaining -= used
          if remaining == 0 {
            break
          }
        }
        numerator
      }
      let tail = reserve => tail_at(reserve, None)
      // The weighted sum of the largest regret mass is a maximum of convex sums.
      let annual_seats = first_seat_min(
        tail,
        interval.minimum,
        interval.maximum,
      )
      let contributions = []
      let numerator = tail_at(annual_seats, Some(contributions))
      Some({
        annual_seats,
        optimal_seats: {
          minimum: annual_seats,
          maximum: last_seat_at_level(
            tail,
            annual_seats,
            interval.maximum,
            numerator,
          ),
        },
        regret_numerator: numerator,
        weight,
        worst_regret: worst(annual_seats),
        contributions,
      })
    }
    _ => None
  }
  {
    currency,
    annual_seats: lo,
    max_optimal_annual_seats: last,
    annual_commitment: lo.to_int64() * year,
    worst_regret: best_regret,
    allowance,
    weighted_plan,
    tail_plan,
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
