#!/bin/bash
# 启用本仓库的 Git hooks（只需跑一次）：把 hooks 目录指向 .githooks，
# 此后每次提交前自动跑 moon test，失败则阻止提交。
set -euo pipefail
cd "$(dirname "$0")/.."
git config core.hooksPath .githooks
chmod +x .githooks/pre-commit
echo "Git hooks 已启用（core.hooksPath=.githooks），提交前将自动跑 moon test。"
