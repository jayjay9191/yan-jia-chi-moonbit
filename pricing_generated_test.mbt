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
      assert_eq(t.verified_at, "2026-11-08")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-08")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "受限")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
