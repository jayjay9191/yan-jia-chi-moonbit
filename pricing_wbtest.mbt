///|
/// 白盒测试：验证规则的回归测试，用合成记录逐条触发规则。
/// 同包内可直接构造 PriceStatus 枚举值。
/// Run `moon test` to execute.

///|
/// 一个全部合法的合成记录，其他测试只改其中一个字段。
fn valid_tool() -> ToolPricing {
  {
    key: "APV-0001",
    session: "20261115-T",
    name: "测试工具",
    pricing_url: "https://example.com/pricing",
    free_tier: "Free $0",
    paid_price: "Plus $8/月",
    currency: "USD",
    billing: "按月",
    student_discount: "未见",
    reachable: "能打开",
    verified_at: "2026-11-08",
    note: "测试",
    status: PriceStatus::Verified,
    history: [],
  }
}

///|
fn tool_with(
  status : PriceStatus,
  paid_price : String,
  currency : String,
  billing : String,
  reachable : String,
  url : String,
  verified_at : String,
  student : String,
  free_tier : String,
  name : String,
) -> ToolPricing {
  {
    key: "APV-0001",
    session: "20261115-T",
    name,
    pricing_url: url,
    free_tier,
    paid_price,
    currency,
    billing,
    student_discount: student,
    reachable,
    verified_at,
    note: "测试",
    status,
    history: [],
  }
}

///|
/// 只改一个字段，其他字段保持合法。status/paid_price/currency/billing
/// 四个字段联动时，用 tool_with 全量构造。
fn with_name(t : ToolPricing, name : String) -> ToolPricing {
  {
    name,
    pricing_url: t.pricing_url,
    free_tier: t.free_tier,
    paid_price: t.paid_price,
    currency: t.currency,
    billing: t.billing,
    student_discount: t.student_discount,
    reachable: t.reachable,
    verified_at: t.verified_at,
    note: t.note,
    status: t.status,
    key: t.key,
    session: t.session,
    history: t.history,
  }
}

///|
fn with_url(t : ToolPricing, url : String) -> ToolPricing {
  {
    name: t.name,
    pricing_url: url,
    free_tier: t.free_tier,
    paid_price: t.paid_price,
    currency: t.currency,
    billing: t.billing,
    student_discount: t.student_discount,
    reachable: t.reachable,
    verified_at: t.verified_at,
    note: t.note,
    status: t.status,
    key: t.key,
    session: t.session,
    history: t.history,
  }
}

///|
fn with_verified_at(t : ToolPricing, v : String) -> ToolPricing {
  {
    name: t.name,
    pricing_url: t.pricing_url,
    free_tier: t.free_tier,
    paid_price: t.paid_price,
    currency: t.currency,
    billing: t.billing,
    student_discount: t.student_discount,
    reachable: t.reachable,
    verified_at: v,
    note: t.note,
    status: t.status,
    key: t.key,
    session: t.session,
    history: t.history,
  }
}

///|
fn with_reachable(t : ToolPricing, r : String) -> ToolPricing {
  {
    name: t.name,
    pricing_url: t.pricing_url,
    free_tier: t.free_tier,
    paid_price: t.paid_price,
    currency: t.currency,
    billing: t.billing,
    student_discount: t.student_discount,
    reachable: r,
    verified_at: t.verified_at,
    note: t.note,
    status: t.status,
    key: t.key,
    session: t.session,
    history: t.history,
  }
}

///|
fn with_student(t : ToolPricing, s : String) -> ToolPricing {
  {
    name: t.name,
    pricing_url: t.pricing_url,
    free_tier: t.free_tier,
    paid_price: t.paid_price,
    currency: t.currency,
    billing: t.billing,
    student_discount: s,
    reachable: t.reachable,
    verified_at: t.verified_at,
    note: t.note,
    status: t.status,
    key: t.key,
    session: t.session,
    history: t.history,
  }
}

///|
fn with_free_tier(t : ToolPricing, f : String) -> ToolPricing {
  {
    name: t.name,
    pricing_url: t.pricing_url,
    free_tier: f,
    paid_price: t.paid_price,
    currency: t.currency,
    billing: t.billing,
    student_discount: t.student_discount,
    reachable: t.reachable,
    verified_at: t.verified_at,
    note: t.note,
    status: t.status,
    key: t.key,
    session: t.session,
    history: t.history,
  }
}

///|
test "valid synthetic record passes" {
  assert_eq(validate_tools([valid_tool()]).length(), 0)
}

///|
test "duplicate name is an issue" {
  // 两条同名记录，key 不同——只应报重名 1 个问题，不报 key 重复
  let issues = validate_tools([valid_tool(), with_key(valid_tool(), "APV-0002")])
  assert_eq(issues.length(), 1)
  assert_true(issues[0].contains("重复"))
}

///|
test "empty name is an issue" {
  let issues = validate_tools([with_name(valid_tool(), "")])
  assert_eq(issues.length(), 1)
  assert_true(issues[0].contains("没有名字"))
}

///|
test "http url is an issue" {
  let issues = validate_tools([
    with_url(valid_tool(), "http://example.com/pricing"),
  ])
  assert_eq(issues.length(), 1)
  assert_true(issues[0].contains("https://"))
}

///|
test "ftp url is an issue" {
  let issues = validate_tools([
    with_url(valid_tool(), "ftp://example.com/pricing"),
  ])
  assert_eq(issues.length(), 1)
}

///|
test "empty url is an issue" {
  let issues = validate_tools([with_url(valid_tool(), "")])
  assert_eq(issues.length(), 1)
}

///|
test "verified with empty price is an issue" {
  // 空价格 + 已核验：冒充已核验；同时 USD 价格里没 $ 符号，共 2 个问题
  let t = tool_with(
    PriceStatus::Verified,
    "",
    "USD",
    "按月",
    "能打开",
    "https://example.com/pricing",
    "2026-11-08",
    "未见",
    "Free $0",
    "测试工具",
  )
  let issues = validate_tools([t])
  assert_eq(issues.length(), 2)
  assert_true(issues[0].contains("冒充"))
}

///|
test "unverified with price is an issue" {
  // 有价格却标未核验到：只改这一处，货币/计费都留空，只报 1 个问题
  let t = tool_with(
    PriceStatus::Unverified,
    "Plus $8/月",
    "",
    "",
    "能打开",
    "https://example.com/pricing",
    "2026-11-08",
    "未见",
    "Free $0",
    "测试工具",
  )
  let issues = validate_tools([t])
  assert_eq(issues.length(), 1)
  assert_true(issues[0].contains("自相矛盾"))
}

///|
test "partial with empty price is an issue" {
  let t = tool_with(
    PriceStatus::VerifiedPartial,
    "",
    "USD",
    "按月",
    "能打开",
    "https://example.com/pricing",
    "2026-11-08",
    "未见",
    "Free $0",
    "测试工具",
  )
  let issues = validate_tools([t])
  assert_eq(issues.length(), 2)
  assert_true(issues[0].contains("冒充"))
}

///|
test "verified with empty currency is an issue" {
  let t = tool_with(
    PriceStatus::Verified,
    "Plus $8/月",
    "",
    "按月",
    "能打开",
    "https://example.com/pricing",
    "2026-11-08",
    "未见",
    "Free $0",
    "测试工具",
  )
  let issues = validate_tools([t])
  assert_eq(issues.length(), 1)
  assert_true(issues[0].contains("货币必须是"))
}

///|
test "unverified with currency is an issue" {
  let t = tool_with(
    PriceStatus::Unverified,
    "",
    "USD",
    "",
    "能打开",
    "https://example.com/pricing",
    "2026-11-08",
    "未见",
    "Free $0",
    "测试工具",
  )
  let issues = validate_tools([t])
  assert_eq(issues.length(), 1)
  assert_true(issues[0].contains("不编货币"))
}

///|
test "usd price without dollar sign is an issue" {
  let t = tool_with(
    PriceStatus::Verified,
    "Plus 8/月",
    "USD",
    "按月",
    "能打开",
    "https://example.com/pricing",
    "2026-11-08",
    "未见",
    "Free $0",
    "测试工具",
  )
  let issues = validate_tools([t])
  assert_eq(issues.length(), 1)
  assert_true(issues[0].contains("没有 $ 符号"))
}

///|
test "jpy price without yen sign is an issue" {
  let t = tool_with(
    PriceStatus::Verified,
    "Plus 3000/月",
    "JPY",
    "按月",
    "能打开",
    "https://example.com/pricing",
    "2026-11-08",
    "未见",
    "Free $0",
    "测试工具",
  )
  let issues = validate_tools([t])
  assert_eq(issues.length(), 1)
  assert_true(issues[0].contains("没有 ¥ 符号"))
}

///|
test "cny price without yen sign is an issue" {
  let t = tool_with(
    PriceStatus::Verified,
    "Plus 8/月",
    "CNY",
    "按月",
    "能打开",
    "https://example.com/pricing",
    "2026-11-08",
    "未见",
    "Free $0",
    "测试工具",
  )
  let issues = validate_tools([t])
  assert_eq(issues.length(), 1)
}

///|
test "verified with empty billing is an issue" {
  let t = tool_with(
    PriceStatus::Verified,
    "Plus $8/月",
    "USD",
    "",
    "能打开",
    "https://example.com/pricing",
    "2026-11-08",
    "未见",
    "Free $0",
    "测试工具",
  )
  let issues = validate_tools([t])
  assert_eq(issues.length(), 1)
  assert_true(issues[0].contains("计费周期"))
}

///|
test "unverified with billing is an issue" {
  let t = tool_with(
    PriceStatus::Unverified,
    "",
    "",
    "按月",
    "能打开",
    "https://example.com/pricing",
    "2026-11-08",
    "未见",
    "Free $0",
    "测试工具",
  )
  let issues = validate_tools([t])
  assert_eq(issues.length(), 1)
  assert_true(issues[0].contains("计费周期"))
}

///|
test "bad verified_at month is an issue" {
  let issues = validate_tools([with_verified_at(valid_tool(), "2026-13-01")])
  assert_eq(issues.length(), 1)
  assert_true(issues[0].contains("verified_at"))
}

///|
test "bad verified_at separator is an issue" {
  let issues = validate_tools([with_verified_at(valid_tool(), "2026/11/08")])
  assert_eq(issues.length(), 1)
}

///|
test "bad verified_at short day is an issue" {
  let issues = validate_tools([with_verified_at(valid_tool(), "2026-11-8")])
  assert_eq(issues.length(), 1)
}

///|
test "invalid reachable value is an issue" {
  let issues = validate_tools([with_reachable(valid_tool(), "能打开一半")])
  assert_eq(issues.length(), 1)
  assert_true(issues[0].contains("reachable"))
}

///|
test "blocked page cannot be verified" {
  let issues = validate_tools([with_reachable(valid_tool(), "打不开")])
  assert_eq(issues.length(), 1)
  assert_true(issues[0].contains("看不到页面"))
}

///|
test "limited page cannot be verified" {
  let issues = validate_tools([with_reachable(valid_tool(), "受限")])
  assert_eq(issues.length(), 1)
}

///|
test "empty student discount is an issue" {
  let issues = validate_tools([with_student(valid_tool(), "")])
  assert_eq(issues.length(), 1)
  assert_true(issues[0].contains("学生"))
}

///|
test "empty free tier is an issue" {
  let issues = validate_tools([with_free_tier(valid_tool(), "")])
  assert_eq(issues.length(), 1)
  assert_true(issues[0].contains("免费版"))
}

///|
test "three problems in one record are all reported" {
  // 已核验 + 空价格 + 空货币 + 空计费 = 3 个问题
  let t = tool_with(
    PriceStatus::Verified,
    "",
    "",
    "",
    "能打开",
    "https://example.com/pricing",
    "2026-11-08",
    "未见",
    "Free $0",
    "测试工具",
  )
  let issues = validate_tools([t])
  assert_eq(issues.length(), 3)
}

///|
test "status eq same" {
  assert_true(status_eq(PriceStatus::Verified, PriceStatus::Verified))
  assert_true(
    status_eq(PriceStatus::VerifiedPartial, PriceStatus::VerifiedPartial),
  )
  assert_true(status_eq(PriceStatus::Unverified, PriceStatus::Unverified))
}

///|
test "status eq different" {
  assert_true(!status_eq(PriceStatus::Verified, PriceStatus::Unverified))
  assert_true(!status_eq(PriceStatus::VerifiedPartial, PriceStatus::Verified))
  assert_true(!status_eq(PriceStatus::Unverified, PriceStatus::VerifiedPartial))
}

///|
test "leap day roundtrip" {
  assert_eq(date_to_days("2000-02-29"), 11016)
  assert_eq(days_to_date(11016), "2000-02-29")
  assert_eq(date_to_days("2024-02-29"), 19782)
  assert_eq(days_to_date(19782), "2024-02-29")
}

///|
test "digit value covers all arms" {
  assert_eq(digit_value('3'), 3)
  assert_eq(digit_value('x'), -1)
  assert_eq(date_to_days("2023-03-03"), 19419)
}

///|
/// 只改 key / session / history，其他字段保持合法。
fn with_key(t : ToolPricing, k : String) -> ToolPricing {
  {
    key: k,
    session: t.session,
    name: t.name,
    pricing_url: t.pricing_url,
    free_tier: t.free_tier,
    paid_price: t.paid_price,
    currency: t.currency,
    billing: t.billing,
    student_discount: t.student_discount,
    reachable: t.reachable,
    verified_at: t.verified_at,
    note: t.note,
    status: t.status,
    history: t.history,
  }
}

///|
fn with_session(t : ToolPricing, s : String) -> ToolPricing {
  {
    key: t.key,
    session: s,
    name: t.name,
    pricing_url: t.pricing_url,
    free_tier: t.free_tier,
    paid_price: t.paid_price,
    currency: t.currency,
    billing: t.billing,
    student_discount: t.student_discount,
    reachable: t.reachable,
    verified_at: t.verified_at,
    note: t.note,
    status: t.status,
    history: t.history,
  }
}

///|
fn with_history(t : ToolPricing, h : Array[HistoryEntry]) -> ToolPricing {
  {
    key: t.key,
    session: t.session,
    name: t.name,
    pricing_url: t.pricing_url,
    free_tier: t.free_tier,
    paid_price: t.paid_price,
    currency: t.currency,
    billing: t.billing,
    student_discount: t.student_discount,
    reachable: t.reachable,
    verified_at: t.verified_at,
    note: t.note,
    status: t.status,
    history: h,
  }
}

///|
fn recheck_entry() -> HistoryEntry {
  {
    date: "2026-11-15",
    session: "20261115-R1",
    change: "无变化",
    old_price: "",
    new_price: "",
    note: "复核：价格无变化",
  }
}

///|
fn price_up_entry() -> HistoryEntry {
  {
    date: "2026-11-15",
    session: "20261115-R1",
    change: "涨价",
    old_price: "输入 ¥3.5、输出 ¥12.5",
    new_price: "输入 ¥6、输出 ¥24",
    note: "复核：GLM-5.1 涨价",
  }
}

///|
test "empty key is an issue" {
  let t = with_key(valid_tool(), "")
  let issues = validate_tools([t])
  assert_eq(issues.length(), 1)
}

///|
test "duplicate key is an issue" {
  let a = valid_tool()
  let b = with_name(valid_tool(), "另一工具")
  let issues = validate_tools([a, b])
  assert_eq(issues.length(), 1)
}

///|
test "empty session is an issue" {
  let t = with_session(valid_tool(), "")
  let issues = validate_tools([t])
  assert_eq(issues.length(), 1)
}

///|
test "valid history entries pass" {
  let t = with_history(valid_tool(), [recheck_entry(), price_up_entry()])
  let issues = validate_tools([t])
  assert_eq(issues.length(), 0)
}

///|
test "history with bad date is an issue" {
  let h : HistoryEntry = {
    date: "2026-13-01",
    session: "20261115-R1",
    change: "无变化",
    old_price: "",
    new_price: "",
    note: "测试",
  }
  let t = with_history(valid_tool(), [h])
  let issues = validate_tools([t])
  assert_eq(issues.length(), 1)
}

///|
test "history with bad change is an issue" {
  let h : HistoryEntry = {
    date: "2026-11-15",
    session: "20261115-R1",
    change: "随便改",
    old_price: "",
    new_price: "",
    note: "测试",
  }
  let t = with_history(valid_tool(), [h])
  let issues = validate_tools([t])
  assert_eq(issues.length(), 1)
}

///|
test "history price up without prices is an issue" {
  let h : HistoryEntry = {
    date: "2026-11-15",
    session: "20261115-R1",
    change: "涨价",
    old_price: "",
    new_price: "",
    note: "测试",
  }
  let t = with_history(valid_tool(), [h])
  let issues = validate_tools([t])
  assert_eq(issues.length(), 1)
}

///|
test "history price up with same price is an issue" {
  let h : HistoryEntry = {
    date: "2026-11-15",
    session: "20261115-R1",
    change: "涨价",
    old_price: "输入 ¥3.5、输出 ¥12.5",
    new_price: "输入 ¥3.5、输出 ¥12.5",
    note: "测试",
  }
  let t = with_history(valid_tool(), [h])
  let issues = validate_tools([t])
  assert_eq(issues.length(), 1)
}

///|
test "history with empty session is an issue" {
  let h : HistoryEntry = {
    date: "2026-11-15",
    session: "",
    change: "无变化",
    old_price: "",
    new_price: "",
    note: "测试",
  }
  let t = with_history(valid_tool(), [h])
  let issues = validate_tools([t])
  assert_eq(issues.length(), 1)
}

///|
test "history change counts" {
  let tools = [
    with_history(valid_tool(), [recheck_entry()]),
    with_history(
      with_name(with_key(valid_tool(), "APV-0002"), "另一工具"),
      [price_up_entry()],
    ),
  ]
  assert_eq(history_entries_count(tools), 2)
  assert_eq(rechecked_tools_count(tools), 2)
  assert_eq(count_history_change(tools, "涨价"), 1)
  assert_eq(count_history_change(tools, "无变化"), 1)
  assert_eq(count_history_change(tools, "降价"), 0)
}

///|
test "is valid change covers six kinds" {
  assert_true(is_valid_change("无变化"))
  assert_true(is_valid_change("涨价"))
  assert_true(is_valid_change("降价"))
  assert_true(is_valid_change("下架"))
  assert_true(is_valid_change("新档位"))
  assert_true(is_valid_change("未看到价"))
  assert_true(!is_valid_change("随便改"))
  assert_true(!is_valid_change(""))
}
