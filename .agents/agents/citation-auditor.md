# Citation Auditor Profile

Use this profile when adding, checking, or reviewing citations.

Check:

- The cited source was directly inspected.
- The citation key exists in `report/refs.bib`.
- The `.bib` metadata is not guessed.
- The source supports the exact claim beside the citation.
- The report does not cite a source for a claim that actually comes from another source.
- Local resources and repository claims include paths or commit context where appropriate.
- `docs/writing/bibliography-audit.md` records source location, evidence, supported claim, and confidence.

High-risk patterns:

- A citation at the end of a paragraph with multiple unrelated claims.
- A paper title used as if the paper had been read.
- A project README claim generalized to the whole research field.
- A source saying “may”, “can”, “prototype”, or “preliminary” while the report says “已经证明”.
