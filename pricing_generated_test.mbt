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
      assert_eq(t.verified_at, "2026-11-15")
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

///|
test "generated: Semrush status" {
  match @ai-pricing-verifier.tool_by_name("Semrush") {
    Some(t) => {
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按月")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "按年")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "部分核验")
      assert_eq(t.currency, "USD")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "月/年")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "打不开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
      assert_eq(@ai-pricing-verifier.status_text(t.status), "未核验到")
      assert_eq(t.currency, "")
      assert_eq(t.reachable, "能打开")
      assert_eq(@ai-pricing-verifier.billing_category(t.billing), "")
      assert_eq(t.verified_at, "2026-11-15")
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
