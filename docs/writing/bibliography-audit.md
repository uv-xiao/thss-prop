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

### hector2022

- Source: `resources/cement/refs.bib` entry `HECTOR`
- Additional sources: `resources/skyegg/doc/7_evaluation.tex`, `resources/cement/doc/7_Related_Work.tex`
- Accessed: 2026-05-06
- Evidence inspected: ICCAD 2022 metadata and abstract describing HECTOR as a two-level MLIR-based IR for hardware synthesis, with a high-level IR binding computation to timing-annotated control graph and a low-level IR for hardware modules and elastic interconnects; SkyEgg evaluation uses HECTOR as a baseline/native scheduling flow.
- Supports: Chapter 3 claims about HECTOR as early hardware synthesis infrastructure and a foundation for later MLIR/HLS/e-graph synthesis work.
- Metadata confidence: high for metadata from local BibTeX; use detailed method claims only at abstract level unless full paper is inspected.
- Open gaps: inspect full PDF before adding fine-grained HECTOR implementation details.

### clay2025

- Source: `resources/isamore/refs.bib` entry `peng_clay_2025`
- Additional sources: `resources/clay/sec/0_intro.tex`, `resources/clay/sec/1_preliminaries.tex`, `resources/clay/sec/2_methodologies.tex`, `resources/clay/sec/3_eval.tex`, `resources/clay/tex/framework.tex`, `resources/clay/tex/interface.tex`, `resources/clay/tex/code-transfrom.tex`, `resources/clay/tex/synthesis.tex`, `resources/clay/tex/sched.tex`, `resources/clay/tex/impl.tex`, `resources/clay/tex/eval-desc.tex`, `resources/clay/tex/eval-results.tex`, `resources/clay/fig/tab:exts-desc.tex`, `resources/clay/fig/tab:exts-ppa.tex`, `resources/clay/fig/tab:exts-e2e.tex`, `resources/clay/fig/tab:ablation-ppa.tex`, `resources/clay/fig/tab:base-compare.tex`
- Accessed: 2026-05-06
- Evidence inspected: full local LaTeX structure for Clay, including introduction, preliminaries, methodology, evaluation, framework/interface/synthesis/scheduling/implementation fragments, and evaluation tables. Source text supports claims about limitations of in-pipeline-only ASIP frameworks, unified instruction extension actions and microarchitectural attributes, CADL, HIR/LIR/RuleIR lowering, microarchitecture-aware coupling-strategy selection, ILP/modulo scheduling, finite-state hardware generation, Clay-core/Rocket-core evaluation, individual-kernel speedups, and EdgeDet/CFOEst workload results.
- Supports: Chapter 3 claims about Clay as a microarchitecture-aware ASIP framework and a major subsection for hardware frontend and synthesis optimization; detailed Clay section text, figures, and evaluation statements.
- Metadata confidence: high for local manuscript content and local BibTeX metadata; final publication details, pages, and DOI still need confirmation before bibliography freeze.
- Open gaps: verify final ICCAD 2025 proceedings metadata when the official record is available.

### skyegg2026

- Source: `resources/skyegg/doc/1_introduction.tex`
- Additional sources: `resources/skyegg/doc/2_background.tex`, `resources/skyegg/doc/3_overview.tex`, `resources/skyegg/doc/4_egraph.tex`, `resources/skyegg/doc/5_formulation.tex`, `resources/skyegg/doc/6_solving.tex`, `resources/skyegg/doc/7_evaluation.tex`, `resources/skyegg/doc/8_related_work.tex`, `resources/skyegg/fig/overview-p1.pdf`, `resources/skyegg/fig/egraph-p1.pdf`, `resources/skyegg/results/speedup_ilp_vs_asap.pdf`
- Accessed: 2026-05-05 and 2026-05-06
- Evidence inspected: local LaTeX source on hardware synthesis fragmentation, SkyEgg overview, MLIR-to-e-graph construction, mapping e-nodes and mapping rules, timing-property modeling, profile-based timing database, path-delay/chaining constraints, transformation- and mapping-aware ILP formulation, top-k path delays, ASAP scheduler, evaluation methodology, speedup/resource/timing/scalability results, and ablation framing.
- Supports: Chapter 1 and Chapter 3 claims about synthesis optimization fragmentation, e-graph-based joint transformation/mapping/scheduling, timing-aware mapping selection, ILP/ASAP solving tradeoffs, and reported performance/timing-closure results.
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

### cayman2025

- Source: `resources/cayman/main.tex`, `resources/cayman/doc/1_introduction.tex`, `resources/cayman/doc/3_methodology.tex`, `resources/cayman/doc/4_evaluation.tex`, and `resources/cayman/refs.bib`.
- Additional sources: `resources/aquas/refs.bib` entry `xiao_cayman_2025`; `resources/isamore/refs.bib` entry `xiao_cayman_2025`; ResearchGate metadata page; J-GLOBAL metadata page.
- Accessed: 2026-05-06
- Evidence inspected: title, DAC 2025 venue metadata, DOI, author list, introduction framing, methodology sections on wPST representation, profiling/program analysis, accelerator modeling, coupled/decoupled/scratchpad interfaces, dynamic-programming candidate selection, accelerator merging, implementation, and evaluation.
- Supports: Chapter 2 Cayman subsection claims about custom accelerator generation with control-flow/data-access optimization, whole-application program structure tree, processor-accelerator interface specialization, Pareto candidate selection, reusable accelerator merging, and reported speedups/area savings.
- Metadata confidence: high for local manuscript content and BibTeX-backed metadata; final camera-ready status should still be checked before final submission.
- Open gaps: verify final author order, page numbers, and official DOI formatting against the published DAC record before final bibliography freeze.

## External Technical And Industrial Sources

### tpuv4isca2023

- Source: https://arxiv.org/abs/2304.01433
- Accessed: 2026-05-06
- Evidence inspected: arXiv abstract and metadata for TPU v4 ISCA 2023, including authors, DSA framing, production ML workload changes, SparseCore embedding acceleration, 4096-chip supercomputer scale, and reported TPU v4 vs TPU v3 performance and performance/Watt improvements.
- Supports: Chapter 1 claims that AI/ML workload evolution drives industrial domain-specific architectures and that successful accelerators are full hardware-software systems rather than isolated chips.
- Metadata confidence: high for arXiv metadata and abstract; exact venue formatting can be refined later.
- Open gaps: inspect PDF before citing detailed system architecture beyond abstract-level claims.

### avo2026

- Source: https://arxiv.org/abs/2603.24517
- Accessed: 2026-05-06
- Evidence inspected: arXiv abstract and metadata for AVO, including agentic variation operators, autonomous coding-agent loop, lineage/domain-knowledge/execution-feedback inputs, attention kernels on NVIDIA Blackwell B200 GPUs, and reported gains over cuDNN and FlashAttention-4 in evaluated configurations.
- Supports: Chapter 1 and Chapter 5 claims that agentic search/evolution can be technically relevant to performance-critical kernel/compiler optimization when constrained by execution feedback and verification.
- Metadata confidence: high for arXiv metadata and abstract; precise benchmark claims should be rechecked in the PDF before final numeric discussion.
- Open gaps: inspect PDF for affiliations, exact benchmark matrix, hardware configuration, and limitations.

### alphaevolve2025

- Source: https://arxiv.org/abs/2506.13131
- Accessed: 2026-05-06
- Evidence inspected: arXiv abstract and metadata for AlphaEvolve, including evolutionary coding-agent framing, direct code edits by LLMs, evaluator feedback, Google computational-stack examples, and algorithmic discovery claims including the 4x4 complex matrix multiplication example.
- Supports: Chapter 1 claims about evaluator-constrained coding agents and the broader model-tool-evaluator loop.
- Metadata confidence: high for arXiv metadata and abstract; detailed examples should be checked in the PDF before final numeric discussion.
- Open gaps: inspect PDF for exact wording of infrastructure optimization and proof/correctness claims.

### openaiCodex2025

- Source: https://openai.com/index/introducing-codex/
- Accessed: 2026-05-06
- Evidence inspected: official OpenAI page describing Codex as a cloud-based software engineering agent, separate sandbox environments preloaded with repositories, file edits, command execution, test harnesses, linters, type checkers, citations to terminal logs and test outputs, and manual review requirement.
- Supports: Chapter 1 claims about agentic coding workflows relying on sandbox, tool use, tests, logs, and human review rather than unconstrained text generation.
- Metadata confidence: high for official product page; use as vendor/system evidence rather than peer-reviewed research result.
- Open gaps: add separate entries for GPT-5-Codex, Operator, or ChatGPT agent system cards only if final prose cites those pages directly.

### anthropicClaudeCode2026

- Source: https://docs.anthropic.com/en/docs/claude-code/overview
- Accessed: 2026-05-06
- Evidence inspected: official Anthropic documentation describing Claude Code as an agentic coding tool that operates from development environments and supports repository-oriented coding workflows.
- Supports: Chapter 1 claims that agentic coding has become an explicit engineering workflow with tool use and human oversight requirements.
- Metadata confidence: high for official documentation; use as vendor/system evidence, not peer-reviewed benchmark evidence.
- Open gaps: if final prose cites adoption or productivity numbers, inspect the Agentic Coding Trends Report PDF separately and add a separate citation key.

### pytorchCompile2026

- Source: https://docs.pytorch.org/docs/stable/generated/torch.compile.html
- Additional source: https://docs.pytorch.org/docs/main/user_guide/torch_compiler/torch.compiler.html
- Accessed: 2026-05-06
- Evidence inspected: official PyTorch documentation for `torch.compile`, including compiled-region caching, backend compilation, fallback behavior, and TorchDynamo graph capture through CPython frame evaluation.
- Supports: Chapter 1 claims that mainstream ML frameworks expose compilation-to-runtime boundaries through graph capture, graph breaks, backend compilation, recompilation, and fallback.
- Metadata confidence: high for official documentation; exact version number may change with PyTorch documentation updates.
- Open gaps: avoid citing performance claims unless tied to a stable paper or benchmark report.

### tensorrtllm2026

- Source: https://docs.nvidia.com/tensorrt-llm/
- Additional source: https://nvidia.github.io/TensorRT-LLM/
- Accessed: 2026-05-06
- Evidence inspected: official NVIDIA TensorRT-LLM documentation describing LLM inference acceleration and optimization on NVIDIA GPUs, runtime components, serving documentation, and integration topics.
- Supports: Chapter 1 claims that production LLM inference is a compiler-runtime system involving engine generation, runtime execution, serving integration, and performance-sensitive deployment mechanisms.
- Metadata confidence: high for official documentation; use as vendor/system evidence rather than peer-reviewed performance result.
- Open gaps: inspect versioned documentation pages before citing detailed feature lists or benchmark numbers.

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
