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
        self.assertIn("20 个工具", buf1.getvalue())

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

    def test_json_counts(self):
        data = json.loads((ROOT / "data" / "pricing.json").read_text(encoding="utf-8"))
        tools = data["tools"]
        self.assertEqual(len(tools), 20)
        from collections import Counter

        self.assertEqual(
            Counter(t["status"] for t in tools),
            {"verified": 8, "partial": 3, "unverified": 9},
        )
        self.assertEqual(
            Counter(t["currency"] for t in tools),
            {"USD": 7, "JPY": 2, "CNY": 2, "": 9},
        )
        self.assertEqual(
            Counter(t["reachable"] for t in tools),
            {"能打开": 16, "打不开": 3, "受限": 1},
        )
        # 未核验到的行 paid_price 必须为空，货币、计费也为空
        for t in tools:
            if t["status"] == "unverified":
                self.assertEqual(t["paid_price"], "")
                self.assertEqual(t["currency"], "")
                self.assertEqual(t["billing"], "")
                self.assertIn("付费版原文：", t["note"])


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
        self.assertIn("20 条测试", buf.getvalue())

    def test_billing_category_matches_moonbit(self):
        self.assertEqual(generate_tests.billing_category("按量，无月/年订阅"), "按量")
        self.assertEqual(generate_tests.billing_category("按月，年付最高省16%"), "按月")
        self.assertEqual(generate_tests.billing_category("月/年均有"), "月/年")
        self.assertEqual(generate_tests.billing_category(""), "")


if __name__ == "__main__":
    unittest.main()
