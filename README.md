# QAIssueProject

QAIssueProject is a tiny routed-repo fixture for validating LinearAgent end-to-end behavior against a real GitHub repository and a real Linear project.

Goals:
- prove per-project repo routing works
- prove issue worktrees can be created and used here
- prove PR review can run against a non-LinearAgent repo
- keep the repo intentionally small and understandable

## Setup

```bash
git clone https://github.com/h-agent-bot/QAIssueProject.git
cd QAIssueProject
sh scripts/setup_venv.sh
. .venv/bin/activate
sh scripts/pre_submit.sh
sh scripts/install_git_hooks.sh
```

## Agent Harness

```yaml
version: 1
test_commands:
  - sh scripts/pre_submit.sh
lint_commands: []
integration_commands: []
log_paths: []
merge_requirements:
  require_clean_tests: true
  require_clean_review: true
  require_linear_comment: true
  require_resolved_review_comments: true
  require_issue_worktree: true
review_prompt_hints:
  - Prefer concrete findings over stylistic commentary.
  - Require evidence for completion claims.
  - Reject changes with weak tests or missing harness evidence.
repo_facts:
  default_branch: main
  project_key: QAIssueProject
  spec_path: README.md
  review_channel: github-pr-comments
  issue_status_channel: linear-comments
  worktree_root: .worktrees
  telemetry_root: telemetry
  require_worktree_per_issue: true
```

## Workflow

- keep changes intentionally tiny
- one issue per worktree branch under `.worktrees/`
- open a PR for meaningful work
- let review decide `approved` / `changes_requested` / `blocked`
- read `prompts/developer.md` before issue work
- use the repo-local pre-push hook; it runs `bash scripts/pre_submit.sh`

## Smoke

agentloop smoke
