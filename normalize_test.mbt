///|
/// 价格归一化黑盒测试：只测公开 API 的行为（月均价、货币、拒绝原因），
/// 不直接碰枚举构造子（见 AGENTS.md）。
/// 真实案例取自 data/pricing.json：Midjourney 四档（APV-0015）、
/// Grammarly（APV-0025）、QuillBot（APV-0026）、豆包（未核验到）。

///|
fn norm_kind(s : String) -> String {
  @yan-jia-chi-moonbit.normalize_kind(@yan-jia-chi-moonbit.normalize_price(s))
}

///|
fn norm_cents(s : String) -> Int32 {
  @yan-jia-chi-moonbit.normalized_monthly_cents(
    @yan-jia-chi-moonbit.normalize_price(s),
  )
}

///|
fn norm_reason(s : String) -> String {
  @yan-jia-chi-moonbit.normalize_reason(@yan-jia-chi-moonbit.normalize_price(s))
}

///|
test "normalize monthly usd" {
  assert_eq(norm_kind("$10/月按月"), "normalized")
  assert_eq(norm_cents("$10/月按月"), 1000)
  assert_eq(
    @yan-jia-chi-moonbit.normalized_currency_code(
      @yan-jia-chi-moonbit.normalize_price("$10/月按月"),
    ),
    "USD",
  )
  assert_true(
    !@yan-jia-chi-moonbit.normalized_billed_annually(
      @yan-jia-chi-moonbit.normalize_price("$10/月按月"),
    ),
  )
}

///|
test "normalize annual-billed monthly rate" {
  // $8/月按年：金额已是月费率，按年付记 true，月均价即 $8
  assert_eq(norm_cents("$8/月按年"), 800)
  assert_true(
    @yan-jia-chi-moonbit.normalized_billed_annually(
      @yan-jia-chi-moonbit.normalize_price("$8/月按年"),
    ),
  )
}

///|
test "normalize yearly total divides by 12" {
  assert_eq(norm_cents("$96/年"), 800)
  assert_eq(norm_cents("$200/年"), 1667)
  assert_eq(norm_cents("$1,200/年"), 10000)
  assert_true(
    @yan-jia-chi-moonbit.normalized_billed_annually(
      @yan-jia-chi-moonbit.normalize_price("$96/年"),
    ),
  )
}

///|
test "normalize cny with explicit code" {
  assert_eq(
    @yan-jia-chi-moonbit.normalized_monthly_cents(
      @yan-jia-chi-moonbit.normalize_price_with_currency("¥99/月", "CNY"),
    ),
    9900,
  )
  assert_eq(
    @yan-jia-chi-moonbit.normalized_monthly_cents(
      @yan-jia-chi-moonbit.normalize_price_with_currency("年付 ¥990", "CNY"),
    ),
    8250,
  )
  assert_eq(
    @yan-jia-chi-moonbit.normalized_currency_code(
      @yan-jia-chi-moonbit.normalize_price_with_currency("¥99/月", "CNY"),
    ),
    "CNY",
  )
}

///|
test "normalize english period markers" {
  assert_eq(norm_cents("$9.9/mo"), 990)
  assert_eq(norm_cents("$9.9/month"), 990)
  assert_eq(norm_cents("$120/year"), 1000)
}

///|
test "normalize decimal rounding" {
  assert_eq(norm_cents("$8.33/月"), 833)
  assert_eq(norm_cents("$8.335/月"), 834)
  assert_eq(norm_cents("$8.334/月"), 833)
}

///|
test "normalize per seat" {
  assert_eq(norm_cents("Pro $69/席/月（按月付）"), 6900)
  assert_true(
    @yan-jia-chi-moonbit.normalized_per_seat(
      @yan-jia-chi-moonbit.normalize_price("Pro $69/席/月（按月付）"),
    ),
  )
  assert_eq(norm_cents("Premium $8.33/月（按年付）"), 833)
  assert_true(
    @yan-jia-chi-moonbit.normalized_billed_annually(
      @yan-jia-chi-moonbit.normalize_price("Premium $8.33/月（按年付）"),
    ),
  )
}

///|
test "normalize eur and gbp symbols" {
  assert_eq(norm_cents("€20/月"), 2000)
  assert_eq(
    @yan-jia-chi-moonbit.normalized_currency_code(
      @yan-jia-chi-moonbit.normalize_price("€20/月"),
    ),
    "EUR",
  )
  assert_eq(norm_cents("£15/月"), 1500)
  assert_eq(
    @yan-jia-chi-moonbit.normalized_currency_code(
      @yan-jia-chi-moonbit.normalize_price("£15/月"),
    ),
    "GBP",
  )
}

///|
test "normalize free cases" {
  assert_eq(norm_kind("免费使用"), "free")
  assert_eq(norm_kind("Free trial"), "free")
  assert_eq(norm_kind("$0/月"), "free")
}

///|
test "normalize rejects empty price" {
  assert_eq(norm_kind(""), "cannot_normalize")
  assert_true(norm_reason("").contains("空价格"))
}

///|
test "normalize rejects multi-tier string" {
  // Midjourney 整条 paid_price 原文：四档写在一起，必须先指定档位
  let s = "Basic $10/月按月、$8/月按年；Standard $30/$24；Pro $60/$48；Mega $120/$96；年付约省20%"
  assert_eq(norm_kind(s), "cannot_normalize")
  assert_true(norm_reason(s).contains("多档套餐"))
}

///|
test "normalize rejects ideographic comma multi-tier" {
  // 、是中文顿号，分隔档位：真实记录里 36 条只用它分隔多档
  //（Power BI APV-0206、Shadow APV-0437），旧版会只取第一档静默通过
  let s = "Pro $14/用户/月、Premium Per User $24/用户/月"
  assert_eq(norm_kind(s), "cannot_normalize")
  assert_true(norm_reason(s).contains("多档套餐"))
  assert_eq(
    norm_kind("Neo Pro $44.99/月、Power Pro $59.99/月"),
    "cannot_normalize",
  )
}

///|
test "normalize rejects english or multi-tier" {
  // or 并列两种价：Nansen（APV-0978）$49/月按年或 $69/月按月、
  // Messari（APV-0990）$4,500/年或 $1,350/季，只取其一会丢掉另一种
  assert_eq(
    norm_kind("$49/month (annual) or $69/month (monthly)"),
    "cannot_normalize",
  )
  assert_eq(norm_kind("$4,500/year or $1,350/quarter"), "cannot_normalize")
}

///|
test "normalize rejects custom and pay-as-you-go" {
  assert_eq(norm_kind("定制定价"), "cannot_normalize")
  assert_true(norm_reason("定制定价").contains("定制定价"))
  assert_eq(norm_kind("联系销售"), "cannot_normalize")
  assert_eq(norm_kind("API按量：输入 ¥8/1M tokens"), "cannot_normalize")
  assert_true(
    norm_reason("API按量：输入 ¥8/1M tokens").contains("按量计费"),
  )
}

///|
test "normalize rejects bare yen symbol" {
  // ¥ 同时是人民币与日元符号：不猜货币，明确拒绝
  assert_eq(norm_kind("¥99/月"), "cannot_normalize")
  assert_true(
    norm_reason("¥99/月").contains("无法区分人民币与日元"),
  )
}

///|
test "normalize rejects missing period" {
  assert_eq(norm_kind("$20"), "cannot_normalize")
  assert_true(norm_reason("$20").contains("未注明计费周期"))
  // 首月优惠价不是稳定月费：不默认按月
  assert_eq(
    @yan-jia-chi-moonbit.normalize_kind(
      @yan-jia-chi-moonbit.normalize_price_with_currency("¥9.9首月", "CNY"),
    ),
    "cannot_normalize",
  )
}

///|
test "normalize rejects free mixed with paid price" {
  assert_eq(norm_kind("免费版 + Pro $20/月"), "cannot_normalize")
  assert_true(norm_reason("免费版 + Pro $20/月").contains("混写"))
}

///|
test "midjourney tiers normalize to monthly and save 20 percent" {
  // APV-0015 Midjourney：2026-11-08 首次核验，2026-11-15 两次复核无变化；
  // 四档按月价与按年折算月费率逐档对齐，年付省 20% 由 MoonBit 算出。
  assert_eq(norm_cents("$10/月按月"), 1000)
  assert_eq(norm_cents("$8/月按年"), 800)
  assert_eq(@yan-jia-chi-moonbit.annual_saving_pct(1000, 800), 20)
  assert_eq(norm_cents("$30/月"), 3000)
  assert_eq(norm_cents("$24/月"), 2400)
  assert_eq(@yan-jia-chi-moonbit.annual_saving_pct(3000, 2400), 20)
  assert_eq(norm_cents("$60/月"), 6000)
  assert_eq(norm_cents("$48/月"), 4800)
  assert_eq(@yan-jia-chi-moonbit.annual_saving_pct(6000, 4800), 20)
  assert_eq(norm_cents("$120/月"), 12000)
  assert_eq(norm_cents("$96/月"), 9600)
  assert_eq(@yan-jia-chi-moonbit.annual_saving_pct(12000, 9600), 20)
}

///|
test "annual saving pct edge cases" {
  assert_eq(@yan-jia-chi-moonbit.annual_saving_pct(0, 0), 0)
  assert_eq(@yan-jia-chi-moonbit.annual_saving_pct(1000, 1000), 0)
  assert_eq(@yan-jia-chi-moonbit.annual_saving_pct(1000, 900), 10)
}

///|
test "normalize tool price uses record currency" {
  // Grammarly（APV-0025）：记录 currency=USD，付费价原文单档
  match @yan-jia-chi-moonbit.tool_by_name("Grammarly") {
    Some(t) => {
      let r = @yan-jia-chi-moonbit.normalize_tool_price(t)
      assert_eq(@yan-jia-chi-moonbit.normalize_kind(r), "normalized")
      assert_eq(@yan-jia-chi-moonbit.normalized_monthly_cents(r), 1200)
      assert_eq(@yan-jia-chi-moonbit.normalized_currency_code(r), "USD")
      assert_true(@yan-jia-chi-moonbit.normalized_per_seat(r))
    }
    None => assert_true(false)
  }
  // QuillBot（APV-0026）：$8.33/月（按年付）
  match @yan-jia-chi-moonbit.tool_by_name("QuillBot") {
    Some(t) => {
      let r = @yan-jia-chi-moonbit.normalize_tool_price(t)
      assert_eq(@yan-jia-chi-moonbit.normalized_monthly_cents(r), 833)
      assert_true(@yan-jia-chi-moonbit.normalized_billed_annually(r))
    }
    None => assert_true(false)
  }
}

///|
test "normalize tool price refuses unverified and multi-tier records" {
  // 豆包：未核验到，paid_price 为空，不编价格
  match @yan-jia-chi-moonbit.tool_by_name("豆包") {
    Some(t) => {
      let r = @yan-jia-chi-moonbit.normalize_tool_price(t)
      assert_eq(@yan-jia-chi-moonbit.normalize_kind(r), "cannot_normalize")
      assert_true(
        @yan-jia-chi-moonbit.normalize_reason(r).contains("未核验到"),
      )
    }
    None => assert_true(false)
  }
  // Midjourney：整条 paid_price 是四档合写，先指定档位
  match @yan-jia-chi-moonbit.tool_by_name("Midjourney") {
    Some(t) => {
      let r = @yan-jia-chi-moonbit.normalize_tool_price(t)
      assert_eq(@yan-jia-chi-moonbit.normalize_kind(r), "cannot_normalize")
      assert_true(
        @yan-jia-chi-moonbit.normalize_reason(r).contains("多档套餐"),
      )
    }
    None => assert_true(false)
  }
  // Power BI（APV-0206）：paid_price 用顿号分隔两档，拒绝而非只取第一档
  match @yan-jia-chi-moonbit.tool_by_name("Power BI") {
    Some(t) => {
      let r = @yan-jia-chi-moonbit.normalize_tool_price(t)
      assert_eq(@yan-jia-chi-moonbit.normalize_kind(r), "cannot_normalize")
      assert_true(
        @yan-jia-chi-moonbit.normalize_reason(r).contains("多档套餐"),
      )
    }
    None => assert_true(false)
  }
}

///|
test "cheaper monthly cents" {
  assert_eq(
    @yan-jia-chi-moonbit.cheaper_monthly_cents("$10/月按月", "$8/月按年"),
    800,
  )
  // 货币不同不比较、不换算
  assert_eq(
    @yan-jia-chi-moonbit.cheaper_monthly_cents("$10/月", "€8/月"),
    -1,
  )
  // 任一无法归一化返回 -1
  assert_eq(
    @yan-jia-chi-moonbit.cheaper_monthly_cents("$10/月", "定制定价"),
    -1,
  )
  // 相等返回该月均价
  assert_eq(
    @yan-jia-chi-moonbit.cheaper_monthly_cents("$10/月", "$10/月"),
    1000,
  )
}

///|
test "format monthly of" {
  assert_eq(
    @yan-jia-chi-moonbit.format_monthly_of("$8/月按年"),
    "USD 8.00/月",
  )
  assert_eq(@yan-jia-chi-moonbit.format_monthly_of("$200/年"), "USD 16.67/月")
  assert_eq(@yan-jia-chi-moonbit.format_monthly_of("定制定价"), "")
}

///|
test "detect currency from codes and symbols" {
  // 代码优先：CNY/USD/EUR/GBP/JPY/INR/SAR/CAD/AUD
  assert_eq(norm_cents("CNY 100/月"), 10000)
  assert_eq(
    @yan-jia-chi-moonbit.normalized_currency_code(
      @yan-jia-chi-moonbit.normalize_price("CNY 100/月"),
    ),
    "CNY",
  )
  assert_eq(norm_cents("USD 20/月"), 2000)
  assert_eq(norm_cents("EUR 20/月"), 2000)
  assert_eq(norm_cents("GBP 20/月"), 2000)
  assert_eq(norm_cents("JPY 1000/月"), 100000)
  assert_eq(
    @yan-jia-chi-moonbit.normalized_currency_code(
      @yan-jia-chi-moonbit.normalize_price("JPY 1000/月"),
    ),
    "JPY",
  )
  assert_eq(norm_cents("INR 500/月"), 50000)
  assert_eq(norm_cents("₹500/月"), 50000)
  // C$/A$/SAR 不做汇率换算，记 Other
  assert_eq(norm_cents("C$20/月"), 2000)
  assert_eq(
    @yan-jia-chi-moonbit.normalized_currency_code(
      @yan-jia-chi-moonbit.normalize_price("C$20/月"),
    ),
    "OTHER",
  )
  assert_eq(norm_cents("A$20/月"), 2000)
  assert_eq(norm_cents("SAR 50/月"), 5000)
}

///|
test "normalize other dollar variants are not usd" {
  // NT$/HK$/R$ 不是美元：不猜成 USD，记 Other，金额照算
  //（与 C$/A$/SAR 同口径：只认金额，不编货币、不换算）
  assert_eq(norm_cents("NT$20/月"), 2000)
  assert_eq(
    @yan-jia-chi-moonbit.normalized_currency_code(
      @yan-jia-chi-moonbit.normalize_price("NT$20/月"),
    ),
    "OTHER",
  )
  assert_eq(norm_cents("HK$20/月"), 2000)
  assert_eq(
    @yan-jia-chi-moonbit.normalized_currency_code(
      @yan-jia-chi-moonbit.normalize_price("HK$20/月"),
    ),
    "OTHER",
  )
  assert_eq(norm_cents("R$20/月"), 2000)
  assert_eq(
    @yan-jia-chi-moonbit.normalized_currency_code(
      @yan-jia-chi-moonbit.normalize_price("R$20/月"),
    ),
    "OTHER",
  )
}

///|
test "currency from code covers all branches" {
  let eur = @yan-jia-chi-moonbit.normalize_price_with_currency("20/月", "EUR")
  assert_eq(@yan-jia-chi-moonbit.normalized_currency_code(eur), "EUR")
  let gbp = @yan-jia-chi-moonbit.normalize_price_with_currency("20/月", "GBP")
  assert_eq(@yan-jia-chi-moonbit.normalized_currency_code(gbp), "GBP")
  let jpy = @yan-jia-chi-moonbit.normalize_price_with_currency(
    "¥9900/月", "JPY",
  )
  assert_eq(@yan-jia-chi-moonbit.normalized_currency_code(jpy), "JPY")
  assert_eq(@yan-jia-chi-moonbit.normalized_monthly_cents(jpy), 990000)
  let inr = @yan-jia-chi-moonbit.normalize_price_with_currency("500/月", "INR")
  assert_eq(@yan-jia-chi-moonbit.normalized_currency_code(inr), "INR")
  // 未知代码记 Other，不编货币
  let other = @yan-jia-chi-moonbit.normalize_price_with_currency(
    "20/月", "CAD",
  )
  assert_eq(@yan-jia-chi-moonbit.normalized_currency_code(other), "OTHER")
  // with_currency 也走同一套拒绝规则
  assert_eq(
    @yan-jia-chi-moonbit.normalize_kind(
      @yan-jia-chi-moonbit.normalize_price_with_currency("定制定价", "CNY"),
    ),
    "cannot_normalize",
  )
}

///|
test "normalize rejects unrecognized currency and missing amount" {
  // 有数字、有周期，无货币符号：不猜货币
  assert_eq(norm_kind("20/月"), "cannot_normalize")
  assert_true(norm_reason("20/月").contains("未识别货币符号"))
  // 只有符号、没有数字：不编金额
  assert_eq(norm_kind("$"), "cannot_normalize")
  assert_true(norm_reason("$").contains("无金额数字"))
  // 小数点后无数字：小数点不认，金额照取
  assert_eq(norm_cents("$20. 按月"), 2000)
}

///|
test "cheaper monthly same currency pairs" {
  assert_eq(
    @yan-jia-chi-moonbit.cheaper_monthly_cents("CNY 100/月", "CNY 80/月"),
    8000,
  )
  assert_eq(
    @yan-jia-chi-moonbit.cheaper_monthly_cents("€20/月", "€16/月"),
    1600,
  )
  assert_eq(
    @yan-jia-chi-moonbit.cheaper_monthly_cents("£20/月", "£15/月"),
    1500,
  )
  assert_eq(
    @yan-jia-chi-moonbit.cheaper_monthly_cents("JPY 1000/月", "JPY 800/月"),
    80000,
  )
  assert_eq(
    @yan-jia-chi-moonbit.cheaper_monthly_cents("INR 500/月", "INR 400/月"),
    40000,
  )
  // Other 货币之间也可比（同为 Other，不换算）
  assert_eq(
    @yan-jia-chi-moonbit.cheaper_monthly_cents("C$20/月", "C$16/月"),
    1600,
  )
}

///|
test "accessors on non-normalized results" {
  // Free：月均价/货币/席位/按年均为缺省值，原因留空
  let free = @yan-jia-chi-moonbit.normalize_price("免费使用")
  assert_eq(@yan-jia-chi-moonbit.normalized_monthly_cents(free), -1)
  assert_eq(@yan-jia-chi-moonbit.normalized_currency_code(free), "")
  assert_true(!@yan-jia-chi-moonbit.normalized_per_seat(free))
  assert_true(!@yan-jia-chi-moonbit.normalized_billed_annually(free))
  assert_eq(@yan-jia-chi-moonbit.normalize_reason(free), "")
  // CannotNormalize：读数同样是缺省值
  let bad = @yan-jia-chi-moonbit.normalize_price("定制定价")
  assert_eq(@yan-jia-chi-moonbit.normalized_monthly_cents(bad), -1)
  assert_eq(@yan-jia-chi-moonbit.normalized_currency_code(bad), "")
  assert_true(!@yan-jia-chi-moonbit.normalized_per_seat(bad))
  assert_true(!@yan-jia-chi-moonbit.normalized_billed_annually(bad))
}
