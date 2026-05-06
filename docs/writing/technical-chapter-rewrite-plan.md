# Technical Chapter Rewrite Plan

Source learned from: `resources/博士开题报告-陈仁泽.pdf`

This note records the required rewrite strategy for Chapters 2-4. It is a planning and writing-control file, not report text.

## Diagnosis

The current technical chapters are still too close to extended summaries. They contain many correct facts, but most representative works are compressed into one subsection each. This makes the report read like a related-work survey instead of a doctoral proposal's completed-work chapters.

The reference report uses a different organization. For each completed work, it patiently develops:

1. local problem and motivation;
2. technical background and formal object;
3. system or method overview;
4. core components, representations, algorithms, or rules;
5. implementation and experimental evidence;
6. relation to the chapter's central problem;
7. local conclusion.

The key lesson is not to add more prose inside the existing flat sections. The section hierarchy itself must expose the technical method. A committee reader should be able to understand each work's technical contribution from the subsection tree before reading every paragraph.

## Reference Report Pattern

The completed-work chapters in the reference report repeatedly use the following shapes.

### Chapter 2 Pattern

The MAGIS chapter is organized as:

- chapter introduction;
- research background and motivation;
- design overview;
- analyzer;
- mutation rules;
- optimizer;
- experimental evaluation;
- related work;
- conclusion.

Inside method sections, it gives definitions and algorithms, such as computation graph model, memory model, D-Graph, F-Trans, F-Tree, M-Rules, incremental scheduling, and top-level search. The text introduces a problem before each technical object, then explains why that object is needed.

### Chapter 3 Pattern

The MoteNN chapter is organized as:

- introduction;
- preliminaries;
- methodology;
- core insight;
- workflow overview;
- axis connecting graph;
- sliding-window handling;
- optimization algorithm;
- experimental evaluation.

The important lesson is the "insight -> workflow -> formal object -> special case -> algorithm" sequence. It does not state "we optimize memory" and jump to results; it teaches the technical reader the exact abstraction that makes the method possible.

### Chapter 4 Pattern

The ArkVale chapter is organized as:

- related work and background;
- key observations;
- technical solution;
- system design;
- page summary and importance estimation;
- experiments.

The important lesson is that a concrete system section should expose runtime state, data structures, selection logic, and estimation formulae. A figure is used to carry the state-transition story.

## Required Rewrite Rule For This Report

Each important first-author or co-first-author completed work must become a miniature technical chapter inside its major chapter. A representative work section must not remain a single long `==` subsection. It should usually have `===` subsections:

- `研究背景与动机`
- `核心问题与设计目标`
- `方法概览`
- one to four concrete technical sections named by the work's actual abstractions
- `实现与实验评估`
- `小结：对本报告主线的意义`

For supporting works where the user is not first/co-first author, use a shorter but still technical structure:

- `问题定位`
- `技术框架`
- `结果与影响`
- `对后续工作的支撑`

The current "one work, one section" style is acceptable only for minor supporting works, and even there the section must include method and evidence rather than only claims.

## Chapter 2 Rewrite Skeleton

Chapter title remains: `面向领域定制的架构接口与端到端协同`.

### 2.1 引言

Keep the current framework -> what to customize -> microarchitecture constraints chain, but state that the chapter contains three representative technical systems.

### 2.2 ASIP/ISAX 端到端协同框架：APS 与 Aquas

This section is currently too compressed. Split it into two nested representative-work blocks or two major subsections:

#### 2.2.1 APS：统一 ISAX 接口与端到端 ASIP 工具链

Required substructure:

- `研究背景与动机`: RoCC/CV-X-IF protocol fragmentation, custom instruction usability problem.
- `APS-itfc 统一事务接口`: issue, GPR request, recall, memory read/write, memory response, result response, valid-ready transaction, backend adapters.
- `CADL 与 ISAX-specific synthesis`: CADL -> SIR -> SSIR, structured control, scheduling constraints, dynamic pipeline generation.
- `APS-c 编译支持`: semantic matcher, profile-guided matcher, bitwidth-aware vectorization, wrapper/intrinsic generation.
- `实验评估与意义`: PQC, BitNet, DSP cases; explain metric, baseline, and why results support toolchain co-design.

#### 2.2.2 Aquas：数据密集 ISAX 的硬件-软件协同优化

Required substructure:

- `研究背景与动机`: APS limitations for memory-centric ISAX, interface bandwidth, cache effects, robust matching.
- `core-ISAX memory interface model`: width, beat count, in-flight transactions, latency, cache-line facts.
- `Aquas-IR 三层表示`: functional, architectural, temporal levels.
- `硬件合成与访存接口选择`: scratchpad elision, interface selection/canonicalization, transaction scheduling/ordering.
- `编译器匹配与自动 offloading`: Polygeist/MLIR normalization, e-graph internal/external rewrites, skeleton-component matching, effect/ordering constraints.
- `实验评估与意义`: PQC, PCL, graphics, CPU LLM inference. Avoid only listing speedups; explain which technical mechanism each case validates.

### 2.3 可复用自定义指令识别：ISAMORE

ISAMORE must be no less detailed than APS/Aquas combined. Required substructure:

- `研究背景与动机`: reusable custom instructions, area/verification cost, syntactic hotspot limits.
- `问题建模与整体流程`: input domain programs, output Pareto instruction candidates, RIMT pipeline.
- `结构化 DSL`: Loop/If, Vec, App, pattern variables, type system, why ordinary expression e-graphs are insufficient.
- `E-graph anti-unification`: least general generalization over semantic equivalence space, reusable pattern discovery.
- `Phase-oriented RIMT`: ruleset phases, saturating/nonsaturating rules, pattern-application rewrites, explosion control.
- `智能 AU 与硬件感知选择`: smart AU, vectorization, cost model, HLS/RoCC backend, Pareto selection.
- `实验评估与意义`: benchmark/library/LLM/PQC evidence; connect reusable ISAX to agile chip design.

### 2.4 微架构感知定制：Cayman

Now that `resources/cayman` exists, this section must be rewritten from source, not metadata. Required substructure:

- `研究背景与动机`: candidate selection and hardware design are separated; prior DFG-only or sequential off-core accelerator flows miss control flow and data access.
- `整体框架`: LLVM IR, whole-application program structure tree, profiling/analysis, candidate selection, accelerator configuration, accelerator merging.
- `wPST 表示、profiling 与程序分析`: SESE regions, bb/control-flow regions, duration/count profiling, loop-carried dependency, stream access pattern, footprint analysis.
- `加速器建模与接口选择`: coupled, decoupled, scratchpad interfaces; control-flow optimization; performance/area estimation.
- `候选选择算法`: knapsack formulation over non-overlapping wPST subtrees, dynamic programming, Pareto/filtering, complexity.
- `加速器合并`: reusable accelerator, reconfigurable datapath, mux/config registers, FSM sharing, heuristic merging.
- `实验评估与意义`: comparison with NOVIA/QsCores; speedup under area budgets; interface specialization and merging area savings.

## Chapter 3 Rewrite Skeleton

Chapter title remains: `面向高质量硬件实现的前端抽象与综合优化`.

### 3.1 引言

State the chapter-level question: architecture capability must become synthesizable, verifiable, and high-quality hardware; this requires explicit frontends, IRs, timing semantics, microarchitecture attributes, mapping, and scheduling.

### 3.2 HECTOR：硬件综合基础设施积累

Supporting-work structure:

- `问题定位`: MLIR multi-level IR as early hardware synthesis infrastructure.
- `技术框架`: levels, lowering, relation to later Cement/Clay/SkyEgg.
- `影响`: why it matters as early framework accumulation, but do not expand like first-author work.

### 3.3 Cement：周期确定型硬件前端

Required substructure:

- `研究背景与动机`: why conventional HDL/HLS abstractions fail to express cycle behavior cleanly.
- `CmtHDL 与事件层`: event abstraction, hardware behavior expression.
- `ctrl 子语言与时序分析`: control constructs, timing analysis, cycle determinism.
- `FSM synthesis 与硬件生成`: lowering path and generated implementation.
- `实验评估与意义`: PolyBench, systolic, sparse cases; connect to reliable hardware frontend.

### 3.4 Clay：面向实现质量的 ASIP 前端与综合机制

Required substructure:

- `研究背景与动机`: ASIP frontends need microarchitecture-agnostic action specification but implementation-quality control.
- `action 抽象与微架构属性`: operation/action surface, attributes, separation of behavior and implementation.
- `CADL/接口与 coupling strategy`: relation to processor-accelerator integration and microarchitecture choices.
- `综合流程与实现质量控制`: how constraints guide generated hardware.
- `实验评估与意义`: Clay-core/Rocket-core and available evaluation evidence.

### 3.5 SkyEgg：变换、映射与调度联合优化

Required substructure:

- `研究背景与动机`: fixed HLS phase order loses cross-layer opportunities.
- `E-graph 设计空间`: algebraic transformation and hardware mapping candidates as rewrites.
- `调度式 extraction`: ILP formulation, mapping/scheduling legality and objective.
- `ASAP heuristic`: scalability and quality tradeoff.
- `实验评估与意义`: Vitis comparison, timing, resources, speedup; transition to EggMind strategy automation.

## Chapter 4 Rewrite Skeleton

Chapter title remains: `大模型与形式化技术驱动的软硬件协同方法`.

### 4.1 引言

Define the chapter-level question: LLM/agentic methods must operate on formal/compiler objects and evidence, not free text.

### 4.2 EggMind：E-graph 策略自动化

EggMind is the absolute focus and must become a detailed representative-work section:

- `研究背景与动机`: EqSat strategy bottleneck in ISAMORE/SkyEgg-style methods.
- `策略对象与 EqSatL`: ruleset partitioning, schedule construction, simplification control.
- `Agentic workflow`: Strategist, Generator, Evaluator, Partitioner, Simplifier, strategy repository.
- `Proof-derived motif memory`: proof extraction, motif abstraction, memory update, reuse.
- `Tractability guidance`: ruleset dependency/risk model, simplification hints.
- `实验评估与意义`: vectorization, XLA tensor compiler, EqMap logic synthesis; ablations; explain why it is formal + LLM co-design.

### 4.3 OriGen：大模型辅助 RTL 生成中的反馈闭环

Moderate-detail supporting structure:

- `问题定位`: open-source RTL generation limitations, privacy/customization/reproducibility.
- `数据增强`: code-to-code augmentation, teacher model, refined RTL.
- `编译反馈自反思`: VerilogFixEval, compiler error messages, repair training.
- `结果与启示`: use as feedback-loop evidence, not a main representative work.

### 4.4 协同边界与本章小结

Keep a synthesis section, but make it a real technical boundary discussion:

- what LLM owns;
- what formal/compiler objects own;
- how evidence and evaluator decide;
- how this motivates Chapter 5.

## Figure Requirements

The technical chapters should use figures aggressively but academically.

- For existing work, prefer figures already in `resources/<work>/fig*`, `fig_tex`, or paper sources.
- For each representative first/co-first work, include at least one figure if available:
  - APS/Aquas: framework/interface or compiler overview figures.
  - ISAMORE: RIMT overview, DSL/e-graph/AU or phase figure.
  - Cayman: framework, wPST, interface model, candidate selection, or merging figure.
  - Cement/Clay/SkyEgg: system/method overview figures.
  - EggMind: workflow/EqSatL/motif/evaluation figure.
- If the figure source is PDF, copy or reference it through `report/figures/` or a stable path and cite it in the caption.
- Do not insert decorative figures. Every figure must carry a method object, system architecture, algorithm flow, or evaluation result.

## Immediate Implementation Order

1. Rewrite Chapter 2 first, because Cayman source is now available and Chapter 2 is currently the largest mismatch.
2. Then rewrite Chapter 4, because EggMind is the absolute focus and should visibly follow the reference-report method/system/experiment pattern.
3. Rewrite Chapter 3 last, because it has more supporting-work balance constraints and needs careful space allocation between Cement, Clay, and SkyEgg.
4. After each chapter rewrite, run `make pdf`, inspect heading density, and commit separately.

## Quality Gate

Before a technical chapter is considered done, it must pass these checks:

- Does each representative work have its own technical subsection tree?
- Are the work's internal abstractions named in headings?
- Does each method section explain what problem forced the abstraction?
- Are algorithms, rules, or models described concretely rather than only named?
- Are experiments tied back to mechanisms, not only speedup numbers?
- Does the chapter ending explain how the work supports the report's central thesis?
- Are unsupported claims avoided or marked as residual risk?
