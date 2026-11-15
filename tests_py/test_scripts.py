#!/usr/bin/env python3
"""脚本的单元测试（Python 标准库 unittest）。

跑法（项目根目录）：
    python3 -m unittest discover -s tests_py -v

只测纯函数与确定性输出，不联网、不写仓库文件。
"""

import io
import json
import sys
import unittest
from contextlib import redirect_stdout
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "scripts"))

import csv_to_json  # noqa: E402
import generate_data  # noqa: E402
import generate_tests  # noqa: E402


class TestMbtEmit(unittest.TestCase):
    def test_mbt_str_escapes(self):
        self.assertEqual(generate_data.mbt_str('a"b'), '"a\\"b"')
        self.assertEqual(generate_data.mbt_str("a\\b"), '"a\\\\b"')
        self.assertEqual(generate_data.mbt_str("a\nb"), '"a\\nb"')
        self.assertEqual(generate_data.mbt_str("a\tb"), '"a\\tb"')
        self.assertEqual(generate_data.mbt_str("中文"), '"中文"')

    def test_status_map_covers_all(self):
        self.assertEqual(
            set(generate_data.STATUS_MAP),
            {"verified", "partial", "unverified"},
        )

    def test_unknown_status_raises(self):
        with self.assertRaises(ValueError):
            generate_data.emit_tool({"status": "bogus", "name": "x"})


class TestGenerateData(unittest.TestCase):
    def test_deterministic(self):
        # 同一份 JSON 生成两次，字节一致
        buf1 = io.StringIO()
        buf2 = io.StringIO()
        with redirect_stdout(buf1):
            generate_data.main()
        first = (ROOT / "pricing_data.mbt").read_text(encoding="utf-8")
        with redirect_stdout(buf2):
            generate_data.main()
        second = (ROOT / "pricing_data.mbt").read_text(encoding="utf-8")
        self.assertEqual(first, second)
        data = json.loads((ROOT / "data" / "pricing.json").read_text(encoding="utf-8"))
        self.assertIn(f"{len(data['tools'])} 个工具", buf1.getvalue())

    def test_generated_file_has_all_tools(self):
        text = (ROOT / "pricing_data.mbt").read_text(encoding="utf-8")
        data = json.loads((ROOT / "data" / "pricing.json").read_text(encoding="utf-8"))
        for tool in data["tools"]:
            self.assertIn(tool["name"], text)


class TestCsvImport(unittest.TestCase):
    def test_parse_rows_count(self):
        rows = csv_to_json.parse_rows(csv_to_json.CSV_PATH)
        self.assertEqual(len(rows), 20)

    def test_thousand_separator_prices_survive(self):
        # CSV 里 ChatGPT/Gemini 的千分位价格没加引号，解析不能切断它们
        rows = {r["name"]: r for r in csv_to_json.parse_rows(csv_to_json.CSV_PATH)}
        self.assertIn("1,400", rows["ChatGPT / OpenAI"]["paid_raw"])
        self.assertIn("16,800", rows["ChatGPT / OpenAI"]["paid_raw"])
        self.assertIn("1,450", rows["Gemini / Google"]["paid_raw"])
        self.assertIn("2,900", rows["Gemini / Google"]["paid_raw"])
        self.assertEqual(
            rows["ChatGPT / OpenAI"]["student"], "定价页未见通用学生折扣；ChatGPT for Teachers 美国K-12教师免费至2027年6月，另有Edu版面向高校"
        )

    def test_billing_reassembly(self):
        rows = {r["name"]: r for r in csv_to_json.parse_rows(csv_to_json.CSV_PATH)}
        self.assertEqual(rows["DeepSeek"]["billing_csv"], "按量，无月/年订阅")
        self.assertEqual(rows["Gemini / Google"]["billing_csv"], "按月，年付最高省16%")
        self.assertEqual(rows["Claude / Anthropic"]["billing_csv"], "月/年均有")
        self.assertEqual(rows["Qwen / 通义千问"]["billing_csv"], "—")

    def test_json_invariants(self):
        # 不变量断言：不写死总数/分档数，数据扩到 200、1000 条也不用改。
        data = json.loads((ROOT / "data" / "pricing.json").read_text(encoding="utf-8"))
        tools = data["tools"]
        self.assertGreater(len(tools), 0)
        from collections import Counter

        # 状态只在三档里；货币只在四种里；可达性只在三种里
        self.assertTrue(
            set(t["status"] for t in tools)
            <= {"verified", "partial", "unverified"}
        )
        self.assertTrue(
            set(t["currency"] for t in tools) <= {"USD", "JPY", "CNY", ""}
        )
        self.assertTrue(
            set(t["reachable"] for t in tools) <= {"能打开", "打不开", "受限"}
        )
        # 记录键唯一且非空；核验会话非空；三档都有记录
        keys = [t["key"] for t in tools]
        self.assertEqual(len(keys), len(set(keys)))
        self.assertTrue(all(k for k in keys))
        self.assertTrue(all(t["session"] for t in tools))
        self.assertTrue(set(t["status"] for t in tools) == {"verified", "partial", "unverified"})
        # 未核验到的行 paid_price 必须为空，货币、计费也为空
        for t in tools:
            if t["status"] == "unverified":
                self.assertEqual(t["paid_price"], "")
                self.assertEqual(t["currency"], "")
                self.assertEqual(t["billing"], "")
            # 涨价/降价的 history 必须新旧价俱全且不同
            for h in t.get("history", []):
                self.assertIn(
                    h["change"],
                    {"无变化", "涨价", "降价", "下架", "新档位", "未看到价"},
                )
                if h["change"] in ("涨价", "降价"):
                    self.assertTrue(h["old_price"])
                    self.assertTrue(h["new_price"])
                    self.assertNotEqual(h["old_price"], h["new_price"])


class TestGenerateTests(unittest.TestCase):
    def test_deterministic(self):
        buf = io.StringIO()
        with redirect_stdout(buf):
            generate_tests.main()
        first = (ROOT / "pricing_generated_test.mbt").read_text(encoding="utf-8")
        with redirect_stdout(io.StringIO()):
            generate_tests.main()
        second = (ROOT / "pricing_generated_test.mbt").read_text(encoding="utf-8")
        self.assertEqual(first, second)
        data = json.loads((ROOT / "data" / "pricing.json").read_text(encoding="utf-8"))
        self.assertIn(f"{len(data['tools'])} 条测试", buf.getvalue())

    def test_billing_category_matches_moonbit(self):
        self.assertEqual(generate_tests.billing_category("按量，无月/年订阅"), "按量")
        self.assertEqual(generate_tests.billing_category("按月，年付最高省16%"), "按月")
        self.assertEqual(generate_tests.billing_category("月/年均有"), "月/年")
        self.assertEqual(generate_tests.billing_category(""), "")


if __name__ == "__main__":
    unittest.main()
