///|
pub(all) struct PlanOffer {
  plan : String
  quote : String
  source : String
}

///|
pub(all) struct PlanClass {
  plan : String
  members : Array[PlanOffer]
  annual_saving : Int32?
}

///|
pub(all) struct PlanClassReport {
  classes : Array[PlanClass]
  issues : Array[String]
}

///|
fn plan_root(parents : Array[Int32], start : Int32) -> Int32 {
  let mut index = start
  while parents[index] != index {
    index = parents[index]
  }
  index
}

///|
/// Currency/seat must agree across billing options; same-cycle quotes must align.
/// ponytail: quadratic per-record audit; index pairs if records grow to thousands of offers.
pub fn audit_plan_classes(classes : Array[PlanClass]) -> Array[String] {
  let issues = []
  for i in 0..<classes.length() {
    let cls = classes[i]
    if cls.plan.trim().is_empty() || cls.members.is_empty() {
      issues.push("空套餐身份或空报价类：" + cls.plan)
    }
    for j in 0..<i {
      if classes[j].plan.trim() == cls.plan.trim() {
        issues.push("同一套餐被拆成多个类：" + cls.plan)
      }
    }
    for offer in cls.members {
      if offer.plan != cls.plan {
        issues.push("套餐身份冲突：" + cls.plan + " / " + offer.plan)
      }
      if is_starting_quote(offer.quote) {
        issues.push("报价下限，须核对固定金额：\{offer.quote}")
      } else if is_first_term_quote(offer.quote) {
        issues.push(
          "首期报价，须核对固定续费金额：\{offer.quote}",
        )
      } else if normalize_kind(normalize_price(offer.quote)) != "normalized" {
        issues.push("不可解析报价：" + offer.quote)
      }
      for j in 0..<i {
        if classes[j].members.any(other => {
            other.source == offer.source && other.quote == offer.quote
          }) {
          issues.push("同一写法落入两个类：" + offer.quote)
        }
      }
    }
    for a in 0..<cls.members.length() {
      for b in (a + 1)..<cls.members.length() {
        let left = cls.members[a].quote
        let right = cls.members[b].quote
        if is_starting_quote(left) ||
          is_starting_quote(right) ||
          is_first_term_quote(left) ||
          is_first_term_quote(right) {
          continue
        }
        match (normalize_price(left), normalize_price(right)) {
          (Normalized(pa), Normalized(pb)) => {
            let reason = if !currency_eq(pa.currency, pb.currency) {
              "币种不同"
            } else if pa.per_seat != pb.per_seat {
              "席位口径不同"
            } else if pa.billed_annually == pb.billed_annually {
              let reason = align_reason(align_prices(left, right))
              let (_, year_a) = subscription_cost(pa, 1)
              let (_, year_b) = subscription_cost(pb, 1)
              if reason != "" || year_a == year_b {
                reason
              } else {
                "同一付款周期折算一年分别为 \{year_a} 分与 \{year_b} 分"
              }
            } else {
              ""
            }
            if reason != "" {
              issues.push("\{cls.plan}：\{left} / \{right}：\{reason}")
            }
          }
          _ => issues.push("类内报价不可解析：\{left} / \{right}")
        }
      }
    }
  }
  issues
}

///|
fn quote_start(fragment : String) -> Int32? {
  let mut price_start : Int32? = None
  let markers = ["C$", "A$", "NT$", "HK$", "R$", "$", "€", "£", "¥", "₹"]
  for code in price_codes {
    for sign in ["", "-", "−"] {
      markers.push(" " + sign + code + " ")
    }
  }
  for symbol in markers {
    if fragment.find(symbol) is Some(offset) {
      if price_start is None ||
        (price_start is Some(previous) && offset < previous) {
        price_start = Some(offset)
      }
    }
  }
  price_start
}

///|
fn starting_prefix(plan : String) -> Bool {
  let text = plan.to_lower()
  text.has_suffix("起价") ||
  text.has_suffix("起步") ||
  ["from", "starting at", "starts at", "at least"]
  .iter()
  .any(marker => {
    text == marker ||
    text.has_suffix(" " + marker) ||
    text.has_suffix("(" + marker) ||
    text.has_suffix("（" + marker)
  })
}

///|
fn first_term_prefix(plan : String) -> Bool {
  let text = plan.to_lower()
  first_term_markers.iter().any(marker => text.has_suffix(marker))
}

///|
// Learn the column order from an explicit pair in one named offer.
fn compact_billing_order(fragments : Array[String]) -> Bool? {
  let mut order = None
  for fragment in fragments {
    guard quote_start(fragment) is Some(start) else { continue }
    let plan = fragment.clamped_view(end=start).trim().to_owned()
    if plan.is_empty() ||
      starting_prefix(plan) ||
      first_term_prefix(plan) ||
      plan.has_suffix("-") ||
      plan.has_suffix("−") {
      continue
    }
    let pair = fragment
      .clamped_view(start~)
      .to_owned()
      .split("、")
      .map(part => part.trim().to_owned())
      .to_array()
    if pair.length() != 2 {
      continue
    }
    let first = pair[0]
    let second = pair[1]
    let a = normalize_price(first)
    let b = normalize_price(second)
    if is_starting_quote(first) ||
      is_starting_quote(second) ||
      is_first_term_quote(first) ||
      is_first_term_quote(second) ||
      normalize_kind(a) != "normalized" ||
      normalize_kind(b) != "normalized" {
      continue
    }
    let annual_first = normalized_billed_annually(a)
    if annual_first == normalized_billed_annually(b) ||
      !(first.has_suffix("/月按月") || first.has_suffix("/月按年")) ||
      !(second.has_suffix("/月按月") || second.has_suffix("/月按年")) {
      continue
    }
    if order is Some(previous) && previous != annual_first {
      return None
    }
    order = Some(annual_first)
  }
  order
}

///|
pub fn plan_classes(raw : String) -> PlanClassReport {
  let offers : Array[PlanOffer] = []
  let issues = []
  let fragments = raw
    .replace_all(old=";", new="；")
    .split("；")
    .map(fragment => fragment.trim().to_owned())
    .to_array()
  let compact_order = compact_billing_order(fragments)
  for fragment in fragments {
    if fragment.has_prefix("年付约省") {
      continue
    }
    guard quote_start(fragment) is Some(offset) else {
      issues.push("缺少命名套餐或可解析报价：" + fragment)
      continue
    }
    let plan = fragment.clamped_view(end=offset).trim().to_owned()
    if plan == "" {
      issues.push("报价缺少套餐身份：" + fragment)
      continue
    }
    if plan.has_suffix("-") || plan.has_suffix("−") {
      issues.push("无法确认有效价格：\{fragment}")
      continue
    }
    if starting_prefix(plan) {
      issues.push("报价下限，须核对固定金额：\{fragment}")
      continue
    }
    if first_term_prefix(plan) {
      issues.push("首期报价，须核对固定续费金额：\{fragment}")
      continue
    }
    let price = fragment.clamped_view(start=offset).trim().to_owned()
    let quotes = price.split("、").map(s => s.trim().to_owned()).to_array()
    let compact = price.split("/").map(s => s.trim().to_owned()).to_array()
    if quotes.length() == 1 &&
      compact.length() == 2 &&
      compact[0].has_prefix("$") &&
      compact[1].has_prefix("$") {
      guard compact_order is Some(annual_first) else {
        issues.push("简写缺少一致的月付/年付顺序：\{fragment}")
        continue
      }
      quotes.clear()
      let monthly = if annual_first { compact[1] } else { compact[0] }
      let annual = if annual_first { compact[0] } else { compact[1] }
      quotes.push(monthly + "/月按月")
      quotes.push(annual + "/月按年")
    }
    if quotes.length() > 2 {
      issues.push("多档混写须逐档核对：" + fragment)
      continue
    }
    for quote in quotes {
      if is_starting_quote(quote) {
        issues.push("报价下限，须核对固定金额：\{fragment}")
      } else if is_first_term_quote(quote) {
        issues.push("首期报价，须核对固定续费金额：\{fragment}")
      } else if normalize_kind(normalize_price(quote)) == "normalized" {
        offers.push({ plan, quote, source: fragment, })
      } else {
        issues.push(
          "报价不可解析：\{fragment}：\{normalize_reason(normalize_price(quote))}",
        )
      }
    }
  }
  let parents = Array::makei(offers.length(), i => i)
  for i in 0..<offers.length() {
    for j in (i + 1)..<offers.length() {
      if offers[i].plan == offers[j].plan {
        parents[plan_root(parents, j)] = plan_root(parents, i)
      }
    }
  }
  let classes = []
  for i in 0..<offers.length() {
    if plan_root(parents, i) != i {
      continue
    }
    let members = offers.filter(offer => offer.plan == offers[i].plan)
    let monthly = members
      .iter()
      .find_first(offer => {
        !normalized_billed_annually(normalize_price(offer.quote))
      })
    let annual = members
      .iter()
      .find_first(offer => {
        normalized_billed_annually(normalize_price(offer.quote))
      })
    let coherent = audit_plan_classes([
      { plan: offers[i].plan, members, annual_saving: None, },
    ]).is_empty()
    let saving = match (monthly, annual) {
      (Some(m), Some(a)) =>
        if coherent {
          match compare_budget(m.quote, a.quote, 1) {
            Ok(budget) => Some(saving_pct(budget.year_a, budget.year_b))
            Err(_) => None
          }
        } else {
          None
        }
      _ => None
    }
    classes.push({ plan: offers[i].plan, members, annual_saving: saving, })
  }
  for issue in audit_plan_classes(classes) {
    issues.push(issue)
  }
  { classes, issues, }
}

///|
pub(all) struct ClassSession {
  session : String
  class_count : Int32
  detail : String
}

///|
pub(all) struct ClassStability {
  sessions : Array[ClassSession]
  complete : Bool
  observed_stable : Bool
}

///|
fn session_options(
  classes : Array[PlanClass],
) -> Map[(String, Bool), NormalizedPrice] {
  let options = Map([])
  for cls in classes {
    for offer in cls.members {
      if normalize_price(offer.quote) is Normalized(price) {
        // A valid report has already checked that duplicate options agree exactly.
        options[(cls.plan, price.billed_annually)] = price
      }
    }
  }
  options
}

///|
fn compare_session_options(
  before : Array[PlanClass],
  after : Array[PlanClass],
) -> String {
  let old = session_options(before)
  let current = session_options(after)
  let keys = old.keys().collect()
  for key in current.keys() {
    if !old.contains(key) {
      keys.push(key)
    }
  }
  keys.sort()
  let differences : Array[String] = []
  for key in keys {
    let (plan, annual) = key
    let label = plan + (if annual { " 年付" } else { " 月付" })
    match (old.get(key), current.get(key)) {
      (Some(a), Some(b)) =>
        if !currency_eq(a.currency, b.currency) || a.per_seat != b.per_seat {
          differences.push(label + "：币种或席位口径变化，须核对")
        } else {
          let (_, old_cost) = subscription_cost(a, 1)
          let (_, new_cost) = subscription_cost(b, 1)
          if old_cost != new_cost {
            differences.push("\{label}：\{old_cost} → \{new_cost} 分/年")
          }
        }
      (Some(_), None) => differences.push(label + "：本次原文未见")
      (None, Some(_)) => differences.push(label + "：前次原文未见")
      (None, None) => ()
    }
  }
  if differences.is_empty() {
    "与前次独立原文逐套餐、逐付款周期核对，金额和口径一致"
  } else {
    join_strings(differences, "；")
  }
}

///|
/// Inspect stored quotes only. A note saying "unchanged" cannot recreate a quote.
pub fn class_stability(tool : ToolPricing) -> ClassStability {
  let sessions = []
  let mut complete = tool.history.length() >= 2
  let mut observed_stable = true
  let mut baseline : Array[String]? = None
  let mut last_valid : Array[PlanClass]? = None
  let mut observed = 0
  let seen_sessions : Array[String] = []
  for index in observation_order(tool.history) {
    let event = tool.history[index]
    let session = event.session.trim().to_owned()
    let independent = !session.is_empty() &&
      !seen_sessions.contains(session) &&
      is_valid_date(event.date) &&
      is_valid_change(event.change)
    if independent {
      seen_sessions.push(session)
    }
    let quote = if event.new_price != "" {
      event.new_price
    } else if event.change == "无变化" {
      event.old_price
    } else {
      ""
    }
    let report = plan_classes(quote)
    let valid = independent &&
      quote != "" &&
      report.issues.is_empty() &&
      !report.classes.is_empty()
    sessions.push({
      session: event.session,
      class_count: if valid {
        report.classes.length()
      } else {
        0
      },
      detail: if !independent {
        "会话重复、标识为空或日期/变动类型无效，不计为独立复核"
      } else if quote == "" {
        "缺少复核当时的价格原文，稳定性待核对"
      } else if valid {
        if last_valid is Some(previous) {
          compare_session_options(previous, report.classes)
        } else if sessions.is_empty() {
          "套餐身份与类内报价已核对，作为首个可比快照"
        } else {
          "套餐身份与类内报价已核对，前次证据不可用"
        }
      } else {
        join_strings(report.issues, "；")
      },
    })
    if !valid {
      complete = false
      last_valid = None
      continue
    }
    last_valid = Some(report.classes)
    let names = report.classes.map(cls => cls.plan)
    names.sort()
    if baseline is Some(previous) {
      if names != previous {
        observed_stable = false
      }
    } else {
      baseline = Some(names)
    }
    observed += 1
  }
  { sessions, complete, observed_stable: observed_stable && observed >= 2, }
}
