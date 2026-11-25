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
fn align_kind_of(a : String, b : String) -> String {
  @yan-jia-chi-moonbit.align_kind(@yan-jia-chi-moonbit.align_prices(a, b))
}

///|
fn align_reason_of(a : String, b : String) -> String {
  @yan-jia-chi-moonbit.align_reason(@yan-jia-chi-moonbit.align_prices(a, b))
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
    -1,
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

///|
/// 口径对齐：同一工具不同来源的两种价格写法，判定是否为同一套餐。
/// 判定标准：两侧都能归一化成功，且货币相同、月均价（整数分）相同、
/// 计费口径（按席/按用户/按人 vs 不按人头）相同；任一侧被拒绝直接
/// 拒绝判定，不猜。

///|
test "align same plan different spellings" {
  // Midjourney Basic 年付月费率 vs Pika Starter 年总价：同为 USD 800 分
  assert_eq(align_kind_of("$8/月按年", "$96/年"), "same")
  assert_eq(align_kind_of("$96/年", "$8/月按年"), "same")
  // 同一套餐时原因留空
  assert_eq(align_reason_of("$8/月按年", "$96/年"), "")
  // Midjourney Standard 年付月费率 vs Udio Pro 年总价：同为 USD 2400 分
  assert_eq(align_kind_of("$24/月", "$288/年"), "same")
  assert_eq(align_kind_of("$10/月按月", "$120/年"), "same")
  assert_eq(align_kind_of("€20/月", "€240/年"), "same")
}

///|
test "align different monthly price" {
  assert_eq(align_kind_of("$10/月", "$8/月"), "different")
  assert_true(align_reason_of("$10/月", "$8/月").contains("月均价不同"))
  // 真实记录：TripIt Pro $49/年（408 分）vs KOA Rewards $39/年（325 分）
  assert_eq(align_kind_of("$49/年", "$39/年"), "different")
  // 同一档位按月付与按年付的月费率不同时判不同：月均价是判据，
  // 不是档位——Basic 按月 $10 与按年折算 $8 是两个价格，不是一回事；
  // 要比同一档位的不同付费周期，用 annual_saving_pct
  assert_eq(align_kind_of("$10/月按月", "$8/月按年"), "different")
}

///|
test "align different currency" {
  assert_eq(align_kind_of("$10/月", "€10/月"), "different")
  assert_true(align_reason_of("$10/月", "€10/月").contains("货币不同"))
  // 真实记录：Emitwise £7,500/年 vs TripIt Pro $49/年
  assert_eq(align_kind_of("£7,500/年", "$49/年"), "different")
}

///|
test "align different billing unit" {
  // 按席/按用户计价 vs 不按人头计价：月均价同为 1200 分，口径不同
  assert_eq(align_kind_of("$12/用户/月", "$12/月"), "different")
  assert_true(
    align_reason_of("$12/用户/月", "$12/月").contains("计费口径不同"),
  )
  // 真实记录写法：Grammarly $12/用户/月 vs Playground 年付 $144/年
  assert_eq(align_kind_of("$12/用户/月", "$144/年"), "different")
}

///|
test "align refuses multi-tier side" {
  // Midjourney 整条 paid_price 原文：四档合写，先指定档位
  let s = "Basic $10/月按月、$8/月按年；Standard $30/$24；Pro $60/$48；Mega $120/$96；年付约省20%"
  assert_eq(align_kind_of(s, "$8/月按年"), "cannot_align")
  assert_true(align_reason_of(s, "$8/月按年").contains("多档套餐"))
  // 第二侧被拒绝也一样：报第二处的原因
  assert_eq(align_kind_of("$8/月按年", s), "cannot_align")
  assert_true(align_reason_of("$8/月按年", s).contains("多档套餐"))
  // Power BI：顿号分隔两档
  let pbi = "Pro $14/用户/月、Premium Per User $24/用户/月（均按年付）"
  assert_eq(align_kind_of(pbi, "$14/用户/月"), "cannot_align")
}

///|
test "align refuses usage-based and custom sides" {
  assert_eq(
    align_kind_of("API按量：输入 ¥8/1M tokens", "$10/月"),
    "cannot_align",
  )
  assert_true(
    align_reason_of("API按量：输入 ¥8/1M tokens", "$10/月").contains(
      "按量计费",
    ),
  )
  assert_eq(align_kind_of("定制定价", "$10/月"), "cannot_align")
  assert_true(
    align_reason_of("定制定价", "$10/月").contains("定制定价"),
  )
}

///|
test "align refuses bare yen and empty price" {
  assert_eq(align_kind_of("¥99/月", "$10/月"), "cannot_align")
  assert_true(
    align_reason_of("¥99/月", "$10/月").contains(
      "无法区分人民币与日元",
    ),
  )
  assert_eq(align_kind_of("", "$10/月"), "cannot_align")
  assert_true(align_reason_of("", "$10/月").contains("空价格"))
  assert_eq(align_kind_of("$10/月", ""), "cannot_align")
  // 两侧都被拒绝：报第一处的
  assert_eq(align_kind_of("定制定价", ""), "cannot_align")
  assert_true(align_reason_of("定制定价", "").contains("定制定价"))
}

///|
test "align free cases" {
  assert_eq(align_kind_of("免费使用", "$0/月"), "same")
  assert_eq(align_kind_of("免费使用", "$10/月"), "different")
  assert_true(
    align_reason_of("免费使用", "$10/月").contains("一侧免费"),
  )
  assert_eq(align_kind_of("$10/月", "免费使用"), "different")
}

///|
test "align rounds to same cents" {
  // AllTrails+ $35.99/年：(3599+6)/12=300 分，与 $3/月同价
  assert_eq(align_kind_of("$35.99/年", "$3/月"), "same")
}

///|
test "ambiguous amounts and unsupported currencies cannot align" {
  assert_eq(norm_kind("14-day trial, then $15/month"), "cannot_normalize")
  assert_eq(norm_kind("$49/month(annual)or$69/month"), "cannot_normalize")
  assert_eq(norm_kind("$-15/month"), "cannot_normalize")
  assert_eq(norm_kind("$9,00/month"), "cannot_normalize")
  assert_eq(norm_kind("$12,34,567/month"), "cannot_normalize")
  assert_eq(norm_kind("$21474836.48/month"), "cannot_normalize")
  assert_eq(norm_kind("$4294967297/month"), "cannot_normalize")
  assert_eq(align_kind_of("C$15/month", "A$15/month"), "cannot_align")
  assert_eq(
    @yan-jia-chi-moonbit.cheaper_monthly_cents("C$15/month", "A$12/month"),
    -1,
  )
}

///|
test "official member rates preserve unit and annual billing" {
  let rate = @yan-jia-chi-moonbit.normalize_price(
    "$15 per member per month Billed yearly",
  )
  assert_eq(@yan-jia-chi-moonbit.normalized_monthly_cents(rate), 1500)
  assert_true(@yan-jia-chi-moonbit.normalized_per_seat(rate))
  assert_true(@yan-jia-chi-moonbit.normalized_billed_annually(rate))
  assert_eq(align_kind_of("$15/user/month", "$15 per member per month"), "same")
  assert_eq(
    @yan-jia-chi-moonbit.cheaper_monthly_cents("$15/user/month", "$12/month"),
    -1,
  )
}

///|
test "Midjourney Basic annual replay retains two recorded observations" {
  match @yan-jia-chi-moonbit.tool_by_name("Midjourney") {
    Some(tool) => {
      assert_eq(tool.key, "APV-0015")
      let r1 = tool.history.filter(h => h.session == "20261115-R1")[0]
      let r5 = tool.history.filter(h => h.session == "20261118-R5")[0]
      assert_true(r1.note.contains("Basic $10/$8"))
      assert_true(r5.new_price.contains("Basic $10/月按月、$8/月按年"))
      assert_eq(
        align_kind_of("$8/月按年", "$8 / month billed annually"),
        "same",
      )
      assert_eq(align_kind_of("$8 / month billed annually", "$96/year"), "same")
      assert_eq(norm_cents("$96/year"), 800)
      assert_eq(@yan-jia-chi-moonbit.annual_saving_pct(1000, 800), 20)
    }
    None => assert_true(false)
  }
}

///|
test "team budget preserves exact yearly cents and actual first charge" {
  match
    @yan-jia-chi-moonbit.compare_budget(
      "$3/user/month", "$35.99 per user per year", 5,
    ) {
    Ok(b) => {
      assert_eq(b.currency, "USD")
      assert_eq(b.first_charge_a, 1500L)
      assert_eq(b.first_charge_b, 17995L)
      assert_eq(b.year_a, 18000L)
      assert_eq(b.year_b, 17995L)
    }
    Err(_) => assert_true(false)
  }
  assert_true(
    @yan-jia-chi-moonbit.compare_budget("$3/user/month", "$35.99/year", 5)
    is Err(_),
  )
  assert_true(
    @yan-jia-chi-moonbit.compare_budget(
      "C$3/user/month", "A$35.99 per user per year", 5,
    )
    is Err(_),
  )
  assert_true(
    @yan-jia-chi-moonbit.compare_budget("$3/month", "$36/year", 0) is Err(_),
  )
  assert_true(
    @yan-jia-chi-moonbit.compare_budget("$3/month", "$36/year", 5) is Err(_),
  )
}

///|
test "Slack Business Plus announced repricing preserves billing basis" {
  let old_annual = "$12.50 per user per month billed annually"
  let new_annual = "$15 per user per month billed annually"
  assert_eq(align_kind_of(old_annual, new_annual), "different")
  match @yan-jia-chi-moonbit.compare_budget(old_annual, new_annual, 10) {
    Ok(b) => {
      assert_eq(b.currency, "USD")
      assert_eq(b.year_a, 150000L)
      assert_eq(b.year_b, 180000L)
      assert_eq(b.first_charge_b - b.first_charge_a, 30000L)
    }
    Err(_) => assert_true(false)
  }
  match
    @yan-jia-chi-moonbit.compare_budget("$15/user/month", "$18/user/month", 10) {
    Ok(b) => {
      assert_eq(b.year_a, 180000L)
      assert_eq(b.year_b, 216000L)
    }
    Err(_) => assert_true(false)
  }
}

///|
test "repricing compares paid standard quotes on the same renewal cycle" {
  let annual = "$12.50 per user per month billed annually"
  let new_annual = "$180/user/year"
  assert_true(
    @yan-jia-chi-moonbit.compare_repricing(annual, new_annual, 10) is Ok(_),
  )
  assert_true(
    @yan-jia-chi-moonbit.compare_repricing(annual, "$18/user/month", 10)
    is Err(_),
  )
  assert_true(
    @yan-jia-chi-moonbit.compare_repricing(
      "$10/user/month promo", "$18/user/month", 10,
    )
    is Err(_),
  )
  assert_true(
    @yan-jia-chi-moonbit.compare_repricing(
      "$10/user/month", "$18/user/month 优惠", 10,
    )
    is Err(_),
  )
}

///|
test "budget and repricing reject starting prices and mixed payment labels" {
  let standard = "$20/user/month"
  for
    quote in [
      "$15/user/month起", "Starting at $15/user/month", "$15/user/month and up",
    ] {
    assert_true(
      @yan-jia-chi-moonbit.compare_budget(quote, standard, 10) is Err(_),
    )
    assert_true(
      @yan-jia-chi-moonbit.compare_repricing(standard, quote, 10) is Err(_),
    )
  }
  for
    quote in [
      "$15/user/month 年付或月付", "$15/user/month billed monthly or annually",
    ] {
    assert_true(
      @yan-jia-chi-moonbit.compare_budget(quote, standard, 10) is Err(_),
    )
  }
}

///|
test "conflicting billing basis is rejected while annual payment of a monthly rate is valid" {
  for
    quote in [
      "USD 20/月/年", "USD 20/年按月", "USD 20/月按月且按年", "USD 20/month per year",
      "USD 20/year billed monthly",
    ] {
    assert_eq(norm_kind(quote), "cannot_normalize")
    assert_true(norm_reason(quote).contains("计费周期冲突"))
  }
  assert_eq(norm_cents("USD 20/month billed annually"), 2000)
  assert_eq(norm_cents("USD 20/月（按年付）"), 2000)
  assert_eq(norm_cents("USD 240/year billed annually"), 2000)
}

///|
test "nominal monthly and yearly rates cannot hide unsupported payment terms" {
  let monthly = "$30 USD/member/month"
  let annual = "$144 USD/member/year"
  for
    quote in [
      "$20 USD/member/month quarterly", "$20 USD/member/month billed  quarterly",
      "$20 USD/member/month billed QUARTERLY", "$20 USD/用户/月（每季度支付）",
      "$60 USD semiannual", "$60 USD semi-annual", "$60 USD semi annual", "$60 USD semi  annual",
      "$20 USD bimonthly", "$20 USD bi-monthly", "$60 USD/member/three months", "$20 USD/member/month (quarterly)",
      "$20 USD/用户/月（按季度付）", "$20 USD/用户/月，每3个月扣款",
    ] {
    assert_eq(norm_kind(quote), "cannot_normalize")
    assert_true(norm_reason(quote).contains("不支持该付款周期"))
    assert_true(
      @yan-jia-chi-moonbit.compare_budget(quote, monthly, 2) is Err(_),
    )
  }
  match @yan-jia-chi-moonbit.compare_budget(monthly, annual, 2) {
    Ok(cost) => {
      assert_eq((cost.first_charge_a, cost.first_charge_b), (6000L, 28800L))
      assert_eq((cost.year_a, cost.year_b), (72000L, 28800L))
    }
    Err(reason) => fail(reason)
  }
}

///|
test "annual commitment and cash billing are independent evidence" {
  let billed_monthly = "USD 69.99/month Annual contract, billed monthly"
  let prepaid = "USD 779.99/year Annual, prepaid"
  for
    quote in [
      "USD 69.99/month (annual plan)", "USD 69.99/month (yearly)", "USD 69.99/月（年度合约）",
      "USD 69.99 annual contract",
    ] {
    assert_eq(norm_kind(quote), "cannot_normalize")
    assert_true(norm_reason(quote).contains("付款周期"))
  }
  assert_eq(norm_kind(billed_monthly), "normalized")
  assert_eq(norm_cents(billed_monthly), 6999)
  let library = @yan-jia-chi-moonbit.compare_budget(billed_monthly, prepaid, 1)
  guard library is Ok(plan) else {
    fail("expected fixed-account cash schedule")
  }
  assert_eq((plan.first_charge_a, plan.year_a), (6999L, 83988L))
  assert_eq((plan.first_charge_b, plan.year_b), (77999L, 77999L))
  assert_eq(
    @yan-jia-chi-moonbit.align_kind(
      @yan-jia-chi-moonbit.align_prices(billed_monthly, "USD 69.99/month"),
    ),
    "different",
  )
  assert_true(
    @yan-jia-chi-moonbit.compare_repricing(billed_monthly, "USD 69.99/month", 1)
    is Err(_),
  )
  assert_eq(norm_cents("USD 20/month annual billing only"), 2000)
  assert_eq(norm_cents("USD 60 yearly"), 500)
  assert_eq(norm_cents("USD 20/月按年"), 2000)
  assert_eq(norm_cents("USD 20/月（全年预付）"), 2000)
  assert_eq(norm_cents("USD 20/月（按年）"), 2000)
  assert_eq(
    norm_cents("USD 69.99/month annual contract, billed  Monthly"),
    6999,
  )
  assert_eq(norm_cents("USD 20/月（年度承诺，每月扣款）"), 2000)
}
