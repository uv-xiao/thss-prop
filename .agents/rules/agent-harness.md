# Agent Harness Rules

- `AGENTS.md` is a concise router, not the full project manual.
- Detailed operating knowledge belongs under `.agents/rules/`, `.agents/skills/`, `.agents/agents/`, `.agents/templates/`, `docs/writing/`, and `docs/in_progress/`.
- `.agents/skills/<name>/SKILL.md` is the executable workflow surface for repeatable work.
- `.agents/agents/*.md` files are expert consultation profiles. They are read-only checklists unless the user explicitly asks for delegated subagent work.
- If a harness rule changes during a task, reread the changed rule before continuing.
- Do not duplicate the same rule across several files unless one file is the short router and the other is the normative rule.
- Do not create or depend on `.codex/`, `.claude/`, or `.opencode/` in this repository.
- Keep source resources under `resources/`, report source under `report/`, and harness instructions under `.agents/`.
