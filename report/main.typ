// 开题报告初稿
// Build after installing Typst:
//   typst compile main.typ
//   typst compile main.typ --input alwaysstartodd=false

#import "@preview/modern-pku-thesis:0.2.3": appendix, conf

#show: conf.with(
  cauthor: "肖有为",
  eauthor: "Youwei Xiao",
  studentid: "2201111592",
  blindid: "TODO",
  cthesisname: "博士研究生开题报告",
  cheader: "北京大学博士研究生开题报告",
  ctitle: "敏捷芯片设计与创新性编译技术驱动的软硬件协同",
  etitle: "Hardware-Software Co-Design Driven by Agile Chip Design and Innovative Compilation Techniques",
  school: "TODO",
  cfirstmajor: "TODO",
  cmajor: "TODO",
  emajor: "TODO",
  direction: "敏捷芯片设计与编译技术",
  csupervisor: "TODO",
  esupervisor: "TODO",
  date: (year: 2026, month: 5),
  degree-type: "academic",

  cabstract: [
    AI 与数据密集型应用快速演进，使算力需求、能效约束、芯片设计生产力和软硬件生态构建成本同时成为系统瓶颈。领域定制计算能够提升性能与能效，但只有在架构接口、硬件实现、编译映射、验证证据和运行时反馈之间形成可复用闭环时，才能成为持续演化的系统能力。本文围绕“敏捷芯片设计与创新性编译技术驱动的软硬件协同”这一主题，系统梳理本人已有研究基础，并提出面向后续博士阶段的研究计划。

    已有工作分为三个层次：面向领域定制的架构接口与端到端协同，研究应用需求如何通过架构接口转化为可复用的指令、微架构和加速器能力；面向高质量硬件实现的前端抽象与综合优化，研究架构能力如何落到可综合、可验证、性能与资源可控的硬件实现；大模型与形式化技术驱动的软硬件协同方法，研究编译接口如何连接程序语义、硬件能力与验证反馈。未来工作将进一步围绕验证约束下的架构、硬件与编译协同生成，可解释、可审计的编译基础设施，以及面向工业级异构架构的算子优化与运行时编译协同，构建可解释、可验证、可自动演化、可运行时落地的软硬件协同系统闭环。
  ],
  ckeywords: ("敏捷芯片设计", "软硬件协同", "编译器", "e-graph", "自定义指令", "高层综合"),

  eabstract: [
    This proposal studies hardware-software co-design driven by agile chip design and innovative compilation techniques. The central goal is to improve system productivity across application-driven specialization, architecture interfaces, hardware generation, compiler retargeting, synthesis optimization, verification evidence, and runtime feedback.
  ],
  ekeywords: ("agile chip design", "hardware-software co-design", "compiler", "e-graph", "custom instruction", "HLS"),

  acknowledgements: [
    TODO: 正式版本补充致谢。
  ],

  bibcontent: read("refs.bib"),
  bibstyle: "numeric",
  bibversion: "2015",
  listofimage: false,
  listoftable: false,
  listofcode: false,
  alwaysstartodd: false,
)

= 引言

== 领域应用演进与领域定制计算趋势

本节目标：以综述形式建立产业与技术背景，说明 AI/LLM 工作负载、后量子密码、信号处理、点云处理、图形渲染等应用共同推动领域定制计算；同时区分“LLM 作为工作负载”和“LLM/agentic 作为工程自动化方法”两条线。

写作 TODO：
- 从算力需求、能效约束、先进工艺收益放缓和应用迭代速度共同进入，不写成泛泛“算力紧缺”。
- AI/LLM 是主线压力，PQC、DSP、点云、图形等作为多样性扩展。
- 简短引入 LLM/agentic 方法作为行业技术趋势，但只点出趋势，不展开方法细节。
- 证据采用关键转折处代表性例子，不默认放表格。

Source paths:
- `docs/writing/introduction-evidence-plan.md`
- `resources/aps/`
- `resources/aquas/`
- `resources/isamore/`
- `resources/compiler-infra-is-harness-medium.md`

== 芯片设计生产力瓶颈与敏捷设计路径

本节目标：先讲芯片设计生产力、验证成本和迭代速度瓶颈，再引出“敏捷芯片设计”。敏捷芯片设计定义为快速形成、验证、映射和迭代领域硬件能力，而不是单纯缩短 RTL 编写时间。

写作 TODO：
- 综述 ASIP/ISAX、RISC-V 扩展接口、FPGA/可重构加速器、HLS/硬件前端、AI 辅助硬件设计。
- 每类路线都写价值与局限，不提前展开本人工作。
- 将 agentic/LLM 方法作为设计自动化新兴路线之一，说明其面对 correctness、verification、maintainability、observability 风险。
- 用 OpenAI/Anthropic、NVIDIA AVO、Google AlphaEvolve、Siemens/Synopsys 等材料分清趋势证据、技术机制证据和 EDA 行业证据。

Source paths:
- `docs/writing/introduction-evidence-plan.md`
- `resources/cement/`
- `resources/origen/`
- `resources/compiler-infra-is-harness-medium.md`

== 跨硬件架构的软硬件协同生态与关键接口

本节目标：提出本报告的中心视角：软硬件协同不是单一硬件工具或单一编译优化集合，而是面向跨硬件架构的协同生态。架构接口定义硬件能提供什么能力，编译接口定义软件如何发现、使用、优化和验证这些能力，运行时反馈定义这些能力如何在工业系统中调度和演化。

写作 TODO：
- 明确定义架构接口：ISA/ISAX、微架构机制、存储层次、互连、加速器执行模型、运行时可见资源抽象。
- 明确定义编译接口：IR、lowering、pattern/rewrite、调度、代码生成、runtime API、profiling feedback。
- 写出“编译基础设施作为 agent harness medium”的腰部论断：agentic 方法必须通过 compiler-native objects、pass/action 边界、target contracts、semantic/executable checks、benchmark/trace evidence 进入协同流程。
- 绘制图 1：“跨硬件架构软硬件协同生态”。

Figure TODO:
- `figures/co-design-ecosystem.svg`：应用需求、架构接口、编译接口、硬件实现、综合/验证、运行时反馈、证据闭环。

Source paths:
- `resources/compiler-infra-is-harness-medium.md`
- `docs/writing/introduction-evidence-plan.md`
- `docs/writing/terminology.md`

== 面向协同接口的国内外研究现状

本节目标：以“协同接口”为主线综述国内外研究现状，为后三章现有工作和第五章未来工作建立评价坐标。不要按项目或论文名机械分类。

写作 TODO：
- 应用到架构：领域需求如何转化为架构、指令和微架构能力。
- 架构到硬件：架构能力如何转化为可综合、可验证、质量可控的硬件实现。
- 软件到编译：程序语义如何转化为可优化、可证明、可迁移的中间表示和优化空间。
- 编译到运行时：编译决策如何进入异构执行、调度、数据移动和性能反馈。
- 自动化方法：按 OpenAI/Anthropic -> AlphaEvolve -> NVIDIA AVO -> Agentic EDA/verification-agent -> 模型-工具-证据闭环的递进链条组织。
- 每类都采用“已有路线 -> 成熟点 -> 未解决问题”的结构。

Source paths:
- `docs/writing/introduction-evidence-plan.md`
- `resources/*/` 中各论文 related work
- `resources/compiler-infra-is-harness-medium.md`

== 核心科学问题与研究挑战

本节目标：把 1.1-1.4 的综述收束为三个核心科学问题。不要添加核心问题映射表。

三个核心问题：
1. 应用需求如何通过架构接口转化为可复用的指令、微架构和加速器能力；
2. 架构能力如何高质量落到可综合、可验证、性能与资源可控的硬件实现；
3. 编译接口如何连接程序语义、硬件能力和运行时反馈，形成跨硬件架构的可解释、可验证、可复用证据闭环。

写作 TODO：
- 连续论证，不列表格。
- 每个挑战要指向后续一个现有工作章或未来工作章。
- 第三个问题吸收“编译基础设施作为 harness medium”的思想，不把问题命名成 agent 问题。

== 已有研究基础与拟开展研究

本节目标：用一到两页说明后文章节安排，明确现有工作与未来工作边界。不另设“报告结构安排”小节。

写作 TODO：
- 第二章主要回应问题 1，并通过 ISAMORE 支撑问题 3。
- 第三章主要回应问题 2，并通过 HECTOR、Clay、SkyEgg 支撑问题 3。
- 第四章主要回应问题 3，并反向支撑问题 1、2。
- 第五章把三个核心问题合成为未来系统闭环。
- 绘制图 2：“研究问题与章节映射”。

Figure TODO:
- `figures/problem-chapter-map.svg`：三个核心问题、第二至第四章已有工作、第五章三个未来方向、主问题/次级支撑关系。

= 面向领域定制的架构接口与端到端协同

== 引言

本章目标：回答应用需求如何通过架构接口转化为可复用的指令、微架构和加速器能力。本章不是论文列表，而是“端到端协同框架 -> 定制什么 -> 微架构约束”的递进。

写作 TODO：
- 本章覆盖 APS、Aquas、ISAMORE、Cayman。
- 顺序固定为 APS/Aquas -> ISAMORE -> Cayman。
- ISAMORE 篇幅不得少于 APS/Aquas 合计篇幅。

== ASIP/ISAX 端到端协同框架：APS 与 Aquas

写作 TODO：
- APS：接口分裂、ISAX-specific synthesis、compiler support；统一接口、CADL/synthesis flow、compiler support、bitwidth-aware vectorization。
- Aquas：复杂数据密集 ISAX、memory-interface attributes、cache effects、robust compiler mapping；MLIR/Aquas-IR、多层 IR、e-graph/skeleton-components matching、硬件侧访存机制选择。
- 补充评估：案例、speedup、area、跨平台/跨应用复用。
- 小结 APS/Aquas 如何回答“如何把定制能力端到端接入工具链”。

Source paths:
- `resources/aps/`
- `resources/aquas/`
- `docs/writing/bibliography-audit.md`

== 可复用自定义指令识别：ISAMORE

写作 TODO：
- 说明自定义指令面积昂贵，必须跨程序和跨工作负载复用。
- 同等详细写两条线：可复用自定义指令作为敏捷芯片设计机制；e-graph anti-unification 作为方法创新。
- 详细展开 structured DSL、phase-oriented process、smart AU、pattern sampling、hardware-aware cost model、multi-objective selection、pattern vectorization。
- 补充 benchmark、开源库、RoCC 案例、PQC/LLM、speedup、area saving。

Source paths:
- `resources/isamore/`
- `docs/writing/bibliography-audit.md`

== 微架构感知定制：Cayman

写作 TODO：
- Cayman 是一作/共同一作工作，应作为本章重要子章节，不附带概括。
- 从 APS/Aquas/ISAMORE 的定制能力发现和接入，推进到微架构约束与实现协同。
- 需要先阅读资源后补充核心抽象、设计流程、工具链接口、微架构感知机制、实验指标。

Source paths:
- `resources/` 中 Cayman 相关材料，待定位。

== 本章小结

写作 TODO：
- 回到第一章问题 1。
- 说明本章如何支撑第三章的高质量硬件实现问题。

= 面向高质量硬件实现的前端抽象与综合优化

== 引言

本章目标：回答架构能力如何高质量落到可综合、可验证、性能与资源可控的硬件实现。

写作 TODO：
- 覆盖 HECTOR、Cement、Clay、SkyEgg。
- 顺序固定为 HECTOR -> Cement -> Clay -> SkyEgg。
- HECTOR 是早期技术框架积累，着重概括但不按一作代表性工作展开。

== 综合基础设施积累：HECTOR

写作 TODO：
- 概括 HECTOR 的 MLIR 多层 IR、高层综合基础设施和工具链支撑。
- 说明 HECTOR 如何为 Clay/SkyEgg 提供硬件 IR、综合流程组织或可扩展接口。
- 不详细展开实现细节，但不能简略带过。

Source paths:
- `resources/` 中 HECTOR 相关材料，待定位。

== 周期确定型硬件前端：Cement

写作 TODO：
- 说明 HDL/HLS/DSL/IR 的现状与局限。
- 展开 CmtHDL 的 event layer、control sub-language。
- 展开 CmtC 的 timing analysis、FSM synthesis。
- 补充 PolyBench、systolic array、sparse accelerator 等实验。

Source paths:
- `resources/cement/`

== 面向硬件实现质量的前端抽象与综合机制：Clay

写作 TODO：
- Clay 是一作/共同一作工作，应作为重要子章节。
- 不写成 Cement 的后续版本，而写成与 Cement 的分工互补：Cement 偏前端表达和周期确定性，Clay 偏实现质量与综合机制。
- 需要先阅读资源后补充问题背景、核心抽象、实现流程、实验结果。

Source paths:
- `resources/` 中 Clay 相关材料，待定位。

== 变换、映射与调度联合优化：SkyEgg

写作 TODO：
- SkyEgg 是本章方法高潮，并过渡到第四章 EggMind。
- 展开 HLS 顺序流程局限、e-graph 统一设计空间、mapping candidates as rewrite rules、ILP extraction as scheduling、ASAP heuristic。
- 补充评估结果和意义，不压缩 Clay 篇幅。

Source paths:
- `resources/skyegg/`

== 本章小结

写作 TODO：
- 回到第一章问题 2。
- 通过 SkyEgg 过渡到 e-graph 策略自动化和大模型/形式化方法。

= 大模型与形式化技术驱动的软硬件协同方法

== 引言

本章目标：说明大模型与形式化技术结合后，对软硬件协同方法体系和工具链能力的作用。EggMind 是绝对重点，OriGen 较为详细概括。

写作 TODO：
- 说明大模型具有生成、搜索和策略迁移潜力，但需要形式化语义、等价约束、可验证反馈和 tractability control。
- 引出 EggMind 与 OriGen 的不同定位。

== E-graph 策略自动化：EggMind

写作 TODO：
- 按完整现有工作展开：方法、系统、实验、意义。
- 背景：EqSat 表达巨大等价空间，但 rewrite space 和 e-graph growth 难控制。
- 方法：EqSatL、proof-derived rewrite motif caching、tractability guidance。
- 实验：从资源补充设置、基线、指标和结果。
- 与 ISAMORE/SkyEgg 的关系：EggMind 是策略层，服务已有 e-graph 优化任务。
- 与 AlphaEvolve 轻量对照：共同点是可执行/可验证反馈约束搜索；EggMind 更贴近编译优化和等价空间。

Source paths:
- `resources/eggmind/`
- `docs/writing/introduction-evidence-plan.md`

== 大模型辅助硬件生成中的形式化反馈：OriGen

写作 TODO：
- OriGen 作者位置靠后，只做较为详细概括，不按同等篇幅代表性工作展开。
- 说明 LLM 生成 RTL 的语义、时序、接口、可综合性要求。
- 展开 code-to-code augmentation、compiler feedback、self-reflection，以及数据质量和形式化检查相关机制。
- 连接未来“验证约束下的架构、硬件与编译协同生成”。

Source paths:
- `resources/origen/`

== 形式化约束与大模型能力的协同边界

写作 TODO：
- 总结大模型适合候选生成、搜索启发、策略归纳和跨任务迁移。
- 总结形式化技术适合语义边界、等价关系、反例反馈、优化空间约束和可复现证据。
- 为第五章三个未来方向提供问题定义。

== 本章小结

写作 TODO：
- 回到第一章问题 3。
- 引出仍未完成的系统闭环。

= 未来工作

== 未来工作总体目标

本章目标：把前三章现有工作提炼出的剩余问题组织为三个概括性未来方向，构建可解释、可验证、可自动演化、可运行时落地的软硬件协同系统闭环。

写作 TODO：
- 说明第五章不是项目列表，而是从已有工作自然推出的剩余矛盾。
- 三个方向顺序固定：验证约束下的架构、硬件与编译协同生成；可解释、可审计的编译基础设施；面向工业级异构架构的算子优化与运行时编译协同。

== 验证约束下的架构、硬件与编译协同生成

写作 TODO：
- Spine 是该方向已有基础或原型，但小节标题不用 Spine。
- Spine 既承接 APS/Aquas 的端到端协同框架，也是 OriGen 所代表的大模型硬件生成方法向系统级协同生成的延伸。
- 展开 semantic boundary、typed artifacts、staged hardware generation、staged compiler lowering、executable oracle、cross-layer checks。

Source paths:
- `resources/spine/`
- `resources/compiler-infra-is-harness-medium.md`
- `resources/aps/`
- `resources/aquas/`
- `resources/origen/`

== 可解释、可审计的编译基础设施

写作 TODO：
- IntelliC 是本方向主要未来工作载体，但标题和论证对象是可解释、可审计的编译基础设施。
- 使用“目标事实 -> 显式 IR 与语义契约 -> 受约束变换 -> 可执行后端产物 -> 证据与反馈”的论证链。
- 展开 syntax/semantics 分离、TraceDB、rewrite/gate 证据、agent action 安全边界。
- 说明 Spine 提供架构/硬件目标描述与证据，IntelliC 提供编译生成、验证和证据组织层。

Source paths:
- `resources/IntelliC/`
- `resources/compiler-infra-is-harness-medium.md`

== 面向工业级异构架构的算子优化与运行时编译协同

写作 TODO：
- 本方向采用并列双子线组织，不写成上下游闭环绑定。
- 子线一：工业级异构架构上的芯片算子自动优化，重点来自 `resources/seed-proposal.docx`，包括复杂 fused 算子、Torch 训练/推理算子、长程 Agent Harness、IR/Pass/profiling/形式化辅助优化和回归验证。
- 子线二：运行时分布式协同，重点来自 PTO Runtime distributed features，包括任务图执行、异构设备边界、数据移动、ready/completion protocol、TensorMap/RingBuffer 扩展和可观测性。
- 写 AVO 时作为“方向正确但问题仍未被系统解决”的外部证据，不写成窄义 baseline 或竞品。

Source paths:
- `resources/seed-proposal.docx`
- PTO Runtime distributed features 相关资源，待定位。
- `docs/writing/introduction-evidence-plan.md`

== 集成路线、里程碑与风险控制

写作 TODO：
- 阶段 1：验证约束下协同生成的小型硬件案例 oracle-IR-RTL-codegen 闭环。
- 阶段 2：可解释编译基础设施的最小可执行 compiler slice 和证据模型。
- 阶段 3：推进核心 fused 算子与 Torch 算子的长程自动优化 Harness，以及 PTO Runtime distributed features 的运行时任务图协同、数据移动和可观测性。
- 阶段 4：跨层案例整合与论文/开源输出。
- 风险与对策：语义边界过大、agent 生成不可控、运行时依赖真实硬件、评估指标不统一；从小闭环开始、使用 typed artifacts、以可执行 oracle 和 trace 为核心证据。

= 结论

写作 TODO：
- 重申核心矛盾：领域应用演进与芯片/编译/软件生态生产力不足。
- 总结三章现有工作如何构成技术基础。
- 总结未来工作如何从现有基础推进到系统闭环。
- 点明预期贡献：方法体系、工具链能力和可验证软硬件协同能力。

#appendix()

= 待核验清单

+ 确认学院、专业、导师、开题报告格式要求和页数要求。
+ 确认各代表性工作的一作身份、正式会议状态和 BibTeX。
+ 补充 Cayman、Clay、HECTOR 的准确论文信息。
+ 安装 Typst CLI 后编译 `report/main.typ`，并根据 pkuthss 模板报错调整。
