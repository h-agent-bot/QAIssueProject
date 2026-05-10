#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
cd "$ROOT"

echo "QAIssueProject pre-submit gate"
git diff --check
test -f README.md
