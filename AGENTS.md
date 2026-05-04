# Thesis Proposal Agent Guide

This file is the Codex entrypoint for the thesis proposal workspace.

## Read First

Before editing report text, references, terminology, or harness files, agents must:

1. Run `git status --short --branch`.
2. Read `.agents/README.md`.
3. Read every file under `.agents/rules/`.
4. Load the task-relevant skill under `.agents/skills/<name>/SKILL.md`.
5. Inspect the relevant report files under `report/` and supporting materials under `resources/`.

## Harness Layout

- `.agents/rules/`: mandatory project rules.
- `.agents/skills/`: executable workflows.
- `.agents/agents/`: expert review profiles.
- `.agents/templates/`: reusable writing, review, PR, bibliography, and terminology templates.
- `docs/writing/`: evolving project-specific writing requirements and preference records.
- `docs/in_progress/human_words/`: source wording from user feedback before it is curated into durable rules.

## Completion Gate

No agent may claim report writing is ready unless it has checked structure, word-budget fit, citation traceability, terminology consistency, Chinese academic style, and technical alignment with English source material.
