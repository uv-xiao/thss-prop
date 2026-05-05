# Bibliography Audit

This file records evidence for bibliography entries and report claims. It is not rendered in the report.

## Audit Rules

- Add one entry for each citation key that supports a report claim.
- Record where the source was inspected.
- Record the exact claim type supported by the source.
- Mark incomplete metadata instead of guessing.

## Institutional Sources

## Local Work Sources

### aps2025

- Source: `resources/aps/sec/0_intro.tex`
- Accessed: 2026-05-05
- Evidence inspected: introduction on agile ASIP specialization, RISC-V ISAX integration, interface divergence across RoCC/CV-X-IF, ISAX-specific synthesis, compiler support, APS interface/synthesis/compiler flow, and case-study speedups.
- Supports: report introduction claims about RISC-V ASIP motivation, interface fragmentation, and the need for end-to-end hardware-software co-design.
- Metadata confidence: provisional; `report/refs.bib` entry still uses manuscript/local repository metadata and should be finalized later.
- Open gaps: final venue, author order, and publication status need confirmation.

### aquas2026

- Source: `resources/aquas/sec/0_intro.tex`
- Accessed: 2026-05-05
- Evidence inspected: introduction on edge ASIP demand, data-intensive ISAX memory-interface challenges, semantic gap in ISAX offloading, MLIR/Aquas-IR, e-graph-based robust mapping, case studies, speedup, and area data.
- Supports: report introduction claims about complex ISAX, memory-interface attributes, cache effects, scratchpad/access mechanisms, robust mapping, and data-intensive case studies.
- Metadata confidence: provisional; `report/refs.bib` entry still uses manuscript/local repository metadata and should be finalized later.
- Open gaps: final venue, author order, and publication status need confirmation.

### isamore2026

- Source: `resources/isamore/tex/1_introduction.tex`
- Accessed: 2026-05-05
- Evidence inspected: introduction on reusable custom instructions, low reusability of hotspot-driven instruction customization, semantic equivalence, e-graph anti-unification, structured DSL, phase-oriented process, smart AU, pattern vectorization, hardware-aware selection, and evaluation.
- Supports: report introduction claims about reusable custom instructions as a key mechanism and e-graph anti-unification as method innovation.
- Metadata confidence: provisional; `report/refs.bib` entry still uses manuscript/local repository metadata and should be finalized later.
- Open gaps: final venue, author order, and publication status need confirmation.

### cement2024

- Source: `resources/cement/doc/1_Introduction.tex`
- Accessed: 2026-05-05
- Evidence inspected: introduction on FPGA accelerator programming difficulty, RTL productivity limits, HLS unpredictability, cycle-deterministic eHDL, event layer, control sub-language, timing analysis, FSM synthesis, and evaluation.
- Supports: report introduction claims about hardware frontend productivity and predictability.
- Metadata confidence: provisional; `report/refs.bib` entry still uses manuscript/local repository metadata and should be finalized later.
- Open gaps: final venue and exact publication metadata need confirmation.

### skyegg2026

- Source: `resources/skyegg/doc/1_introduction.tex`
- Additional sources: `resources/skyegg/doc/2_background.tex`, `resources/skyegg/doc/8_related_work.tex`
- Accessed: 2026-05-05
- Evidence inspected: introduction on hardware synthesis, separation of algebraic transformation/scheduling/mapping, e-graph design-space representation, transformation- and mapping-aware scheduling, ILP/ASAP solving, and evaluation.
- Supports: report introduction claims about synthesis optimization fragmentation and e-graph-based joint optimization.
- Metadata confidence: provisional; `report/refs.bib` entry still uses manuscript/local repository metadata and should be finalized later.
- Open gaps: final venue, author order, and publication status need confirmation.

### origen2024

- Source: `resources/origen/1_Introduction.tex`
- Additional sources: `resources/origen/2_Background.tex`
- Accessed: 2026-05-05
- Evidence inspected: introduction and background on LLMs for Verilog generation, RTL dataset scarcity and quality, code-to-code augmentation, compiler-feedback self-reflection, VerilogFixEval, and open-source RTL model limitations.
- Supports: report related-work claims about AI-assisted RTL generation, dataset quality, compiler feedback, and self-reflection.
- Metadata confidence: provisional; `report/refs.bib` entry still uses manuscript/local repository metadata and should be finalized later.
- Open gaps: final venue, author order, and publication status need confirmation.

### eggmind2026

- Source: `resources/eggmind/tex/2_background.tex`
- Additional sources: `resources/eggmind/tex/8_related_work.tex`
- Accessed: 2026-05-05
- Evidence inspected: background and related work on equality saturation, strategy-guided EqSat, rule-space growth, expert-tuned schedules, guide-based methods, online search/controllers, LLM-guided optimization, EqSatL, proof-derived motifs, and tractability guidance.
- Supports: report related-work claims about EqSat strategy control and agentic compiler optimization.
- Metadata confidence: provisional; `report/refs.bib` entry still uses manuscript/local repository metadata and should be finalized later.
- Open gaps: final venue, author order, and publication status need confirmation.

### rightcapitalhq-chinese-style-guide

- Source: https://github.com/RightCapitalHQ/chinese-style-guide
- Accessed: 2026-05-05
- Evidence inspected: repository README sections on simplified Chinese, Mainland usage, Chinese-English spacing, punctuation, translation, numbers, and mixed-language style.
- Supports: project Chinese academic style and mixed-language formatting rules.
- Metadata confidence: high for web guidance, not currently included in `report/refs.bib`.
- Open gaps: not a thesis-writing standard; use only as style baseline.

### tsinghua-graduate-thesis-writing-guide-2023

- Source: https://www.dhs.tsinghua.edu.cn/wp-content/uploads/2023/12/2024031107044595.pdf
- Accessed: 2026-05-05
- Evidence inspected: guide states thesis should have correct wording, smooth language, reliable data, clear expression, and standardized figures, tables, formulas, and units; it references GB/T 7713.1 and GB/T 7714.
- Supports: evidence, formatting, reference, and academic writing constraints.
- Metadata confidence: high for institutional PDF, not currently included in `report/refs.bib`.
- Open gaps: report is an opening report, so use together with topic-report requirement.

### tsinghua-dhs-topic-report-requirements-2024

- Source: https://www.dhs.tsinghua.edu.cn/wp-content/uploads/2024/03/2024031808152596.pdf
- Accessed: 2026-05-05
- Evidence inspected: requirements for thesis topic report structure, body length no less than 5000 characters, research topic, literature review, research question and argument, methodology, outline, feasibility, schedule, references, and appendix.
- Supports: proposal argument structure and minimum length rules.
- Metadata confidence: high for institutional PDF, not currently included in `report/refs.bib`.
- Open gaps: target field may have additional advisor or committee requirements.
