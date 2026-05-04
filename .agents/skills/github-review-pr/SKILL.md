---
name: github-review-pr
description: Perform a GitHub PR review focused on report argument, evidence, terminology, and Typst build correctness.
---

# GitHub Review PR

Use this for read-only review of a thesis proposal PR.

## Workflow

1. Resolve PR number, base, and head.
2. List changed files.
3. Classify risk:
   - argument structure;
   - unsupported or hallucinated claim;
   - citation metadata;
   - technical translation;
   - terminology consistency;
   - Typst build/layout;
   - harness rule drift.
4. Inspect relevant report and source files.
5. Run non-mutating checks when available.
6. Report findings by severity using `.agents/templates/report-review.md`.

## Hard Rules

- Do not edit files in review mode.
- Do not change GitHub state unless the user asks.
- Do not claim a citation mismatch without inspecting the cited source or local evidence note.
