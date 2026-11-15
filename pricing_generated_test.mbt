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
