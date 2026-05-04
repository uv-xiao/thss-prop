# Thesis Proposal Agent Harness

This harness is repo-local and optimized for iterative Chinese thesis proposal writing.

## Principles

- Treat the report as an academic argument, not a collection of notes.
- Keep the main text concise enough for an opening report while still fully argued.
- Require evidence for every technical, historical, industrial, or comparative claim.
- Preserve English source meaning before translating or paraphrasing into Chinese.
- Separate article-facing text from support assets: `.bib`, terminology tables, review notes, and evolving rules do not automatically appear in the report.
- Promote recurring human preferences into durable rules only after they are interpreted and checked against existing rules.

## Layout

- `rules/`: mandatory rules for all report work.
- `skills/`: repeatable workflows agents can execute directly.
- `agents/`: expert consultation profiles for writing, review, citation, terminology, and GitHub collaboration.
- `templates/`: standard document shapes for writing tasks, reviews, PRs, citation audits, and terminology updates.

## Core Workflows

- Draft or revise a section: `.agents/skills/report-draft-section/SKILL.md`.
- Review a section or whole report: `.agents/skills/report-review-section/SKILL.md`.
- Curate bibliography entries: `.agents/skills/curate-bibliography/SKILL.md`.
- Curate terminology: `.agents/skills/curate-terminology/SKILL.md`.
- Evolve writing rules from feedback: `.agents/skills/evolve-writing-rules/SKILL.md`.
- Collaborate through GitHub: `.agents/skills/github-create-pr/SKILL.md`, `.agents/skills/github-review-pr/SKILL.md`, `.agents/skills/github-merge-pr/SKILL.md`.
