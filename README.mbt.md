# AI 工具定价核验 · MoonBit 版

20 个常用 AI 工具官网定价的数据资产 + 证据链 + 验证规则（MoonBit 实现）。

数据是用户 Lexmount 第二份作品的真实核验结果：2026-11-08，Lexmount Cloud Browser
实际打开各官网逐页记录，未用第三方汇总文章，未编造未看到的价格。

## 实测数据（2026-11-15 当场跑出，带分母）

| 项目 | 实测结果 |
| --- | --- |
| MoonBit 测试 | 72/72 通过（20 条逐工具生成断言 + 23 条黑盒 + 29 条白盒） |
| Python 测试（脚本） | 11/11 通过 |
| 验证规则 | 11 条规则，真实数据 0 个问题（`verify`） |
| 核心库覆盖 | 0 行未覆盖（pricing/validate/dates/report/生成数据） |
| CLI 入口覆盖 | 28 行未覆盖——moon test 不跑可执行入口（工具链限制），已用演示命令逐条实测 |
| 已核验（官网价已完整记录） | 8/20 |
| 部分核验 | 3/20（Gemini 只在 Google One 页看到价、Copilot 只核验到商业版、海螺只见到起步价） |
| 未核验到付费价 | 9/20（价格留空，不编造） |
| 有付费价记录 | 11/20；无付费价记录 9/20 |
| 页面能打开 | 16/20；打不开 3/20；受限（地区限制）1/20 |
| 货币 | USD 7 个，JPY 2 个，CNY 2 个，无货币（未核验到）9 个 |
| 计费 | 按量 3 个，按月 5 个，月/年 2 个，按年 1 个，无（未核验到）9 个 |
| 学生/教育优惠有说明 | 4/20；写“未见”16/20（“未见”指页面上没看到，不是“没有优惠”） |
| 过期未复核（距今超 30 天） | 0/20（2026-11-15）；下次复核不晚于 2026-12-08 |

## 演示命令（复制粘贴即跑）

```sh
export PATH="$HOME/.moon/bin:$PATH"
cd ai-pricing-verifier

# 汇总报告（带分母）
moon run cmd/main report

# 列出全部 20 个工具及价格状态
moon run cmd/main list

# 跑全部 11 条验证规则，目标 0 错
moon run cmd/main verify

# 过期未复核的记录（超 30 天）
moon run cmd/main stale

# 单条证据链：来源 URL → 记录 → 核验时间 → 状态
moon run cmd/main check Cursor
moon run cmd/main check "豆包"
moon run cmd/main check "ChatGPT / OpenAI"

# 测试
moon test
python3 -m unittest discover -s tests_py
```

注意：工具名只接受全名，`check 黎明`这种简称查不到（和参赛管家一样）。

## 数据说明

- 唯一事实源是 `data/pricing.json`，改数据只改 JSON，改完跑
  `python3 scripts/generate_data.py`（再跑 `moon fmt && moon test`）。
- 逐工具断言由 `python3 scripts/generate_tests.py` 从 JSON 生成，
  JSON 一变测试跟着变。
- CSV 导入是一次性的：`python3 scripts/csv_to_json.py`（源 CSV 在
  `~/workspace/goals/internradar/files/ai-pricing-verification/pricing.csv`）。
  注意源 CSV 有个小毛病——ChatGPT、Gemini 两行的千分位价格（JP¥1,400、
  JP¥1,450）没加引号，直接用 csv 模块会切错字段；导入脚本按首尾字段
  定位 + 计费周期查表重组，并对 reachable、计费周期做交叉校验。
- 价格只在核验当天（2026-11-08）有效，官网随时会改；本工具的政策是
  30 天复核一次，`stale` 会标出过期记录。

## 与 Lexmount 二等奖 J006「AI岗位实习导航」的对比

| 维度 | J006（4 人队） | 本项目（1 人） |
| --- | --- | --- |
| 数据规模 | 360 条记录、274 在招、14 个采集日、103 个时间点 | 20 个工具、1 个核验日（2026-11-08）——规模小是事实，赢在验证深度 |
| 证据链 | 5 步（来源 URL → 原始记录 → 键 → 复核 → 实时页面） | 4 步（定价页 URL → 记录 → 核验时间 → 状态），`check` 当场可查 |
| 明确标空白 | 是（263/274 无毕业年份等） | 是（9/20 未核验到，付费价留空；3/20 部分核验单列一档） |
| 验证方法论 | 自述，未见测试 | 11 条规则 + 72 项 MoonBit 测试 + 11 项 Python 测试，`verify` 0 错 |
| 公开仓库 | 无 | 本地已 git init，待建远程仓库（见下） |
| CI | 无 | `.github/workflows/moon-test.yml` 已写好，仓库建好后生效 |
| 可运行工具 | 演示链接 403 打不开 | CLI 本地可跑：list / verify / stale / report / check |
| 数字来源 | PDF 自述 | JSON 数据 + 生成器 + 测试三重锁定，全部带分母 |
| 变现 | ¥9.9 深度报告（自述，未见回执） | 无——诚实缺口，待定 |

## 范围与未完成事项（诚实写清）

- **公开仓库还没建**：本地 git 已 init、多 commit，未推、未建远程仓库，
  等用户下一步指令。
- **没发 Mooncakes、没填 MoonBit 报名表**：同上，等用户指令。
- **静态快照，不是实时核验**：数据是 2026-11-08 的一次核验，不联网、
  不重新打开官网；价格过期靠 `stale` 提醒人工复核。
- **规模只有 20 条**：J006 是 360 条。扩量（更多工具、定期复核）是
  下一步最直接的补强方向。
- **核验日只有一天**：J006 有 14 个采集日、103 个时间点；本批只有
  2026-11-08 一天，没有“涨价/下架”这类生命周期追踪。
- **学生优惠只记“页面上有没有”**：16/20 写“未见”不等于没有优惠，
  只说明定价页上没看到。
- **CLI 入口 28 行未覆盖**：moon test 不跑可执行入口（工具链限制，
  参赛管家也一样）；已用演示命令逐条实测通过。
