///|
/// CLI 入口。
///   无参数 / report                带分母的汇总报告
///   list                          列出全部工具及价格状态
///   verify                        跑全部验证规则，目标 0 错；有问题返回码 1
///   stale                         按 verified_at 标出过期未复核的记录（超 30 天）
///   check <工具名>                单条证据链：5 步可追溯（来源 URL → 记录键 → 原始记录 → 复核 → 实时页面）
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
    "help" | "-h" | "--help" => print_usage()
    other => {
      println("未知子命令：\{other}")
      print_usage()
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
    "verify：跑全部验证规则，目标 0 错；有问题返回码 1",
  )
  println(
    "stale：按 verified_at 标出过期未复核的记录（超 30 天）",
  )
  println(
    "check <工具名>：单条证据链（5 步：来源 URL → 记录键 → 原始记录 → 复核 → 实时页面）",
  )
  println("help：显示本帮助")
  println("工具名只接受全名，例如：moon run cmd/main check Cursor")
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
    "数据说明：分批实测——首批 2026-11-08（Lexmount 云平台任务，实际打开各官网逐页核验），扩量 2026-11-15（逐个打开官方定价页核验）；未用第三方汇总文章，未编造未看到的价格。价格只在核验当天有效，官网随时会改，30 天后需复核；变动轨迹见各条记录的 history。",
  )
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
