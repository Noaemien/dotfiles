# Project Instructions for Claude Code Agents
## Core Workflow

ALWAYS start every task by invoking the task-planner agent to break down the work, define steps, and assign sub-tasks.
ALWAYS end every task by invoking the code-reviewer agent to check for quality, bugs, and adherence to standards.

## Additional Guidelines

Reference this file at the start of every agent session for consistency.
If needed, import task-specific rules from .claude/rules/ (e.g., @.claude/rules/testing.md for test instructions).
Prioritize clarity, scalability, and minimal changes to avoid breaking dependencies.

## RULES

NEVER create or edit issues on linear.
Use the MCP only for reading issues.

## Python / Package Manager

ALWAYS use `uv` to run Python tools. NEVER use `.venv/bin/`, bare `python`, or `python3`.
- Run tests: `uv run pytest ...`
- Run formatter: `uv run black ...`
- Run any Python CLI: `uv run <tool> ...`

## Git Commits

After completing any code change, ALWAYS commit immediately without asking.
Do not wait for the user to say "commit" — auto-commit is expected.
Commit small, atomic changes — don't batch unrelated modifications into one commit.
Use Conventional Commits format: `type(scope): message` (e.g., `feat(auth): add login endpoint`).
NO description body — only the subject line.
NO Co-Authored-By trailer.
