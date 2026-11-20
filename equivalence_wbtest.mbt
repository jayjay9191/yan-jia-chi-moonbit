///|
test "Midjourney has eight observed payment variants in four plan classes" {
  let report = plan_classes(trajectory_tool("Midjourney").paid_price)
  assert_eq(report.classes.length(), 4)
  assert_eq(
    report.classes.fold(init=0, (n, cls) => n + cls.members.length()),
    8,
  )
  assert_eq(report.issues.length(), 0)
  for cls in report.classes {
    assert_eq(cls.annual_saving, Some(20))
  }
}

///|
test "equal prices do not merge different named plans" {
  let report = plan_classes("Basic $10/月；Pro $10/月")
  assert_eq(report.classes.length(), 2)
  assert_eq(report.issues.length(), 0)
}

///|
test "duplicate named plan declarations are unioned and conflicting same-cycle prices reported" {
  let report = plan_classes("Basic $10/月；Basic $11/月")
  assert_eq(report.classes.length(), 1)
  assert_true(report.issues.any(s => s.contains("月均价不同")))
}

///|
test "annual monthly rate and annual total align inside one plan" {
  let report = plan_classes("Basic $8/月按年；Basic $96/年")
  assert_eq(report.classes.length(), 1)
  assert_eq(report.issues.length(), 0)
}

///|
test "class audit checks every pair and catches currency or seat contradictions" {
  for
    quote in [
      "Basic $10/月；Basic €8/月按年", "Basic $10/用户/月；Basic $8/月按年",
    ] {
    assert_true(plan_classes(quote).issues.length() > 0)
  }
}

///|
test "compact pairs require explicit period context and ambiguous fragments remain visible" {
  let report = plan_classes("Standard $30/$24")
  assert_eq(report.classes.length(), 0)
  assert_true(report.issues.length() > 0)
  assert_true(plan_classes("Basic $10/月；待定").issues.length() > 0)
}

///|
test "empty unnamed free and malformed prices are not fabricated into offers" {
  for
    quote in [
      "", "$10/月", "Basic $0/月", "Basic $x/月", "Basic $10/月、$8/月、$6/月",
    ] {
    assert_true(plan_classes(quote).issues.length() > 0)
  }
}

///|
test "manual conflicting membership is diagnosed across classes" {
  let cls = plan_classes("Basic $10/月").classes[0]
  let other = { ..cls, plan: "Pro", }
  assert_true(
    audit_plan_classes([cls, other]).any(s => s.contains("两个类")),
  )
  assert_true(
    audit_plan_classes([
      { ..cls, members: [{ ..cls.members[0], plan: "Pro", }], },
    ]).any(s => s.contains("套餐身份")),
  )
}

///|
test "actual Midjourney sessions expose R1 evidence gap and verify R3 R5 identities" {
  let report = class_stability(trajectory_tool("Midjourney"))
  assert_eq(report.sessions.length(), 3)
  assert_false(report.complete)
  assert_true(report.observed_stable)
  assert_eq(report.sessions[0].class_count, 0)
  assert_true(report.sessions[0].detail.contains("缺少"))
  assert_eq([report.sessions[1].class_count, report.sessions[2].class_count], [
    4, 4,
  ])
}

///|
test "fully observed sessions are stable only when plan identities stay equal" {
  let tool = trajectory_tool("Midjourney")
  let first = history_event("无变化", "Basic $10/月", "Basic $10/月")
  let second = { ..first, session: "second", }
  let stable = class_stability({ ..tool, history: [first, second], })
  assert_true(stable.complete && stable.observed_stable)
  let changed = { ..second, new_price: "Pro $10/月", }
  assert_false(
    class_stability({ ..tool, history: [first, changed], }).observed_stable,
  )
}

///|
test "missing history or an internally inconsistent snapshot cannot certify stability" {
  let tool = trajectory_tool("Midjourney")
  assert_false(class_stability({ ..tool, history: [], }).complete)
  let inconsistent = history_event(
    "无变化", "", "Basic $10/月；Basic $20/月",
  )
  assert_false(
    class_stability({ ..tool, history: [inconsistent, inconsistent], }).complete,
  )
}

///|
test "external class audits reject unparseable members and never advertise unsupported savings" {
  let cls = plan_classes("Basic $10/月").classes[0]
  let bad = { ..cls.members[0], quote: "定制价格", }
  assert_true(
    audit_plan_classes([{ ..cls, members: [cls.members[0], bad], }]).length() >=
    2,
  )
  assert_true(
    plan_classes("Basic $10/月；Basic €8/月按年").classes[0].annual_saving
    is None,
  )
  let tool = trajectory_tool("Tana")
  let absent = history_event("涨价", "$10/月", "")
  assert_false(class_stability({ ..tool, history: [absent], }).complete)
}

///|
test "repeated or unnamed sessions and invalid dates are not independent rechecks" {
  let tool = trajectory_tool("Midjourney")
  let first = history_event("无变化", "Basic $10/月", "Basic $10/月")
  for
    second in [
      first,
      { ..first, session: " fixture ", },
      { ..first, session: "", },
      { ..first, session: "second", date: "2026-02-30", },
    ] {
    let report = class_stability({ ..tool, history: [first, second], })
    assert_false(report.complete)
    assert_false(report.observed_stable)
    assert_true(
      report.sessions[1].detail.contains("会话") ||
      report.sessions[1].detail.contains("日期"),
    )
  }
}

///|
test "class audit refuses empty identities and split classes for one plan" {
  let basic = plan_classes("Basic $10/月").classes[0]
  let duplicate = plan_classes("Basic $11/月").classes[0]
  assert_true(
    audit_plan_classes([basic, duplicate]).any(issue => {
      issue.contains("同一套餐")
    }),
  )
  assert_true(
    audit_plan_classes([{ ..basic, members: [], }]).any(issue => {
      issue.contains("空")
    }),
  )
  assert_true(
    audit_plan_classes([{ ..basic, plan: " ", }]).any(issue => {
      issue.contains("空")
    }),
  )
}

///|
test "annual plan classes compare exact charges before monthly rounding" {
  let conflict = plan_classes("Basic $96/年；Basic $96.01/年")
  assert_eq(conflict.issues.length(), 1)
  let tiny = plan_classes("Basic $0.01/月；Basic $0.01/年")
  assert_eq(tiny.issues.length(), 0)
  assert_eq(tiny.classes[0].annual_saving, Some(92))
}

///|
test "negative or abbreviated charges are not fabricated as low positive prices" {
  for
    quote in ["-$10/月", "$−10/月", "−€10/月", "$1k/月", "$1.2M/年"] {
    assert_eq(normalize_kind(normalize_price(quote)), "cannot_normalize")
  }
  let supplied = plan_classes("Basic -$10/月")
  assert_eq(supplied.classes.length(), 0)
  assert_eq(supplied.issues.length(), 1)
}

///|
test "self-supplied quotes accept English separators and numeric currency codes" {
  let report = plan_classes("Basic USD 10/month; Basic USD 96/year")
  assert_eq(report.issues, [])
  assert_eq(report.classes.length(), 1)
  assert_eq(report.classes[0].annual_saving, Some(20))
  let inr = plan_classes("Starter ₹100/月；Starter INR 960/年")
  assert_eq(inr.issues, [])
  assert_eq(inr.classes[0].annual_saving, Some(20))
}

///|
test "malformed observation cannot consume the valid observation of a session" {
  let tool = trajectory_tool("Midjourney")
  let first = history_event("无变化", "", "Basic $10/月")
  let later = { ..first, session: "later", date: "2026-11-21", }
  let invalid = { ..first, date: "invalid", }
  let report = class_stability({ ..tool, history: [later, invalid, first], })
  assert_false(report.complete)
  assert_true(report.observed_stable)
  assert_eq(report.sessions.map(s => s.class_count), [1, 1, 0])
}
