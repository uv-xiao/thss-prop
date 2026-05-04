---
name: github-create-pr
description: Prepare and publish a GitHub PR for thesis proposal writing, citation, terminology, or harness changes.
---

# GitHub Create PR

Use this when publishing report work through GitHub.

## Workflow

1. Confirm the current branch is not the protected base branch unless the user explicitly wants direct push.
2. Run `git status --short --branch`.
3. Review changed files and classify scope: report text, bibliography, terminology, harness, resources, build config.
4. Run `make pdf` when report build can be affected.
5. Fill `.agents/templates/pr-body.md`.
6. Push the branch and create or update the PR.

## Guardrails

- Never force-push without explicit user approval.
- Never publish report changes with known broken citation syntax.
- Never hide unresolved citation or translation risks; put them in the PR body.
