---
name: curate-bibliography
description: Add, validate, or audit bibliography entries for the thesis proposal without hallucinated metadata.
---

# Curate Bibliography

Use this when adding sources to `report/refs.bib`, checking citations, or building a bibliography audit trail.

## Workflow

1. Identify the report claim that needs a source.
2. Inspect the source directly: local PDF, local repository, official web page, DOI page, arXiv page, publisher page, or another primary metadata source.
3. Add or update the BibTeX entry in `report/refs.bib`.
4. Add or update `docs/writing/bibliography-audit.md` with:
   - citation key;
   - source location;
   - inspected evidence;
   - report claim supported;
   - metadata confidence;
   - remaining gaps.
5. Compile with `make pdf` if report citation syntax changed.

## Hard Rules

- Do not invent authors, venues, years, titles, DOIs, URLs, or page ranges.
- Do not cite a source that only loosely relates to the claim.
- Prefer primary metadata over secondary aggregators.
- If metadata is incomplete, mark the entry and audit note as incomplete instead of filling guesses.

## Output

Use `.agents/templates/bibliography-audit.md` for audit notes.
