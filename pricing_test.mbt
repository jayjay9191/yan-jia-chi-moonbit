///|
/// 黑盒测试：只测公开 API 的行为，不测实现细节。
/// Run `moon test` to execute and `moon test --update` to refresh snapshots.

///|
fn arr_contains(items : Array[String], s : String) -> Bool {
  for i in 0..<items.length() {
    if items[i] == s {
      return true
    }
  }
  false
}

///|
test "registry has twenty tools" {
  assert_eq(@ai-pricing-verifier.all_tools().length(), 20)
}

///|
test "all tools have name and https url" {
  let tools = @ai-pricing-verifier.all_tools()
  for i in 0..<tools.length() {
    assert_true(tools[i].name != "")
    assert_true(tools[i].pricing_url.has_prefix("https://"))
  }
}

///|
test "status counts are 8 verified 3 partial 9 unverified" {
  let tools = @ai-pricing-verifier.all_tools()
  assert_eq(@ai-pricing-verifier.verified_count(tools), 8)
  assert_eq(@ai-pricing-verifier.partial_count(tools), 3)
  assert_eq(@ai-pricing-verifier.unverified_count(tools), 9)
}

///|
test "names by status" {
  let tools = @ai-pricing-verifier.all_tools()
  let verified = @ai-pricing-verifier.names_verified(tools)
  assert_true(arr_contains(verified, "Cursor"))
  assert_true(arr_contains(verified, "DeepSeek"))
  assert_true(!arr_contains(verified, "豆包"))
  let unverified = @ai-pricing-verifier.names_unverified(tools)
  assert_true(arr_contains(unverified, "豆包"))
  assert_true(arr_contains(unverified, "讯飞星火"))
  assert_true(!arr_contains(unverified, "Cursor"))
  let partial = @ai-pricing-verifier.names_partial(tools)
  assert_eq(partial.length(), 3)
  assert_true(arr_contains(partial, "Gemini / Google"))
}

///|
test "real data passes all validation rules" {
  let issues = @ai-pricing-verifier.validate_tools(
    @ai-pricing-verifier.all_tools(),
  )
  assert_eq(issues.length(), 0)
}

///|
test "report counts with denominators" {
  // today = 2026-11-15（自 1970-01-01 起第 20772 天）
  let r = @ai-pricing-verifier.build_report(
    @ai-pricing-verifier.all_tools(),
    20772,
  )
  assert_eq(r.total, 20)
  assert_eq(r.verified, 8)
  assert_eq(r.partial, 3)
  assert_eq(r.unverified, 9)
  assert_eq(r.has_price, 11)
  assert_eq(r.no_price, 9)
  assert_eq(r.reachable_ok, 16)
  assert_eq(r.reachable_blocked, 3)
  assert_eq(r.reachable_limited, 1)
  assert_eq(r.currency_usd, 7)
  assert_eq(r.currency_jpy, 2)
  assert_eq(r.currency_cny, 2)
  assert_eq(r.currency_empty, 9)
  assert_eq(r.billing_pay_as_you_go, 3)
  assert_eq(r.billing_monthly, 5)
  assert_eq(r.billing_monthly_yearly, 2)
  assert_eq(r.billing_yearly, 1)
  assert_eq(r.billing_empty, 9)
  assert_eq(r.student_seen, 4)
  assert_eq(r.student_unseen, 16)
  assert_eq(r.stale_count, 0)
  assert_eq(r.today, "2026-11-15")
}

///|
test "report lines carry denominators" {
  let r = @ai-pricing-verifier.build_report(
    @ai-pricing-verifier.all_tools(),
    20772,
  )
  let lines = @ai-pricing-verifier.report_lines(r)
  assert_eq(lines[0], "工具总数：20")
  assert_eq(lines[1], "已核验（官网价已完整记录）：8/20")
  assert_eq(lines[2], "部分核验：3/20")
  assert_eq(lines[3], "未核验到付费价：9/20")
}

///|
test "evidence chain for verified tool" {
  match @ai-pricing-verifier.tool_by_name("Cursor") {
    Some(t) => {
      let lines = @ai-pricing-verifier.evidence_lines(t)
      assert_true(lines[1].contains("https://cursor.com/pricing"))
      assert_true(lines[3].contains("Plus $8/月"))
      assert_true(lines[8].contains("2026-11-08"))
      assert_true(lines[9].contains("已核验"))
    }
    None => assert_true(false)
  }
}

///|
test "evidence chain for unverified tool shows no price" {
  match @ai-pricing-verifier.tool_by_name("豆包") {
    Some(t) => {
      let lines = @ai-pricing-verifier.evidence_lines(t)
      assert_true(lines[3].contains("未核验到"))
      assert_true(lines[4].contains("无，付费价未核验到"))
      assert_true(lines[7].contains("受限"))
      assert_true(lines[9].contains("未核验到"))
    }
    None => assert_true(false)
  }
}

///|
test "lookup needs full name" {
  assert_true(@ai-pricing-verifier.tool_by_name("Cursor") is Some(_))
  // 简称查不到：只接受全名
  assert_true(@ai-pricing-verifier.tool_by_name("GPT") is None)
  assert_true(@ai-pricing-verifier.tool_by_name("不存在的工具") is None)
}

///|
test "billing category by prefix" {
  assert_eq(
    @ai-pricing-verifier.billing_category("按量，无月/年订阅"),
    "按量",
  )
  assert_eq(
    @ai-pricing-verifier.billing_category("按月，年付最高省16%"),
    "按月",
  )
  assert_eq(@ai-pricing-verifier.billing_category("月/年均有"), "月/年")
  assert_eq(@ai-pricing-verifier.billing_category("按年"), "按年")
  assert_eq(@ai-pricing-verifier.billing_category(""), "")
  assert_eq(
    @ai-pricing-verifier.billing_category("按月（仅见“每月”）"),
    "按月",
  )
}

///|
test "status text via lookup" {
  match @ai-pricing-verifier.tool_by_name("Cursor") {
    Some(t) =>
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
    None => assert_true(false)
  }
  match @ai-pricing-verifier.tool_by_name("Gemini / Google") {
    Some(t) =>
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
    None => assert_true(false)
  }
  match @ai-pricing-verifier.tool_by_name("豆包") {
    Some(t) =>
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
    None => assert_true(false)
  }
}

///|
test "date to days known values" {
  assert_eq(@ai-pricing-verifier.date_to_days("1970-01-01"), 0)
  assert_eq(@ai-pricing-verifier.date_to_days("2026-11-08"), 20765)
  assert_eq(@ai-pricing-verifier.date_to_days("2026-11-15"), 20772)
  assert_eq(@ai-pricing-verifier.date_to_days("2000-02-29"), 11016)
  assert_eq(@ai-pricing-verifier.date_to_days("2024-02-29"), 19782)
  assert_eq(@ai-pricing-verifier.date_to_days("2026-13-01"), -1)
  assert_eq(@ai-pricing-verifier.date_to_days("2026/11/08"), -1)
}

///|
test "days to date roundtrip" {
  assert_eq(@ai-pricing-verifier.days_to_date(0), "1970-01-01")
  assert_eq(@ai-pricing-verifier.days_to_date(20765), "2026-11-08")
  assert_eq(@ai-pricing-verifier.days_to_date(20772), "2026-11-15")
  assert_eq(@ai-pricing-verifier.days_to_date(11016), "2000-02-29")
}

///|
test "today from timestamp" {
  // 2026-11-15 00:00 UTC 的毫秒时间戳
  assert_eq(@ai-pricing-verifier.today_days(1794700800000UL), 20772)
  assert_eq(@ai-pricing-verifier.today_string(1794700800000UL), "2026-11-15")
}

///|
test "is valid date" {
  assert_true(@ai-pricing-verifier.is_valid_date("2026-11-08"))
  assert_true(!@ai-pricing-verifier.is_valid_date("2026-13-01"))
  assert_true(!@ai-pricing-verifier.is_valid_date("2026-00-10"))
  assert_true(!@ai-pricing-verifier.is_valid_date("2026-11-32"))
  assert_true(!@ai-pricing-verifier.is_valid_date("2026/11/08"))
  assert_true(!@ai-pricing-verifier.is_valid_date("2026-11-8"))
  assert_true(!@ai-pricing-verifier.is_valid_date(""))
}

///|
test "days since verified" {
  assert_eq(@ai-pricing-verifier.days_since_verified("2026-11-08", 20772), 7)
  assert_eq(@ai-pricing-verifier.days_since_verified("2026-13-01", 20772), -1)
}

///|
test "stale boundary is 30 days" {
  // 2026-11-08 核验：30 天后（2026-12-08）未过期，31 天后过期
  assert_true(!@ai-pricing-verifier.is_stale("2026-11-08", 20795))
  assert_true(@ai-pricing-verifier.is_stale("2026-11-08", 20796))
  assert_true(!@ai-pricing-verifier.is_stale("2026-11-08", 20772))
  // 格式不对的日期也算过期（不能当新鲜的用）
  assert_true(@ai-pricing-verifier.is_stale("2026-13-01", 20772))
}

///|
test "tool names list" {
  let names = @ai-pricing-verifier.tool_names()
  assert_eq(names.length(), 20)
  assert_eq(names[0], "Qwen / 通义千问")
  assert_eq(names[19], "Cursor")
}

///|
test "billing category unknown" {
  assert_eq(@ai-pricing-verifier.billing_category("未知"), "其他")
}

///|
test "report stale count when all expired" {
  // today = 2026-12-09，距 2026-11-08 已 31 天，20 条全过期
  let r = @ai-pricing-verifier.build_report(
    @ai-pricing-verifier.all_tools(),
    20796,
  )
  assert_eq(r.stale_count, 20)
}

///|
test "is valid date rejects non digit" {
  assert_true(!@ai-pricing-verifier.is_valid_date("202a-11-08"))
}

///|
test "join strings" {
  assert_eq(@ai-pricing-verifier.join_strings(["a", "b"], "、"), "a、b")
  assert_eq(@ai-pricing-verifier.join_strings([], "、"), "")
  assert_eq(@ai-pricing-verifier.join_strings(["a"], "、"), "a")
}
