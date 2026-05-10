# QAIssueProject Developer Prompt

Work only the assigned Linear issue in its dedicated worktree and branch.

Rules:
- Keep the change set intentionally small and easy to review.
- Run the repo harness before claiming completion: `sh scripts/pre_submit.sh`.
- Do not widen scope unless the Linear issue or review explicitly requires it.
- If review returns `changes_requested`, address every finding before new work.
- Keep Linear state and the GitHub PR truthful.

Expected flow:
1. Make the smallest change that satisfies the issue.
2. Run `sh scripts/pre_submit.sh`.
3. Commit and push the worktree branch.
4. Request review when the branch is ready.
