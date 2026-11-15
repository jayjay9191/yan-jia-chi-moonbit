///|
/// 由 scripts/generate_tests.py 从 data/pricing.json 生成，不要手改。
/// 每个工具一条测试：状态、货币、可达性、计费周期归类、记录键、核验会话。
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
      assert_eq(t.key, "APV-0001")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0002")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.key, "APV-0003")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.key, "APV-0004")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.key, "APV-0005")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0006")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.key, "APV-0007")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0008")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.key, "APV-0009")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.key, "APV-0010")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0011")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.key, "APV-0012")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0013")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.key, "APV-0014")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0015")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.key, "APV-0016")
      assert_eq(t.session, "20261108-LXM")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 纳米 AI / 360 status" {
  match @ai-pricing-verifier.tool_by_name("纳米 AI / 360") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "CNY")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0017")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.key, "APV-0018")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.key, "APV-0019")
      assert_eq(t.session, "20261108-LXM")
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
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0020")
      assert_eq(t.session, "20261108-LXM")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Notion AI status" {
  match @ai-pricing-verifier.tool_by_name("Notion AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0021")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Jasper status" {
  match @ai-pricing-verifier.tool_by_name("Jasper") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0022")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Copy.ai status" {
  match @ai-pricing-verifier.tool_by_name("Copy.ai") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0023")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Writesonic status" {
  match @ai-pricing-verifier.tool_by_name("Writesonic") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0024")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Grammarly status" {
  match @ai-pricing-verifier.tool_by_name("Grammarly") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0025")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: QuillBot status" {
  match @ai-pricing-verifier.tool_by_name("QuillBot") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0026")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Wordtune status" {
  match @ai-pricing-verifier.tool_by_name("Wordtune") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0027")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Sudowrite status" {
  match @ai-pricing-verifier.tool_by_name("Sudowrite") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0028")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Rytr status" {
  match @ai-pricing-verifier.tool_by_name("Rytr") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0029")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Anyword status" {
  match @ai-pricing-verifier.tool_by_name("Anyword") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0030")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Frase status" {
  match @ai-pricing-verifier.tool_by_name("Frase") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0031")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Scalenut status" {
  match @ai-pricing-verifier.tool_by_name("Scalenut") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0032")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: TextCortex status" {
  match @ai-pricing-verifier.tool_by_name("TextCortex") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0033")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: AI Cohesive status" {
  match @ai-pricing-verifier.tool_by_name("AI Cohesive") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0034")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: INK status" {
  match @ai-pricing-verifier.tool_by_name("INK") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0035")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Hypotenuse AI status" {
  match @ai-pricing-verifier.tool_by_name("Hypotenuse AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0036")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Writecream status" {
  match @ai-pricing-verifier.tool_by_name("Writecream") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0037")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Simplified status" {
  match @ai-pricing-verifier.tool_by_name("Simplified") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0038")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ContentBot status" {
  match @ai-pricing-verifier.tool_by_name("ContentBot") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0039")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: WordHero status" {
  match @ai-pricing-verifier.tool_by_name("WordHero") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0040")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Nichesss status" {
  match @ai-pricing-verifier.tool_by_name("Nichesss") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0041")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ClosersCopy status" {
  match @ai-pricing-verifier.tool_by_name("ClosersCopy") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0042")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Article Forge status" {
  match @ai-pricing-verifier.tool_by_name("Article Forge") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0043")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Kafkai status" {
  match @ai-pricing-verifier.tool_by_name("Kafkai") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "JPY")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0044")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: LongShot AI status" {
  match @ai-pricing-verifier.tool_by_name("LongShot AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0045")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Peppertype status" {
  match @ai-pricing-verifier.tool_by_name("Peppertype") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0046")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Narrato status" {
  match @ai-pricing-verifier.tool_by_name("Narrato") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0047")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Berq status" {
  match @ai-pricing-verifier.tool_by_name("Berq") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0048")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ZimmWriter status" {
  match @ai-pricing-verifier.tool_by_name("ZimmWriter") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0049")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: WordAI status" {
  match @ai-pricing-verifier.tool_by_name("WordAI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0050")
      assert_eq(t.session, "20261115-A")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Leonardo.Ai status" {
  match @ai-pricing-verifier.tool_by_name("Leonardo.Ai") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0051")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ideogram status" {
  match @ai-pricing-verifier.tool_by_name("Ideogram") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0052")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Stability AI status" {
  match @ai-pricing-verifier.tool_by_name("Stability AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0053")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Playground AI status" {
  match @ai-pricing-verifier.tool_by_name("Playground AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0054")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Krea AI status" {
  match @ai-pricing-verifier.tool_by_name("Krea AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0055")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Freepik AI status" {
  match @ai-pricing-verifier.tool_by_name("Freepik AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0056")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Adobe Firefly status" {
  match @ai-pricing-verifier.tool_by_name("Adobe Firefly") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0057")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Canva AI status" {
  match @ai-pricing-verifier.tool_by_name("Canva AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0058")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Recraft status" {
  match @ai-pricing-verifier.tool_by_name("Recraft") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0059")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Picsart AI status" {
  match @ai-pricing-verifier.tool_by_name("Picsart AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0060")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fotor AI status" {
  match @ai-pricing-verifier.tool_by_name("Fotor AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0061")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: NightCafe status" {
  match @ai-pricing-verifier.tool_by_name("NightCafe") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0062")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: StarryAI status" {
  match @ai-pricing-verifier.tool_by_name("StarryAI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0063")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: DreamStudio status" {
  match @ai-pricing-verifier.tool_by_name("DreamStudio") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0064")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: GetIMG status" {
  match @ai-pricing-verifier.tool_by_name("GetIMG") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0065")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Clipdrop status" {
  match @ai-pricing-verifier.tool_by_name("Clipdrop") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0066")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Remove.bg status" {
  match @ai-pricing-verifier.tool_by_name("Remove.bg") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0067")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Photoroom status" {
  match @ai-pricing-verifier.tool_by_name("Photoroom") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0068")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Topaz AI status" {
  match @ai-pricing-verifier.tool_by_name("Topaz AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0069")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Magnific AI status" {
  match @ai-pricing-verifier.tool_by_name("Magnific AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0070")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Designs.ai status" {
  match @ai-pricing-verifier.tool_by_name("Designs.ai") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0071")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Looka status" {
  match @ai-pricing-verifier.tool_by_name("Looka") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0072")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: LogoAI status" {
  match @ai-pricing-verifier.tool_by_name("LogoAI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0073")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Uizard status" {
  match @ai-pricing-verifier.tool_by_name("Uizard") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0074")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Galileo AI status" {
  match @ai-pricing-verifier.tool_by_name("Galileo AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0075")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Framer AI status" {
  match @ai-pricing-verifier.tool_by_name("Framer AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0076")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Durable status" {
  match @ai-pricing-verifier.tool_by_name("Durable") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0077")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 10Web status" {
  match @ai-pricing-verifier.tool_by_name("10Web") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0078")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Artbreeder status" {
  match @ai-pricing-verifier.tool_by_name("Artbreeder") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0079")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: DeepAI status" {
  match @ai-pricing-verifier.tool_by_name("DeepAI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0080")
      assert_eq(t.session, "20261115-B")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Runway status" {
  match @ai-pricing-verifier.tool_by_name("Runway") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0081")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Pika status" {
  match @ai-pricing-verifier.tool_by_name("Pika") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0082")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Luma AI status" {
  match @ai-pricing-verifier.tool_by_name("Luma AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0083")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Kling AI status" {
  match @ai-pricing-verifier.tool_by_name("Kling AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0084")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Suno status" {
  match @ai-pricing-verifier.tool_by_name("Suno") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0085")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Udio status" {
  match @ai-pricing-verifier.tool_by_name("Udio") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0086")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ElevenLabs status" {
  match @ai-pricing-verifier.tool_by_name("ElevenLabs") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0087")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Descript status" {
  match @ai-pricing-verifier.tool_by_name("Descript") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0088")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: HeyGen status" {
  match @ai-pricing-verifier.tool_by_name("HeyGen") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0089")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Synthesia status" {
  match @ai-pricing-verifier.tool_by_name("Synthesia") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0090")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Pictory status" {
  match @ai-pricing-verifier.tool_by_name("Pictory") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0091")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: InVideo status" {
  match @ai-pricing-verifier.tool_by_name("InVideo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0092")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fliki status" {
  match @ai-pricing-verifier.tool_by_name("Fliki") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0093")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Murf AI status" {
  match @ai-pricing-verifier.tool_by_name("Murf AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0094")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Resemble AI status" {
  match @ai-pricing-verifier.tool_by_name("Resemble AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0095")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Play.ht status" {
  match @ai-pricing-verifier.tool_by_name("Play.ht") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0096")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lovo AI status" {
  match @ai-pricing-verifier.tool_by_name("Lovo AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0097")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: WellSaid Labs status" {
  match @ai-pricing-verifier.tool_by_name("WellSaid Labs") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0098")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Speechify status" {
  match @ai-pricing-verifier.tool_by_name("Speechify") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0099")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Otter.ai status" {
  match @ai-pricing-verifier.tool_by_name("Otter.ai") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0100")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fireflies.ai status" {
  match @ai-pricing-verifier.tool_by_name("Fireflies.ai") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0101")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Rev status" {
  match @ai-pricing-verifier.tool_by_name("Rev") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0102")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Krisp status" {
  match @ai-pricing-verifier.tool_by_name("Krisp") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0103")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Riverside status" {
  match @ai-pricing-verifier.tool_by_name("Riverside") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0104")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: CapCut status" {
  match @ai-pricing-verifier.tool_by_name("CapCut") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0105")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: OpusClip status" {
  match @ai-pricing-verifier.tool_by_name("OpusClip") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0106")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Vizard status" {
  match @ai-pricing-verifier.tool_by_name("Vizard") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0107")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Wisecut status" {
  match @ai-pricing-verifier.tool_by_name("Wisecut") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0108")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Kapwing status" {
  match @ai-pricing-verifier.tool_by_name("Kapwing") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0109")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: VEED status" {
  match @ai-pricing-verifier.tool_by_name("VEED") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0110")
      assert_eq(t.session, "20261115-C")
    }
    None => assert_true(false)
  }
}

///|
test "generated: GitHub Copilot status" {
  match @ai-pricing-verifier.tool_by_name("GitHub Copilot") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0111")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Tabnine status" {
  match @ai-pricing-verifier.tool_by_name("Tabnine") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0112")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Windsurf status" {
  match @ai-pricing-verifier.tool_by_name("Windsurf") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0113")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Amazon Q Developer status" {
  match @ai-pricing-verifier.tool_by_name("Amazon Q Developer") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0114")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Sourcegraph Cody status" {
  match @ai-pricing-verifier.tool_by_name("Sourcegraph Cody") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0115")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: JetBrains AI status" {
  match @ai-pricing-verifier.tool_by_name("JetBrains AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0116")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Replit Agent status" {
  match @ai-pricing-verifier.tool_by_name("Replit Agent") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0117")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: v0 status" {
  match @ai-pricing-verifier.tool_by_name("v0") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0118")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Bolt.new status" {
  match @ai-pricing-verifier.tool_by_name("Bolt.new") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0119")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lovable status" {
  match @ai-pricing-verifier.tool_by_name("Lovable") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0120")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Augment Code status" {
  match @ai-pricing-verifier.tool_by_name("Augment Code") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0121")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Qodo status" {
  match @ai-pricing-verifier.tool_by_name("Qodo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0122")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Pieces status" {
  match @ai-pricing-verifier.tool_by_name("Pieces") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0123")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Cline status" {
  match @ai-pricing-verifier.tool_by_name("Cline") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0124")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Roo Code status" {
  match @ai-pricing-verifier.tool_by_name("Roo Code") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0125")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Trae status" {
  match @ai-pricing-verifier.tool_by_name("Trae") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0126")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: MarsCode status" {
  match @ai-pricing-verifier.tool_by_name("MarsCode") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0127")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: CodeGeeX status" {
  match @ai-pricing-verifier.tool_by_name("CodeGeeX") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0128")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fitten Code status" {
  match @ai-pricing-verifier.tool_by_name("Fitten Code") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0129")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Comate / 文心快码 status" {
  match @ai-pricing-verifier.tool_by_name("Comate / 文心快码") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "CNY")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0130")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Devin status" {
  match @ai-pricing-verifier.tool_by_name("Devin") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0131")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Sweep status" {
  match @ai-pricing-verifier.tool_by_name("Sweep") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0132")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mintlify status" {
  match @ai-pricing-verifier.tool_by_name("Mintlify") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0133")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Figma AI status" {
  match @ai-pricing-verifier.tool_by_name("Figma AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0134")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Miro AI status" {
  match @ai-pricing-verifier.tool_by_name("Miro AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0135")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Linear status" {
  match @ai-pricing-verifier.tool_by_name("Linear") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0136")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Airtable AI status" {
  match @ai-pricing-verifier.tool_by_name("Airtable AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0137")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ClickUp AI status" {
  match @ai-pricing-verifier.tool_by_name("ClickUp AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0138")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Asana AI status" {
  match @ai-pricing-verifier.tool_by_name("Asana AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0139")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Monday AI status" {
  match @ai-pricing-verifier.tool_by_name("Monday AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0140")
      assert_eq(t.session, "20261115-D")
    }
    None => assert_true(false)
  }
}

///|
test "generated: OpenAI API status" {
  match @ai-pricing-verifier.tool_by_name("OpenAI API") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0141")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Claude API status" {
  match @ai-pricing-verifier.tool_by_name("Claude API") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0142")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Gemini API status" {
  match @ai-pricing-verifier.tool_by_name("Gemini API") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0143")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mistral AI status" {
  match @ai-pricing-verifier.tool_by_name("Mistral AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0144")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Cohere status" {
  match @ai-pricing-verifier.tool_by_name("Cohere") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0145")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: AI21 Labs status" {
  match @ai-pricing-verifier.tool_by_name("AI21 Labs") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0146")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Together AI status" {
  match @ai-pricing-verifier.tool_by_name("Together AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0147")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Groq status" {
  match @ai-pricing-verifier.tool_by_name("Groq") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0148")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fireworks AI status" {
  match @ai-pricing-verifier.tool_by_name("Fireworks AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0149")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: OpenRouter status" {
  match @ai-pricing-verifier.tool_by_name("OpenRouter") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0150")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Replicate status" {
  match @ai-pricing-verifier.tool_by_name("Replicate") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0151")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: DeepInfra status" {
  match @ai-pricing-verifier.tool_by_name("DeepInfra") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0152")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Hugging Face Inference status" {
  match @ai-pricing-verifier.tool_by_name("Hugging Face Inference") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0153")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Voyage AI status" {
  match @ai-pricing-verifier.tool_by_name("Voyage AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0154")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Jina AI status" {
  match @ai-pricing-verifier.tool_by_name("Jina AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0155")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Pinecone status" {
  match @ai-pricing-verifier.tool_by_name("Pinecone") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0156")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Weaviate status" {
  match @ai-pricing-verifier.tool_by_name("Weaviate") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0157")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Qdrant status" {
  match @ai-pricing-verifier.tool_by_name("Qdrant") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0158")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Zilliz status" {
  match @ai-pricing-verifier.tool_by_name("Zilliz") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0159")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Modal status" {
  match @ai-pricing-verifier.tool_by_name("Modal") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0160")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Baseten status" {
  match @ai-pricing-verifier.tool_by_name("Baseten") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0161")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Anyscale status" {
  match @ai-pricing-verifier.tool_by_name("Anyscale") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "AC")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0162")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: RunPod status" {
  match @ai-pricing-verifier.tool_by_name("RunPod") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0163")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Novita AI status" {
  match @ai-pricing-verifier.tool_by_name("Novita AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0164")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: SiliconFlow / 硅基流动 status" {
  match @ai-pricing-verifier.tool_by_name("SiliconFlow / 硅基流动") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0165")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: FriendliAI status" {
  match @ai-pricing-verifier.tool_by_name("FriendliAI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0166")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Azure OpenAI status" {
  match @ai-pricing-verifier.tool_by_name("Azure OpenAI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0167")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: AWS Bedrock status" {
  match @ai-pricing-verifier.tool_by_name("AWS Bedrock") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0168")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Snowflake Cortex status" {
  match @ai-pricing-verifier.tool_by_name("Snowflake Cortex") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0169")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Databricks status" {
  match @ai-pricing-verifier.tool_by_name("Databricks") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0170")
      assert_eq(t.session, "20261115-E")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Slack AI status" {
  match @ai-pricing-verifier.tool_by_name("Slack AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0171")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Zoom AI Companion status" {
  match @ai-pricing-verifier.tool_by_name("Zoom AI Companion") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0172")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fellow status" {
  match @ai-pricing-verifier.tool_by_name("Fellow") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0173")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Read AI status" {
  match @ai-pricing-verifier.tool_by_name("Read AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0174")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Motion status" {
  match @ai-pricing-verifier.tool_by_name("Motion") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0175")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Reclaim AI status" {
  match @ai-pricing-verifier.tool_by_name("Reclaim AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0176")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mem status" {
  match @ai-pricing-verifier.tool_by_name("Mem") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0177")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Tana status" {
  match @ai-pricing-verifier.tool_by_name("Tana") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0178")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Heptabase status" {
  match @ai-pricing-verifier.tool_by_name("Heptabase") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0179")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Craft status" {
  match @ai-pricing-verifier.tool_by_name("Craft") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0180")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Todoist AI status" {
  match @ai-pricing-verifier.tool_by_name("Todoist AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0181")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Sunsama status" {
  match @ai-pricing-verifier.tool_by_name("Sunsama") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0182")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Dropbox Dash status" {
  match @ai-pricing-verifier.tool_by_name("Dropbox Dash") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0183")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Box AI status" {
  match @ai-pricing-verifier.tool_by_name("Box AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0184")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: HubSpot AI status" {
  match @ai-pricing-verifier.tool_by_name("HubSpot AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0185")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Salesforce Einstein status" {
  match @ai-pricing-verifier.tool_by_name("Salesforce Einstein") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0186")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Zendesk AI status" {
  match @ai-pricing-verifier.tool_by_name("Zendesk AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0187")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Intercom Fin status" {
  match @ai-pricing-verifier.tool_by_name("Intercom Fin") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0188")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Gong status" {
  match @ai-pricing-verifier.tool_by_name("Gong") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0189")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: You.com status" {
  match @ai-pricing-verifier.tool_by_name("You.com") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0190")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Genspark status" {
  match @ai-pricing-verifier.tool_by_name("Genspark") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0191")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Felo status" {
  match @ai-pricing-verifier.tool_by_name("Felo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0192")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Metaso / 秘塔 AI 搜索 status" {
  match @ai-pricing-verifier.tool_by_name("Metaso / 秘塔 AI 搜索") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0193")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 天工 AI status" {
  match @ai-pricing-verifier.tool_by_name("天工 AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0194")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 商汤商量 / SenseChat status" {
  match @ai-pricing-verifier.tool_by_name("商汤商量 / SenseChat") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0195")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 百川智能 / 百小应 status" {
  match @ai-pricing-verifier.tool_by_name("百川智能 / 百小应") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0196")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 零一万物 / 万知 status" {
  match @ai-pricing-verifier.tool_by_name("零一万物 / 万知") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0197")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 阶跃星辰 / 跃问 status" {
  match @ai-pricing-verifier.tool_by_name("阶跃星辰 / 跃问") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0198")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 面壁智能 / 面壁露卡 Luca status" {
  match @ai-pricing-verifier.tool_by_name("面壁智能 / 面壁露卡 Luca") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0199")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 火山引擎 status" {
  match @ai-pricing-verifier.tool_by_name("火山引擎") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "CNY")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0200")
      assert_eq(t.session, "20261115-F")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Julius AI status" {
  match @ai-pricing-verifier.tool_by_name("Julius AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0201")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Polymer status" {
  match @ai-pricing-verifier.tool_by_name("Polymer") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0202")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Akkio status" {
  match @ai-pricing-verifier.tool_by_name("Akkio") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0203")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Obviously AI status" {
  match @ai-pricing-verifier.tool_by_name("Obviously AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0204")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Tableau status" {
  match @ai-pricing-verifier.tool_by_name("Tableau") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0205")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Power BI status" {
  match @ai-pricing-verifier.tool_by_name("Power BI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0206")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Looker status" {
  match @ai-pricing-verifier.tool_by_name("Looker") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0207")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mixpanel status" {
  match @ai-pricing-verifier.tool_by_name("Mixpanel") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0208")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Amplitude status" {
  match @ai-pricing-verifier.tool_by_name("Amplitude") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0209")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: MonkeyLearn status" {
  match @ai-pricing-verifier.tool_by_name("MonkeyLearn") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0210")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: DataRobot status" {
  match @ai-pricing-verifier.tool_by_name("DataRobot") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0211")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: H2O.ai status" {
  match @ai-pricing-verifier.tool_by_name("H2O.ai") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0212")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ThoughtSpot status" {
  match @ai-pricing-verifier.tool_by_name("ThoughtSpot") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0213")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Sisense status" {
  match @ai-pricing-verifier.tool_by_name("Sisense") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0214")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Domo status" {
  match @ai-pricing-verifier.tool_by_name("Domo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0215")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Qlik Sense status" {
  match @ai-pricing-verifier.tool_by_name("Qlik Sense") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0216")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Zoho Analytics status" {
  match @ai-pricing-verifier.tool_by_name("Zoho Analytics") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0217")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Metabase status" {
  match @ai-pricing-verifier.tool_by_name("Metabase") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0218")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Hex status" {
  match @ai-pricing-verifier.tool_by_name("Hex") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0219")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mode status" {
  match @ai-pricing-verifier.tool_by_name("Mode") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0220")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: GoodData status" {
  match @ai-pricing-verifier.tool_by_name("GoodData") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0221")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Luzmo status" {
  match @ai-pricing-verifier.tool_by_name("Luzmo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0222")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Rows status" {
  match @ai-pricing-verifier.tool_by_name("Rows") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0223")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Equals status" {
  match @ai-pricing-verifier.tool_by_name("Equals") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0224")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Causal status" {
  match @ai-pricing-verifier.tool_by_name("Causal") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0225")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: PostHog status" {
  match @ai-pricing-verifier.tool_by_name("PostHog") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0226")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Heap status" {
  match @ai-pricing-verifier.tool_by_name("Heap") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0227")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Pendo status" {
  match @ai-pricing-verifier.tool_by_name("Pendo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0228")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Hotjar status" {
  match @ai-pricing-verifier.tool_by_name("Hotjar") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0229")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ChartMogul status" {
  match @ai-pricing-verifier.tool_by_name("ChartMogul") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0230")
      assert_eq(t.session, "20261115-I")
    }
    None => assert_true(false)
  }
}

///|
test "generated: QuickBooks status" {
  match @ai-pricing-verifier.tool_by_name("QuickBooks") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0231")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Xero status" {
  match @ai-pricing-verifier.tool_by_name("Xero") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0232")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: FreshBooks status" {
  match @ai-pricing-verifier.tool_by_name("FreshBooks") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0233")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Wave status" {
  match @ai-pricing-verifier.tool_by_name("Wave") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0234")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ramp status" {
  match @ai-pricing-verifier.tool_by_name("Ramp") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0235")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Brex status" {
  match @ai-pricing-verifier.tool_by_name("Brex") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0236")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mercury status" {
  match @ai-pricing-verifier.tool_by_name("Mercury") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0237")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Bench status" {
  match @ai-pricing-verifier.tool_by_name("Bench") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0238")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Puzzle status" {
  match @ai-pricing-verifier.tool_by_name("Puzzle") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0239")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Digits status" {
  match @ai-pricing-verifier.tool_by_name("Digits") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0240")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Vic.ai status" {
  match @ai-pricing-verifier.tool_by_name("Vic.ai") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0241")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: FloQast status" {
  match @ai-pricing-verifier.tool_by_name("FloQast") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0242")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: BlackLine status" {
  match @ai-pricing-verifier.tool_by_name("BlackLine") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0243")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: TrendSpider status" {
  match @ai-pricing-verifier.tool_by_name("TrendSpider") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0244")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Composer status" {
  match @ai-pricing-verifier.tool_by_name("Composer") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0245")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Kavout status" {
  match @ai-pricing-verifier.tool_by_name("Kavout") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0246")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Zest AI status" {
  match @ai-pricing-verifier.tool_by_name("Zest AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0247")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Upstart status" {
  match @ai-pricing-verifier.tool_by_name("Upstart") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0248")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Klarna status" {
  match @ai-pricing-verifier.tool_by_name("Klarna") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0249")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Wise status" {
  match @ai-pricing-verifier.tool_by_name("Wise") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0250")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: BILL status" {
  match @ai-pricing-verifier.tool_by_name("BILL") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0251")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Melio status" {
  match @ai-pricing-verifier.tool_by_name("Melio") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0252")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Tipalti status" {
  match @ai-pricing-verifier.tool_by_name("Tipalti") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0253")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Airbase status" {
  match @ai-pricing-verifier.tool_by_name("Airbase") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0254")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Spendesk status" {
  match @ai-pricing-verifier.tool_by_name("Spendesk") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0255")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Pleo status" {
  match @ai-pricing-verifier.tool_by_name("Pleo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "EUR")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0256")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Expensify status" {
  match @ai-pricing-verifier.tool_by_name("Expensify") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0257")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Navan status" {
  match @ai-pricing-verifier.tool_by_name("Navan") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0258")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Deel status" {
  match @ai-pricing-verifier.tool_by_name("Deel") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0259")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Pilot status" {
  match @ai-pricing-verifier.tool_by_name("Pilot") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0260")
      assert_eq(t.session, "20261115-L")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Semrush status" {
  match @ai-pricing-verifier.tool_by_name("Semrush") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0261")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ahrefs status" {
  match @ai-pricing-verifier.tool_by_name("Ahrefs") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0262")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Moz status" {
  match @ai-pricing-verifier.tool_by_name("Moz") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0263")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Surfer SEO status" {
  match @ai-pricing-verifier.tool_by_name("Surfer SEO") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0264")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mailchimp status" {
  match @ai-pricing-verifier.tool_by_name("Mailchimp") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0265")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Klaviyo status" {
  match @ai-pricing-verifier.tool_by_name("Klaviyo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0266")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ActiveCampaign status" {
  match @ai-pricing-verifier.tool_by_name("ActiveCampaign") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0267")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Hootsuite status" {
  match @ai-pricing-verifier.tool_by_name("Hootsuite") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0268")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Buffer status" {
  match @ai-pricing-verifier.tool_by_name("Buffer") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0269")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Sprout Social status" {
  match @ai-pricing-verifier.tool_by_name("Sprout Social") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0270")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: AdCreative.ai status" {
  match @ai-pricing-verifier.tool_by_name("AdCreative.ai") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0271")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Madgicx status" {
  match @ai-pricing-verifier.tool_by_name("Madgicx") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0272")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Later status" {
  match @ai-pricing-verifier.tool_by_name("Later") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0273")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Constant Contact status" {
  match @ai-pricing-verifier.tool_by_name("Constant Contact") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0274")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Similarweb status" {
  match @ai-pricing-verifier.tool_by_name("Similarweb") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0275")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: SE Ranking status" {
  match @ai-pricing-verifier.tool_by_name("SE Ranking") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0276")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mangools status" {
  match @ai-pricing-verifier.tool_by_name("Mangools") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0277")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Screaming Frog status" {
  match @ai-pricing-verifier.tool_by_name("Screaming Frog") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "GBP")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0278")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Yoast SEO status" {
  match @ai-pricing-verifier.tool_by_name("Yoast SEO") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0279")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Clearscope status" {
  match @ai-pricing-verifier.tool_by_name("Clearscope") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0280")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Brevo status" {
  match @ai-pricing-verifier.tool_by_name("Brevo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0281")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Kit status" {
  match @ai-pricing-verifier.tool_by_name("Kit") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0282")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: GetResponse status" {
  match @ai-pricing-verifier.tool_by_name("GetResponse") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0283")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: AWeber status" {
  match @ai-pricing-verifier.tool_by_name("AWeber") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0284")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Omnisend status" {
  match @ai-pricing-verifier.tool_by_name("Omnisend") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0285")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Drip status" {
  match @ai-pricing-verifier.tool_by_name("Drip") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0286")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: SocialPilot status" {
  match @ai-pricing-verifier.tool_by_name("SocialPilot") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0287")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Agorapulse status" {
  match @ai-pricing-verifier.tool_by_name("Agorapulse") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0288")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: BuzzSumo status" {
  match @ai-pricing-verifier.tool_by_name("BuzzSumo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0289")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: SpyFu status" {
  match @ai-pricing-verifier.tool_by_name("SpyFu") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0290")
      assert_eq(t.session, "20261115-H")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Freshchat status" {
  match @ai-pricing-verifier.tool_by_name("Freshchat") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0291")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Crisp status" {
  match @ai-pricing-verifier.tool_by_name("Crisp") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0292")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Help Scout status" {
  match @ai-pricing-verifier.tool_by_name("Help Scout") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0293")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ChatBot status" {
  match @ai-pricing-verifier.tool_by_name("ChatBot") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0294")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: LiveChat status" {
  match @ai-pricing-verifier.tool_by_name("LiveChat") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0295")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Olark status" {
  match @ai-pricing-verifier.tool_by_name("Olark") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0296")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: HappyFox status" {
  match @ai-pricing-verifier.tool_by_name("HappyFox") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0297")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: LiveAgent status" {
  match @ai-pricing-verifier.tool_by_name("LiveAgent") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0298")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Front status" {
  match @ai-pricing-verifier.tool_by_name("Front") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0299")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Botpress status" {
  match @ai-pricing-verifier.tool_by_name("Botpress") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0300")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Chaport status" {
  match @ai-pricing-verifier.tool_by_name("Chaport") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0301")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Tawk.to status" {
  match @ai-pricing-verifier.tool_by_name("Tawk.to") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0302")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Smartsupp status" {
  match @ai-pricing-verifier.tool_by_name("Smartsupp") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0303")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Kayako status" {
  match @ai-pricing-verifier.tool_by_name("Kayako") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0304")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Landbot status" {
  match @ai-pricing-verifier.tool_by_name("Landbot") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0305")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Tidio status" {
  match @ai-pricing-verifier.tool_by_name("Tidio") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0306")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Gorgias status" {
  match @ai-pricing-verifier.tool_by_name("Gorgias") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0307")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ManyChat status" {
  match @ai-pricing-verifier.tool_by_name("ManyChat") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0308")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Chatwoot status" {
  match @ai-pricing-verifier.tool_by_name("Chatwoot") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0309")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Drift status" {
  match @ai-pricing-verifier.tool_by_name("Drift") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0310")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ada status" {
  match @ai-pricing-verifier.tool_by_name("Ada") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0311")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Kustomer status" {
  match @ai-pricing-verifier.tool_by_name("Kustomer") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0312")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Zoho Desk status" {
  match @ai-pricing-verifier.tool_by_name("Zoho Desk") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "INR")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0313")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Dixa status" {
  match @ai-pricing-verifier.tool_by_name("Dixa") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "EUR")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0314")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Gladly status" {
  match @ai-pricing-verifier.tool_by_name("Gladly") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0315")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Trengo status" {
  match @ai-pricing-verifier.tool_by_name("Trengo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "EUR")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0316")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Userlike status" {
  match @ai-pricing-verifier.tool_by_name("Userlike") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "EUR")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0317")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: HelpCrunch status" {
  match @ai-pricing-verifier.tool_by_name("HelpCrunch") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0318")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: JivoChat status" {
  match @ai-pricing-verifier.tool_by_name("JivoChat") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0319")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: LivePerson status" {
  match @ai-pricing-verifier.tool_by_name("LivePerson") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0320")
      assert_eq(t.session, "20261115-G")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Wysa status" {
  match @ai-pricing-verifier.tool_by_name("Wysa") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0321")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Woebot status" {
  match @ai-pricing-verifier.tool_by_name("Woebot") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0322")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Headspace status" {
  match @ai-pricing-verifier.tool_by_name("Headspace") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0323")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Calm status" {
  match @ai-pricing-verifier.tool_by_name("Calm") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0324")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ada Health status" {
  match @ai-pricing-verifier.tool_by_name("Ada Health") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0325")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: OpenEvidence status" {
  match @ai-pricing-verifier.tool_by_name("OpenEvidence") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0326")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Glass Health status" {
  match @ai-pricing-verifier.tool_by_name("Glass Health") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0327")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lumen status" {
  match @ai-pricing-verifier.tool_by_name("Lumen") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0328")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Levels status" {
  match @ai-pricing-verifier.tool_by_name("Levels") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0329")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Zoe status" {
  match @ai-pricing-verifier.tool_by_name("Zoe") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "GBP")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0330")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Hippocratic AI status" {
  match @ai-pricing-verifier.tool_by_name("Hippocratic AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0331")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ambience Healthcare status" {
  match @ai-pricing-verifier.tool_by_name("Ambience Healthcare") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0332")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Abridge status" {
  match @ai-pricing-verifier.tool_by_name("Abridge") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0333")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Regard status" {
  match @ai-pricing-verifier.tool_by_name("Regard") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0334")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lindus Health status" {
  match @ai-pricing-verifier.tool_by_name("Lindus Health") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0335")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: BetterHelp status" {
  match @ai-pricing-verifier.tool_by_name("BetterHelp") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0336")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Talkspace status" {
  match @ai-pricing-verifier.tool_by_name("Talkspace") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0337")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Cerebral status" {
  match @ai-pricing-verifier.tool_by_name("Cerebral") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0338")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Hims status" {
  match @ai-pricing-verifier.tool_by_name("Hims") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0339")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ro status" {
  match @ai-pricing-verifier.tool_by_name("Ro") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0340")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Noom status" {
  match @ai-pricing-verifier.tool_by_name("Noom") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0341")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: MyFitnessPal status" {
  match @ai-pricing-verifier.tool_by_name("MyFitnessPal") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0342")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Cronometer status" {
  match @ai-pricing-verifier.tool_by_name("Cronometer") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0343")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Oura status" {
  match @ai-pricing-verifier.tool_by_name("Oura") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0344")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: WHOOP status" {
  match @ai-pricing-verifier.tool_by_name("WHOOP") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0345")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Eight Sleep status" {
  match @ai-pricing-verifier.tool_by_name("Eight Sleep") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0346")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Function Health status" {
  match @ai-pricing-verifier.tool_by_name("Function Health") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0347")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Superpower status" {
  match @ai-pricing-verifier.tool_by_name("Superpower") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0348")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Nabla status" {
  match @ai-pricing-verifier.tool_by_name("Nabla") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0349")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Suki AI status" {
  match @ai-pricing-verifier.tool_by_name("Suki AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0350")
      assert_eq(t.session, "20261115-K")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Greenhouse status" {
  match @ai-pricing-verifier.tool_by_name("Greenhouse") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0351")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lever status" {
  match @ai-pricing-verifier.tool_by_name("Lever") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0352")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: HireVue status" {
  match @ai-pricing-verifier.tool_by_name("HireVue") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0353")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Paradox status" {
  match @ai-pricing-verifier.tool_by_name("Paradox") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0354")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Eightfold AI status" {
  match @ai-pricing-verifier.tool_by_name("Eightfold AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0355")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Beamery status" {
  match @ai-pricing-verifier.tool_by_name("Beamery") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0356")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Phenom status" {
  match @ai-pricing-verifier.tool_by_name("Phenom") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0357")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Gem status" {
  match @ai-pricing-verifier.tool_by_name("Gem") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0358")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Workable status" {
  match @ai-pricing-verifier.tool_by_name("Workable") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0359")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Breezy HR status" {
  match @ai-pricing-verifier.tool_by_name("Breezy HR") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0360")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Manatal status" {
  match @ai-pricing-verifier.tool_by_name("Manatal") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0361")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Remote status" {
  match @ai-pricing-verifier.tool_by_name("Remote") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0362")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Oyster HR status" {
  match @ai-pricing-verifier.tool_by_name("Oyster HR") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0363")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Gusto status" {
  match @ai-pricing-verifier.tool_by_name("Gusto") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0364")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: BambooHR status" {
  match @ai-pricing-verifier.tool_by_name("BambooHR") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0365")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lattice status" {
  match @ai-pricing-verifier.tool_by_name("Lattice") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0366")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Culture Amp status" {
  match @ai-pricing-verifier.tool_by_name("Culture Amp") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0367")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 15Five status" {
  match @ai-pricing-verifier.tool_by_name("15Five") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0368")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ashby status" {
  match @ai-pricing-verifier.tool_by_name("Ashby") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0369")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: SmartRecruiters status" {
  match @ai-pricing-verifier.tool_by_name("SmartRecruiters") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0370")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: JazzHR status" {
  match @ai-pricing-verifier.tool_by_name("JazzHR") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0371")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Zoho Recruit status" {
  match @ai-pricing-verifier.tool_by_name("Zoho Recruit") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0372")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Recruitee status" {
  match @ai-pricing-verifier.tool_by_name("Recruitee") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0373")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Teamtailor status" {
  match @ai-pricing-verifier.tool_by_name("Teamtailor") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0374")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Rippling status" {
  match @ai-pricing-verifier.tool_by_name("Rippling") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0375")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: HiBob status" {
  match @ai-pricing-verifier.tool_by_name("HiBob") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0376")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Personio status" {
  match @ai-pricing-verifier.tool_by_name("Personio") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0377")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Justworks status" {
  match @ai-pricing-verifier.tool_by_name("Justworks") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0378")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fountain status" {
  match @ai-pricing-verifier.tool_by_name("Fountain") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0379")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: TestGorilla status" {
  match @ai-pricing-verifier.tool_by_name("TestGorilla") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0380")
      assert_eq(t.session, "20261115-M")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Duolingo Max status" {
  match @ai-pricing-verifier.tool_by_name("Duolingo Max") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0381")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Khanmigo status" {
  match @ai-pricing-verifier.tool_by_name("Khanmigo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0382")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Quizlet status" {
  match @ai-pricing-verifier.tool_by_name("Quizlet") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0383")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Photomath status" {
  match @ai-pricing-verifier.tool_by_name("Photomath") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0384")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Chegg status" {
  match @ai-pricing-verifier.tool_by_name("Chegg") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0385")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Socratic status" {
  match @ai-pricing-verifier.tool_by_name("Socratic") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0386")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Udemy status" {
  match @ai-pricing-verifier.tool_by_name("Udemy") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0387")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Coursiv status" {
  match @ai-pricing-verifier.tool_by_name("Coursiv") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0388")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Speak status" {
  match @ai-pricing-verifier.tool_by_name("Speak") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0389")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Elsa Speak status" {
  match @ai-pricing-verifier.tool_by_name("Elsa Speak") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0390")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Memrise status" {
  match @ai-pricing-verifier.tool_by_name("Memrise") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0391")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Babbel status" {
  match @ai-pricing-verifier.tool_by_name("Babbel") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0392")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Busuu status" {
  match @ai-pricing-verifier.tool_by_name("Busuu") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0393")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lingoda status" {
  match @ai-pricing-verifier.tool_by_name("Lingoda") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0394")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Preply status" {
  match @ai-pricing-verifier.tool_by_name("Preply") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0395")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: iTalki status" {
  match @ai-pricing-verifier.tool_by_name("iTalki") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0396")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Coursera Plus status" {
  match @ai-pricing-verifier.tool_by_name("Coursera Plus") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0397")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Brilliant status" {
  match @ai-pricing-verifier.tool_by_name("Brilliant") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0398")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: DataCamp status" {
  match @ai-pricing-verifier.tool_by_name("DataCamp") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0399")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Codecademy status" {
  match @ai-pricing-verifier.tool_by_name("Codecademy") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0400")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: MasterClass status" {
  match @ai-pricing-verifier.tool_by_name("MasterClass") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0401")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Skillshare status" {
  match @ai-pricing-verifier.tool_by_name("Skillshare") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0402")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Rosetta Stone status" {
  match @ai-pricing-verifier.tool_by_name("Rosetta Stone") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0403")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Pimsleur status" {
  match @ai-pricing-verifier.tool_by_name("Pimsleur") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0404")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: LingQ status" {
  match @ai-pricing-verifier.tool_by_name("LingQ") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0405")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: HelloTalk status" {
  match @ai-pricing-verifier.tool_by_name("HelloTalk") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0406")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Cambly status" {
  match @ai-pricing-verifier.tool_by_name("Cambly") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0407")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mondly status" {
  match @ai-pricing-verifier.tool_by_name("Mondly") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "kr")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0408")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Brainly status" {
  match @ai-pricing-verifier.tool_by_name("Brainly") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0409")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Course Hero status" {
  match @ai-pricing-verifier.tool_by_name("Course Hero") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0410")
      assert_eq(t.session, "20261115-J")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Discord Nitro status" {
  match @ai-pricing-verifier.tool_by_name("Discord Nitro") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0411")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Xbox Game Pass status" {
  match @ai-pricing-verifier.tool_by_name("Xbox Game Pass") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0412")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: PlayStation Plus status" {
  match @ai-pricing-verifier.tool_by_name("PlayStation Plus") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0413")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Nintendo Switch Online status" {
  match @ai-pricing-verifier.tool_by_name("Nintendo Switch Online") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0414")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: GeForce NOW status" {
  match @ai-pricing-verifier.tool_by_name("GeForce NOW") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0415")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: EA Play status" {
  match @ai-pricing-verifier.tool_by_name("EA Play") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0416")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Roblox Premium status" {
  match @ai-pricing-verifier.tool_by_name("Roblox Premium") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0417")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Minecraft Realms status" {
  match @ai-pricing-verifier.tool_by_name("Minecraft Realms") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0418")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fortnite Crew status" {
  match @ai-pricing-verifier.tool_by_name("Fortnite Crew") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0419")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Twitch Turbo status" {
  match @ai-pricing-verifier.tool_by_name("Twitch Turbo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0420")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Unity status" {
  match @ai-pricing-verifier.tool_by_name("Unity") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0421")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Unreal Engine status" {
  match @ai-pricing-verifier.tool_by_name("Unreal Engine") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0422")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: GameMaker status" {
  match @ai-pricing-verifier.tool_by_name("GameMaker") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0423")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Construct 3 status" {
  match @ai-pricing-verifier.tool_by_name("Construct 3") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0424")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: GDevelop status" {
  match @ai-pricing-verifier.tool_by_name("GDevelop") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0425")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Apple Arcade status" {
  match @ai-pricing-verifier.tool_by_name("Apple Arcade") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0426")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Google Play Pass status" {
  match @ai-pricing-verifier.tool_by_name("Google Play Pass") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0427")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Amazon Luna status" {
  match @ai-pricing-verifier.tool_by_name("Amazon Luna") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0428")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Humble Choice status" {
  match @ai-pricing-verifier.tool_by_name("Humble Choice") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0429")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Nexus Mods status" {
  match @ai-pricing-verifier.tool_by_name("Nexus Mods") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0430")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: FACEIT status" {
  match @ai-pricing-verifier.tool_by_name("FACEIT") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0431")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mobalytics Plus status" {
  match @ai-pricing-verifier.tool_by_name("Mobalytics Plus") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0432")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Streamlabs Ultra status" {
  match @ai-pricing-verifier.tool_by_name("Streamlabs Ultra") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0433")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Restream status" {
  match @ai-pricing-verifier.tool_by_name("Restream") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0434")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Dota Plus status" {
  match @ai-pricing-verifier.tool_by_name("Dota Plus") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0435")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Boosteroid status" {
  match @ai-pricing-verifier.tool_by_name("Boosteroid") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0436")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Shadow status" {
  match @ai-pricing-verifier.tool_by_name("Shadow") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0437")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Antstream Arcade status" {
  match @ai-pricing-verifier.tool_by_name("Antstream Arcade") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0438")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Parsec status" {
  match @ai-pricing-verifier.tool_by_name("Parsec") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0439")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Blacknut status" {
  match @ai-pricing-verifier.tool_by_name("Blacknut") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0440")
      assert_eq(t.session, "20261115-N")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Uber One status" {
  match @ai-pricing-verifier.tool_by_name("Uber One") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0441")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lyft Pink status" {
  match @ai-pricing-verifier.tool_by_name("Lyft Pink") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0442")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: TripIt Pro status" {
  match @ai-pricing-verifier.tool_by_name("TripIt Pro") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0443")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Priority Pass status" {
  match @ai-pricing-verifier.tool_by_name("Priority Pass") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0444")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: AllTrails+ status" {
  match @ai-pricing-verifier.tool_by_name("AllTrails+") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0445")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Gaia GPS status" {
  match @ai-pricing-verifier.tool_by_name("Gaia GPS") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0446")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Flightradar24 status" {
  match @ai-pricing-verifier.tool_by_name("Flightradar24") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0447")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Wanderlog Pro status" {
  match @ai-pricing-verifier.tool_by_name("Wanderlog Pro") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0448")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: TrustedHousesitters status" {
  match @ai-pricing-verifier.tool_by_name("TrustedHousesitters") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0449")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: eDreams Prime status" {
  match @ai-pricing-verifier.tool_by_name("eDreams Prime") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0450")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Worldpackers status" {
  match @ai-pricing-verifier.tool_by_name("Worldpackers") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0451")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Roadtrippers status" {
  match @ai-pricing-verifier.tool_by_name("Roadtrippers") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0452")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Harvest Hosts status" {
  match @ai-pricing-verifier.tool_by_name("Harvest Hosts") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0453")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: KOA Rewards status" {
  match @ai-pricing-verifier.tool_by_name("KOA Rewards") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0454")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Passport America status" {
  match @ai-pricing-verifier.tool_by_name("Passport America") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0455")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: The Dyrt PRO status" {
  match @ai-pricing-verifier.tool_by_name("The Dyrt PRO") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0456")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: CityPASS status" {
  match @ai-pricing-verifier.tool_by_name("CityPASS") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0457")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Go City status" {
  match @ai-pricing-verifier.tool_by_name("Go City") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0458")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Timeshifter status" {
  match @ai-pricing-verifier.tool_by_name("Timeshifter") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0459")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Flighty status" {
  match @ai-pricing-verifier.tool_by_name("Flighty") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0460")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Couchsurfing status" {
  match @ai-pricing-verifier.tool_by_name("Couchsurfing") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0461")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Japan Rail Pass status" {
  match @ai-pricing-verifier.tool_by_name("Japan Rail Pass") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "JPY")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0462")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Booking.com status" {
  match @ai-pricing-verifier.tool_by_name("Booking.com") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0463")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Airbnb status" {
  match @ai-pricing-verifier.tool_by_name("Airbnb") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0464")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Skyscanner status" {
  match @ai-pricing-verifier.tool_by_name("Skyscanner") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0465")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Kayak status" {
  match @ai-pricing-verifier.tool_by_name("Kayak") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0466")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Expedia status" {
  match @ai-pricing-verifier.tool_by_name("Expedia") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0467")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Trip.com status" {
  match @ai-pricing-verifier.tool_by_name("Trip.com") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0468")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Google Flights status" {
  match @ai-pricing-verifier.tool_by_name("Google Flights") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0469")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Viator status" {
  match @ai-pricing-verifier.tool_by_name("Viator") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0470")
      assert_eq(t.session, "20261115-O")
    }
    None => assert_true(false)
  }
}

///|
test "generated: BiggerPockets status" {
  match @ai-pricing-verifier.tool_by_name("BiggerPockets") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0471")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: PropStream status" {
  match @ai-pricing-verifier.tool_by_name("PropStream") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0472")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: DealMachine status" {
  match @ai-pricing-verifier.tool_by_name("DealMachine") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0473")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: BatchLeads status" {
  match @ai-pricing-verifier.tool_by_name("BatchLeads") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0474")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: REsimpli status" {
  match @ai-pricing-verifier.tool_by_name("REsimpli") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0475")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: DoorLoop status" {
  match @ai-pricing-verifier.tool_by_name("DoorLoop") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0476")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: AppFolio status" {
  match @ai-pricing-verifier.tool_by_name("AppFolio") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0477")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Buildium status" {
  match @ai-pricing-verifier.tool_by_name("Buildium") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0478")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: RentRedi status" {
  match @ai-pricing-verifier.tool_by_name("RentRedi") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0479")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: TurboTenant status" {
  match @ai-pricing-verifier.tool_by_name("TurboTenant") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0480")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Avail status" {
  match @ai-pricing-verifier.tool_by_name("Avail") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0481")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Hemlane status" {
  match @ai-pricing-verifier.tool_by_name("Hemlane") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0482")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: TenantCloud status" {
  match @ai-pricing-verifier.tool_by_name("TenantCloud") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0483")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Rentec Direct status" {
  match @ai-pricing-verifier.tool_by_name("Rentec Direct") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0484")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Propertyware status" {
  match @ai-pricing-verifier.tool_by_name("Propertyware") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0485")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Yardi Breeze status" {
  match @ai-pricing-verifier.tool_by_name("Yardi Breeze") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0486")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Entrata status" {
  match @ai-pricing-verifier.tool_by_name("Entrata") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0487")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: RealPage status" {
  match @ai-pricing-verifier.tool_by_name("RealPage") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0488")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: CoStar status" {
  match @ai-pricing-verifier.tool_by_name("CoStar") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0489")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Crexi status" {
  match @ai-pricing-verifier.tool_by_name("Crexi") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0490")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: LoopNet status" {
  match @ai-pricing-verifier.tool_by_name("LoopNet") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0491")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: HouseCanary status" {
  match @ai-pricing-verifier.tool_by_name("HouseCanary") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0492")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Matterport status" {
  match @ai-pricing-verifier.tool_by_name("Matterport") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0493")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Restb.ai status" {
  match @ai-pricing-verifier.tool_by_name("Restb.ai") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0494")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: BoxBrownie status" {
  match @ai-pricing-verifier.tool_by_name("BoxBrownie") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0495")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Virtual Staging AI status" {
  match @ai-pricing-verifier.tool_by_name("Virtual Staging AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0496")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Styldod status" {
  match @ai-pricing-verifier.tool_by_name("Styldod") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0497")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: CubiCasa status" {
  match @ai-pricing-verifier.tool_by_name("CubiCasa") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0498")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Zillow Premier Agent status" {
  match @ai-pricing-verifier.tool_by_name("Zillow Premier Agent") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0499")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 贝壳找房 status" {
  match @ai-pricing-verifier.tool_by_name("贝壳找房") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0500")
      assert_eq(t.session, "20261115-P")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Harvey AI status" {
  match @ai-pricing-verifier.tool_by_name("Harvey AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0501")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: CoCounsel status" {
  match @ai-pricing-verifier.tool_by_name("CoCounsel") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0502")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lexis+ AI status" {
  match @ai-pricing-verifier.tool_by_name("Lexis+ AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0503")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Westlaw Precision status" {
  match @ai-pricing-verifier.tool_by_name("Westlaw Precision") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0504")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Luminance status" {
  match @ai-pricing-verifier.tool_by_name("Luminance") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0505")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Litera Kira status" {
  match @ai-pricing-verifier.tool_by_name("Litera Kira") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0506")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Evisort status" {
  match @ai-pricing-verifier.tool_by_name("Evisort") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0507")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ironclad status" {
  match @ai-pricing-verifier.tool_by_name("Ironclad") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0508")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: LinkSquares status" {
  match @ai-pricing-verifier.tool_by_name("LinkSquares") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0509")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ContractPodAi status" {
  match @ai-pricing-verifier.tool_by_name("ContractPodAi") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0510")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Robin AI status" {
  match @ai-pricing-verifier.tool_by_name("Robin AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0511")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Juro status" {
  match @ai-pricing-verifier.tool_by_name("Juro") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0512")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: SpotDraft status" {
  match @ai-pricing-verifier.tool_by_name("SpotDraft") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0513")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: LawGeex status" {
  match @ai-pricing-verifier.tool_by_name("LawGeex") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0514")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Filevine status" {
  match @ai-pricing-verifier.tool_by_name("Filevine") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0515")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Clio status" {
  match @ai-pricing-verifier.tool_by_name("Clio") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0516")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: MyCase status" {
  match @ai-pricing-verifier.tool_by_name("MyCase") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0517")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: PracticePanther status" {
  match @ai-pricing-verifier.tool_by_name("PracticePanther") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0518")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Smokeball status" {
  match @ai-pricing-verifier.tool_by_name("Smokeball") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0519")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: LEAP Legal status" {
  match @ai-pricing-verifier.tool_by_name("LEAP Legal") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0520")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Relativity status" {
  match @ai-pricing-verifier.tool_by_name("Relativity") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0521")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Everlaw status" {
  match @ai-pricing-verifier.tool_by_name("Everlaw") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0522")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: DISCO status" {
  match @ai-pricing-verifier.tool_by_name("DISCO") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0523")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Spellbook status" {
  match @ai-pricing-verifier.tool_by_name("Spellbook") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0524")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Legora status" {
  match @ai-pricing-verifier.tool_by_name("Legora") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0525")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Paxton AI status" {
  match @ai-pricing-verifier.tool_by_name("Paxton AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0526")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: DoNotPay status" {
  match @ai-pricing-verifier.tool_by_name("DoNotPay") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0527")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: LegalZoom status" {
  match @ai-pricing-verifier.tool_by_name("LegalZoom") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0528")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Rocket Lawyer status" {
  match @ai-pricing-verifier.tool_by_name("Rocket Lawyer") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0529")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Trust & Will status" {
  match @ai-pricing-verifier.tool_by_name("Trust & Will") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0530")
      assert_eq(t.session, "20261115-Q")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Toast status" {
  match @ai-pricing-verifier.tool_by_name("Toast") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0531")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Square for Restaurants status" {
  match @ai-pricing-verifier.tool_by_name("Square for Restaurants") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0532")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lightspeed Restaurant status" {
  match @ai-pricing-verifier.tool_by_name("Lightspeed Restaurant") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0533")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: TouchBistro status" {
  match @ai-pricing-verifier.tool_by_name("TouchBistro") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0534")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Clover status" {
  match @ai-pricing-verifier.tool_by_name("Clover") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0535")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Revel Systems status" {
  match @ai-pricing-verifier.tool_by_name("Revel Systems") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0536")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 7shifts status" {
  match @ai-pricing-verifier.tool_by_name("7shifts") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0537")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Restaurant365 status" {
  match @ai-pricing-verifier.tool_by_name("Restaurant365") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0538")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: MarginEdge status" {
  match @ai-pricing-verifier.tool_by_name("MarginEdge") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0539")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: MarketMan status" {
  match @ai-pricing-verifier.tool_by_name("MarketMan") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0540")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: xtraCHEF status" {
  match @ai-pricing-verifier.tool_by_name("xtraCHEF") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0541")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: BevSpot status" {
  match @ai-pricing-verifier.tool_by_name("BevSpot") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0542")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Crunchtime status" {
  match @ai-pricing-verifier.tool_by_name("Crunchtime") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0543")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ChowNow status" {
  match @ai-pricing-verifier.tool_by_name("ChowNow") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0544")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: GloriaFood status" {
  match @ai-pricing-verifier.tool_by_name("GloriaFood") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0545")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Flipdish status" {
  match @ai-pricing-verifier.tool_by_name("Flipdish") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0546")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Deliverect status" {
  match @ai-pricing-verifier.tool_by_name("Deliverect") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0547")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Popmenu status" {
  match @ai-pricing-verifier.tool_by_name("Popmenu") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0548")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: BentoBox status" {
  match @ai-pricing-verifier.tool_by_name("BentoBox") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0549")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Otter status" {
  match @ai-pricing-verifier.tool_by_name("Otter") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0550")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: OpenTable status" {
  match @ai-pricing-verifier.tool_by_name("OpenTable") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0551")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Resy status" {
  match @ai-pricing-verifier.tool_by_name("Resy") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0552")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Tock status" {
  match @ai-pricing-verifier.tool_by_name("Tock") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0553")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: SevenRooms status" {
  match @ai-pricing-verifier.tool_by_name("SevenRooms") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0554")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Foodics status" {
  match @ai-pricing-verifier.tool_by_name("Foodics") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "SAR")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0555")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Petpooja status" {
  match @ai-pricing-verifier.tool_by_name("Petpooja") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0556")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: HungerRush status" {
  match @ai-pricing-verifier.tool_by_name("HungerRush") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0557")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: SpotOn status" {
  match @ai-pricing-verifier.tool_by_name("SpotOn") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0558")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: GoTab status" {
  match @ai-pricing-verifier.tool_by_name("GoTab") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0559")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Brink POS status" {
  match @ai-pricing-verifier.tool_by_name("Brink POS") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0560")
      assert_eq(t.session, "20261115-R")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Shopify status" {
  match @ai-pricing-verifier.tool_by_name("Shopify") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0561")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: BigCommerce status" {
  match @ai-pricing-verifier.tool_by_name("BigCommerce") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0562")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: WooCommerce status" {
  match @ai-pricing-verifier.tool_by_name("WooCommerce") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0563")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Wix status" {
  match @ai-pricing-verifier.tool_by_name("Wix") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0564")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Squarespace status" {
  match @ai-pricing-verifier.tool_by_name("Squarespace") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0565")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Shopware status" {
  match @ai-pricing-verifier.tool_by_name("Shopware") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "EUR")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0566")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: PrestaShop status" {
  match @ai-pricing-verifier.tool_by_name("PrestaShop") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "EUR")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0567")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Adobe Commerce status" {
  match @ai-pricing-verifier.tool_by_name("Adobe Commerce") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0568")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ecwid status" {
  match @ai-pricing-verifier.tool_by_name("Ecwid") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0569")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Big Cartel status" {
  match @ai-pricing-verifier.tool_by_name("Big Cartel") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0570")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Sellfy status" {
  match @ai-pricing-verifier.tool_by_name("Sellfy") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0571")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Gumroad status" {
  match @ai-pricing-verifier.tool_by_name("Gumroad") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0572")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Etsy status" {
  match @ai-pricing-verifier.tool_by_name("Etsy") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0573")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Amazon Seller Central status" {
  match @ai-pricing-verifier.tool_by_name("Amazon Seller Central") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0574")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Shift4Shop status" {
  match @ai-pricing-verifier.tool_by_name("Shift4Shop") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0575")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Volusion status" {
  match @ai-pricing-verifier.tool_by_name("Volusion") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0576")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: X-Cart status" {
  match @ai-pricing-verifier.tool_by_name("X-Cart") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0577")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Medusa status" {
  match @ai-pricing-verifier.tool_by_name("Medusa") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0578")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Saleor status" {
  match @ai-pricing-verifier.tool_by_name("Saleor") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0579")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Swell status" {
  match @ai-pricing-verifier.tool_by_name("Swell") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0580")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: VTEX status" {
  match @ai-pricing-verifier.tool_by_name("VTEX") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0581")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: commercetools status" {
  match @ai-pricing-verifier.tool_by_name("commercetools") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0582")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Snipcart status" {
  match @ai-pricing-verifier.tool_by_name("Snipcart") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0583")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lemon Squeezy status" {
  match @ai-pricing-verifier.tool_by_name("Lemon Squeezy") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0584")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Cin7 status" {
  match @ai-pricing-verifier.tool_by_name("Cin7") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0585")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: inFlow Inventory status" {
  match @ai-pricing-verifier.tool_by_name("inFlow Inventory") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0586")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ShipStation status" {
  match @ai-pricing-verifier.tool_by_name("ShipStation") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0587")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Shippo status" {
  match @ai-pricing-verifier.tool_by_name("Shippo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0588")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Easyship status" {
  match @ai-pricing-verifier.tool_by_name("Easyship") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0589")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Printful status" {
  match @ai-pricing-verifier.tool_by_name("Printful") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0590")
      assert_eq(t.session, "20261115-S")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Alvys status" {
  match @ai-pricing-verifier.tool_by_name("Alvys") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0591")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: EasyPost status" {
  match @ai-pricing-verifier.tool_by_name("EasyPost") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0592")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ShipEngine status" {
  match @ai-pricing-verifier.tool_by_name("ShipEngine") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0593")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: AfterShip status" {
  match @ai-pricing-verifier.tool_by_name("AfterShip") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0594")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Track-POD status" {
  match @ai-pricing-verifier.tool_by_name("Track-POD") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0595")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Detrack status" {
  match @ai-pricing-verifier.tool_by_name("Detrack") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0596")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Upper Route Planner status" {
  match @ai-pricing-verifier.tool_by_name("Upper Route Planner") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0597")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: RoadWarrior status" {
  match @ai-pricing-verifier.tool_by_name("RoadWarrior") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0598")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Flexport status" {
  match @ai-pricing-verifier.tool_by_name("Flexport") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0599")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Freightos status" {
  match @ai-pricing-verifier.tool_by_name("Freightos") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0600")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: FourKites status" {
  match @ai-pricing-verifier.tool_by_name("FourKites") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0601")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: project44 status" {
  match @ai-pricing-verifier.tool_by_name("project44") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0602")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ShipBob status" {
  match @ai-pricing-verifier.tool_by_name("ShipBob") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0603")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Uber Freight status" {
  match @ai-pricing-verifier.tool_by_name("Uber Freight") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0604")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Transfix status" {
  match @ai-pricing-verifier.tool_by_name("Transfix") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0605")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Flock Freight status" {
  match @ai-pricing-verifier.tool_by_name("Flock Freight") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0606")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Loadsmart status" {
  match @ai-pricing-verifier.tool_by_name("Loadsmart") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0607")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Descartes Systems status" {
  match @ai-pricing-verifier.tool_by_name("Descartes Systems") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "EUR")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0608")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Manhattan Associates status" {
  match @ai-pricing-verifier.tool_by_name("Manhattan Associates") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0609")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Blue Yonder status" {
  match @ai-pricing-verifier.tool_by_name("Blue Yonder") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0610")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Kinaxis status" {
  match @ai-pricing-verifier.tool_by_name("Kinaxis") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0611")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: o9 Solutions status" {
  match @ai-pricing-verifier.tool_by_name("o9 Solutions") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0612")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ToolsGroup status" {
  match @ai-pricing-verifier.tool_by_name("ToolsGroup") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0613")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: RELEX Solutions status" {
  match @ai-pricing-verifier.tool_by_name("RELEX Solutions") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0614")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: E2open status" {
  match @ai-pricing-verifier.tool_by_name("E2open") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0615")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: SPS Commerce status" {
  match @ai-pricing-verifier.tool_by_name("SPS Commerce") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0616")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Bringg status" {
  match @ai-pricing-verifier.tool_by_name("Bringg") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0617")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: FarEye status" {
  match @ai-pricing-verifier.tool_by_name("FarEye") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0618")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Veho status" {
  match @ai-pricing-verifier.tool_by_name("Veho") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0619")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Overhaul status" {
  match @ai-pricing-verifier.tool_by_name("Overhaul") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0620")
      assert_eq(t.session, "20261115-T")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Tulip Interfaces status" {
  match @ai-pricing-verifier.tool_by_name("Tulip Interfaces") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0621")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: MaintainX status" {
  match @ai-pricing-verifier.tool_by_name("MaintainX") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0622")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: UpKeep status" {
  match @ai-pricing-verifier.tool_by_name("UpKeep") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0623")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fiix status" {
  match @ai-pricing-verifier.tool_by_name("Fiix") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0624")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: MRPeasy status" {
  match @ai-pricing-verifier.tool_by_name("MRPeasy") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0625")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Formlabs status" {
  match @ai-pricing-verifier.tool_by_name("Formlabs") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0626")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Protolabs status" {
  match @ai-pricing-verifier.tool_by_name("Protolabs") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0627")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Limble CMMS status" {
  match @ai-pricing-verifier.tool_by_name("Limble CMMS") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0628")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: C3 AI status" {
  match @ai-pricing-verifier.tool_by_name("C3 AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0629")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Plex Systems status" {
  match @ai-pricing-verifier.tool_by_name("Plex Systems") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0630")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Augury status" {
  match @ai-pricing-verifier.tool_by_name("Augury") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0631")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Instrumental status" {
  match @ai-pricing-verifier.tool_by_name("Instrumental") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0632")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Bright Machines status" {
  match @ai-pricing-verifier.tool_by_name("Bright Machines") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0633")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fictiv status" {
  match @ai-pricing-verifier.tool_by_name("Fictiv") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0634")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Xometry status" {
  match @ai-pricing-verifier.tool_by_name("Xometry") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0635")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: MachineMetrics status" {
  match @ai-pricing-verifier.tool_by_name("MachineMetrics") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0636")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Sight Machine status" {
  match @ai-pricing-verifier.tool_by_name("Sight Machine") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0637")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Braincube status" {
  match @ai-pricing-verifier.tool_by_name("Braincube") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0638")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Seeq status" {
  match @ai-pricing-verifier.tool_by_name("Seeq") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0639")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Cognite status" {
  match @ai-pricing-verifier.tool_by_name("Cognite") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0640")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: AspenTech status" {
  match @ai-pricing-verifier.tool_by_name("AspenTech") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0641")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: PTC ThingWorx status" {
  match @ai-pricing-verifier.tool_by_name("PTC ThingWorx") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0642")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Honeywell Forge status" {
  match @ai-pricing-verifier.tool_by_name("Honeywell Forge") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0643")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fracttal status" {
  match @ai-pricing-verifier.tool_by_name("Fracttal") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0644")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Tractian status" {
  match @ai-pricing-verifier.tool_by_name("Tractian") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0645")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Uptake status" {
  match @ai-pricing-verifier.tool_by_name("Uptake") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0646")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Vention status" {
  match @ai-pricing-verifier.tool_by_name("Vention") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0647")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Markforged status" {
  match @ai-pricing-verifier.tool_by_name("Markforged") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0648")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Stratasys status" {
  match @ai-pricing-verifier.tool_by_name("Stratasys") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0649")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Oden Technologies status" {
  match @ai-pricing-verifier.tool_by_name("Oden Technologies") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0650")
      assert_eq(t.session, "20261115-U")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Solargraf status" {
  match @ai-pricing-verifier.tool_by_name("Solargraf") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0651")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: EVgo status" {
  match @ai-pricing-verifier.tool_by_name("EVgo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0652")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Electrify America status" {
  match @ai-pricing-verifier.tool_by_name("Electrify America") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0653")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Monta status" {
  match @ai-pricing-verifier.tool_by_name("Monta") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0654")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: OpenSolar status" {
  match @ai-pricing-verifier.tool_by_name("OpenSolar") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0655")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Energy Toolbase status" {
  match @ai-pricing-verifier.tool_by_name("Energy Toolbase") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0656")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Sweep / sweep.net status" {
  match @ai-pricing-verifier.tool_by_name("Sweep / sweep.net") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0657")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: CarbonChain status" {
  match @ai-pricing-verifier.tool_by_name("CarbonChain") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0658")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ChargePoint status" {
  match @ai-pricing-verifier.tool_by_name("ChargePoint") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0659")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Wallbox status" {
  match @ai-pricing-verifier.tool_by_name("Wallbox") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0660")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Aurora Solar status" {
  match @ai-pricing-verifier.tool_by_name("Aurora Solar") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0661")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: HelioScope status" {
  match @ai-pricing-verifier.tool_by_name("HelioScope") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0662")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Electricity Maps status" {
  match @ai-pricing-verifier.tool_by_name("Electricity Maps") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "EUR")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0663")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: WattTime status" {
  match @ai-pricing-verifier.tool_by_name("WattTime") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0664")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Tomorrow.io status" {
  match @ai-pricing-verifier.tool_by_name("Tomorrow.io") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0665")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Watershed status" {
  match @ai-pricing-verifier.tool_by_name("Watershed") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0666")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Persefoni status" {
  match @ai-pricing-verifier.tool_by_name("Persefoni") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0667")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Greenly status" {
  match @ai-pricing-verifier.tool_by_name("Greenly") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0668")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Normative status" {
  match @ai-pricing-verifier.tool_by_name("Normative") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0669")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Emitwise status" {
  match @ai-pricing-verifier.tool_by_name("Emitwise") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "GBP")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0670")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Cloverly status" {
  match @ai-pricing-verifier.tool_by_name("Cloverly") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0671")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Patch status" {
  match @ai-pricing-verifier.tool_by_name("Patch") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0672")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: BrainBox AI status" {
  match @ai-pricing-verifier.tool_by_name("BrainBox AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0673")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ento status" {
  match @ai-pricing-verifier.tool_by_name("Ento") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0674")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Facilio status" {
  match @ai-pricing-verifier.tool_by_name("Facilio") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0675")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Sense status" {
  match @ai-pricing-verifier.tool_by_name("Sense") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0676")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Arcadia status" {
  match @ai-pricing-verifier.tool_by_name("Arcadia") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0677")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: OhmConnect status" {
  match @ai-pricing-verifier.tool_by_name("OhmConnect") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0678")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Greyparrot status" {
  match @ai-pricing-verifier.tool_by_name("Greyparrot") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0679")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: AMP Robotics status" {
  match @ai-pricing-verifier.tool_by_name("AMP Robotics") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0680")
      assert_eq(t.session, "20261115-V")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mapbox status" {
  match @ai-pricing-verifier.tool_by_name("Mapbox") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0681")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: TomTom status" {
  match @ai-pricing-verifier.tool_by_name("TomTom") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0682")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: HERE Technologies status" {
  match @ai-pricing-verifier.tool_by_name("HERE Technologies") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0683")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Samsara status" {
  match @ai-pricing-verifier.tool_by_name("Samsara") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0684")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Geotab status" {
  match @ai-pricing-verifier.tool_by_name("Geotab") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0685")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fleetio status" {
  match @ai-pricing-verifier.tool_by_name("Fleetio") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0686")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Motive status" {
  match @ai-pricing-verifier.tool_by_name("Motive") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0687")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Verizon Connect status" {
  match @ai-pricing-verifier.tool_by_name("Verizon Connect") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0688")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lytx status" {
  match @ai-pricing-verifier.tool_by_name("Lytx") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0689")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Nauto status" {
  match @ai-pricing-verifier.tool_by_name("Nauto") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0690")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Route4Me status" {
  match @ai-pricing-verifier.tool_by_name("Route4Me") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0691")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Circuit status" {
  match @ai-pricing-verifier.tool_by_name("Circuit") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0692")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: OptimoRoute status" {
  match @ai-pricing-verifier.tool_by_name("OptimoRoute") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0693")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Routific status" {
  match @ai-pricing-verifier.tool_by_name("Routific") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0694")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Onfleet status" {
  match @ai-pricing-verifier.tool_by_name("Onfleet") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0695")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Turo status" {
  match @ai-pricing-verifier.tool_by_name("Turo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0696")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Zipcar status" {
  match @ai-pricing-verifier.tool_by_name("Zipcar") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0697")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lime status" {
  match @ai-pricing-verifier.tool_by_name("Lime") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0698")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Bird status" {
  match @ai-pricing-verifier.tool_by_name("Bird") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0699")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Uber status" {
  match @ai-pricing-verifier.tool_by_name("Uber") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0700")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lyft status" {
  match @ai-pricing-verifier.tool_by_name("Lyft") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0701")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Waymo status" {
  match @ai-pricing-verifier.tool_by_name("Waymo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0702")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: BlaBlaCar status" {
  match @ai-pricing-verifier.tool_by_name("BlaBlaCar") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "EUR")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0703")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: FlixBus status" {
  match @ai-pricing-verifier.tool_by_name("FlixBus") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0704")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Citymapper status" {
  match @ai-pricing-verifier.tool_by_name("Citymapper") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "GBP")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0705")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Transit App status" {
  match @ai-pricing-verifier.tool_by_name("Transit App") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0706")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Moovit status" {
  match @ai-pricing-verifier.tool_by_name("Moovit") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0707")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Tesla status" {
  match @ai-pricing-verifier.tool_by_name("Tesla") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0708")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Rivian status" {
  match @ai-pricing-verifier.tool_by_name("Rivian") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "CAD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0709")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lucid Motors status" {
  match @ai-pricing-verifier.tool_by_name("Lucid Motors") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0710")
      assert_eq(t.session, "20261115-W")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Bloomberg status" {
  match @ai-pricing-verifier.tool_by_name("Bloomberg") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0711")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Financial Times status" {
  match @ai-pricing-verifier.tool_by_name("Financial Times") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0712")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: The Economist status" {
  match @ai-pricing-verifier.tool_by_name("The Economist") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0713")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: The Wall Street Journal status" {
  match @ai-pricing-verifier.tool_by_name("The Wall Street Journal") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0714")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: The Washington Post status" {
  match @ai-pricing-verifier.tool_by_name("The Washington Post") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0715")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: The New York Times status" {
  match @ai-pricing-verifier.tool_by_name("The New York Times") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0716")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: The Athletic status" {
  match @ai-pricing-verifier.tool_by_name("The Athletic") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0717")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Apple News+ status" {
  match @ai-pricing-verifier.tool_by_name("Apple News+") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0718")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Medium status" {
  match @ai-pricing-verifier.tool_by_name("Medium") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0719")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Substack status" {
  match @ai-pricing-verifier.tool_by_name("Substack") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0720")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: The Guardian status" {
  match @ai-pricing-verifier.tool_by_name("The Guardian") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "GBP")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0721")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Wired status" {
  match @ai-pricing-verifier.tool_by_name("Wired") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0722")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: The Atlantic status" {
  match @ai-pricing-verifier.tool_by_name("The Atlantic") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0723")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Rolling Stone status" {
  match @ai-pricing-verifier.tool_by_name("Rolling Stone") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0724")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: NewsAPI status" {
  match @ai-pricing-verifier.tool_by_name("NewsAPI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0725")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: GNews API status" {
  match @ai-pricing-verifier.tool_by_name("GNews API") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "EUR")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0726")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mediastack status" {
  match @ai-pricing-verifier.tool_by_name("Mediastack") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0727")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: DaVinci Resolve Studio status" {
  match @ai-pricing-verifier.tool_by_name("DaVinci Resolve Studio") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0728")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Final Cut Pro status" {
  match @ai-pricing-verifier.tool_by_name("Final Cut Pro") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0729")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: OBS Studio status" {
  match @ai-pricing-verifier.tool_by_name("OBS Studio") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0730")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Streamlabs status" {
  match @ai-pricing-verifier.tool_by_name("Streamlabs") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0731")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Epidemic Sound status" {
  match @ai-pricing-verifier.tool_by_name("Epidemic Sound") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0732")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Artlist status" {
  match @ai-pricing-verifier.tool_by_name("Artlist") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0733")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Pond5 status" {
  match @ai-pricing-verifier.tool_by_name("Pond5") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0734")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Getty Images status" {
  match @ai-pricing-verifier.tool_by_name("Getty Images") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0735")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Shutterstock status" {
  match @ai-pricing-verifier.tool_by_name("Shutterstock") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0736")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Unsplash status" {
  match @ai-pricing-verifier.tool_by_name("Unsplash") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0737")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Semafor status" {
  match @ai-pricing-verifier.tool_by_name("Semafor") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0738")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Puck status" {
  match @ai-pricing-verifier.tool_by_name("Puck") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0739")
      assert_eq(t.session, "20261115-X")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Eventbrite status" {
  match @ai-pricing-verifier.tool_by_name("Eventbrite") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0740")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Eventzilla status" {
  match @ai-pricing-verifier.tool_by_name("Eventzilla") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0741")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Humanitix status" {
  match @ai-pricing-verifier.tool_by_name("Humanitix") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0742")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Universe status" {
  match @ai-pricing-verifier.tool_by_name("Universe") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0743")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Peatix status" {
  match @ai-pricing-verifier.tool_by_name("Peatix") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "JPY")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0744")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: TicketSource status" {
  match @ai-pricing-verifier.tool_by_name("TicketSource") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0745")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Yapsody status" {
  match @ai-pricing-verifier.tool_by_name("Yapsody") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0746")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ThunderTix status" {
  match @ai-pricing-verifier.tool_by_name("ThunderTix") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0747")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Purplepass status" {
  match @ai-pricing-verifier.tool_by_name("Purplepass") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0748")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ticketleap status" {
  match @ai-pricing-verifier.tool_by_name("Ticketleap") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0749")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Brushfire status" {
  match @ai-pricing-verifier.tool_by_name("Brushfire") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0750")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Whova status" {
  match @ai-pricing-verifier.tool_by_name("Whova") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0751")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Airmeet status" {
  match @ai-pricing-verifier.tool_by_name("Airmeet") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0752")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Accelevents status" {
  match @ai-pricing-verifier.tool_by_name("Accelevents") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0753")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: EventMobi status" {
  match @ai-pricing-verifier.tool_by_name("EventMobi") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0754")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Swapcard status" {
  match @ai-pricing-verifier.tool_by_name("Swapcard") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0755")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: PheedLoop status" {
  match @ai-pricing-verifier.tool_by_name("PheedLoop") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0756")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Bizzabo status" {
  match @ai-pricing-verifier.tool_by_name("Bizzabo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0757")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: RingCentral Events status" {
  match @ai-pricing-verifier.tool_by_name("RingCentral Events") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0758")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Meetup status" {
  match @ai-pricing-verifier.tool_by_name("Meetup") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0759")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Cvent status" {
  match @ai-pricing-verifier.tool_by_name("Cvent") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0760")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ticket Tailor status" {
  match @ai-pricing-verifier.tool_by_name("Ticket Tailor") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "GBP")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0761")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Billetto status" {
  match @ai-pricing-verifier.tool_by_name("Billetto") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "EUR")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0762")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Splash status" {
  match @ai-pricing-verifier.tool_by_name("Splash") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0763")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ticketmaster status" {
  match @ai-pricing-verifier.tool_by_name("Ticketmaster") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0764")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: StubHub status" {
  match @ai-pricing-verifier.tool_by_name("StubHub") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0765")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: SeatGeek status" {
  match @ai-pricing-verifier.tool_by_name("SeatGeek") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0766")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: DICE status" {
  match @ai-pricing-verifier.tool_by_name("DICE") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "GBP")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0767")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fever status" {
  match @ai-pricing-verifier.tool_by_name("Fever") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0768")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Luma status" {
  match @ai-pricing-verifier.tool_by_name("Luma") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0769")
      assert_eq(t.session, "20261115-Z")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Rover status" {
  match @ai-pricing-verifier.tool_by_name("Rover") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0770")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Wag! status" {
  match @ai-pricing-verifier.tool_by_name("Wag!") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0771")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: PetBacker status" {
  match @ai-pricing-verifier.tool_by_name("PetBacker") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0772")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Pawshake status" {
  match @ai-pricing-verifier.tool_by_name("Pawshake") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0773")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mad Paws status" {
  match @ai-pricing-verifier.tool_by_name("Mad Paws") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "AUD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0774")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: PetDesk status" {
  match @ai-pricing-verifier.tool_by_name("PetDesk") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0775")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fuzzy status" {
  match @ai-pricing-verifier.tool_by_name("Fuzzy") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0776")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Dutch status" {
  match @ai-pricing-verifier.tool_by_name("Dutch") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0777")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Pawp status" {
  match @ai-pricing-verifier.tool_by_name("Pawp") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0778")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Pumpkin status" {
  match @ai-pricing-verifier.tool_by_name("Pumpkin") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0779")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lemonade Pet status" {
  match @ai-pricing-verifier.tool_by_name("Lemonade Pet") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0780")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Spot status" {
  match @ai-pricing-verifier.tool_by_name("Spot") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0781")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Figo status" {
  match @ai-pricing-verifier.tool_by_name("Figo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0782")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Trupanion status" {
  match @ai-pricing-verifier.tool_by_name("Trupanion") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0783")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Healthy Paws status" {
  match @ai-pricing-verifier.tool_by_name("Healthy Paws") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0784")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Embrace status" {
  match @ai-pricing-verifier.tool_by_name("Embrace") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0785")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ManyPets status" {
  match @ai-pricing-verifier.tool_by_name("ManyPets") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0786")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fetch status" {
  match @ai-pricing-verifier.tool_by_name("Fetch") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0787")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: MetLife Pet status" {
  match @ai-pricing-verifier.tool_by_name("MetLife Pet") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0788")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Petcube status" {
  match @ai-pricing-verifier.tool_by_name("Petcube") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0789")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Furbo status" {
  match @ai-pricing-verifier.tool_by_name("Furbo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0790")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Whistle status" {
  match @ai-pricing-verifier.tool_by_name("Whistle") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0791")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fi status" {
  match @ai-pricing-verifier.tool_by_name("Fi") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0792")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Tractive status" {
  match @ai-pricing-verifier.tool_by_name("Tractive") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0793")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Halo Collar status" {
  match @ai-pricing-verifier.tool_by_name("Halo Collar") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0794")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Vetster status" {
  match @ai-pricing-verifier.tool_by_name("Vetster") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0795")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Embark status" {
  match @ai-pricing-verifier.tool_by_name("Embark") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0796")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Wisdom Panel status" {
  match @ai-pricing-verifier.tool_by_name("Wisdom Panel") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0797")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: The Farmer's Dog status" {
  match @ai-pricing-verifier.tool_by_name("The Farmer's Dog") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0798")
      assert_eq(t.session, "20261115-AA")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Nanit status" {
  match @ai-pricing-verifier.tool_by_name("Nanit") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0799")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: CuboAi status" {
  match @ai-pricing-verifier.tool_by_name("CuboAi") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0800")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Huckleberry status" {
  match @ai-pricing-verifier.tool_by_name("Huckleberry") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0801")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lingokids status" {
  match @ai-pricing-verifier.tool_by_name("Lingokids") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0802")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ABCmouse status" {
  match @ai-pricing-verifier.tool_by_name("ABCmouse") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0803")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: HOMER status" {
  match @ai-pricing-verifier.tool_by_name("HOMER") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0804")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Reading Eggs status" {
  match @ai-pricing-verifier.tool_by_name("Reading Eggs") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0805")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Miku status" {
  match @ai-pricing-verifier.tool_by_name("Miku") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0806")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Glow status" {
  match @ai-pricing-verifier.tool_by_name("Glow") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0807")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Speech Blubs status" {
  match @ai-pricing-verifier.tool_by_name("Speech Blubs") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0808")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mightier status" {
  match @ai-pricing-verifier.tool_by_name("Mightier") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0809")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Starfall status" {
  match @ai-pricing-verifier.tool_by_name("Starfall") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0810")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Osmo status" {
  match @ai-pricing-verifier.tool_by_name("Osmo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0811")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Owlet status" {
  match @ai-pricing-verifier.tool_by_name("Owlet") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0812")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Kinedu status" {
  match @ai-pricing-verifier.tool_by_name("Kinedu") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0813")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Cradlewise status" {
  match @ai-pricing-verifier.tool_by_name("Cradlewise") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0814")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: SNOO status" {
  match @ai-pricing-verifier.tool_by_name("SNOO") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0815")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Flo status" {
  match @ai-pricing-verifier.tool_by_name("Flo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0816")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Hatch status" {
  match @ai-pricing-verifier.tool_by_name("Hatch") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0817")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Wonder Weeks status" {
  match @ai-pricing-verifier.tool_by_name("Wonder Weeks") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0818")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Clue status" {
  match @ai-pricing-verifier.tool_by_name("Clue") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0819")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ovia status" {
  match @ai-pricing-verifier.tool_by_name("Ovia") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0820")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Natural Cycles status" {
  match @ai-pricing-verifier.tool_by_name("Natural Cycles") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0821")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Otsimo status" {
  match @ai-pricing-verifier.tool_by_name("Otsimo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0822")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Joon status" {
  match @ai-pricing-verifier.tool_by_name("Joon") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0823")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Epic status" {
  match @ai-pricing-verifier.tool_by_name("Epic") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0824")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Nara Baby status" {
  match @ai-pricing-verifier.tool_by_name("Nara Baby") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0825")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Sprout Baby status" {
  match @ai-pricing-verifier.tool_by_name("Sprout Baby") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0826")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Baby Connect status" {
  match @ai-pricing-verifier.tool_by_name("Baby Connect") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0827")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Sago Mini World status" {
  match @ai-pricing-verifier.tool_by_name("Sago Mini World") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0828")
      assert_eq(t.session, "20261115-AB")
    }
    None => assert_true(false)
  }
}

///|
test "generated: X Premium status" {
  match @ai-pricing-verifier.tool_by_name("X Premium") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0829")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: LinkedIn Premium status" {
  match @ai-pricing-verifier.tool_by_name("LinkedIn Premium") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0830")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Reddit Premium status" {
  match @ai-pricing-verifier.tool_by_name("Reddit Premium") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0831")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Telegram Premium status" {
  match @ai-pricing-verifier.tool_by_name("Telegram Premium") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0832")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Snapchat+ status" {
  match @ai-pricing-verifier.tool_by_name("Snapchat+") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0833")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: YouTube Premium status" {
  match @ai-pricing-verifier.tool_by_name("YouTube Premium") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0834")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Meta Verified status" {
  match @ai-pricing-verifier.tool_by_name("Meta Verified") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0835")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Patreon status" {
  match @ai-pricing-verifier.tool_by_name("Patreon") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0836")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ko-fi status" {
  match @ai-pricing-verifier.tool_by_name("Ko-fi") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0837")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Buy Me a Coffee status" {
  match @ai-pricing-verifier.tool_by_name("Buy Me a Coffee") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0838")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Skool status" {
  match @ai-pricing-verifier.tool_by_name("Skool") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0839")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Circle status" {
  match @ai-pricing-verifier.tool_by_name("Circle") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0840")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mighty Networks status" {
  match @ai-pricing-verifier.tool_by_name("Mighty Networks") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0841")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Discourse status" {
  match @ai-pricing-verifier.tool_by_name("Discourse") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0842")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Tribe status" {
  match @ai-pricing-verifier.tool_by_name("Tribe") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0843")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Bettermode status" {
  match @ai-pricing-verifier.tool_by_name("Bettermode") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0844")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Hivebrite status" {
  match @ai-pricing-verifier.tool_by_name("Hivebrite") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0845")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Vanilla Forums status" {
  match @ai-pricing-verifier.tool_by_name("Vanilla Forums") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0846")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: BuddyBoss status" {
  match @ai-pricing-verifier.tool_by_name("BuddyBoss") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0847")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Whop status" {
  match @ai-pricing-verifier.tool_by_name("Whop") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0848")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Geneva status" {
  match @ai-pricing-verifier.tool_by_name("Geneva") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0849")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mastodon status" {
  match @ai-pricing-verifier.tool_by_name("Mastodon") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0850")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Bluesky status" {
  match @ai-pricing-verifier.tool_by_name("Bluesky") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0851")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Tumblr status" {
  match @ai-pricing-verifier.tool_by_name("Tumblr") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0852")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Pinterest status" {
  match @ai-pricing-verifier.tool_by_name("Pinterest") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0853")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Quora+ status" {
  match @ai-pricing-verifier.tool_by_name("Quora+") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0854")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Rumble Premium status" {
  match @ai-pricing-verifier.tool_by_name("Rumble Premium") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0855")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Locals status" {
  match @ai-pricing-verifier.tool_by_name("Locals") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0856")
      assert_eq(t.session, "20261115-Y")
    }
    None => assert_true(false)
  }
}

///|
test "generated: HoneyBook status" {
  match @ai-pricing-verifier.tool_by_name("HoneyBook") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0857")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Pixieset status" {
  match @ai-pricing-verifier.tool_by_name("Pixieset") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0858")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Imagen AI status" {
  match @ai-pricing-verifier.tool_by_name("Imagen AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0859")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Aftershoot status" {
  match @ai-pricing-verifier.tool_by_name("Aftershoot") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0860")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Evoto status" {
  match @ai-pricing-verifier.tool_by_name("Evoto") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0861")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Retouch4me status" {
  match @ai-pricing-verifier.tool_by_name("Retouch4me") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0862")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Luminar Neo status" {
  match @ai-pricing-verifier.tool_by_name("Luminar Neo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0863")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ON1 Photo RAW status" {
  match @ai-pricing-verifier.tool_by_name("ON1 Photo RAW") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0864")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Zenfolio status" {
  match @ai-pricing-verifier.tool_by_name("Zenfolio") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0865")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Format status" {
  match @ai-pricing-verifier.tool_by_name("Format") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0866")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Dubsado status" {
  match @ai-pricing-verifier.tool_by_name("Dubsado") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0867")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 17hats status" {
  match @ai-pricing-verifier.tool_by_name("17hats") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0868")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Iris Works status" {
  match @ai-pricing-verifier.tool_by_name("Iris Works") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0869")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Aisle Planner status" {
  match @ai-pricing-verifier.tool_by_name("Aisle Planner") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0870")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ShootDotEdit status" {
  match @ai-pricing-verifier.tool_by_name("ShootDotEdit") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0871")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Narrative status" {
  match @ai-pricing-verifier.tool_by_name("Narrative") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0872")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: FilterPixel status" {
  match @ai-pricing-verifier.tool_by_name("FilterPixel") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0873")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Neurapix status" {
  match @ai-pricing-verifier.tool_by_name("Neurapix") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0874")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Minted status" {
  match @ai-pricing-verifier.tool_by_name("Minted") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0875")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mixbook status" {
  match @ai-pricing-verifier.tool_by_name("Mixbook") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0876")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Sprout Studio status" {
  match @ai-pricing-verifier.tool_by_name("Sprout Studio") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0877")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ShootProof status" {
  match @ai-pricing-verifier.tool_by_name("ShootProof") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0878")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Pic-Time status" {
  match @ai-pricing-verifier.tool_by_name("Pic-Time") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0879")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: DxO PhotoLab status" {
  match @ai-pricing-verifier.tool_by_name("DxO PhotoLab") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0880")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Capture One status" {
  match @ai-pricing-verifier.tool_by_name("Capture One") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0881")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: SmugMug status" {
  match @ai-pricing-verifier.tool_by_name("SmugMug") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0882")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: PhotoShelter status" {
  match @ai-pricing-verifier.tool_by_name("PhotoShelter") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0883")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Táve (现 VSCO Workspace) status" {
  match @ai-pricing-verifier.tool_by_name("Táve (现 VSCO Workspace)") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0884")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Studio Ninja status" {
  match @ai-pricing-verifier.tool_by_name("Studio Ninja") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0885")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Zola status" {
  match @ai-pricing-verifier.tool_by_name("Zola") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0886")
      assert_eq(t.session, "20261115-AC")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Elicit status" {
  match @ai-pricing-verifier.tool_by_name("Elicit") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0887")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Consensus status" {
  match @ai-pricing-verifier.tool_by_name("Consensus") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0888")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Scite.ai status" {
  match @ai-pricing-verifier.tool_by_name("Scite.ai") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0889")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: SciSpace status" {
  match @ai-pricing-verifier.tool_by_name("SciSpace") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0890")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Paperpal status" {
  match @ai-pricing-verifier.tool_by_name("Paperpal") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0891")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Trinka AI status" {
  match @ai-pricing-verifier.tool_by_name("Trinka AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0892")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Jenni AI status" {
  match @ai-pricing-verifier.tool_by_name("Jenni AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0893")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Afforai / Logically status" {
  match @ai-pricing-verifier.tool_by_name("Afforai / Logically") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0894")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Humata AI status" {
  match @ai-pricing-verifier.tool_by_name("Humata AI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0895")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ChatPDF status" {
  match @ai-pricing-verifier.tool_by_name("ChatPDF") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0896")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: SciSummary status" {
  match @ai-pricing-verifier.tool_by_name("SciSummary") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0897")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Litmaps status" {
  match @ai-pricing-verifier.tool_by_name("Litmaps") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0898")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Zotero status" {
  match @ai-pricing-verifier.tool_by_name("Zotero") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0899")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: EndNote status" {
  match @ai-pricing-verifier.tool_by_name("EndNote") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0900")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Mendeley status" {
  match @ai-pricing-verifier.tool_by_name("Mendeley") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0901")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Overleaf status" {
  match @ai-pricing-verifier.tool_by_name("Overleaf") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0902")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Research Rabbit status" {
  match @ai-pricing-verifier.tool_by_name("Research Rabbit") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0903")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Connected Papers status" {
  match @ai-pricing-verifier.tool_by_name("Connected Papers") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0904")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Semantic Scholar status" {
  match @ai-pricing-verifier.tool_by_name("Semantic Scholar") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0905")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Academia.edu status" {
  match @ai-pricing-verifier.tool_by_name("Academia.edu") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0906")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: GPTZero status" {
  match @ai-pricing-verifier.tool_by_name("GPTZero") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0907")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Originality.ai status" {
  match @ai-pricing-verifier.tool_by_name("Originality.ai") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0908")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Copyleaks status" {
  match @ai-pricing-verifier.tool_by_name("Copyleaks") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0909")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Turnitin status" {
  match @ai-pricing-verifier.tool_by_name("Turnitin") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0910")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: iThenticate status" {
  match @ai-pricing-verifier.tool_by_name("iThenticate") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0911")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Rayyan status" {
  match @ai-pricing-verifier.tool_by_name("Rayyan") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0912")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Covidence status" {
  match @ai-pricing-verifier.tool_by_name("Covidence") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0913")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Writefull status" {
  match @ai-pricing-verifier.tool_by_name("Writefull") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0914")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Scholarcy status" {
  match @ai-pricing-verifier.tool_by_name("Scholarcy") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0915")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Undermind status" {
  match @ai-pricing-verifier.tool_by_name("Undermind") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0916")
      assert_eq(t.session, "20261115-AD")
    }
    None => assert_true(false)
  }
}

///|
test "generated: OpenGov status" {
  match @ai-pricing-verifier.tool_by_name("OpenGov") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0917")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Granicus status" {
  match @ai-pricing-verifier.tool_by_name("Granicus") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0918")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: CivicPlus status" {
  match @ai-pricing-verifier.tool_by_name("CivicPlus") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0919")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: SeeClickFix status" {
  match @ai-pricing-verifier.tool_by_name("SeeClickFix") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0920")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: GovPilot status" {
  match @ai-pricing-verifier.tool_by_name("GovPilot") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0921")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ClearGov status" {
  match @ai-pricing-verifier.tool_by_name("ClearGov") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0922")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Polco status" {
  match @ai-pricing-verifier.tool_by_name("Polco") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0923")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: PublicInput status" {
  match @ai-pricing-verifier.tool_by_name("PublicInput") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0924")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: CitizenLab status" {
  match @ai-pricing-verifier.tool_by_name("CitizenLab") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0925")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Zencity status" {
  match @ai-pricing-verifier.tool_by_name("Zencity") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0926")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Balancing Act status" {
  match @ai-pricing-verifier.tool_by_name("Balancing Act") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0927")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Questica status" {
  match @ai-pricing-verifier.tool_by_name("Questica") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0928")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Envisio status" {
  match @ai-pricing-verifier.tool_by_name("Envisio") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0929")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ClearPoint Strategy status" {
  match @ai-pricing-verifier.tool_by_name("ClearPoint Strategy") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0930")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Cloudpermit status" {
  match @ai-pricing-verifier.tool_by_name("Cloudpermit") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0931")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: GovOS status" {
  match @ai-pricing-verifier.tool_by_name("GovOS") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0932")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: PayIt status" {
  match @ai-pricing-verifier.tool_by_name("PayIt") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0933")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: InvoiceCloud status" {
  match @ai-pricing-verifier.tool_by_name("InvoiceCloud") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0934")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: TextMyGov status" {
  match @ai-pricing-verifier.tool_by_name("TextMyGov") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0935")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: GovQA status" {
  match @ai-pricing-verifier.tool_by_name("GovQA") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0936")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Laserfiche status" {
  match @ai-pricing-verifier.tool_by_name("Laserfiche") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0937")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: AchieveIt status" {
  match @ai-pricing-verifier.tool_by_name("AchieveIt") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0938")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Esri ArcGIS Online status" {
  match @ai-pricing-verifier.tool_by_name("Esri ArcGIS Online") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0939")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: 国家政务服务平台 status" {
  match @ai-pricing-verifier.tool_by_name("国家政务服务平台") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "CNY")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0940")
      assert_eq(t.session, "20261115-AE")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Lemonade status" {
  match @ai-pricing-verifier.tool_by_name("Lemonade") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0941")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Root Insurance status" {
  match @ai-pricing-verifier.tool_by_name("Root Insurance") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0942")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Hippo Insurance status" {
  match @ai-pricing-verifier.tool_by_name("Hippo Insurance") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0943")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Next Insurance status" {
  match @ai-pricing-verifier.tool_by_name("Next Insurance") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0944")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Coalition status" {
  match @ai-pricing-verifier.tool_by_name("Coalition") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0945")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Vouch status" {
  match @ai-pricing-verifier.tool_by_name("Vouch") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0946")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Corvus Insurance status" {
  match @ai-pricing-verifier.tool_by_name("Corvus Insurance") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0947")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: At-Bay status" {
  match @ai-pricing-verifier.tool_by_name("At-Bay") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0948")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Clearcover status" {
  match @ai-pricing-verifier.tool_by_name("Clearcover") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0949")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Branch Insurance status" {
  match @ai-pricing-verifier.tool_by_name("Branch Insurance") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0950")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Kin Insurance status" {
  match @ai-pricing-verifier.tool_by_name("Kin Insurance") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0951")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Openly status" {
  match @ai-pricing-verifier.tool_by_name("Openly") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0952")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Slide Insurance status" {
  match @ai-pricing-verifier.tool_by_name("Slide Insurance") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0953")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Neptune Flood status" {
  match @ai-pricing-verifier.tool_by_name("Neptune Flood") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0954")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Policygenius status" {
  match @ai-pricing-verifier.tool_by_name("Policygenius") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0955")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Insurify status" {
  match @ai-pricing-verifier.tool_by_name("Insurify") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0956")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: The Zebra status" {
  match @ai-pricing-verifier.tool_by_name("The Zebra") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0957")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: CoverWallet status" {
  match @ai-pricing-verifier.tool_by_name("CoverWallet") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0958")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Simply Business status" {
  match @ai-pricing-verifier.tool_by_name("Simply Business") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0959")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ladder Life status" {
  match @ai-pricing-verifier.tool_by_name("Ladder Life") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0960")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ethos Life status" {
  match @ai-pricing-verifier.tool_by_name("Ethos Life") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0961")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Bestow status" {
  match @ai-pricing-verifier.tool_by_name("Bestow") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0962")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Haven Life status" {
  match @ai-pricing-verifier.tool_by_name("Haven Life") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0963")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Getsafe status" {
  match @ai-pricing-verifier.tool_by_name("Getsafe") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "EUR")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0964")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: YuLife status" {
  match @ai-pricing-verifier.tool_by_name("YuLife") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0965")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Alan status" {
  match @ai-pricing-verifier.tool_by_name("Alan") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "CAD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0966")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Wefox status" {
  match @ai-pricing-verifier.tool_by_name("Wefox") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0967")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Oscar Health status" {
  match @ai-pricing-verifier.tool_by_name("Oscar Health") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0968")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Sidecar Health status" {
  match @ai-pricing-verifier.tool_by_name("Sidecar Health") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0969")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: ZestyAI status" {
  match @ai-pricing-verifier.tool_by_name("ZestyAI") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0970")
      assert_eq(t.session, "20261115-AF")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Coinbase status" {
  match @ai-pricing-verifier.tool_by_name("Coinbase") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0971")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Kraken status" {
  match @ai-pricing-verifier.tool_by_name("Kraken") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0972")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Chainalysis status" {
  match @ai-pricing-verifier.tool_by_name("Chainalysis") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0973")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Alchemy status" {
  match @ai-pricing-verifier.tool_by_name("Alchemy") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0974")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Infura status" {
  match @ai-pricing-verifier.tool_by_name("Infura") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0975")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: QuickNode status" {
  match @ai-pricing-verifier.tool_by_name("QuickNode") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0976")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Moralis status" {
  match @ai-pricing-verifier.tool_by_name("Moralis") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0977")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Nansen status" {
  match @ai-pricing-verifier.tool_by_name("Nansen") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0978")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Dune Analytics status" {
  match @ai-pricing-verifier.tool_by_name("Dune Analytics") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0979")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: The Graph status" {
  match @ai-pricing-verifier.tool_by_name("The Graph") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0980")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Chainlink status" {
  match @ai-pricing-verifier.tool_by_name("Chainlink") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0981")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Uniswap status" {
  match @ai-pricing-verifier.tool_by_name("Uniswap") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0982")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: OpenSea status" {
  match @ai-pricing-verifier.tool_by_name("OpenSea") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0983")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: MoonPay status" {
  match @ai-pricing-verifier.tool_by_name("MoonPay") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0984")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Transak status" {
  match @ai-pricing-verifier.tool_by_name("Transak") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "EUR")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0985")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: BitGo status" {
  match @ai-pricing-verifier.tool_by_name("BitGo") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0986")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Fireblocks status" {
  match @ai-pricing-verifier.tool_by_name("Fireblocks") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0987")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: CertiK status" {
  match @ai-pricing-verifier.tool_by_name("CertiK") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0988")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: CoinGecko status" {
  match @ai-pricing-verifier.tool_by_name("CoinGecko") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0989")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Messari status" {
  match @ai-pricing-verifier.tool_by_name("Messari") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0990")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Glassnode status" {
  match @ai-pricing-verifier.tool_by_name("Glassnode") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0991")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: CryptoQuant status" {
  match @ai-pricing-verifier.tool_by_name("CryptoQuant") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0992")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Kaiko status" {
  match @ai-pricing-verifier.tool_by_name("Kaiko") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0993")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Santiment status" {
  match @ai-pricing-verifier.tool_by_name("Santiment") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0994")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: LunarCrush status" {
  match @ai-pricing-verifier.tool_by_name("LunarCrush") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0995")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: DappRadar status" {
  match @ai-pricing-verifier.tool_by_name("DappRadar") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0996")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Ankr status" {
  match @ai-pricing-verifier.tool_by_name("Ankr") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按量")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0997")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Blockdaemon status" {
  match @ai-pricing-verifier.tool_by_name("Blockdaemon") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-0998")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Figment status" {
  match @ai-pricing-verifier.tool_by_name("Figment") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "其他")
      assert_eq(t.verified_at, "2026-11-16")
      assert_eq(t.key, "APV-0999")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}

///|
test "generated: Etherscan status" {
  match @ai-pricing-verifier.tool_by_name("Etherscan") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "已核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
      assert_eq(t.key, "APV-1000")
      assert_eq(t.session, "20261115-AG")
    }
    None => assert_true(false)
  }
}
