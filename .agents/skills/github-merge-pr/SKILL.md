---
name: github-merge-pr
description: Finalize or merge a GitHub PR and archive active writing feedback records.
---

# GitHub Merge PR

Use this when merging, closing, or cleaning up after a report PR.

## Workflow

1. Confirm PR number, title, and merge target.
2. Verify required checks or run `make pdf` locally if appropriate.
3. Ensure `docs/in_progress/human_words/` records relevant to the PR are either still active or archived.
4. If archiving, move records to `docs/archive/pr-<number>-<title-slug>/human_words/`.
5. Preserve a brief archive README with PR number, title, branch, and what writing preferences were learned.
6. Merge only after explicit approval or user instruction.

## Guardrails

- Do not delete human feedback records.
- Do not merge when known citation, terminology, or build blockers remain unless the user explicitly accepts them.
