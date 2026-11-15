///|
/// 由 scripts/generate_tests.py 从 data/pricing.json 生成，不要手改。
/// 每个工具一条测试：状态、货币、可达性、计费周期归类。
/// 黑盒测试：只用公开 API（status_text 读状态，不构造枚举值）。

///|
test "generated: Qwen / 通义千问 status" {
  match @ai-pricing-verifier.tool_by_name("Qwen / 通义千问") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: DeepSeek status" {
  match @ai-pricing-verifier.tool_by_name("DeepSeek") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 豆包 status" {
  match @ai-pricing-verifier.tool_by_name("豆包") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Kimi / Moonshot AI status" {
  match @ai-pricing-verifier.tool_by_name("Kimi / Moonshot AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ChatGPT / OpenAI status" {
  match @ai-pricing-verifier.tool_by_name("ChatGPT / OpenAI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "JPY")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Claude / Anthropic status" {
  match @ai-pricing-verifier.tool_by_name("Claude / Anthropic") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Gemini / Google status" {
  match @ai-pricing-verifier.tool_by_name("Gemini / Google") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "JPY")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Grok / xAI status" {
  match @ai-pricing-verifier.tool_by_name("Grok / xAI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 文心一言 / 百度 status" {
  match @ai-pricing-verifier.tool_by_name("文心一言 / 百度") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 讯飞星火 status" {
  match @ai-pricing-verifier.tool_by_name("讯飞星火") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 智谱清言 / GLM status" {
  match @ai-pricing-verifier.tool_by_name("智谱清言 / GLM") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "CNY")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 腾讯元宝 / 混元 status" {
  match @ai-pricing-verifier.tool_by_name("腾讯元宝 / 混元") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Copilot / Microsoft status" {
  match @ai-pricing-verifier.tool_by_name("Copilot / Microsoft") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Perplexity status" {
  match @ai-pricing-verifier.tool_by_name("Perplexity") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Midjourney status" {
  match @ai-pricing-verifier.tool_by_name("Midjourney") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 夸克 AI status" {
  match @ai-pricing-verifier.tool_by_name("夸克 AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 纳米 AI / 360 status" {
  match @ai-pricing-verifier.tool_by_name("纳米 AI / 360") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 海螺 AI / MiniMax status" {
  match @ai-pricing-verifier.tool_by_name("海螺 AI / MiniMax") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "CNY")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 通义灵码 status" {
  match @ai-pricing-verifier.tool_by_name("通义灵码") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Cursor status" {
  match @ai-pricing-verifier.tool_by_name("Cursor") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-08")
    }
    None => assert_true(false)
  }
}
