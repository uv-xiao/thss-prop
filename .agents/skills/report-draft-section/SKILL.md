---
name: report-draft-section
description: Draft or revise a thesis proposal section with argument, citation, terminology, and word-budget gates.
---

# Report Draft Section

Use this when drafting or revising any report section.

## Required Reading

1. `AGENTS.md`
2. `.agents/README.md`
3. `.agents/rules/report-argument.md`
4. `.agents/rules/chinese-academic-style.md`
5. `.agents/rules/evidence-citations-translation.md`
6. `docs/writing/terminology.md`
7. `docs/writing/preferences.md`
8. The relevant source files in `report/` and `resources/`

## Workflow

1. Identify the target section, its controlling claim, and its role in the full proposal arc.
2. Set a section word-budget target before editing.
3. List the sources or local resources that support the planned claims.
4. Draft or revise text so each paragraph has one function and a visible logical transition.
5. Add or update citation keys only after inspecting the source.
6. Update `docs/writing/terminology.md` for any new or changed technical term.
7. Run the no-hallucination gate in `.agents/rules/evidence-citations-translation.md`.
8. Run `make pdf` unless the user explicitly asks for text-only drafting.
9. Summarize changed argument, citation impact, terminology impact, and verification.

## Hard Rules

- Do not add unsupported claims.
- Do not expand the section just to sound complete.
- Do not translate English technical terms by intuition when a source or existing project usage can decide the wording.
- Do not let existing work dominate future research design unless the section is explicitly about existing basis.

## Output

Use `.agents/templates/writing-task.md` for planning or handoff notes when the task is non-trivial.
