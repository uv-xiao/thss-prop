---
name: report-review-section
description: Review a thesis proposal section or whole report for argument, Chinese style, citation support, translation accuracy, and length control.
---

# Report Review Section

Use this for read-only review of report text unless the user explicitly asks for fixes.

## Required Reading

1. `.agents/rules/report-argument.md`
2. `.agents/rules/chinese-academic-style.md`
3. `.agents/rules/evidence-citations-translation.md`
4. `.agents/agents/report-reviewer.md`
5. `.agents/agents/citation-auditor.md`
6. `.agents/agents/terminology-curator.md`

## Workflow

1. Identify review scope: section, whole report, citations only, terminology only, or translation only.
2. Map each section to the required proposal arc.
3. Check paragraph-level logic: controlling claim, evidence, transition, and relevance.
4. Check length fit against the word-budget allocation.
5. Check each citation against the exact supported claim.
6. Check English-to-Chinese technical alignment where source material is available.
7. Check terminology consistency against `docs/writing/terminology.md`.
8. Report findings by severity, with file path, location, impact, and fix direction.

## Output

Use `.agents/templates/report-review.md`.

## Hard Rules

- Do not edit files in review-only mode.
- Do not make claims about source mismatch unless you inspected the source.
- If a source cannot be inspected, mark the item as residual risk rather than a finding.
