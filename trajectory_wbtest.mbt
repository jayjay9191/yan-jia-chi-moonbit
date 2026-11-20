///|
fn trajectory_tool(name : String) -> ToolPricing {
  guard tool_by_name(name) is Some(tool) else { abort("missing fixture") }
  tool
}

///|
fn history_event(
  change : String,
  old : String,
  next : String,
  date~ : String = "2026-11-18",
  session~ : String = "fixture",
) -> HistoryEntry {
  {
    date,
    session,
    change,
    old_price: old,
    new_price: next,
    note: "synthetic test",
  }
}

///|
test "Tana trajectory computes a rounded minus 21 percent" {
  let report = analyze_trajectory(trajectory_tool("Tana"))
  assert_eq(report.events[1].percent, Some(-21))
  assert_eq(report.events[1].change, "降价")
  assert_eq(report.events[1].level, "常规复核")
}

///|
test "GLM multi-tier repricing requires tier-by-tier review" {
  let report = analyze_trajectory(trajectory_tool("智谱清言 / GLM"))
  assert_true(report.events[0].percent is None)
  assert_true(report.events[0].detail.contains("逐档核对"))
  assert_true(report.events[0].needs_review)
}

///|
test "Tabnine delisting remains a stop verdict and retains all history" {
  let report = analyze_trajectory(trajectory_tool("Tabnine"))
  assert_eq(report.events.length(), 3)
  assert_eq(report.status, "已下架，停止复核，保留历史")
}

///|
test "two trailing unobserved events downgrade the current verdict" {
  let tool = trajectory_tool("Tana")
  let history = [
    history_event("未看到价", "", ""),
    history_event("未看到价", "", "", session="second"),
  ]
  assert_eq(
    analyze_trajectory({ ..tool, history, }).status,
    "数据不可观测，降级为未核验",
  )
}

///|
test "one observation failure does not downgrade and later observation recovers" {
  let tool = trajectory_tool("Tana")
  let missing = history_event("未看到价", "", "")
  let seen = history_event("无变化", "", "", session="third")
  assert_eq(
    analyze_trajectory({ ..tool, history: [missing], }).status,
    "保留原核验状态",
  )
  assert_eq(
    analyze_trajectory({
      ..tool,
      history: [missing, { ..missing, session: "second", }, seen],
    }).status,
    "保留原核验状态",
  )
}

///|
test "major movement thresholds are inclusive" {
  let tool = trajectory_tool("Tana")
  for
    (old, next, category, major) in [
      ("$10/月", "$15/月", "涨价", true),
      ("$10/月", "$14.9/月", "涨价", false),
      ("$10/月", "$7/月", "降价", true),
      ("$10/月", "$7.1/月", "降价", false),
    ] {
    let event = analyze_trajectory({
        ..tool,
        history: [history_event(category, old, next)],
      }).events[0]
    assert_eq(event.needs_review, major)
  }
}

///|
test "history is processed in chronological order without mutating its source" {
  let tool = trajectory_tool("Tana")
  let late = history_event(
    "无变化",
    "",
    "",
    date="2026-11-19",
    session="late",
  )
  let early = history_event("未看到价", "", "", date="2026-11-17")
  let report = analyze_trajectory({ ..tool, history: [late, early], })
  assert_eq(report.events[0].date, early.date)
  assert_eq(report.status, "保留原核验状态")
}

///|
test "price units currencies billing and declared direction must agree" {
  let tool = trajectory_tool("Tana")
  for
    (old, next) in [
      ("$10/月", "€15/月"),
      ("$10/用户/月", "$15/月"),
      ("$10/月", "$15/月按年"),
      ("$15/月", "$10/月"),
      ("$0/月", "$10/月"),
    ] {
    let event = analyze_trajectory({
        ..tool,
        history: [history_event("涨价", old, next)],
      }).events[0]
    assert_true(event.percent is None)
    assert_true(event.needs_review)
  }
}

///|
test "rounded percent does not change a major-movement boundary" {
  let tool = trajectory_tool("Tana")
  let event = analyze_trajectory({
      ..tool,
      history: [history_event("涨价", "$100/月", "$149.9/月")],
    }).events[0]
  assert_eq(event.percent, Some(50))
  assert_false(event.needs_review)
}

///|
test "trajectory rejects invalid dates and unsupported categories" {
  let tool = trajectory_tool("Tana")
  for
    event in [
      history_event("其它", "", ""),
      history_event("无变化", "", "", date="2026-02-30"),
    ] {
    assert_true(
      (Ok(analyze_trajectory({ ..tool, history: [event], })) catch {
        e => Err(e)
      })
      is Err(_),
    )
  }
}

///|
test "calendar validation observes month length and century leap rules" {
  for date in ["2026-02-29", "2026-04-31", "1900-02-29"] {
    assert_false(is_valid_date(date))
  }
  for date in ["2024-02-29", "2000-02-29", "2026-04-30"] {
    assert_true(is_valid_date(date))
  }
}

///|
test "full history classification matches the six measured category counts" {
  let summary = trajectory_summary(all_tools())
  assert_eq(summary.counts, [368, 160, 1, 3, 6, 404])
  assert_eq(summary.counts.fold(init=0, (n, count) => n + count), 942)
}

///|
test "review queue has a hard limit and a deterministic tie break" {
  let queue = recheck_queue(all_tools(), date_to_days("2026-11-20"))
  assert_eq(queue.length(), 20)
  assert_eq(recheck_queue([], date_to_days("2026-11-20")).length(), 0)
  let tool = trajectory_tool("Tana")
  let a = { ..tool, key: "a", name: "a", history: [], }
  let b = { ..a, key: "b", name: "b", }
  assert_eq(recheck_queue([b, a], date_to_days("2026-11-20"))[0].key, "a")
}

///|
test "queue prioritizes older checks and price-change history" {
  let tool = trajectory_tool("Tana")
  let old = { ..tool, key: "old", verified_at: "2026-10-01", history: [], }
  let recent = {
    ..tool,
    key: "recent",
    verified_at: "2026-11-19",
    history: [],
  }
  assert_eq(
    recheck_queue([recent, old], date_to_days("2026-11-20"))[0].key,
    "old",
  )
  let delisted = {
    ..recent,
    key: "delisted",
    history: [history_event("下架", "$10/月", "")],
  }
  assert_eq(
    recheck_queue([recent, delisted], date_to_days("2026-11-20"))[0].key,
    "delisted",
  )
}

///|
test "queue flags invalid and future verification dates instead of negative ages" {
  let tool = trajectory_tool("Tana")
  for date in ["invalid", "2026-12-01"] {
    let queue = recheck_queue(
      [{ ..tool, verified_at: date, }],
      date_to_days("2026-11-20"),
    )
    assert_true(queue[0].reason.contains("日期待核对"))
  }
}

///|
test "summary orders computable major movements before unquantified multi-tier changes" {
  let tool = trajectory_tool("Tana")
  let up = {
    ..tool,
    key: "up",
    history: [history_event("涨价", "$10/月", "$16/月")],
  }
  let down = {
    ..tool,
    key: "down",
    history: [history_event("降价", "$10/月", "$6/月")],
  }
  let summary = trajectory_summary([
    down,
    trajectory_tool("智谱清言 / GLM"),
    up,
  ])
  assert_eq(summary.review.map(report => report.key), ["up", "down", "APV-0011"])
}

///|
test "percentage calculation retains wide integer precision at supported price limits" {
  let tool = trajectory_tool("Tana")
  let report = analyze_trajectory({
    ..tool,
    history: [history_event("涨价", "$0.01/月", "$21474836.47/月")],
  })
  assert_eq(report.events[0].percent, Some(214748364600L))
  assert_true(report.events[0].needs_review)
}

///|
test "annual repricing uses original charges before monthly rounding" {
  let tool = trajectory_tool("Tana")
  for
    (old, next, percent) in [
      ("$0.01/年", "$0.02/年", 100L),
      ("$49/年", "$50/年", 2L),
    ] {
    let event = analyze_trajectory({
        ..tool,
        history: [history_event("涨价", old, next)],
      }).events[0]
    assert_eq(event.percent, Some(percent))
  }
}

///|
test "queue derives delisting and observability from chronological trajectory" {
  let tool = trajectory_tool("Tana")
  let delisted = history_event(
    "下架",
    "$10/月",
    "",
    date="2026-11-19",
    session="delisted",
  )
  let seen = history_event("无变化", "$10/月", "$10/月", date="2026-11-17")
  let queue = recheck_queue(
    [{ ..tool, history: [delisted, seen], }],
    date_to_days("2026-11-20"),
  )
  assert_true(queue[0].reason.contains("停止报价复核"))
  let missing = history_event("未看到价", "", "")
  let unseen = recheck_queue(
    [{ ..tool, history: [missing, { ..missing, session: "second", }], }],
    date_to_days("2026-11-20"),
  )
  assert_true(unseen[0].reason.contains("数据不可观测"))
  let malformed = recheck_queue(
    [{ ..tool, history: [history_event("无变化", "", "", date="invalid")], }],
    date_to_days("2026-11-20"),
  )
  assert_true(malformed[0].reason.contains("轨迹不合法"))
}

///|
test "duplicate missing-price sessions cannot cause a false observability downgrade" {
  let tool = trajectory_tool("Tana")
  let missing = history_event("未看到价", "", "")
  let report = analyze_trajectory({ ..tool, history: [missing, missing], })
  assert_eq(report.events.length(), 2)
  assert_eq(report.status, "保留原核验状态")
  assert_true(report.events[1].detail.contains("独立"))
}

///|
test "delisted archives stay stopped until a new observed price returns" {
  let tool = trajectory_tool("Tana")
  let removed = history_event(
    "下架",
    "$10/月",
    "",
    date="2026-11-18",
    session="removed",
  )
  let first = history_event(
    "未看到价",
    "",
    "",
    date="2026-11-19",
    session="missing-1",
  )
  let second = history_event(
    "未看到价",
    "",
    "",
    date="2026-11-20",
    session="missing-2",
  )
  let archive = { ..tool, history: [removed, first, second], }
  let report = analyze_trajectory(archive)
  assert_eq(report.status, "已下架，停止复核，保留历史")
  assert_eq(report.events[2].level, "已下架，停止复核，保留历史")
  assert_true(
    recheck_queue([archive], date_to_days("2026-11-20"))[0].reason.contains(
      "停止报价复核",
    ),
  )
  let note_only = history_event(
    "无变化",
    "",
    "",
    date="2026-11-21",
    session="note-only",
  )
  assert_eq(
    analyze_trajectory({ ..tool, history: [removed, first, second, note_only], }).status,
    "已下架，停止复核，保留历史",
  )
  let observed = history_event(
    "新档位",
    "",
    "$12/月",
    date="2026-11-21",
    session="returned",
  )
  let active = { ..tool, history: [removed, first, second, observed], }
  assert_eq(analyze_trajectory(active).status, "保留原核验状态")
  assert_false(
    recheck_queue([active], date_to_days("2026-11-21"))[0].reason.contains(
      "停止报价复核",
    ),
  )
}
