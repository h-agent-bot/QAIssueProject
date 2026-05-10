#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOOKS_PATH_REL=".githooks"
HOOKS_DIR="$ROOT_DIR/.githooks"
PRE_PUSH_HOOK="$HOOKS_DIR/pre-push"
PRE_SUBMIT_SCRIPT="$ROOT_DIR/scripts/pre_submit.sh"

if ! git -C "$ROOT_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "ERROR: $ROOT_DIR is not inside a git worktree." >&2
  exit 1
fi

if [[ ! -f "$PRE_SUBMIT_SCRIPT" ]]; then
  echo "ERROR: missing canonical pre-submit gate at $PRE_SUBMIT_SCRIPT" >&2
  exit 1
fi

if [[ ! -f "$PRE_PUSH_HOOK" ]]; then
  echo "ERROR: missing pre-push hook at $PRE_PUSH_HOOK" >&2
  exit 1
fi

chmod +x "$PRE_SUBMIT_SCRIPT" "$PRE_PUSH_HOOK"

CURRENT_HOOKS_PATH="$(git -C "$ROOT_DIR" config --get core.hooksPath || true)"
STATUS="already_configured"

if [[ "$CURRENT_HOOKS_PATH" != "$HOOKS_PATH_REL" ]]; then
  git -C "$ROOT_DIR" config core.hooksPath "$HOOKS_PATH_REL"
  STATUS="configured"
fi

echo "Repo-local git hooks $STATUS"
echo "root=$ROOT_DIR"
echo "core.hooksPath=$HOOKS_PATH_REL"
echo "pre_push_hook=.githooks/pre-push"
echo "default_gate=bash scripts/pre_submit.sh"
