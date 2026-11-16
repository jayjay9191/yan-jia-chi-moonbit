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
fn lines_contain(lines : Array[String], s : String) -> Bool {
  for i in 0..<lines.length() {
    if lines[i].contains(s) {
      return true
    }
  }
  false
}

///|
test "registry is non-empty and names match count" {
  let tools = @yan-jia-chi-moonbit.all_tools()
  assert_true(tools.length() > 0)
  assert_eq(tools.length(), @yan-jia-chi-moonbit.tool_names().length())
}

///|
test "all tools have name and https url" {
  let tools = @yan-jia-chi-moonbit.all_tools()
  for i in 0..<tools.length() {
    assert_true(tools[i].name != "")
    assert_true(tools[i].pricing_url.has_prefix("https://"))
  }
}

///|
test "status counts sum to total" {
  let tools = @yan-jia-chi-moonbit.all_tools()
  let total = tools.length()
  assert_eq(
    @yan-jia-chi-moonbit.verified_count(tools) +
    @yan-jia-chi-moonbit.partial_count(tools) +
    @yan-jia-chi-moonbit.unverified_count(tools),
    total,
  )
  // 三档都有记录：已核验、部分核验、未核验到都不是空档
  assert_true(@yan-jia-chi-moonbit.verified_count(tools) > 0)
  assert_true(@yan-jia-chi-moonbit.partial_count(tools) > 0)
  assert_true(@yan-jia-chi-moonbit.unverified_count(tools) > 0)
}

///|
test "names by status" {
  let tools = @yan-jia-chi-moonbit.all_tools()
  let verified = @yan-jia-chi-moonbit.names_verified(tools)
  assert_true(arr_contains(verified, "Cursor"))
  assert_true(arr_contains(verified, "DeepSeek"))
  assert_true(!arr_contains(verified, "豆包"))
  let unverified = @yan-jia-chi-moonbit.names_unverified(tools)
  assert_true(arr_contains(unverified, "豆包"))
  assert_true(arr_contains(unverified, "讯飞星火"))
  assert_true(!arr_contains(unverified, "Cursor"))
  let partial = @yan-jia-chi-moonbit.names_partial(tools)
  assert_true(arr_contains(partial, "Gemini / Google"))
}

///|
test "real data passes all validation rules" {
  let issues = @yan-jia-chi-moonbit.validate_tools(
    @yan-jia-chi-moonbit.all_tools(),
  )
  assert_eq(issues.length(), 0)
}

///|
test "report counts are internally consistent" {
  // today = 2026-11-16（自 1970-01-01 起第 20773 天；R4 复核在 11-16 做，
  // 数据里已有 11-16 的 verified_at，today 必须跟到同一天，否则未来日期被算过期）
  let tools = @yan-jia-chi-moonbit.all_tools()
  let r = @yan-jia-chi-moonbit.build_report(tools, 20773)
  let total = tools.length()
  assert_eq(r.total, total)
  assert_eq(r.verified + r.partial + r.unverified, total)
  assert_eq(r.has_price + r.no_price, total)
  assert_eq(r.reachable_ok + r.reachable_blocked + r.reachable_limited, total)
  assert_eq(
    r.currency_usd +
    r.currency_jpy +
    r.currency_cny +
    r.currency_eur +
    r.currency_gbp +
    r.currency_cad +
    r.currency_aud +
    r.currency_sar +
    r.currency_inr +
    r.currency_other +
    r.currency_empty,
    total,
  )
  assert_eq(
    r.billing_pay_as_you_go +
    r.billing_monthly +
    r.billing_monthly_yearly +
    r.billing_yearly +
    r.billing_empty +
    r.billing_other,
    total,
  )
  assert_eq(r.student_seen + r.student_unseen, total)
  // 2026-11-16 当天：11-08、11-15 与 11-16 三批都在 30 天内，无过期
  assert_eq(r.stale_count, 0)
  assert_eq(r.today, "2026-11-16")
  // 变动轨迹：自洽断言，不写死条数（R1 时写死 11/11/1/4，R2 一到就崩；
  // 见设计手记 §6 的教训）。R1 的事实仍可查：会话 20261115-R1 共 11 条、
  // 涨价 1 条、未看到价 4 条；R2（20261115-R2）新增 121 条。
  assert_eq(
    r.history_entries,
    @yan-jia-chi-moonbit.history_entries_count(tools),
  )
  assert_eq(
    r.rechecked_tools,
    @yan-jia-chi-moonbit.rechecked_tools_count(tools),
  )
  assert_eq(
    r.price_up,
    @yan-jia-chi-moonbit.count_history_change(tools, "涨价"),
  )
  assert_eq(
    r.price_down,
    @yan-jia-chi-moonbit.count_history_change(tools, "降价"),
  )
  assert_eq(
    r.delisted,
    @yan-jia-chi-moonbit.count_history_change(tools, "下架"),
  )
  assert_eq(
    r.unobserved,
    @yan-jia-chi-moonbit.count_history_change(tools, "未看到价"),
  )
}

///|
test "report lines carry denominators" {
  let r = @yan-jia-chi-moonbit.build_report(
    @yan-jia-chi-moonbit.all_tools(),
    20773,
  )
  let lines = @yan-jia-chi-moonbit.report_lines(r)
  assert_eq(lines[0], "工具总数：\{r.total}")
  assert_eq(
    lines[1],
    "已核验（官网价已完整记录）：\{r.verified}/\{r.total}",
  )
  assert_eq(lines[2], "部分核验：\{r.partial}/\{r.total}")
  assert_eq(lines[3], "未核验到付费价：\{r.unverified}/\{r.total}")
  assert_true(lines[lines.length() - 1].contains("变动轨迹"))
}

///|
test "evidence chain for verified tool has five steps" {
  match @yan-jia-chi-moonbit.tool_by_name("Cursor") {
    Some(t) => {
      let lines = @yan-jia-chi-moonbit.evidence_lines(t)
      assert_true(lines_contain(lines, "第 1 步"))
      assert_true(lines_contain(lines, "https://cursor.com/pricing"))
      assert_true(lines_contain(lines, "第 2 步"))
      assert_true(lines_contain(lines, "APV-"))
      assert_true(lines_contain(lines, "第 3 步"))
      assert_true(lines_contain(lines, "Plus $8/月"))
      assert_true(lines_contain(lines, "第 4 步"))
      assert_true(lines_contain(lines, "2026-11-08"))
      assert_true(lines_contain(lines, "已核验"))
      assert_true(lines_contain(lines, "第 5 步"))
    }
    None => assert_true(false)
  }
}

///|
test "evidence chain for unverified tool shows no price" {
  match @yan-jia-chi-moonbit.tool_by_name("豆包") {
    Some(t) => {
      let lines = @yan-jia-chi-moonbit.evidence_lines(t)
      assert_true(lines_contain(lines, "未核验到"))
      assert_true(lines_contain(lines, "无，付费价未核验到"))
      assert_true(lines_contain(lines, "受限"))
      assert_true(lines_contain(lines, "第 2 步"))
    }
    None => assert_true(false)
  }
}

///|
test "evidence chain for price-up tool shows old and new price" {
  // 智谱 GLM-5.1：2026-11-15 第一次复核发现的真实涨价
  match @yan-jia-chi-moonbit.tool_by_name("智谱清言 / GLM") {
    Some(t) => {
      let lines = @yan-jia-chi-moonbit.evidence_lines(t)
      assert_true(lines_contain(lines, "涨价"))
      assert_true(lines_contain(lines, "¥3.5"))
      assert_true(lines_contain(lines, "20261115-R1"))
      assert_true(lines_contain(lines, "APV-0011"))
    }
    None => assert_true(false)
  }
}

///|
test "evidence chain for rechecked tool shows no-change entry" {
  // DeepSeek：2026-11-15 复核确认无变动
  match @yan-jia-chi-moonbit.tool_by_name("DeepSeek") {
    Some(t) => {
      let lines = @yan-jia-chi-moonbit.evidence_lines(t)
      assert_true(lines_contain(lines, "无变化"))
      assert_true(lines_contain(lines, "20261115-R1"))
    }
    None => assert_true(false)
  }
}

///|
test "lookup needs full name" {
  assert_true(@yan-jia-chi-moonbit.tool_by_name("Cursor") is Some(_))
  // 简称查不到：只接受全名
  assert_true(@yan-jia-chi-moonbit.tool_by_name("GPT") is None)
  assert_true(@yan-jia-chi-moonbit.tool_by_name("不存在的工具") is None)
}

///|
test "billing category by prefix" {
  assert_eq(
    @yan-jia-chi-moonbit.billing_category("按量，无月/年订阅"),
    "按量",
  )
  assert_eq(
    @yan-jia-chi-moonbit.billing_category("按月，年付最高省16%"),
    "按月",
  )
  assert_eq(@yan-jia-chi-moonbit.billing_category("月/年均有"), "月/年")
  assert_eq(@yan-jia-chi-moonbit.billing_category("按年"), "按年")
  assert_eq(@yan-jia-chi-moonbit.billing_category(""), "")
  assert_eq(
    @yan-jia-chi-moonbit.billing_category("按月（仅见“每月”）"),
    "按月",
  )
}

///|
test "status text via lookup" {
  match @yan-jia-chi-moonbit.tool_by_name("Cursor") {
    Some(t) =>
      assert_eq(@yan-jia-chi-moonbit.status_text(t.status), "已核验")
    None => assert_true(false)
  }
  match @yan-jia-chi-moonbit.tool_by_name("Gemini / Google") {
    Some(t) =>
      assert_eq(@yan-jia-chi-moonbit.status_text(t.status), "部分核验")
    None => assert_true(false)
  }
  match @yan-jia-chi-moonbit.tool_by_name("豆包") {
    Some(t) =>
      assert_eq(@yan-jia-chi-moonbit.status_text(t.status), "未核验到")
    None => assert_true(false)
  }
}

///|
test "date to days known values" {
  assert_eq(@yan-jia-chi-moonbit.date_to_days("1970-01-01"), 0)
  assert_eq(@yan-jia-chi-moonbit.date_to_days("2026-11-08"), 20765)
  assert_eq(@yan-jia-chi-moonbit.date_to_days("2026-11-15"), 20772)
  assert_eq(@yan-jia-chi-moonbit.date_to_days("2000-02-29"), 11016)
  assert_eq(@yan-jia-chi-moonbit.date_to_days("2024-02-29"), 19782)
  assert_eq(@yan-jia-chi-moonbit.date_to_days("2026-13-01"), -1)
  assert_eq(@yan-jia-chi-moonbit.date_to_days("2026/11/08"), -1)
}

///|
test "days to date roundtrip" {
  assert_eq(@yan-jia-chi-moonbit.days_to_date(0), "1970-01-01")
  assert_eq(@yan-jia-chi-moonbit.days_to_date(20765), "2026-11-08")
  assert_eq(@yan-jia-chi-moonbit.days_to_date(20772), "2026-11-15")
  assert_eq(@yan-jia-chi-moonbit.days_to_date(11016), "2000-02-29")
}

///|
test "today from timestamp" {
  // 2026-11-15 00:00 UTC 的毫秒时间戳
  assert_eq(@yan-jia-chi-moonbit.today_days(1794700800000UL), 20772)
  assert_eq(@yan-jia-chi-moonbit.today_string(1794700800000UL), "2026-11-15")
}

///|
test "today cst is beijing time" {
  // 2026-11-15 20:00 UTC = 2026-11-16 04:00 北京时间：UTC 还是 11-15，
  // 北京已是 11-16；CLI 的 report/stale 必须用北京时间，否则刚复核的
  // 记录会被误判过期（R4：274 条 11-16 的记录在 UTC 11-15 当天被算过期）。
  assert_eq(@yan-jia-chi-moonbit.today_days(1794772800000UL), 20772)
  assert_eq(@yan-jia-chi-moonbit.today_days_cst(1794772800000UL), 20773)
}

///|
test "is valid date" {
  assert_true(@yan-jia-chi-moonbit.is_valid_date("2026-11-08"))
  assert_true(!@yan-jia-chi-moonbit.is_valid_date("2026-13-01"))
  assert_true(!@yan-jia-chi-moonbit.is_valid_date("2026-00-10"))
  assert_true(!@yan-jia-chi-moonbit.is_valid_date("2026-11-32"))
  assert_true(!@yan-jia-chi-moonbit.is_valid_date("2026/11/08"))
  assert_true(!@yan-jia-chi-moonbit.is_valid_date("2026-11-8"))
  assert_true(!@yan-jia-chi-moonbit.is_valid_date(""))
}

///|
test "days since verified" {
  assert_eq(@yan-jia-chi-moonbit.days_since_verified("2026-11-08", 20772), 7)
  assert_eq(@yan-jia-chi-moonbit.days_since_verified("2026-13-01", 20772), -1)
}

///|
test "stale boundary is 30 days" {
  // 2026-11-08 核验：30 天后（2026-12-08）未过期，31 天后过期
  assert_true(!@yan-jia-chi-moonbit.is_stale("2026-11-08", 20795))
  assert_true(@yan-jia-chi-moonbit.is_stale("2026-11-08", 20796))
  assert_true(!@yan-jia-chi-moonbit.is_stale("2026-11-08", 20772))
  // 格式不对的日期也算过期（不能当新鲜的用）
  assert_true(@yan-jia-chi-moonbit.is_stale("2026-13-01", 20772))
}

///|
test "tool names list" {
  let names = @yan-jia-chi-moonbit.tool_names()
  assert_eq(names.length(), @yan-jia-chi-moonbit.all_tools().length())
  assert_eq(names[0], "Qwen / 通义千问")
}

///|
test "billing category unknown" {
  assert_eq(@yan-jia-chi-moonbit.billing_category("未知"), "其他")
}

///|
test "report stale count when all expired" {
  // today = 2026-12-09：2026-11-08 核验的已超 31 天，2026-11-15
  // 核验的才 24 天——过期数 = 11-08 那批的条数，当场算出来
  let tools = @yan-jia-chi-moonbit.all_tools()
  let mut expected = 0
  for i in 0..<tools.length() {
    if @yan-jia-chi-moonbit.is_stale(tools[i].verified_at, 20796) {
      expected = expected + 1
    }
  }
  let r = @yan-jia-chi-moonbit.build_report(tools, 20796)
  assert_eq(r.stale_count, expected)
  assert_true(expected > 0)
}

///|
test "is valid date rejects non digit" {
  assert_true(!@yan-jia-chi-moonbit.is_valid_date("202a-11-08"))
}

///|
test "join strings" {
  assert_eq(@yan-jia-chi-moonbit.join_strings(["a", "b"], "、"), "a、b")
  assert_eq(@yan-jia-chi-moonbit.join_strings([], "、"), "")
  assert_eq(@yan-jia-chi-moonbit.join_strings(["a"], "、"), "a")
}
