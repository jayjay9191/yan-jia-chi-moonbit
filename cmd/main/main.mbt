///|
/// CLI 入口。
///   无参数 / report                带分母的汇总报告
///   list                          列出全部工具及价格状态
///   verify                        跑全部验证规则，目标 0 错；有问题返回码 1
///   stale                         按 verified_at 标出过期未复核的记录（超 30 天）
///   check <工具名>                单条证据链：5 步可追溯（来源 URL → 记录键 → 原始记录 → 复核 → 实时页面）
///   normalize "<单档价格>"       把单档价格折算成月均价（核心语义处理；
///                                多档/按量/定制/免费混写会明确拒绝并说明原因）
///   align "<价格A>" "<价格B>"    口径对齐：两个价格写法是否具有相同价格口径
///                                （货币、月均价、计费口径三项都相同才算同；
///                                任一侧无法归一化时拒绝判定，不猜）
///   help                          显示本帮助
/// 用法：moon run cmd/main [子命令 ...]
/// 工具名只接受全名，例如：
///   moon run cmd/main check Cursor
///   moon run cmd/main check "ChatGPT / OpenAI"
fn main {
  let args = user_args()
  if args.length() == 0 {
    cmd_report()
    return
  }
  match args[0] {
    "list" => cmd_list()
    "verify" => cmd_verify()
    "stale" => cmd_stale()
    "report" => cmd_report()
    "check" => cmd_check(args)
    "normalize" => cmd_normalize(args)
    "align" => cmd_align(args)
    "budget" => cmd_budget(args)
    "seat-plan" | "seat-risk" => cmd_seat_plan(args)
    "reprice" => cmd_reprice(args)
    "compare-quotes" => {
      if args.length() != 3 {
        eprintln(
          "用法：compare-quotes <前次报价原文> <本次报价原文>",
        )
        @env.exit(2)
      }
      println(Json(@lib.compare_quote_snapshots(args[1], args[2])).stringify())
    }
    "trajectory"
    | "trajectory-summary"
    | "classes"
    | "classes-quote"
    | "recheck-queue" => cmd_analysis(args)
    "help" | "-h" | "--help" => print_usage()
    other => {
      println("未知子命令：\{other}")
      print_usage()
      @env.exit(2)
    }
  }
}

///|
/// 命令行参数：去掉 argv[0]（程序路径）和可能出现的前导 "--"。
fn user_args() -> Array[String] {
  let raw = @env.args()
  let out : Array[String] = []
  for i in 1..<raw.length() {
    if i == 1 && raw[i] == "--" {
      continue
    }
    out.push(raw[i])
  }
  out
}

///|
fn print_usage() -> Unit {
  println("用法：moon run cmd/main [子命令 ...]")
  println("无参数 / report：带分母的汇总报告")
  println("list：列出全部工具及价格状态")
  println(
    "seat-plan <套餐名> <12个月席位数，英文逗号分隔> <报价原文>：模拟月付和年付组合",
  )
  println(
    "seat-risk <套餐名> <需求情景1> <需求情景2> <报价原文>：最小化最坏情景的额外成本",
  )
  println(
    "compare-quotes <前次报价原文> <本次报价原文>：输出逐套餐差异 JSON",
  )
  println(
    "verify：跑全部验证规则，目标 0 错；有问题返回码 1",
  )
  println(
    "stale：按 verified_at 标出过期未复核的记录（超 30 天）",
  )
  println(
    "check <工具名>：单条证据链（5 步：来源 URL → 记录键 → 原始记录 → 复核 → 实时页面）",
  )
  println(
    "normalize \"<单档价格>\"：折算月均价，如 normalize \"$8/月按年\"；多档/按量/定制会明确拒绝",
  )
  println(
    "align \"<价格A>\" \"<价格B>\"：口径对齐，如 align \"$8/月按年\" \"$96/年\"；三项（货币、月均价、计费口径）都相同才算价格口径一致",
  )
  println(
    "budget <席位数> <报价A> <报价B>：比较首次扣款、12 个月成本与差额",
  )
  println(
    "reprice slack <席位数>：复跑 Slack Business+ 公告的年付、月付调价",
  )
  println(
    "reprice <席位数> <旧标准报价> <新标准报价>：复核同付款周期调价",
  )
  println("help：显示本帮助")
  println(
    "trajectory <工具名>：轨迹幅度、异常分级与当前可观测状态",
  )
  println("trajectory-summary：六类轨迹计数与重点复核清单")
  println(
    "classes <工具名> [--json]：套餐身份、付款方式、一致性与历史证据缺口",
  )
  println(
    "recheck-queue [YYYY-MM-DD]：按账龄、变动历史和未核验状态列前20项",
  )
  println(
    "classes-quote <报价原文> [--json]：输入自有报价，核对套餐与年付差额",
  )
  println("工具名只接受全名，例如：moon run cmd/main check Cursor")
}

///|
fn print_class_report(label : String, report : @lib.PlanClassReport) -> Unit {
  println("\{label}：\{report.classes.length()}类")
  for cls in report.classes {
    let saving = match cls.annual_saving {
      Some(n) => "年付节省\{n}%"
      None => "未能计算年付节省率"
    }
    println("\{cls.plan} | \{cls.members.length()}种写法 | \{saving}")
    for offer in cls.members {
      println("  \{offer.quote}")
    }
  }
  println("矛盾/待核对：\{report.issues.length()}")
  for issue in report.issues {
    println(issue)
  }
}

///|
fn class_output_json(
  label : String,
  report : @lib.PlanClassReport,
  stability : @lib.ClassStability?,
) -> Json {
  let classes = report.classes.map(cls => {
    let saving = match cls.annual_saving {
      Some(value) => Json(value)
      None => Json::null()
    }
    let members = cls.members.map(offer => {
      Json::object({
        "plan": Json(offer.plan),
        "quote": Json(offer.quote),
        "source": Json(offer.source),
      })
    })
    Json::object({
      "plan": Json(cls.plan),
      "annual_saving": saving,
      "members": Json(members),
    })
  })
  let history = match stability {
    Some(s) =>
      Json::object({
        "complete": Json(s.complete),
        "observed_stable": Json(s.observed_stable),
        "sessions": Json(
          s.sessions.map(session => {
            Json::object({
              "session": Json(session.session),
              "class_count": Json(session.class_count),
              "detail": Json(session.detail),
            })
          }),
        ),
      })
    None => Json::null()
  }
  Json::object({
    "schema_version": Json(1),
    "label": Json(label),
    "classes": Json(classes),
    "issues": Json(report.issues),
    "history": history,
  })
}

///|
fn cmd_classes(args : Array[String]) -> Unit raise {
  let json = args.length() == 3 && args[2] == "--json"
  if (!json && args.length() != 2) ||
    args[1].trim().is_empty() ||
    args[1] == "--json" {
    fail("用法：\{args[0]} <工具名或报价原文> [--json]")
  }
  let (label, report, stability) = if args[0] == "classes-quote" {
    ("输入报价", @lib.plan_classes(args[1]), None)
  } else {
    guard @lib.tool_by_name(args[1]) is Some(tool) else {
      fail("未找到工具：" + args[1])
    }
    (
      tool.name,
      @lib.plan_classes(tool.paid_price),
      Some(@lib.class_stability(tool)),
    )
  }
  if json {
    println(class_output_json(label, report, stability).stringify())
    return
  }
  print_class_report(label, report)
  if stability is Some(s) {
    println(
      "历史证据完整：\{s.complete}；有原文的复核套餐身份稳定：\{s.observed_stable}",
    )
    for session in s.sessions {
      println(
        "\{session.session} | \{session.class_count}类 | \{session.detail}",
      )
    }
  }
}

///|
fn cmd_analysis(args : Array[String]) -> Unit {
  try {
    match args[0] {
      "trajectory-summary" => {
        if args.length() != 1 {
          fail("用法：trajectory-summary")
        }
        let summary = @lib.trajectory_summary(@lib.all_tools())
        let categories = @lib.trajectory_categories()
        for i in 0..<categories.length() {
          println("\{categories[i]}：\{summary.counts[i]}")
        }
        println(
          "重点复核（可计算幅度降序，多档待核对单列）：",
        )
        for report in summary.review {
          for event in report.events {
            if event.needs_review {
              println(
                "\{report.name} | \{event.date} | \{event.level} | \{event.detail}",
              )
            }
          }
        }
      }
      "recheck-queue" => {
        if args.length() > 2 {
          fail("用法：recheck-queue [YYYY-MM-DD]")
        }
        let today = if args.length() == 2 {
          if !@lib.is_valid_date(args[1]) {
            fail("复核日期不合法")
          }
          @lib.date_to_days(args[1])
        } else {
          @lib.today_days_cst(@env.now())
        }
        for item in @lib.recheck_queue(@lib.all_tools(), today) {
          println(
            "\{item.key} | \{item.name} | \{item.reason} | 上次核验 \{item.verified_at} | 分数 \{item.score}",
          )
        }
      }
      "classes-quote" | "classes" => cmd_classes(args)
      "trajectory" => {
        if args.length() != 2 {
          fail("用法：\{args[0]} <工具全名>")
        }
        guard @lib.tool_by_name(args[1]) is Some(tool) else {
          fail("未找到工具：" + args[1])
        }
        let report = @lib.analyze_trajectory(tool)
        println("\{report.name} | \{report.status}")
        for event in report.events {
          println(
            "\{event.date} \{event.session} | \{event.change} | \{event.level} | \{event.detail}",
          )
        }
      }
      _ => fail("未知分析命令")
    }
  } catch {
    err => {
      let message = "分析失败：" + err.to_string()
      if args.length() > 1 && args[args.length() - 1] == "--json" {
        eprintln(message)
      } else {
        println(message)
      }
      @env.exit(2)
    }
  }
}

///|
fn print_tool_names() -> Unit {
  println("工具列表：")
  for name in @lib.tool_names() {
    println("  - \{name}")
  }
}

///|
fn cmd_list() -> Unit {
  let tools = @lib.all_tools()
  println("-- 验价尺（\{tools.length()} 个）--")
  for i in 0..<tools.length() {
    let t = tools[i]
    let price = if t.paid_price == "" { "未核验到" } else { t.paid_price }
    println(
      "\{i + 1}. \{t.name} | \{@lib.status_text(t.status)} | \{price} | \{t.reachable} | 核验于 \{t.verified_at}",
    )
  }
}

///|
fn cmd_verify() -> Unit {
  let tools = @lib.all_tools()
  let issues = @lib.validate_tools(tools)
  println("== 验证规则 ==")
  println("工具：\{tools.length()} 个")
  if issues.length() == 0 {
    println("通过：0 个问题")
  } else {
    println("发现 \{issues.length()} 个问题：")
    for i in 0..<issues.length() {
      println("  - \{issues[i]}")
    }
    @env.exit(1)
  }
}

///|
fn cmd_stale() -> Unit {
  let tools = @lib.all_tools()
  let today = @lib.today_days_cst(@env.now())
  println("== 过期未复核（verified_at 距今超 30 天）==")
  println("今天：\{@lib.days_to_date(today)}")
  let mut stale_count = 0
  for i in 0..<tools.length() {
    let t = tools[i]
    let days = @lib.days_since_verified(t.verified_at, today)
    if @lib.is_stale(t.verified_at, today) {
      stale_count = stale_count + 1
      println(
        "  - \{t.name}：核验于 \{t.verified_at}，距今 \{days} 天，已过期",
      )
    }
  }
  if stale_count == 0 {
    println("过期：0/\{tools.length()} 个")
    // 下次复核日 = 最早的 verified_at + 30 天
    let mut earliest = today
    for i in 0..<tools.length() {
      let v = @lib.date_to_days(tools[i].verified_at)
      if v >= 0 && v < earliest {
        earliest = v
      }
    }
    println(
      "下次复核不晚于：\{@lib.days_to_date(earliest + @lib.STALE_DAYS)}（最早核验日 + 30 天）",
    )
  } else {
    println(
      "过期：\{stale_count}/\{tools.length()} 个，请去官网重新核验",
    )
  }
}

///|
fn cmd_report() -> Unit {
  let tools = @lib.all_tools()
  let today = @lib.today_days_cst(@env.now())
  let r = @lib.build_report(tools, today)
  println("== 验价尺 · 汇总 ==")
  for line in @lib.report_lines(r) {
    println(line)
  }
  println("")
  println("已核验：\{@lib.join_strings(@lib.names_verified(tools), "、")}")
  println(
    "部分核验：\{@lib.join_strings(@lib.names_partial(tools), "、")}",
  )
  println(
    "未核验到：\{@lib.join_strings(@lib.names_unverified(tools), "、")}",
  )
  println("")
  println(
    "数据说明：分批实测——首批 2026-11-08（人工通过云端浏览器实际打开各官网逐页核验），扩量 2026-11-15（逐个打开官方定价页核验）；未用第三方汇总文章，未编造未看到的价格。价格只在核验当天有效，官网随时会改，30 天后需复核；变动轨迹见各条记录的 history。",
  )
}

///|
fn cmd_normalize(args : Array[String]) -> Unit {
  if args.length() < 2 {
    println(
      "用法：normalize \"<单档价格>\"，如 normalize \"$8/月按年\"",
    )
    return
  }
  let s = args[1]
  let r = @lib.normalize_price(s)
  match @lib.normalize_kind(r) {
    "free" => println("\{s} → 免费：无月费")
    "normalized" => {
      println("\{s} → 月均价：\{@lib.format_monthly_of(s)}")
      if @lib.normalized_per_seat(r) {
        println(
          "  （按席/按用户计价：月均价是“每席每月”）",
        )
      }
      if @lib.normalized_billed_annually(r) {
        println("  （按年付折算）")
      }
    }
    _ => println("\{s} → 无法归一化：\{@lib.normalize_reason(r)}")
  }
}

///|
/// 口径对齐：两个价格写法是否具有相同价格口径。
/// 用法：align "<价格A>" "<价格B>"，如 align "$8/月按年" "$96/年"
fn cmd_align(args : Array[String]) -> Unit {
  if args.length() < 3 {
    println(
      "用法：align \"<价格A>\" \"<价格B>\"，如 align \"$8/月按年\" \"$96/年\"",
    )
    return
  }
  let a = args[1]
  let b = args[2]
  let r = @lib.align_prices(a, b)
  match @lib.align_kind(r) {
    "same" => {
      let fa = @lib.format_monthly_of(a)
      if fa == "" {
        println("\"\{a}\" 与 \"\{b}\" → 价格口径一致：均为免费")
      } else {
        println("\"\{a}\" 与 \"\{b}\" → 价格口径一致：均为 \{fa}")
      }
    }
    "different" =>
      println(
        "\"\{a}\" 与 \"\{b}\" → 价格口径不同：\{@lib.align_reason(r)}",
      )
    _ =>
      println(
        "\"\{a}\" 与 \"\{b}\" → 无法判定：\{@lib.align_reason(r)}",
      )
  }
}

///|
fn cmd_check(args : Array[String]) -> Unit {
  if args.length() < 2 {
    println("用法：check <工具名>")
    print_tool_names()
    return
  }
  match @lib.tool_by_name(args[1]) {
    Some(t) => {
      println("== 证据链：《\{t.name}》==")
      for line in @lib.evidence_lines(t) {
        println(line)
      }
    }
    None => {
      println("未找到工具：\{args[1]}")
      print_tool_names()
    }
  }
}

///|
fn budget_money(cents : Int64) -> String {
  let whole = (cents / 100L).to_string()
  let fraction = (cents % 100L).to_string().pad_start(2, '0')
  whole + "." + fraction
}

///|
fn parse_seat_demand(raw : String) -> Array[Int32] raise {
  let seats : Array[Int32] = []
  for field in raw.split(",") {
    seats.push(@string.parse_int(field.trim().to_owned()))
  }
  seats
}

///|
fn cmd_seat_plan(args : Array[String]) -> Unit {
  try {
    let risk = args[0] == "seat-risk"
    let length = if risk { 5 } else { 4 }
    if args.length() != length {
      fail(
        "用法：seat-plan <套餐名> <12个月席位数> <报价原文> 或 seat-risk <套餐名> <情景1> <情景2> <报价原文>",
      )
    }
    let seats = parse_seat_demand(args[2])
    if risk {
      println(
        Json(
          @lib.plan_seat_risk(args[4], args[1], [
            seats,
            parse_seat_demand(args[3]),
          ]),
        ).stringify(),
      )
    } else {
      println(Json(@lib.plan_seat_costs(args[3], args[1], seats)).stringify())
    }
  } catch {
    err => {
      eprintln("席位预算模拟失败：" + err.to_string())
      @env.exit(2)
    }
  }
}

///|
fn cmd_budget(args : Array[String]) -> Unit {
  if args.length() != 4 {
    println("用法：budget <席位数> <报价A> <报价B>")
    return
  }
  let seats = @string.parse_int(args[1]) catch { _ => 0 }
  match @lib.compare_budget(args[2], args[3], seats) {
    Ok(b) => {
      println(
        "币种 \{b.currency}，计费份数 \{b.seats}（同价连续使用 12 个月，未计额外税费）",
      )
      println(
        "报价 A 首次扣款 \{budget_money(b.first_charge_a)}，12 个月 \{budget_money(b.year_a)}",
      )
      println(
        "报价 B 首次扣款 \{budget_money(b.first_charge_b)}，12 个月 \{budget_money(b.year_b)}",
      )
      if b.year_a == b.year_b {
        println("12 个月成本相同")
      } else if b.year_a > b.year_b {
        println(
          "报价 B 的 12 个月成本低 \{budget_money(b.year_a - b.year_b)}",
        )
      } else {
        println(
          "报价 A 的 12 个月成本低 \{budget_money(b.year_b - b.year_a)}",
        )
      }
    }
    Err(reason) => println("无法比较预算：" + reason)
  }
}

///|
fn print_repricing(old : String, new : String, seats : Int32) -> Unit {
  match @lib.compare_repricing(old, new, seats) {
    Ok(b) => {
      let cycle = if @lib.normalized_billed_annually(@lib.normalize_price(old)) {
        "年付"
      } else {
        "月付"
      }
      let unit = if @lib.normalized_per_seat(@lib.normalize_price(old)) {
        "按席"
      } else {
        "整包"
      }
      let direction = if b.year_b > b.year_a {
        "增加"
      } else if b.year_b < b.year_a {
        "减少"
      } else {
        "持平"
      }
      let diff = if b.year_b >= b.year_a {
        b.year_b - b.year_a
      } else {
        b.year_a - b.year_b
      }
      println(
        "\{cycle} · \{unit} · \{b.currency} · \{seats} 份｜原报价 \{old} → \{new}",
      )
      println(
        "首次扣款 \{budget_money(b.first_charge_a)} → \{budget_money(b.first_charge_b)}｜12 个月 \{budget_money(b.year_a)} → \{budget_money(b.year_b)}（\{direction} \{budget_money(diff)}）",
      )
    }
    Err(reason) => {
      println("无法复核调价：" + reason)
      @env.exit(2)
    }
  }
}

///|
fn cmd_reprice(args : Array[String]) -> Unit {
  if args.length() == 3 && args[1] == "slack" {
    let seats = @string.parse_int(args[2]) catch { _ => 0 }
    println(
      "Slack Business+ · 2025-06-17 官方调价公告 · 标准报价，未计额外税费",
    )
    println(
      "来源 https://slack.com/blog/news/june-2025-pricing-and-packaging-announcement",
    )
    print_repricing(
      "$12.50 per user per month billed annually", "$15 per user per month billed annually",
      seats,
    )
    print_repricing("$15/user/month", "$18/user/month", seats)
  } else if args.length() == 4 {
    let seats = @string.parse_int(args[1]) catch { _ => 0 }
    print_repricing(args[2], args[3], seats)
  } else {
    println(
      "用法：reprice slack <席位数> 或 reprice <席位数> <旧标准报价> <新标准报价>",
    )
    @env.exit(2)
  }
}
