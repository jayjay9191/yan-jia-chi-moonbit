///|
/// AI 工具定价记录的结构定义与按名查找。
/// 数据不在这里：20 个工具的真实数据在 data/pricing.json，
/// 由 scripts/generate_data.py 生成 pricing_data.mbt。
/// 改数据只改 JSON，改完跑：python3 scripts/generate_data.py

///|
/// 付费价核验状态。三档缺一不可：
/// - Verified：官网价已完整记录（含仅 API 按量价的 DeepSeek/Kimi/智谱，
///   按原作者 index.html 的口径——“能直接在官网看到完整付费定价的有 8 个”）
/// - VerifiedPartial：只核验到一部分（Gemini 只在 Google One 页看到价、
///   Copilot 只核验到商业版、海螺只见到起步价）。写“已核验”是夸大，
///   写“未核验到”是丢掉已核验到的价格
/// - Unverified：付费价没看到（无定价页 / 需登录 / 打不开 / 地区限制）；
///   这档的 paid_price 必须为空——没有价格就不写价格
pub enum PriceStatus {
  Verified
  VerifiedPartial
  Unverified
}

///|
/// 枚举判等（不用 #derive(Eq)：它会把 equal/not_equal 提升为方法，
/// 触发废弃警告；三档 match 就够了）。
pub fn status_eq(a : PriceStatus, b : PriceStatus) -> Bool {
  match (a, b) {
    (PriceStatus::Verified, PriceStatus::Verified) => true
    (PriceStatus::VerifiedPartial, PriceStatus::VerifiedPartial) => true
    (PriceStatus::Unverified, PriceStatus::Unverified) => true
    _ => false
  }
}

///|
pub(all) struct ToolPricing {
  name : String
  pricing_url : String
  free_tier : String
  paid_price : String // 付费价原文；未核验到的行必须为空字符串
  currency : String // "USD" | "JPY" | "CNY"；未核验到的行必须为空字符串
  billing : String // 计费周期原文；未核验到的行必须为空字符串
  student_discount : String // 学生/教育优惠；"未见"也是明确表态，不能空着
  reachable : String // "能打开" | "打不开" | "受限"
  verified_at : String // 最后核验日期 "YYYY-MM-DD"，本批全是 2026-11-08
  note : String
  status : PriceStatus
}

///|
pub fn status_text(s : PriceStatus) -> String {
  match s {
    PriceStatus::Verified => "已核验"
    PriceStatus::VerifiedPartial => "部分核验"
    PriceStatus::Unverified => "未核验到"
  }
}

///|
pub fn tool_by_name(name : String) -> ToolPricing? {
  let tools = all_tools()
  for i in 0..<tools.length() {
    if tools[i].name == name {
      return Some(tools[i])
    }
  }
  None
}

///|
pub fn tool_names() -> Array[String] {
  let tools = all_tools()
  let out : Array[String] = []
  for i in 0..<tools.length() {
    out.push(tools[i].name)
  }
  out
}

///|
/// 公开的按状态计数/取名字段（枚举构造子在包外只读，CLI 与黑盒测试
/// 用这几个函数，不直接写 PriceStatus::Verified）。
pub fn verified_count(tools : Array[ToolPricing]) -> Int32 {
  count_status(tools, PriceStatus::Verified)
}

///|
pub fn partial_count(tools : Array[ToolPricing]) -> Int32 {
  count_status(tools, PriceStatus::VerifiedPartial)
}

///|
pub fn unverified_count(tools : Array[ToolPricing]) -> Int32 {
  count_status(tools, PriceStatus::Unverified)
}

///|
pub fn names_verified(tools : Array[ToolPricing]) -> Array[String] {
  names_with_status(tools, PriceStatus::Verified)
}

///|
pub fn names_partial(tools : Array[ToolPricing]) -> Array[String] {
  names_with_status(tools, PriceStatus::VerifiedPartial)
}

///|
pub fn names_unverified(tools : Array[ToolPricing]) -> Array[String] {
  names_with_status(tools, PriceStatus::Unverified)
}

///|
pub fn count_status(tools : Array[ToolPricing], s : PriceStatus) -> Int32 {
  let mut n = 0
  for i in 0..<tools.length() {
    if status_eq(tools[i].status, s) {
      n = n + 1
    }
  }
  n
}

///|
pub fn names_with_status(
  tools : Array[ToolPricing],
  s : PriceStatus,
) -> Array[String] {
  let out : Array[String] = []
  for i in 0..<tools.length() {
    if status_eq(tools[i].status, s) {
      out.push(tools[i].name)
    }
  }
  out
}

///|
pub fn count_reachable(tools : Array[ToolPricing], r : String) -> Int32 {
  let mut n = 0
  for i in 0..<tools.length() {
    if tools[i].reachable == r {
      n = n + 1
    }
  }
  n
}

///|
pub fn count_currency(tools : Array[ToolPricing], c : String) -> Int32 {
  let mut n = 0
  for i in 0..<tools.length() {
    if tools[i].currency == c {
      n = n + 1
    }
  }
  n
}

///|
/// 计费周期归类：按原文开头归类，不按包含（“按量，无月/年订阅”里
/// 含有“月/年”，按包含会判错；原文还有“按月，年付最高省16%”
/// “按月（仅见“每月”）”这类带说明的写法）。
pub fn billing_category(billing : String) -> String {
  if billing == "" {
    ""
  } else if billing.has_prefix("按量") {
    "按量"
  } else if billing.has_prefix("月/年") {
    "月/年"
  } else if billing.has_prefix("按年") {
    "按年"
  } else if billing.has_prefix("按月") {
    "按月"
  } else {
    "其他"
  }
}

///|
pub fn count_billing_category(
  tools : Array[ToolPricing],
  cat : String,
) -> Int32 {
  let mut n = 0
  for i in 0..<tools.length() {
    if billing_category(tools[i].billing) == cat {
      n = n + 1
    }
  }
  n
}

///|
/// 单条证据链：来源 URL → 记录 → 核验时间 → 状态。
/// 学 J006 的 5 步证据链（来源 URL → 原始记录 → 键 → 复核 → 实时页面），
/// 这里是 MoonBit 版的 4 步：定价页 URL → 免费版/付费价/货币/计费 →
/// 学生优惠/可达性 → 核验时间 + 状态。未核验到的行不打印价格，
/// 只打印“未核验到（无价格记录）”。
pub fn evidence_lines(t : ToolPricing) -> Array[String] {
  let lines : Array[String] = []
  lines.push("工具：" + t.name)
  lines.push("定价页：" + t.pricing_url)
  lines.push("免费版：" + t.free_tier)
  if t.paid_price == "" {
    lines.push("付费价：未核验到（无价格记录）")
  } else {
    lines.push("付费价：" + t.paid_price)
  }
  if t.currency == "" {
    lines.push("货币：（无，付费价未核验到）")
  } else {
    lines.push("货币：" + t.currency)
  }
  if t.billing == "" {
    lines.push("计费周期：（无，付费价未核验到）")
  } else {
    lines.push("计费周期：" + t.billing)
  }
  lines.push("学生/教育优惠：" + t.student_discount)
  lines.push("页面可达：" + t.reachable)
  lines.push("核验时间：" + t.verified_at)
  lines.push("状态：" + status_text(t.status))
  lines.push("备注：" + t.note)
  lines
}

///|
pub fn join_strings(items : Array[String], sep : String) -> String {
  let mut out = ""
  for i in 0..<items.length() {
    if i > 0 {
      out = out + sep
    }
    out = out + items[i]
  }
  out
}
