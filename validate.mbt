///|
/// 数据校验：检查定价记录本身是否自洽，返回问题列表（空列表表示通过）。
/// 校验规则（学 J085 的验证方法论：每条规则都要能当场验出 0 错或报错，
/// 不靠“看着对”）。共 13 条条目；第 3 条双向，合计 14 项检查：
/// 1. 每个工具必须有名字；名字不重复
/// 2. 定价页 URL 必须以 https:// 开头（本批 20 条全是 https）
/// 3. 价格缺失时必须明确标未核验：paid_price 为空 ⟺ status 为未核验到
///    （双向：空价格 + 已核验 = 冒充已核验；有价格 + 未核验到 = 自相矛盾；
///    部分核验也必须有价格）
/// 4. 货币一致：已核验/部分核验 → 货币必须是 USD/JPY/CNY；未核验到 →
///    货币必须为空（没有价格就不编货币）
/// 5. 货币符号一致：USD 的价格里必须有 "$"，JPY/CNY 的价格里必须有 "¥"；
///    例外：纯费率价（只有百分比、没有固定金额，如 Patreon 平台费为收入的
///    10%）没有货币符号可查，货币按官网市场记 USD，符号检查不适用
/// 6. 计费周期：已核验/部分核验 → 非空；未核验到 → 必须为空
/// 7. verified_at 符合 YYYY-MM-DD
/// 8. reachable 只能是“能打开”/“打不开”/“受限”
/// 9. 页面打不开或受限 → 不能标已核验/部分核验（看不到页面就没法核验价格）
/// 10. 免费版、学生优惠字段非空（"未见"也是明确表态，不能空着）
/// 11. 记录键 key 非空且不重复（证据链第 2 步的锚点，丢了就没法追溯）
/// 12. 核验会话 session 非空（哪一批次、哪天核验的）
/// 13. history 条目合法：日期格式正确；变动类型在 6 种以内
///     （无变化/涨价/降价/下架/新档位/未看到价）；会话非空；
///     涨价/降价必须新旧价俱全且不同（空着或相同都是假轨迹）

///|
/// 纯费率价：价格只有百分比、没有固定金额（如 Patreon 平台费为收入的
/// 10%，官网定价页只给这个费率、无固定月费）。这种价格没有货币符号
/// 可查，货币符号检查不适用；货币仍按官网所在市场记（USD；先例：
/// Klarna 5.99% + $0.30/笔、Wise 0.24% 起均记 USD）。
fn is_rate_only_price(paid_price : String) -> Bool {
  paid_price.contains("%") &&
  !paid_price.contains("$") &&
  !paid_price.contains("¥")
}

///|
pub fn validate_tools(tools : Array[ToolPricing]) -> Array[String] {
  let issues : Array[String] = []
  let seen_names : Array[String] = []
  let seen_keys : Array[String] = []
  for i in 0..<tools.length() {
    let t = tools[i]
    let tag = "《" + t.name + "》"
    if t.key == "" {
      issues.push(tag + "记录键 key 为空")
    } else if contains_string(seen_keys, t.key) {
      issues.push("记录键 key 重复：" + t.key)
    } else {
      seen_keys.push(t.key)
    }
    if t.session == "" {
      issues.push(tag + "核验会话 session 为空")
    }
    for j in 0..<t.history.length() {
      let h = t.history[j]
      let htag = tag + "第 \{j + 1} 条变动轨迹"
      if !is_valid_date(h.date) {
        issues.push(htag + "日期格式不对：" + h.date)
      }
      if !is_valid_change(h.change) {
        issues.push(htag + "变动类型不在 6 种以内：" + h.change)
      }
      if h.session == "" {
        issues.push(htag + "会话为空")
      }
      if h.change == "涨价" || h.change == "降价" {
        if h.old_price == "" || h.new_price == "" {
          issues.push(htag + "涨价/降价必须新旧价俱全")
        } else if h.old_price == h.new_price {
          issues.push(htag + "涨价/降价新旧价相同：假轨迹")
        }
      }
    }
    if t.name == "" {
      issues.push("第 \{i + 1} 个工具没有名字")
    } else if contains_string(seen_names, t.name) {
      issues.push("工具名字重复：" + t.name)
    } else {
      seen_names.push(t.name)
    }
    if !t.pricing_url.has_prefix("https://") {
      issues.push(
        tag +
        "定价页 URL 必须以 https:// 开头，现在是：" +
        t.pricing_url,
      )
    }
    if t.paid_price == "" && !status_eq(t.status, PriceStatus::Unverified) {
      issues.push(
        tag +
        "没有付费价却标了“" +
        status_text(t.status) +
        "”：冒充已核验",
      )
    }
    if t.paid_price != "" && status_eq(t.status, PriceStatus::Unverified) {
      issues.push(
        tag + "有付费价却标了“未核验到”：自相矛盾",
      )
    }
    if status_eq(t.status, PriceStatus::Unverified) {
      if t.currency != "" {
        issues.push(
          tag +
          "未核验到却写了货币 " +
          t.currency +
          "：没有价格就不编货币",
        )
      }
      if t.billing != "" {
        issues.push(
          tag +
          "未核验到却写了计费周期 " +
          t.billing +
          "：自相矛盾",
        )
      }
    } else {
      if t.currency != "USD" && t.currency != "JPY" && t.currency != "CNY" {
        issues.push(
          tag + "货币必须是 USD/JPY/CNY，现在是：" + t.currency,
        )
      } else if t.currency == "USD" &&
        !t.paid_price.contains("$") &&
        !is_rate_only_price(t.paid_price) {
        issues.push(tag + "货币是 USD，但付费价里没有 $ 符号")
      } else if (t.currency == "JPY" || t.currency == "CNY") &&
        !t.paid_price.contains("¥") &&
        !is_rate_only_price(t.paid_price) {
        issues.push(
          tag + "货币是 " + t.currency + "，但付费价里没有 ¥ 符号",
        )
      }
      if t.billing == "" {
        issues.push(tag + "已核验/部分核验却没有计费周期")
      }
    }
    if !is_valid_date(t.verified_at) {
      issues.push(
        tag +
        "verified_at 格式不对：" +
        t.verified_at +
        "（应为 YYYY-MM-DD）",
      )
    }
    if t.reachable != "能打开" &&
      t.reachable != "打不开" &&
      t.reachable != "受限" {
      issues.push(
        tag +
        "reachable 只能是“能打开”/“打不开”/“受限”，现在是：" +
        t.reachable,
      )
    }
    if (t.reachable == "打不开" || t.reachable == "受限") &&
      !status_eq(t.status, PriceStatus::Unverified) {
      issues.push(
        tag +
        "页面" +
        t.reachable +
        "却标了“" +
        status_text(t.status) +
        "”：看不到页面就没法核验价格",
      )
    }
    if t.free_tier == "" {
      issues.push(tag + "免费版字段为空")
    }
    if t.student_discount == "" {
      issues.push(
        tag +
        "学生/教育优惠字段为空（“未见”也是明确表态，不能空着）",
      )
    }
  }
  issues
}

///|
fn contains_string(items : Array[String], s : String) -> Bool {
  for i in 0..<items.length() {
    if items[i] == s {
      return true
    }
  }
  false
}
