---
name: commit
description: Create a git commit with the ✺ model signature. Use when the user asks to commit changes.
---

Create a git commit for the current staged and unstaged changes.

## Steps

1. Run `git status` (never use `-uall`), `git diff`, and `git log --oneline -5` in parallel.
2. Analyze all changes and draft a commit message following the **50/72 rule**:
   - **Subject line**: max 50 characters, imperative mood, no trailing period
   - **Body**: wrap at 72 characters, separated from subject by a blank line
   - Summarize the nature of the changes (new feature, bug fix, refactor, etc.)
   - Do not commit files that likely contain secrets (.env, credentials.json, etc.)
   - Focus on the "why" rather than the "what" — the diff shows what changed
3. Stage relevant files and create the commit. End every commit message with this signature on its own line:

```
✺ Opus 4.6
```

Use the current model version (Opus 4.6, Sonnet 4.6, etc.). The `✺` (U+273A) represents Claude. No `Co-Authored-By` line, no email — just the symbol and model version.

4. Run `git status` after the commit to verify success.

Pass the commit message via HEREDOC:

```bash
git commit -m "$(cat <<'EOF'
commit message here

✺ Opus 4.6
EOF
)"
```

If the commit fails due to a pre-commit hook, fix the issue and create a NEW commit (never amend).
