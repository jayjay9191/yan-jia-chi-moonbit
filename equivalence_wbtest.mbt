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

///|
test "self supplied quotes reject conflicting currency clues" {
  for
    quote in [
      "EUR $10/月", "USD €10/月", "CNY JPY ¥10/月", "AUD C$10/月",
    ] {
    let result = normalize_price(quote)
    assert_eq(normalize_kind(result), "cannot_normalize")
    assert_true(normalize_reason(result).contains("币种标记冲突"))
  }
  for
    quote in [
      "USD $10/月", "EUR €10/月", "CAD C$10/月", "CNY ¥10/月", "JPY ¥10/月",
    ] {
    assert_eq(normalize_kind(normalize_price(quote)), "normalized")
  }
  let report = plan_classes("Basic USD €10/月；Basic USD $96/年")
  assert_eq(report.issues.length(), 1)
  assert_eq(report.classes[0].annual_saving, None)
}

///|
test "compact offers require a consistent paired example and follow its order" {
  let reversed = plan_classes(
    "Basic $8/月按年、$10/月按月；Standard $24/$30",
  )
  assert_eq(reversed.issues, [])
  assert_eq(reversed.classes[1].annual_saving, Some(20))
  for
    quote in [
      "Basic $10/月按月；Pro $8/月按年；Standard $30/$24", "Basic $10/月按月、$8/月按年；Pro $16/月按年、$20/月按月；Standard $30/$24",
    ] {
    let report = plan_classes(quote)
    assert_true(report.issues.any(issue => issue.contains("Standard $30/$24")))
    assert_false(report.classes.any(cls => cls.plan == "Standard"))
  }
}

///|
test "starting quotes remain pending instead of counting as firm offers" {
  for
    quote in [
      "Basic $10/月；Basic $96/年起", "Basic from $10/月；Basic $96/年", "Basic起价 $10/月；Basic $96/年",
      "Basic $10+/月；Basic $96/年",
    ] {
    let report = plan_classes(quote)
    assert_eq(report.classes.length(), 1)
    assert_eq(report.classes[0].plan, "Basic")
    assert_eq(report.classes[0].members.length(), 1)
    assert_eq(report.classes[0].annual_saving, None)
    assert_true(report.issues.any(issue => issue.contains("报价下限")))
  }
  assert_true(compare_budget("$10+/month", "$96/year", 1) is Err(_))
}

///|
test "negative sign before a currency code is not lost in normalization or class parsing" {
  for
    quote in ["-USD 10/month", "−EUR €10/月", "-C$10/month", "USD -10/月"] {
    assert_eq(normalize_kind(normalize_price(quote)), "cannot_normalize")
  }
  let report = plan_classes("Basic -USD $10/month；Basic $96/year")
  assert_eq(report.issues.length(), 1)
  assert_eq(report.classes[0].members.length(), 1)
  assert_eq(report.classes[0].annual_saving, None)
  assert_eq(normalize_kind(normalize_price("EUR €10/month")), "normalized")
}

///|
test "first-term prices are not used for a twelve-month comparison" {
  for
    quote in [
      "$10/月（首月优惠）", "首年 $96/年", "$10/month first month", "introductory $10/month",
    ] {
    match compare_budget(quote, "$96/year", 1) {
      Err(error) => assert_true(error.contains("首期"))
      Ok(_) => fail("first-term quote was accepted")
    }
  }
  let report = plan_classes("Basic 首月 $10/月；Basic $96/年")
  assert_eq(report.classes[0].members.length(), 1)
  assert_eq(report.classes[0].annual_saving, None)
  assert_true(report.issues.any(issue => issue.contains("首期")))
  assert_true(
    compare_budget("$10/月", "$96/年（年付优惠）", 1) is Ok(_),
  )
}

///|
test "historical plan audit compares each matching billing option across sessions" {
  let tool = trajectory_tool("Midjourney")
  let a = history_event(
    "无变化", "", "Basic $10/月；Basic $96/年；Pro $20/月；Team $30/月",
  )
  let b = {
    ..a,
    session: "second",
    new_price: "Basic $11/月；Basic $8/月按年；Pro €20/月；Plus $30/月",
  }
  let report = class_stability({
    ..tool,
    history: [b, { ..a, date: "2026-11-14", }],
  })
  let detail = report.sessions[1].detail
  assert_true(report.complete)
  assert_false(report.observed_stable)
  assert_true(detail.contains("Basic 月付：12000 → 13200 分/年"))
  assert_false(detail.contains("Basic 年付："))
  assert_true(detail.contains("Pro 月付：币种或席位口径变化"))
  assert_true(detail.contains("Team 月付：本次原文未见"))
  assert_true(detail.contains("Plus 月付：前次原文未见"))
}

///|
test "historical plan audit keeps an explicit gap between snapshots" {
  let a = history_event("无变化", "", "Basic $10/月")
  let gaps = { ..a, session: "gap", new_price: "", }
  let b = { ..a, session: "after-gap", new_price: "Basic $12/月", }
  let report = class_stability({
    ..trajectory_tool("Midjourney"),
    history: [a, gaps, b],
  })
  assert_false(report.complete)
  assert_false(report.sessions[2].detail.contains("14400"))
  assert_true(report.sessions[2].detail.contains("前次证据不可用"))
}

///|
test "historical plan audit ignores prices attached to unobserved and delisted entries" {
  let old = history_event("无变化", "", "Basic $10/月")
  for code in ["未看到价", "下架"] {
    let invalid = {
      ..old,
      session: "second",
      change: code,
      new_price: "Basic $99/月",
    }
    let result = class_stability({
      ..trajectory_tool("Midjourney"),
      history: [old, invalid],
    })
    assert_false(result.complete)
    assert_eq(result.sessions[1].class_count, 0)
    assert_true(result.sessions[1].detail.contains("有效报价"))
  }
}

///|
test "terminal separators are allowed but missing internal plan segments are reported" {
  let valid = "Basic $10/月；Basic $96/年"
  assert_eq(plan_classes(valid + "； ; ").issues, [])
  assert_eq(plan_classes(" ; ").classes.length(), 0)
  assert_true(!plan_classes(" ; ").issues.is_empty())
  assert_true(
    !plan_classes("Basic $10/月； ；Basic $96/年").issues.is_empty(),
  )
}

///|
test "plan group order follows first observation and preserves member order" {
  let report = plan_classes("Zeta $10/月；Alpha $5/月；Zeta $96/年")
  assert_eq(report.classes.map(cls => cls.plan), ["Zeta", "Alpha"])
  assert_eq(report.classes[0].members.map(offer => offer.quote), [
    "$10/月", "$96/年",
  ])
  assert_eq(report.classes[0].annual_saving, Some(20))
}

///|
test "historical plan audit flags unchanged labels when the original amounts disagree" {
  let old = history_event("无变化", "", "Basic $10/月")
  let new = { ..old, session: "second", new_price: "Basic $11/月", }
  let result = class_stability({
    ..trajectory_tool("Midjourney"),
    history: [old, new],
  })
  assert_true(result.sessions[1].detail.contains("台账标为无变化"))
  assert_true(result.sessions[1].detail.contains("12000 → 13200"))
}
