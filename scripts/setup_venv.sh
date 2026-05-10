#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
VENV="$ROOT/.venv"

if [ ! -d "$VENV" ]; then
  python3 -m venv "$VENV"
fi

"$VENV/bin/python" -m pip install --upgrade pip >/dev/null

if [ -x "$ROOT/scripts/install_git_hooks.sh" ]; then
  "$ROOT/scripts/install_git_hooks.sh" >/dev/null
fi
