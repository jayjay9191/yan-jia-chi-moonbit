///|
#derive(Debug)
pub suberror PricingAnalysisError {
  InvalidAnalysis(String)
}

///|
pub(all) struct TrajectoryEvent {
  date : String
  session : String
  change : String
  percent : Int64?
  level : String
  detail : String
  needs_review : Bool
}

///|
pub(all) struct TrajectoryReport {
  key : String
  name : String
  events : Array[TrajectoryEvent]
  status : String
}

///|
pub fn trajectory_categories() -> Array[String] {
  ["无变化", "新档位", "涨价", "降价", "下架", "未看到价"]
}

///|
/// Compare only single-tier quotes with matching currency, seat and billing terms.
fn history_movement(event : HistoryEntry) -> (Int64?, Bool, String) {
  match (normalize_price(event.old_price), normalize_price(event.new_price)) {
    (Normalized(old), Normalized(next)) => {
      if !currency_eq(old.currency, next.currency) ||
        old.per_seat != next.per_seat ||
        old.billed_annually != next.billed_annually {
        return (
          None,
          true,
          "币种、席位或付款周期不同，幅度须逐档核对",
        )
      }
      let delta = next.monthly_cents.to_int64() - old.monthly_cents.to_int64()
      if (event.change == "涨价" && delta <= 0L) ||
        (event.change == "降价" && delta >= 0L) {
        return (
          None,
          true,
          "声明的变动方向与金额不一致，须逐档核对",
        )
      }
      let base = old.monthly_cents.to_int64()
      let magnitude = if delta < 0L { -delta } else { delta }
      let rounded = (magnitude * 100L + base / 2L) / base
      let percent = if delta < 0L { -rounded } else { rounded }
      let major = delta * 100L >= base * 50L || delta * 100L <= -base * 30L
      (
        Some(percent),
        major,
        "单档同口径变化\{percent}%（四舍五入）；分级使用未舍入幅度",
      )
    }
    _ =>
      (
        None,
        true,
        "多档、按量或单价不可解析，幅度须逐档核对",
      )
  }
}

///|
pub fn analyze_trajectory(
  tool : ToolPricing,
) -> TrajectoryReport raise PricingAnalysisError {
  for event in tool.history {
    if !is_valid_date(event.date) || !is_valid_change(event.change) {
      raise InvalidAnalysis(
        "轨迹日期或变动类型不合法：" + tool.key,
      )
    }
  }
  // Stable tie-breaking retains the recorded order of same-day sessions.
  let order = Array::makei(tool.history.length(), i => i)
  order.sort_by((a, b) => {
    let date_order = tool.history[a].date.compare(tool.history[b].date)
    if date_order == 0 {
      a.compare(b)
    } else {
      date_order
    }
  })
  let events = []
  let mut missing = 0
  let mut status = "保留原核验状态"
  for index in order {
    let event = tool.history[index]
    missing = if event.change == "未看到价" { missing + 1 } else { 0 }
    let (percent, needs_review, detail) = if event.change == "涨价" ||
      event.change == "降价" {
      history_movement(event)
    } else {
      (None, false, event.change)
    }
    let level = if event.change == "下架" {
      "已下架，停止复核，保留历史"
    } else if missing >= 2 {
      "数据不可观测，降级为未核验"
    } else if needs_review && percent is Some(_) {
      "大幅变动，重点复核"
    } else if needs_review {
      "幅度待核对，重点复核"
    } else {
      "常规复核"
    }
    status = if event.change == "下架" {
      "已下架，停止复核，保留历史"
    } else if missing >= 2 {
      "数据不可观测，降级为未核验"
    } else if event.change == "未看到价" {
      status
    } else {
      "保留原核验状态"
    }
    events.push({
      date: event.date,
      session: event.session,
      change: event.change,
      percent,
      level,
      detail,
      needs_review,
    })
  }
  { key: tool.key, name: tool.name, events, status, }
}

///|
pub(all) struct TrajectorySummary {
  counts : Array[Int32]
  review : Array[TrajectoryReport]
}

///|
fn largest_movement(report : TrajectoryReport) -> Int64 {
  report.events.fold(init=-1L, (largest, event) => {
    let magnitude = match event.percent {
      Some(n) => if n < 0L { -n } else { n }
      None => -1L
    }
    if magnitude > largest {
      magnitude
    } else {
      largest
    }
  })
}

///|
pub fn trajectory_summary(
  tools : Array[ToolPricing],
) -> TrajectorySummary raise PricingAnalysisError {
  let categories = trajectory_categories()
  let counts = Array::make(categories.length(), 0)
  let review = []
  for tool in tools {
    let report = analyze_trajectory(tool)
    for event in report.events {
      for i in 0..<categories.length() {
        if event.change == categories[i] {
          counts[i] += 1
        }
      }
    }
    if report.events.any(e => e.needs_review) {
      review.push(report)
    }
  }
  review.sort_by((a, b) => {
    let movement = largest_movement(b).compare(largest_movement(a))
    if movement == 0 {
      a.key.compare(b.key)
    } else {
      movement
    }
  })
  { counts, review, }
}

///|
pub(all) struct RecheckItem {
  key : String
  name : String
  verified_at : String
  score : Int32
  reason : String
}

///|
/// Queue includes delisted records for archive triage, never fresh-price verification.
pub fn recheck_queue(
  tools : Array[ToolPricing],
  today : Int32,
) -> Array[RecheckItem] {
  let items = []
  for tool in tools {
    let age = days_since_verified(tool.verified_at, today)
    let reasons = []
    let mut score = if age < 0 { 3650 } else { age }
    reasons.push(if age < 0 { "日期待核对" } else { "距核验\{age}天" })
    if tool.history.any(e => {
        e.change == "涨价" || e.change == "降价" || e.change == "下架"
      }) {
      score += 100
      reasons.push("有调价或下架历史")
    }
    if tool.status is Unverified {
      score += 50
      reasons.push("未核验")
    }
    if tool.history.last() is Some(event) && event.change == "下架" {
      reasons.push("已下架，仅核对存档状态，停止报价复核")
    }
    items.push({
      key: tool.key,
      name: tool.name,
      verified_at: tool.verified_at,
      score,
      reason: join_strings(reasons, "；"),
    })
  }
  items.sort_by((a, b) => {
    let score_order = b.score.compare(a.score)
    if score_order == 0 {
      a.key.compare(b.key)
    } else {
      score_order
    }
  })
  items.iter().take(20).to_array()
}
