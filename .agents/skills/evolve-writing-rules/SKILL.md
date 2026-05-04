---
name: evolve-writing-rules
description: Record user feedback and promote repeated writing preferences into harness rules or writing preference notes.
---

# Evolve Writing Rules

Use this when the user gives paragraph-level edits, writing preferences, review comments, citation requirements, terminology decisions, or harness changes.

## Workflow

1. Capture the user's original wording under `docs/in_progress/human_words/`.
2. Classify the feedback:
   - one-off edit;
   - recurring writing preference;
   - terminology decision;
   - citation/evidence rule;
   - report structure rule;
   - harness operation rule.
3. Update the narrowest durable destination:
   - `.agents/rules/` for mandatory future behavior;
   - `docs/writing/preferences.md` for style preferences and examples;
   - `docs/writing/terminology.md` for term choices;
   - `docs/writing/bibliography-audit.md` for citation evidence;
   - `.agents/templates/` for repeatable task output shape.
4. Reread the changed rule or preference file.
5. Summarize what was captured, what was promoted, and what stayed as source feedback.

## Hard Rules

- Preserve human wording before summarizing it.
- Do not turn a local paragraph fix into a global rule unless it generalizes.
- Do not override institutional requirements or source evidence with style preference.
