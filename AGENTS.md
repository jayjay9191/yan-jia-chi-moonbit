# Project Agents.md Guide

This is a [MoonBit](https://docs.moonbitlang.com) project.

You can browse and install extra skills here:
<https://github.com/moonbitlang/skills>

## Project Structure

- MoonBit packages are organized per directory; each directory contains a
  `moon.pkg` file listing its dependencies. Each package has its files and
  blackbox test files (ending in `_test.mbt`) and whitebox test files (ending in
  `_wbtest.mbt`).

- In the toplevel directory, there is a `moon.mod` file listing module
  metadata.

- Data flow in this project (single source of truth):
  `data/pricing.json` → `scripts/generate_data.py` → `pricing_data.mbt`
  (generated, do not hand-edit). Per-tool assertions are generated the same way:
  `scripts/generate_tests.py` → `pricing_generated_test.mbt`.
  The one-time CSV import is `scripts/csv_to_json.py` (source CSV has an
  unquoted-thousands-separator quirk; see its docstring).

## Coding convention

- MoonBit code is organized in block style, each block is separated by `///|`,
  the order of each block is irrelevant. In some refactorings, you can process
  block by block independently.

- Try to keep deprecated blocks in file called `deprecated.mbt` in each
  directory.

- Enum constructors are read-only outside the defining package: CLI and
  blackbox tests must use the public wrapper functions in `pricing.mbt`
  (`verified_count`, `names_verified`, …), never `PriceStatus::Verified`.
  Rule-regression tests that need to build enum values live in the whitebox
  file `pricing_wbtest.mbt`.

- Do not use `#derive(Eq)` on the enum: it promotes `equal`/`not_equal` to
  methods and triggers a deprecation warning. Use the hand-written
  `status_eq` match instead.

## Tooling

- `moon fmt` is used to format your code properly.

- `moon ide` provides project navigation helpers like `peek-def`, `outline`, and
  `find-references`. See $moonbit-agent-guide for details.

- `moon info` is used to update the generated interface of the package, each
  package has a generated interface file `.mbti`, it is a brief formal
  description of the package. If nothing in `.mbti` changes, this means your
  change does not bring the visible changes to the external package users, it is
  typically a safe refactoring.

- In the last step, run `moon info && moon fmt` to update the interface and
  format the code. Check the diffs of `.mbti` file to see if the changes are
  expected.

- Run `moon test` to check tests pass. MoonBit supports snapshot testing; when
  changes affect outputs, run `moon test --update` to refresh snapshots.

- Prefer `assert_eq` or `assert_true(pattern is Pattern(...))` for results that
  are stable or very unlikely to change. For snapshot tests that record
  structured debugging output, derive `Debug` and use `debug_inspect`, rather
  than deriving `Show` for debugging. For solid, well-defined results (e.g.
  scientific computations), prefer assertion tests. You can use
  `moon coverage analyze > uncovered.log` to see which parts of your code are
  not covered by tests.

- `moon test` does not run executable entry points: `cmd/main/main.mbt` will
  show as uncovered. Verify CLI commands by running them (see README demo
  sequence) instead of chasing that coverage number.
