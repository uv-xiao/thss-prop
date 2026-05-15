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

## Internal Future-Work Sources

### compiler-infra-is-harness-medium

- Source: `resources/compiler-infra-is-harness-medium.md`
- Accessed: 2026-05-06
- Evidence inspected: argument that compiler infrastructure is a natural intelligent-agent collaboration medium when target facts, explicit IR/semantic contracts, constrained transformations, executable backend artifacts, and evidence/feedback are organized as first-class objects.
- Supports: Chapter 1 and Chapter 5 claims about compiler infrastructure as the interface between hardware facts, program semantics, verification evidence, and intelligent-agent automation.
- Metadata confidence: internal design memo; cite only as project rationale, not as external publication.

### spine2026

- Source: `resources/spine/docs/story.md`, `resources/spine/docs/design/layer-01-delta-oracle-execution.md`, `resources/spine/docs/design/layer-04-gcd-validation-pipeline.md`
- Accessed: 2026-05-06
- Evidence inspected: semantic boundary, typed Delta actor/task surface, oracle execution, trace stream, alignment reports, and GCD Delta-to-RTL validation pipeline.
- Supports: Chapter 5 future-work claims about verification-constrained architecture/hardware/compiler co-generation and staged executable evidence; cited when the report names the Spine internal prototype.
- Metadata confidence: internal prototype documentation; keep clear distinction between implemented foundation and future vision.

### intellic2026

- Source: `resources/IntelliC/docs/design/compiler_framework.md`, `resources/IntelliC/docs/design/compiler_semantics.md`, `resources/IntelliC/docs/design/agent_harness.md`
- Accessed: 2026-05-06
- Evidence inspected: `IR := Sy + Se`, MLIR/xDSL-style syntax, first-class semantic definitions, TraceDB facts/events, compiler actions, fixed vs agent action boundaries, and repository harness design.
- Supports: Chapter 5 future-work claims about intelligent-agent compiler infrastructure and collaboration over compiler-native objects; cited when the report names the IntelliC internal prototype.
- Metadata confidence: internal design documentation; do not cite as external prior work.

### seed-proposal

- Source: `resources/seed-proposal.docx`
- Accessed: 2026-05-06
- Evidence inspected: project plan for chip-operator automatic optimization agents, architecture/operator/candidate/verification/performance-feedback loop, Torch training/inference operator scope, and 2026.06--2027.06 milestone structure.
- Supports: Chapter 5 future-work claims and schedule for industrial heterogeneous operator optimization.
- Metadata confidence: internal planning document; use for future work, not external evidence.

### pto-runtime

- Source: `resources/pto-runtime/README.md`, `resources/pto-runtime/src/a5/runtime/tensormap_and_ringbuffer/docs/RUNTIME_LOGIC.md`, `resources/pto-runtime/src/a5/runtime/tensormap_and_ringbuffer/docs/profiling_levels.md`
- Accessed: 2026-05-06
- Evidence inspected: host/AICPU/AICore three-program model, TensorMap dependency tracking, RingBuffer flow control and back-pressure, scheduler/orchestrator roles, ready/completion protocol, profiling levels, PMU/runtime trace and failure diagnostics.
- Supports: Chapter 5 future-work claims about runtime-distributed collaboration, task graph execution, and runtime evidence feedback for compiler/operator optimization.
- Metadata confidence: internal prototype documentation; keep implementation details tied to source paths.

## External Technical And Industrial Sources

### mlir2021

- Source: https://arxiv.org/abs/2002.11054
- Accessed: 2026-05-06
- Evidence inspected: title, authors, CGO 2021 metadata, and abstract describing MLIR as an extensible multi-level compiler infrastructure.
- Supports: Chapter 1 claims about MLIR as a foundation for multi-level IR, compiler infrastructure, and cross-layer optimization.
- Metadata confidence: high for arXiv and proceedings metadata; DOI/page formatting can be refined before final submission.

### riscv2019

- Source: https://riscv.org/technical/specifications/
- Accessed: 2026-05-06
- Evidence inspected: official RISC-V specifications page and unprivileged ISA manual reference.
- Supports: Chapter 1 claims about RISC-V as an open ISA ecosystem that lowers barriers for instruction extension and architecture experimentation.
- Metadata confidence: high for manual identity; use official manual URL rather than inferred DOI.

### calyx2021

- Source: https://arxiv.org/abs/2102.09713
- Accessed: 2026-05-06
- Evidence inspected: title, author list, abstract, and ASPLOS 2021 framing of Calyx as a compiler infrastructure for accelerator generators.
- Supports: Chapter 1 claims about hardware IR and accelerator-generator infrastructure as part of the architecture-to-hardware interface.
- Metadata confidence: high for paper identity; final DOI can be added later.

### polygeist2021

- Source: https://research.google/pubs/polygeist-raising-c-to-polyhedral-mlir/
- Accessed: 2026-05-06
- Evidence inspected: title, authors, PACT 2021 metadata, and summary that Polygeist raises C into polyhedral MLIR.
- Supports: Chapter 2 Aquas compiler-flow claims about using Polygeist to lift software code into MLIR.
- Metadata confidence: high for Google Research page metadata.

### tate2009eqsat

- Source: ACM DOI `10.1145/1480881.1480915`
- Accessed: 2026-05-06
- Evidence inspected: title, authors, POPL 2009 identity, and equality saturation concept.
- Supports: Chapter 1 and Chapter 4 claims about equality saturation as a compiler optimization method.
- Metadata confidence: high for DOI and proceedings metadata.

### egg2021

- Source: https://arxiv.org/abs/2004.03082
- Accessed: 2026-05-06
- Evidence inspected: title, authors, POPL/PACMPL metadata, and abstract describing `egg` as a fast and extensible equality saturation library.
- Supports: Chapter 1 claims about e-graphs, equality saturation, and scalable optimization infrastructure.
- Metadata confidence: high for arXiv/PACMPL metadata.

### tpuv4isca2023

- Source: https://arxiv.org/abs/2304.01433
- Accessed: 2026-05-06
- Evidence inspected: arXiv abstract and metadata for TPU v4 ISCA 2023, including authors, DSA framing, production ML workload changes, SparseCore embedding acceleration, 4096-chip supercomputer scale, and reported TPU v4 vs TPU v3 performance and performance/Watt improvements.
- Supports: Chapter 1 claims that AI/ML workload evolution drives industrial domain-specific architectures and that successful accelerators are full hardware-software systems rather than isolated chips.
- Metadata confidence: high for arXiv metadata and abstract; exact venue formatting can be refined later.
- Open gaps: inspect PDF before citing detailed system architecture beyond abstract-level claims.

### nvidiaGB200NVL72

- Source: https://www.nvidia.com/en-us/data-center/gb200-nvl72/
- Accessed: 2026-05-06
- Evidence inspected: official NVIDIA GB200 NVL72 product page, including rack-scale NVLink/NVLink Switch positioning and 72-GPU system framing.
- Supports: Chapter 1 and Chapter 5 claims that LLM systems push optimization from chip-local kernels to rack-scale heterogeneous systems and interconnect-aware runtime/compiler interfaces.
- Metadata confidence: high for official product overview; avoid detailed performance claims not repeated in the report unless inspected in a whitepaper.

### cloudmatrix3842025

- Source: https://arxiv.org/abs/2506.12708
- Accessed: 2026-05-06
- Evidence inspected: arXiv metadata and abstract for serving LLMs on Huawei CloudMatrix384.
- Supports: Chapter 1 and Chapter 5 claims about industrial-scale heterogeneous AI systems and programming/runtime concerns beyond single-device optimization.
- Metadata confidence: high for arXiv identity; detailed architecture claims should be checked in the PDF before final numeric discussion.

### ubmesh2025

- Source: https://arxiv.org/abs/2503.20377
- Accessed: 2026-05-06
- Evidence inspected: arXiv metadata and abstract for UB-Mesh as a datacenter network architecture.
- Supports: Chapter 1 and Chapter 5 claims that cluster interconnect topology and communication paths are part of the compilation-runtime optimization context.
- Metadata confidence: high for arXiv identity; detailed topology claims should be checked in the PDF before final numeric discussion.

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

## Related-work Bibliography Batch for Chapter 1 Survey

This batch was added to support the expanded Chapter 1 related-work survey. Entries were copied or normalized from local source-paper bibliographies under `resources/`, then cited in Chapter 1 at the interface-level claims they support. Metadata confidence is high when DOI/publisher/arXiv information was present in the local BibTeX entry, and medium when the entry is a vendor documentation page or an incomplete local bibliography entry.

### rocket2016

- Source: `resources/aps/refs.bib` entry `asanovic2016rocket`.
- Evidence inspected: APS related-work discussion uses Rocket/RoCC as a representative RISC-V custom coprocessor interface and SoC generator context.
- Supports: Chapter 1 claim that RoCC/Rocket represents one important RISC-V custom-instruction integration path.
- Metadata confidence: high for local technical-report metadata.
- Open gaps: none for the current broad interface claim.

### corevxif2025

- Source: `resources/aps/refs.bib` entry `CORE-V-XIF`; also referenced in `resources/aps/sec/5_related_works.tex`.
- Evidence inspected: APS related-work section identifies CV-X-IF as a core-specific RISC-V instruction-extension interface.
- Supports: Chapter 1 claim that instruction-extension interfaces differ across RISC-V ecosystems.
- Metadata confidence: medium; documentation page rather than paper.
- Open gaps: verify latest official documentation URL if final report needs version-specific details.

### nice2024

- Source: `resources/aps/refs.bib` entry `nice`; also referenced in APS related-work interface list.
- Evidence inspected: NICE appears as a representative instruction co-unit extension interface.
- Supports: Chapter 1 claim about RISC-V extension interface diversity.
- Metadata confidence: medium; vendor documentation page.
- Open gaps: year is documentation/access-based, not publication year.

### picorv32pcpi2020

- Source: `resources/aps/refs.bib` entry `pcpi`; URL normalized from local BibTeX.
- Evidence inspected: APS related-work section lists PCPI among decoupled instruction-extension interfaces.
- Supports: Chapter 1 claim about RISC-V custom-instruction interface families.
- Metadata confidence: medium; repository/documentation source.
- Open gaps: use only for interface existence, not performance or standardization claims.

### scaiev2022

- Source: `resources/aps/refs.bib` entry `scaie-v`; also present in `resources/aquas/refs.bib` and `resources/clay/refs.bib`.
- Evidence inspected: APS, Aquas, and Clay related-work discussions use SCAIE-V as a portable RISC-V ISA-extension interface.
- Supports: Chapter 1 claim that portable ISAX interfaces attempt to reduce core-specific engineering effort.
- Metadata confidence: high; DOI and DAC metadata present.
- Open gaps: none for current claim.

### longnail2024

- Source: `resources/aps/refs.bib` entry `longnail`; also present in `resources/aquas/refs.bib`, `resources/cayman/refs.bib`, and `resources/clay/refs.bib`.
- Evidence inspected: APS/Aquas/Clay discussions compare Longnail as an ASIP/ISAX synthesis framework.
- Supports: Chapter 1 claim that ASIP frameworks link architecture description and hardware generation but differ in interface and microarchitectural scope.
- Metadata confidence: high; DOI and ASPLOS metadata present.
- Open gaps: none for current survey claim.

### assist2019

- Source: `resources/aps/refs.bib` entry `assist`.
- Evidence inspected: APS related-work section lists ASSIST under agile ASIP design frameworks; local entry contains DAC metadata.
- Supports: Chapter 1 claim about behavior-level/functional-specification based RISC-V processor generation.
- Metadata confidence: high; DOI present.
- Open gaps: local source key name was `assist`; report key normalized to `assist2019`.

### synopsysASIPDesigner, cadenceTensilica, codasipStudio

- Sources: `resources/aps/refs.bib` entries `asipdesigner` and `tensilica`; `resources/clay/refs.bib` entry `codasip_codasip_nodate`.
- Evidence inspected: APS and Clay related-work sections use these commercial suites as representative proprietary ASIP design toolchains.
- Supports: Chapter 1 claim that commercial ASIP suites integrate architecture description and design automation but are proprietary/vendor-bound.
- Metadata confidence: medium; vendor documentation pages.
- Open gaps: use as toolchain examples, not peer-reviewed technical results.

### novia2021

- Source: `resources/cayman/refs.bib` entry `NOVIA`; also referenced by `resources/isamore/tex/7_related_work.tex`.
- Evidence inspected: Cayman and ISAMORE related-work sections use NOVIA as a non-conventional inline accelerator / syntactic merging baseline.
- Supports: Chapter 1 claim that prior custom-instruction/accelerator methods include coarse-grained or syntactic merging approaches.
- Metadata confidence: high; DOI and MICRO metadata present.
- Open gaps: none for current survey claim.

### ccores2010

- Source: `resources/cayman/refs.bib` entry `CCORES`; also discussed in ISAMORE related work.
- Evidence inspected: Cayman/ISAMORE cite Conservation Cores as coarse-grained mature-computation acceleration.
- Supports: Chapter 1 claim that prior work includes function/loop/coarse-region style specialization.
- Metadata confidence: high; DOI present.
- Open gaps: none for current claim.

### qscores2011

- Source: `resources/cayman/refs.bib` entry `QSCORES`.
- Evidence inspected: Cayman related work treats QsCores as off-core/quasi-specific cores for energy-efficient specialization.
- Supports: Chapter 1 claim about coarse-grained accelerator generation and quasi-specific cores.
- Metadata confidence: medium; local entry lacks DOI/pages.
- Open gaps: add DOI/page data later if final bibliography quality target requires complete proceedings metadata.

### finder2020

- Source: `resources/cayman/refs.bib` entry `FINDER`; also present in `resources/isamore/refs.bib`.
- Evidence inspected: ISAMORE and Cayman use FINDER as a representative parallel custom-instruction identification method.
- Supports: Chapter 1 claim that prior work explores parallel instruction identification for ASIP acceleration.
- Metadata confidence: high; DOI present.
- Open gaps: none for current survey claim.

### dahlia2020, spatial2018, aetherling2020

- Source: `resources/cement/refs.bib` entries `Dahlia`, `Spatial`, and `Aetherling`; also discussed in `resources/cement/doc/2_Background_Motiviation.tex`.
- Evidence inspected: Cement background compares these DSLs/languages as efforts to improve FPGA programming predictability, expressiveness, or streaming/data-parallel accelerator generation.
- Supports: Chapter 1 claim that hardware DSLs try to bridge abstraction and implementation but remain constrained by expressiveness/domain assumptions.
- Metadata confidence: high; DOI and PLDI metadata present.
- Open gaps: none for current survey claim.

### firrtl2017

- Source: `resources/cement/refs.bib` entry `FIRRTL`; also present in `resources/aquas/refs.bib`.
- Evidence inspected: Cement related-work section lists FIRRTL among hardware IRs; Aquas references it in the broader hardware compiler infrastructure context.
- Supports: Chapter 1 claim about hardware IRs and compiler frameworks supporting transformations.
- Metadata confidence: high; DOI present.
- Open gaps: none for current claim.

### circt2021

- Source: `resources/cement/refs.bib` entry `CIRCT`; also present in `resources/aquas/refs.bib`.
- Evidence inspected: Cement and Aquas related work use CIRCT as the collection of MLIR-based circuit IR compilers and tools.
- Supports: Chapter 1 claim about MLIR/CIRCT hardware infrastructure.
- Metadata confidence: medium; repository/documentation source.
- Open gaps: cite only for infrastructure existence unless a specific CIRCT paper is later selected.

### verilogeval2023, verigen2023, rtlcoder2023, rtlfixer2023, autochip2023

- Source: `resources/origen/references.bib` entries `verilogeval`, `verigen`, `rtlcoder`, `rtlfixer`, and `autochip`.
- Evidence inspected: OriGen introduction and background/related-work sections compare Verilog generation datasets, open-source RTL generation models, and compiler-feedback repair systems.
- Supports: Chapter 1 claim that LLM hardware generation depends on dataset quality, benchmark construction, and compiler/simulator feedback rather than one-shot text generation.
- Metadata confidence: medium to high; VerilogEval has ICCAD metadata; several others are arXiv/preprint entries in local bibliography.
- Open gaps: fill DOI/venue details later if these become central evidence rather than survey examples.

### isaria2024

- Source: `resources/aquas/refs.bib` entry `thomas_automatic_2024`; also discussed in `resources/eggmind/tex/2_background.tex`.
- Evidence inspected: EggMind positions Isaria as expert-tuned strategy/schedule evidence for EqSat/vectorizing compiler generation.
- Supports: Chapter 1 claim that EqSat strategy/schedule design is a key compiler-automation problem.
- Metadata confidence: high; DOI and ASPLOS metadata present.
- Open gaps: none for current survey claim.

### enumo2023

- Source: `resources/aquas/refs.bib` entry `pal_equality_2023`; also discussed in `resources/eggmind/doc/related_work_scan.md`.
- Evidence inspected: EggMind related-work scan uses Enumo as rule/theory exploration evidence.
- Supports: Chapter 1 claim that rule automation expands rewrite vocabularies but does not solve reusable strategy control by itself.
- Metadata confidence: high; DOI present.
- Open gaps: none for current survey claim.

### diospyros2021

- Source: `resources/isamore/refs.bib` entry `vanhattum_vectorization_2021`.
- Evidence inspected: ISAMORE related work cites Diospyros as an EqSat-based vectorization system exploiting existing parallel instructions.
- Supports: Chapter 1 claim that equality saturation has been used to search vectorized DSP code and compiler optimizations.
- Metadata confidence: high; DOI and ASPLOS metadata present.
- Open gaps: none for current survey claim.

### seer2024

- Source: `resources/aquas/refs.bib` entry `cheng_seer_2024`; also discussed by SkyEgg related work.
- Evidence inspected: SkyEgg and EggMind related-work contexts use SEER as HLS/e-graph super-optimization evidence.
- Supports: Chapter 1 claim that e-graph rewriting is being applied to high-level synthesis and compiler optimization.
- Metadata confidence: high; DOI and ASPLOS metadata present.
- Open gaps: none for current claim.

### esyn2024, emorphic2025

- Source: `resources/isamore/refs.bib` entries `chen_e-syn_2024` and `chen_e-morphic_2025`.
- Evidence inspected: ISAMORE/SkyEgg/EggMind related-work contexts use these as logic-synthesis/e-graph examples.
- Supports: Chapter 1 claim that equality saturation has entered EDA optimization beyond software-level compiler rewriting.
- Metadata confidence: medium; arXiv metadata in local bibliography.
- Open gaps: add final venue details when stable if report cites them as central evidence.

### eqmap2025

- Source: `resources/eggmind/refs.bib` entry `hofmann_eqmap_2025`; also discussed in EggMind related work and case study.
- Evidence inspected: EggMind uses EqMap as an e-graph FPGA LUT remapping and logic-synthesis comparison point.
- Supports: Chapter 1 claim that e-graphs are used for FPGA technology mapping and synthesis tasks.
- Metadata confidence: high for local IEEE/ACM metadata; current year/venue are future-dated relative to some source snapshots but consistent with local entry.
- Open gaps: verify proceedings metadata before final submission if needed.

### lakeroad2024

- Source: `resources/aquas/refs.bib` entry `smith_fpga_2024`; also discussed by SkyEgg related work.
- Evidence inspected: SkyEgg related work lists Lakeroad among program-synthesis/e-graph adjacent FPGA mapping methods for complex primitives.
- Supports: Chapter 1 claim that technology mapping to FPGA primitives is an active e-graph/program-synthesis-adjacent research area.
- Metadata confidence: high; DOI and ASPLOS metadata present.
- Open gaps: none for current survey claim.

### aspen2025

- Source: `resources/eggmind/refs.bib` entry `Zhang2025ASPENLE`; also summarized in `resources/eggmind/doc/related_work_scan.md`.
- Evidence inspected: EggMind related-work scan positions ASPEN as LLM-guided e-graph rewriting for RTL datapath optimization.
- Supports: Chapter 1 claim that LLM/e-graph combinations are emerging in EDA but need bounded, reusable, auditable strategy mechanisms.
- Metadata confidence: high for local DOI/MLCAD metadata.
- Open gaps: none for current survey claim.

### related-work-reservoir-batch-2026-05-06

- Source: `docs/writing/related-work-bibliography.md` and `docs/writing/related-work-bib-reservoir.bib`, generated from source-paper introduction/background/related-work sections under `resources/`.
- Evidence inspected: 24 source sections yielded 286 distinct local citation keys, 280 locally resolved entries, and thematic grouping for application-to-architecture, architecture-to-hardware, software-to-compilation, compilation-to-runtime, and LLM/formal automation.
- Promoted entries: `clark_processor_2003`, `clark_automated_2005`, `pozzi_exact_2006`, `aditya_automatic_1999`, `goulding-hotta_greendroid_2011`, `AccelSeeker`, `Trireme`, `VitisHLS`, `Dynamatic`, `AutoDSE`, `ScaleHLS`, `Chisel`, `BSV`, `Filament`, `LegUp`, `nandi_rewrite_2021`, `cao_babble_2022`, `smith_scaling_2024`, `cai2025smoothe`, `dave`, `chipchat`, `chipgpt`, `betterv`, and `sweagent`.
- Supports: Chapter 1's expanded related-work survey. The first group supports the custom-instruction/custom-accelerator lineage; the second group supports hardware language/HLS/IR organization; the third group supports rule generation, abstraction learning, and e-graph extraction/scalability; the fourth group supports LLM-based hardware generation and agentic software-engineering context.
- Metadata confidence: medium to high. Entries were copied from local source-paper `.bib` files and checked against the sections that cite them. Some preprint and workshop entries have intentionally incomplete DOI or venue metadata because the local source entry is incomplete.
- Open gaps: before final submission, verify metadata for preprint/workshop entries that remain cited centrally; unresolved source keys remain listed in `docs/writing/related-work-bibliography.md`.

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

### zotero-related-work-batch-2026-05-11

- Source: `/Users/uvxiao/Zotero/zotero.sqlite` read with `immutable=1&mode=ro`, plus local PDF attachments under `/Users/uvxiao/Zotero/storage/`.
- Parsing method: Zotero item metadata came from `items`, `itemData`, `itemDataValues`, `fields`, `itemCreators`, `creators`, `collections`, `collectionItems`, `tags`, `itemTags`, and `itemAttachments`; `storage:<filename>` attachment paths were resolved as `/Users/uvxiao/Zotero/storage/<attachment item key>/<filename>`.
- Evidence inspected: generated candidate pool in `docs/writing/zotero-related-work-candidates-2026-05-11.md`; inspected Zotero abstracts and first two PDF pages with `pdftotext` for promoted entries.
- Promoted entries: `tensorright2025`, `argus2026`, `flashinfer2025`, `ncclep2026`, `tritondistributed2025`, `streamtensor2025`, `act2025`, `eqsatdialect2025`, `dialegg2025`, `gpukernelagentsol2026`, `pagedattention2023`, `abstractiongap2025`, `tilelang2025`, `trinity2026`, `allo2024`, `solexecbench2026`, `ksearch2026`, and `mscclpp2026`.
- Supports: Chapter 1.4's expanded related-work survey. The batch supplements compiler-native equality saturation and tensor rewrite verification, composable accelerator/AI-kernel programming abstractions, industrial LLM serving and communication abstractions, and agentic GPU-kernel optimization evidence.
- Metadata confidence: medium to high. Titles, authors, years, DOI/URL fields came from Zotero metadata and were cross-checked against local PDFs where available. Some `@misc` preprint and future conference entries may need final venue normalization before submission.
- Open gaps: if any promoted source becomes central evidence rather than survey support, revisit its publisher/arXiv page or DOI page to normalize venue, pages, and final publication year.
