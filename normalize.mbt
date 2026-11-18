///|
/// 价格归一化：把不同写法的单档价格折算成可比的月均价。
/// 这是本项目的核心语义处理——核价结论由 MoonBit 算出来，不是 Python：
/// Python 只负责把 data/pricing.json 原样搬进 pricing_data.mbt（生成器），
/// 14 项校验、状态判定、过期判定与这里的归一化都在 MoonBit 里。
/// 归一化只处理“单档、单价、单周期”的价格原文；多档、按量、定制、
/// 免费档混写的一律明确拒绝并说明原因，绝不猜一个数出来。

///|
/// 货币：只认符号或代码能直接证明的 6 种；其余货币（CAD/AUD/SAR 等）
/// 记为 Other，不做汇率换算——汇率每天变，编一个就是假数据。
/// ¥ 同时是人民币与日元的符号：裸 ¥ 无法区分，见 normalize_price 的说明。
pub enum Currency {
  CNY
  USD
  EUR
  GBP
  JPY
  INR
  Other
}

///|
pub fn currency_code(c : Currency) -> String {
  match c {
    Currency::CNY => "CNY"
    Currency::USD => "USD"
    Currency::EUR => "EUR"
    Currency::GBP => "GBP"
    Currency::JPY => "JPY"
    Currency::INR => "INR"
    Currency::Other => "OTHER"
  }
}

///|
fn currency_eq(a : Currency, b : Currency) -> Bool {
  match (a, b) {
    (Currency::CNY, Currency::CNY) => true
    (Currency::USD, Currency::USD) => true
    (Currency::EUR, Currency::EUR) => true
    (Currency::GBP, Currency::GBP) => true
    (Currency::JPY, Currency::JPY) => true
    (Currency::INR, Currency::INR) => true
    (Currency::Other, Currency::Other) => true
    _ => false
  }
}

///|
/// 归一化后的单档价格。月均价以“分”为单位取整（Int），避免浮点比较：
/// ¥990/年 → 8250 分/月；$200/年 → 1667 分/月（四舍五入）。
pub(all) struct NormalizedPrice {
  currency : Currency
  monthly_cents : Int32 // 月均价（分/¢），已四舍五入
  per_seat : Bool // 是否按席/按用户计价（月均价是“每席每月”）
  billed_annually : Bool // 是否按年付（月均价是年总价 / 12，或已是按年折算的月费率）
  original : String // 归一化前的价格原文
}

///|
/// 归一化结论：Free = 免费；Normalized = 折算成功；
/// CannotNormalize = 明确拒绝，reason 说明为什么（绝不猜数）。
pub enum NormalizeResult {
  Free
  Normalized(NormalizedPrice)
  CannotNormalize(String)
}

///|
/// 供 CLI 与黑盒测试用的公开读数（枚举构造子在包外只读，见 AGENTS.md）。
pub fn normalize_kind(r : NormalizeResult) -> String {
  match r {
    NormalizeResult::Free => "free"
    NormalizeResult::Normalized(_) => "normalized"
    NormalizeResult::CannotNormalize(_) => "cannot_normalize"
  }
}

///|
pub fn normalized_monthly_cents(r : NormalizeResult) -> Int32 {
  match r {
    NormalizeResult::Normalized(p) => p.monthly_cents
    _ => -1
  }
}

///|
pub fn normalized_currency_code(r : NormalizeResult) -> String {
  match r {
    NormalizeResult::Normalized(p) => currency_code(p.currency)
    _ => ""
  }
}

///|
pub fn normalized_per_seat(r : NormalizeResult) -> Bool {
  match r {
    NormalizeResult::Normalized(p) => p.per_seat
    _ => false
  }
}

///|
pub fn normalized_billed_annually(r : NormalizeResult) -> Bool {
  match r {
    NormalizeResult::Normalized(p) => p.billed_annually
    _ => false
  }
}

///|
pub fn normalize_reason(r : NormalizeResult) -> String {
  match r {
    NormalizeResult::CannotNormalize(reason) => reason
    _ => ""
  }
}

///|
/// 月均价的可读写法，如 "USD 8.00/月"。
pub fn format_monthly(p : NormalizedPrice) -> String {
  let whole = p.monthly_cents / 100
  let frac = p.monthly_cents % 100
  let frac_str = if frac < 10 {
    "0" + frac.to_string()
  } else {
    frac.to_string()
  }
  currency_code(p.currency) + " " + whole.to_string() + "." + frac_str + "/月"
}

///|
/// 比较两档单价的月均价（同货币）：返回更便宜的月均价（分）；
/// 任一无法归一化或货币不同返回 -1（不做汇率换算）。
pub fn cheaper_monthly_cents(a : String, b : String) -> Int32 {
  match (normalize_price(a), normalize_price(b)) {
    (NormalizeResult::Normalized(pa), NormalizeResult::Normalized(pb)) =>
      match cheaper_monthly(pa, pb) {
        Some(c) => c.monthly_cents
        None => -1
      }
    _ => -1
  }
}

///|
/// 单档价格原文 → 月均价可读写法（如 "USD 8.00/月"）；
/// 无法归一化返回 ""。
pub fn format_monthly_of(s : String) -> String {
  match normalize_price(s) {
    NormalizeResult::Normalized(p) => format_monthly(p)
    _ => ""
  }
}

///|
/// 归一化单档价格原文。货币从符号或代码识别；¥ 同时是人民币与日元
/// 的符号，原文里没有 CNY/JPY 字样时无法区分，明确拒绝，不猜——
/// 工具记录走 normalize_tool_price，用记录的 currency 字段作准。
pub fn normalize_price(s : String) -> NormalizeResult {
  match precheck(s) {
    Some(r) => r
    None =>
      if s.contains("¥") && !s.contains("CNY") && !s.contains("JPY") {
        CannotNormalize(
          "¥ 无法区分人民币与日元：请注明货币代码，或走工具记录的 currency 字段归一化",
        )
      } else {
        match detect_currency(s) {
          Some(cur) => normalize_core(s, cur)
          None =>
            CannotNormalize(
              "未识别货币符号：价格里没有可识别的货币标记",
            )
        }
      }
  }
}

///|
/// 归一化单档价格原文，货币由调用方用代码指定
/// （"CNY"/"USD"/"EUR"/"GBP"/"JPY"/"INR"，其余记 Other）。
pub fn normalize_price_with_currency(
  s : String,
  code : String,
) -> NormalizeResult {
  match precheck(s) {
    Some(r) => r
    None => normalize_core(s, currency_from_code(code))
  }
}

///|
/// 归一化一条工具记录的付费价：货币以记录的 currency 字段为准
/// （人工核验时已按官网实测写死），价格原文走同一套解析与拒绝规则。
/// 未核验到的记录（paid_price 为空）直接拒绝，不编价格。
pub fn normalize_tool_price(t : ToolPricing) -> NormalizeResult {
  if t.paid_price == "" {
    CannotNormalize("未核验到：无价格可归一化")
  } else {
    match precheck(t.paid_price) {
      Some(r) => r
      None => normalize_core(t.paid_price, currency_from_code(t.currency))
    }
  }
}

///|
/// 同一档位按月付与按年付的月均价之差，占按月价的整数百分比（四舍五入）。
/// 如 Basic $10/月 vs $8/月按年 → 20%。按月价 ≤ 0 时返回 0。
pub fn annual_saving_pct(
  monthly_cents : Int32,
  annual_monthly_cents : Int32,
) -> Int32 {
  if monthly_cents <= 0 {
    0
  } else {
    ((monthly_cents - annual_monthly_cents) * 100 + monthly_cents / 2) /
    monthly_cents
  }
}

///|
/// 同货币下比较两档月均价，返回更便宜的那档；货币不同返回 None
/// （不做汇率换算）；月均价相等返回第一档。
pub fn cheaper_monthly(
  a : NormalizedPrice,
  b : NormalizedPrice,
) -> NormalizedPrice? {
  if !currency_eq(a.currency, b.currency) {
    None
  } else if a.monthly_cents <= b.monthly_cents {
    Some(a)
  } else {
    Some(b)
  }
}

///|
/// 口径对齐结论：Same = 同一套餐；Different = 不同套餐（reason 说明
/// 哪项不同）；CannotAlign = 无法判定（reason 说明哪一侧被拒绝，绝不猜）。
/// 判定标准：两侧都能归一化成功，且货币相同、月均价（整数分）相同、
/// 计费口径（按席/按用户/按人 vs 不按人头）相同。按年付与否不参与判定——
/// 它只影响月均价本身；同一档位按月付与按年付的月费率不同时判不同
/// （如 Midjourney Basic $10/月按月 vs $8/月按年），要比同一档位的
/// 不同付费周期用 annual_saving_pct。更细的计费单位（按次、按 token）
/// 都在按量拒绝里，根本进不了对齐。
pub enum AlignResult {
  Same
  Different(String)
  CannotAlign(String)
}

///|
/// 供 CLI 与黑盒测试用的公开读数（枚举构造子在包外只读，见 AGENTS.md）。
pub fn align_kind(r : AlignResult) -> String {
  match r {
    AlignResult::Same => "same"
    AlignResult::Different(_) => "different"
    AlignResult::CannotAlign(_) => "cannot_align"
  }
}

///|
pub fn align_reason(r : AlignResult) -> String {
  match r {
    AlignResult::Different(reason) => reason
    AlignResult::CannotAlign(reason) => reason
    AlignResult::Same => ""
  }
}

///|
/// 对齐两个价格字符串：是否为同一套餐。任一侧无法归一化时直接拒绝
/// 判定并说明是哪一侧、为什么，绝不猜。
pub fn align_prices(a : String, b : String) -> AlignResult {
  match (normalize_price(a), normalize_price(b)) {
    (NormalizeResult::Free, NormalizeResult::Free) => AlignResult::Same
    (NormalizeResult::Free, NormalizeResult::Normalized(_)) =>
      AlignResult::Different("一侧免费、一侧付费")
    (NormalizeResult::Normalized(_), NormalizeResult::Free) =>
      AlignResult::Different("一侧免费、一侧付费")
    (NormalizeResult::Normalized(pa), NormalizeResult::Normalized(pb)) =>
      if !currency_eq(pa.currency, pb.currency) {
        AlignResult::Different(
          "货币不同：\{currency_code(pa.currency)} 与 \{currency_code(pb.currency)}，不做汇率换算",
        )
      } else if pa.monthly_cents != pb.monthly_cents {
        AlignResult::Different(
          "月均价不同：\{format_monthly(pa)} 与 \{format_monthly(pb)}",
        )
      } else if pa.per_seat != pb.per_seat {
        AlignResult::Different(
          "计费口径不同：一侧按席/按用户/按人计价，一侧不按人头计价",
        )
      } else {
        AlignResult::Same
      }
    (NormalizeResult::CannotNormalize(reason), _) =>
      AlignResult::CannotAlign("第一处价格无法归一化：" + reason)
    (_, NormalizeResult::CannotNormalize(reason)) =>
      AlignResult::CannotAlign("第二处价格无法归一化：" + reason)
  }
}

///|
/// 前置判定：返回 Some 表示结论已定（免费或明确拒绝），None 表示继续解析。
/// 顺序有讲究：多档/定制/按量先于免费——"免费版 + Pro $20/月"这种
/// 混写不能按免费算，也不能只取其中一个数，必须拒绝并让人拆分。
fn precheck(s : String) -> NormalizeResult? {
  if s == "" {
    Some(CannotNormalize("空价格：无价格可归一化"))
  } else if s.contains("；") ||
    s.contains(";") ||
    s.contains("、") ||
    s.contains(" or ") {
    // 顿号 、 与英文 or 也是档位分隔符：真实记录里 36 条用 、分隔多档
    //（如 Power BI APV-0206）、2 条用 or（如 Nansen APV-0978），
    // 只取第一档会静默丢掉其余档位，必须拒绝。
    Some(CannotNormalize("多档套餐：请先指定档位再归一化"))
  } else if s.contains("定制") ||
    s.contains("联系销售") ||
    s.contains("询价") {
    Some(CannotNormalize("定制定价：无固定金额"))
  } else if s.contains("按量") ||
    s.contains("tokens") ||
    s.contains("token") ||
    s.contains("/次") ||
    s.contains("/1M") {
    Some(CannotNormalize("按量计费：无固定月费"))
  } else if !has_digit(s.to_array()) &&
    (s.contains("免费") || s.contains("Free") || s.contains("free")) {
    Some(Free)
  } else if s.contains("免费") {
    Some(CannotNormalize("免费档与付费价混写：请拆分后归一化"))
  } else {
    None
  }
}

///|
/// 从符号或代码识别货币：先认代码（C$/CAD、A$/AUD、NT$/HK$/R$、
/// CNY、USD、EUR、GBP、JPY、INR、SAR），再认符号（$、€、£、₹）；
/// NT$/HK$/R$ 不是美元，记 Other 不猜成 USD；都不认返回 None。
fn detect_currency(s : String) -> Currency? {
  if s.contains("C$") || s.contains("CAD") {
    Some(Currency::Other)
  } else if s.contains("A$") || s.contains("AUD") {
    Some(Currency::Other)
  } else if s.contains("NT$") || s.contains("HK$") || s.contains("R$") {
    Some(Currency::Other)
  } else if s.contains("CNY") {
    Some(Currency::CNY)
  } else if s.contains("USD") {
    Some(Currency::USD)
  } else if s.contains("EUR") {
    Some(Currency::EUR)
  } else if s.contains("GBP") {
    Some(Currency::GBP)
  } else if s.contains("JPY") {
    Some(Currency::JPY)
  } else if s.contains("INR") {
    Some(Currency::INR)
  } else if s.contains("SAR") {
    Some(Currency::Other)
  } else if s.contains("$") {
    Some(Currency::USD)
  } else if s.contains("€") {
    Some(Currency::EUR)
  } else if s.contains("£") {
    Some(Currency::GBP)
  } else if s.contains("₹") {
    Some(Currency::INR)
  } else {
    None
  }
}

///|
fn currency_from_code(code : String) -> Currency {
  match code {
    "CNY" => Currency::CNY
    "USD" => Currency::USD
    "EUR" => Currency::EUR
    "GBP" => Currency::GBP
    "JPY" => Currency::JPY
    "INR" => Currency::INR
    _ => Currency::Other
  }
}

///|
/// 核心解析（precheck 已通过、货币已知）：取第一个金额数字，
/// 按计费周期折算月均价。金额为 0 即免费。
/// 周期判定：含 "/月"/"每月"/"按月"/"月付"/"/mo" 等按月标记 → 金额即月费；
/// 否则含 "/年"/"每年"/"按年"/"年付" 等按年标记 → 年总价 / 12；
/// 两者都没有 → 拒绝（不默认按月）。
/// "$8/月按年"含 "/月" 也含 "按年"：金额已是月费率，月均价即 $8，
/// billed_annually 记 true（按年付的月费率）。
fn normalize_core(s : String, cur : Currency) -> NormalizeResult {
  let cents = parse_amount_cents(s.to_array())
  if cents < 0 {
    return CannotNormalize("无金额数字：无法归一化")
  }
  if cents == 0 {
    return Free
  }
  let monthly = is_monthly_period(s)
  let yearly = is_yearly_period(s)
  let mut monthly_cents = 0
  if monthly {
    monthly_cents = cents
  } else if yearly {
    monthly_cents = (cents + 6) / 12
  } else {
    return CannotNormalize(
      "未注明计费周期：无法判断是按月还是按年",
    )
  }
  let per_seat = s.contains("席") ||
    s.contains("用户") ||
    s.contains("seat") ||
    s.contains("Seat") ||
    s.contains("/人") ||
    s.contains("per user")
  Normalized(NormalizedPrice::{
    currency: cur,
    monthly_cents,
    per_seat,
    billed_annually: yearly,
    original: s,
  })
}

///|
fn is_monthly_period(s : String) -> Bool {
  s.contains("/月") ||
  s.contains("每月") ||
  s.contains("按月") ||
  s.contains("月付") ||
  s.contains("/mo") ||
  s.contains("/month") ||
  s.contains("per month") ||
  s.contains("monthly")
}

///|
fn is_yearly_period(s : String) -> Bool {
  s.contains("/年") ||
  s.contains("每年") ||
  s.contains("按年") ||
  s.contains("年付") ||
  s.contains("年缴") ||
  s.contains("/yr") ||
  s.contains("/year") ||
  s.contains("per year") ||
  s.contains("yearly") ||
  s.contains("annual")
}

///|
fn has_digit(chars : Array[Char]) -> Bool {
  for i in 0..<chars.length() {
    if chars[i].is_ascii_digit() {
      return true
    }
  }
  false
}

///|
/// 取字符串里第一个金额数字，折算成分（Int），四舍五入到分：
/// 小数第 3 位 ≥ 5 进 1。千分位逗号跳过；小数点后无数字时不认作小数点。
/// 没有数字返回 -1。整数部分用 Int 累加（价格量级远小于 Int 上限）。
fn parse_amount_cents(chars : Array[Char]) -> Int32 {
  let n = chars.length()
  let mut i = 0
  while i < n && !chars[i].is_ascii_digit() {
    i = i + 1
  }
  if i >= n {
    return -1
  }
  let mut int_part = 0
  let mut frac2 = 0
  let mut frac2_digits = 0
  let mut third_digit = -1
  let mut seen_dot = false
  while i < n {
    let c = chars[i]
    if c.is_ascii_digit() {
      if !seen_dot {
        int_part = int_part * 10 + digit_value(c)
      } else if frac2_digits < 2 {
        frac2 = frac2 * 10 + digit_value(c)
        frac2_digits = frac2_digits + 1
      } else if third_digit < 0 {
        third_digit = digit_value(c)
      }
      i = i + 1
    } else if c == ',' && !seen_dot {
      i = i + 1
    } else if c == '.' && !seen_dot {
      if i + 1 < n && chars[i + 1].is_ascii_digit() {
        seen_dot = true
        i = i + 1
      } else {
        break
      }
    } else {
      break
    }
  }
  let mut cents = int_part * 100
  if frac2_digits == 1 {
    cents = cents + frac2 * 10
  } else if frac2_digits == 2 {
    cents = cents + frac2
  }
  if third_digit >= 5 {
    cents = cents + 1
  }
  cents
}
