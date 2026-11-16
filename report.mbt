///|
/// 汇总报告：所有数字都带分母（数字没有分母就是自述）。
/// 学生优惠“有说明”指 student_discount 不是“未见”（如 ChatGPT 的教师
/// 免费说明、Claude 的 Campus 链接、Copilot 的 Education 入口、Cursor
/// 的学生链接）；“未见”指页面上没看到，不是“没有优惠”。

///|
pub(all) struct PricingReport {
  total : Int32
  verified : Int32
  partial : Int32
  unverified : Int32
  has_price : Int32
  no_price : Int32
  reachable_ok : Int32
  reachable_blocked : Int32
  reachable_limited : Int32
  currency_usd : Int32
  currency_jpy : Int32
  currency_cny : Int32
  currency_eur : Int32
  currency_gbp : Int32
  currency_cad : Int32
  currency_aud : Int32
  currency_sar : Int32
  currency_inr : Int32
  currency_other : Int32 // 非 ISO 计价单位：kr（Mondly 页面原文）、AC（Anyscale Credits）
  currency_empty : Int32
  billing_pay_as_you_go : Int32 // 按量
  billing_monthly : Int32 // 按月
  billing_monthly_yearly : Int32 // 月/年
  billing_yearly : Int32 // 按年
  billing_empty : Int32
  billing_other : Int32 // 其他（非订阅计费，如按贷款计息/按次/按笔）
  student_seen : Int32 // 学生优惠有说明的
  student_unseen : Int32 // 学生优惠写“未见”的
  stale_count : Int32 // 过期未复核的（距今超 30 天）
  history_entries : Int32 // 变动/复核轨迹总条数
  rechecked_tools : Int32 // 有复核轨迹的记录数
  price_up : Int32 // 涨价条目数
  price_down : Int32 // 降价条目数
  delisted : Int32 // 下架条目数
  unobserved : Int32 // 复核未看到价条目数
  today : String
}

///|
pub fn build_report(tools : Array[ToolPricing], today : Int32) -> PricingReport {
  let mut has_price = 0
  let mut stale = 0
  for i in 0..<tools.length() {
    if tools[i].paid_price != "" {
      has_price = has_price + 1
    }
    if is_stale(tools[i].verified_at, today) {
      stale = stale + 1
    }
  }
  let mut student_seen = 0
  for i in 0..<tools.length() {
    if tools[i].student_discount != "未见" {
      student_seen = student_seen + 1
    }
  }
  {
    total: tools.length(),
    verified: count_status(tools, PriceStatus::Verified),
    partial: count_status(tools, PriceStatus::VerifiedPartial),
    unverified: count_status(tools, PriceStatus::Unverified),
    has_price,
    no_price: tools.length() - has_price,
    reachable_ok: count_reachable(tools, "能打开"),
    reachable_blocked: count_reachable(tools, "打不开"),
    reachable_limited: count_reachable(tools, "受限"),
    currency_usd: count_currency(tools, "USD"),
    currency_jpy: count_currency(tools, "JPY"),
    currency_cny: count_currency(tools, "CNY"),
    currency_eur: count_currency(tools, "EUR"),
    currency_gbp: count_currency(tools, "GBP"),
    currency_cad: count_currency(tools, "CAD"),
    currency_aud: count_currency(tools, "AUD"),
    currency_sar: count_currency(tools, "SAR"),
    currency_inr: count_currency(tools, "INR"),
    currency_other: count_currency(tools, "kr") + count_currency(tools, "AC"),
    currency_empty: count_currency(tools, ""),
    billing_pay_as_you_go: count_billing_category(tools, "按量"),
    billing_monthly: count_billing_category(tools, "按月"),
    billing_monthly_yearly: count_billing_category(tools, "月/年"),
    billing_yearly: count_billing_category(tools, "按年"),
    billing_empty: count_billing_category(tools, ""),
    billing_other: count_billing_category(tools, "其他"),
    student_seen,
    student_unseen: tools.length() - student_seen,
    stale_count: stale,
    history_entries: history_entries_count(tools),
    rechecked_tools: rechecked_tools_count(tools),
    price_up: count_history_change(tools, "涨价"),
    price_down: count_history_change(tools, "降价"),
    delisted: count_history_change(tools, "下架"),
    unobserved: count_history_change(tools, "未看到价"),
    today: days_to_date(today),
  }
}

///|
/// 汇总报告的打印行（每行一个带分母的数字）。
pub fn report_lines(r : PricingReport) -> Array[String] {
  let lines : Array[String] = []
  lines.push("工具总数：\{r.total}")
  lines.push(
    "已核验（官网价已完整记录）：\{r.verified}/\{r.total}",
  )
  lines.push("部分核验：\{r.partial}/\{r.total}")
  lines.push("未核验到付费价：\{r.unverified}/\{r.total}")
  lines.push("有付费价记录：\{r.has_price}/\{r.total}")
  lines.push("无付费价记录：\{r.no_price}/\{r.total}")
  lines.push(
    "页面能打开：\{r.reachable_ok}/\{r.total}；打不开：\{r.reachable_blocked}/\{r.total}；受限（地区限制）：\{r.reachable_limited}/\{r.total}",
  )
  lines.push(
    "货币：USD \{r.currency_usd} 个，JPY \{r.currency_jpy} 个，CNY \{r.currency_cny} 个，EUR \{r.currency_eur} 个，GBP \{r.currency_gbp} 个，CAD \{r.currency_cad} 个，AUD \{r.currency_aud} 个，SAR \{r.currency_sar} 个，INR \{r.currency_inr} 个，其他（kr/AC）\{r.currency_other} 个，无货币（未核验到）\{r.currency_empty} 个",
  )
  lines.push(
    "计费：按量 \{r.billing_pay_as_you_go} 个，按月 \{r.billing_monthly} 个，月/年 \{r.billing_monthly_yearly} 个，按年 \{r.billing_yearly} 个，无（未核验到）\{r.billing_empty} 个，其他（非订阅）\{r.billing_other} 个",
  )
  lines.push(
    "学生/教育优惠有说明：\{r.student_seen}/\{r.total}；写“未见”：\{r.student_unseen}/\{r.total}",
  )
  lines.push(
    "过期未复核（距今超 30 天）：\{r.stale_count}/\{r.total}；今天：\{r.today}",
  )
  lines.push(
    "变动轨迹：\{r.history_entries} 条（复核过 \{r.rechecked_tools}/\{r.total} 条记录；涨价 \{r.price_up} 条、降价 \{r.price_down} 条、下架 \{r.delisted} 条、复核未看到价 \{r.unobserved} 条）",
  )
  lines
}
