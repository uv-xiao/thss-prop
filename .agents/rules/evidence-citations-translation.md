# Evidence, Citations, and Translation Rules

## Evidence Requirement

- Every factual claim about prior work, project behavior, industrial background, technical limitations, or evaluation results must be supported by one of:
  - a citation key in `report/refs.bib`;
  - a concrete local source path under `resources/`;
  - a command output recorded in the task or review notes;
  - a clearly marked author plan or hypothesis.
- Do not cite a paper, repository, standard, dataset, or report that has not been inspected.
- Do not infer paper claims from titles alone.
- When source access is partial, mark the claim as provisional and avoid making it central to the argument.
- Before expanding a representative work, inspect its local source materials under `resources/<work>/`, especially `README.md`, `main.tex`, `sec/`, `doc/`, `draft/`, `tex/`, figures, tables, and `refs.bib` where present.
- Record the source paths used for each expansion in task notes, citation audit notes, or the handoff summary.

## Bibliography Rules

- `report/refs.bib` is the authoritative bibliography.
- Every `.bib` entry must include enough metadata to identify the source: author/editor, title, year, venue or publisher when applicable, and DOI/URL/arXiv/repository URL when available.
- Every `.bib` entry must include a local evidence note outside the BibTeX syntax, or in a nearby audit file, explaining where the source was inspected and what report claim it supports.
- Do not keep unused references in `report/refs.bib` unless they are marked as reserve sources in `docs/writing/bibliography-audit.md`.
- Citation keys should be stable, ASCII, and descriptive, for example `lamport1986latex` or `github2025actions`.

## Translation and Technical Alignment

- Before translating a technical claim, identify the English source sentence, phrase, table, or code location being represented.
- Translate meaning, not word order. Preserve the technical relationship between subject, method, condition, and result.
- Preserve the source's representation mode for formal content. If the source presents a recurrence, constraint, objective, cost model, complexity bound, path delay equation, or table cell as mathematical notation, the report must typeset it as Typst math, including inside report tables. Use code formatting only for actual code identifiers, syntax examples, API names, or literal tool/package names.
- Preserve the source's table structure when reusing table evidence. Do not transpose, collapse, or summarize a source table into a different layout unless explicitly requested, required for page fit, or necessary for clear PDF rendering; if adaptation is necessary, preserve the original technical fields and grouping logic and explain the adaptation in the caption or surrounding prose.
- If the English term has multiple possible Chinese translations, add the choice to `docs/writing/terminology.md` with rationale.
- Never strengthen a source claim during translation. “May improve” cannot become “能够提升”; “prototype” cannot become “成熟系统”; “we evaluate” cannot become “已经证明”.
- If a source distinguishes system design, implementation, evaluation, and theory, keep those distinctions in Chinese.

## Citation Placement

- Place citations at the sentence or clause they support, not at the end of a long paragraph containing multiple claims.
- When a sentence names a specific paper, system, standard, or project as the source of the claim, place the citation immediately after that name. Example: `SkyEgg @skyegg2026 将……` rather than delaying `@skyegg2026` to the end of a long sentence.
- When a sentence synthesizes several works or supports a general claim rather than attributing a claim to one named work, place grouped citations immediately after the supported clause or sentence.
- Do not use a citation as a substitute for explanation. The surrounding sentence must state what the source contributes.
- For review sections, group related sources by question or method, not by a chronological list unless chronology is the argument.

## No Hallucination Gate

Before completing a writing task, check:

1. Are all named papers, systems, standards, projects, authors, and metrics present in a cited source or local resource?
2. Does each citation support the exact claim next to it?
3. Are English source claims translated without stronger modality?
4. Are uncertain facts marked as uncertain or removed?
5. Are bibliography entries syntactically valid enough for Typst/BibTeX processing?
