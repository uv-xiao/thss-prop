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
  ctitle: "面向算力紧缺的敏捷芯片设计与编译协同创新",
  etitle: "Agile Chip Design and Compiler Co-Innovation for Compute-Constrained Systems",
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
    AI 与数据密集型应用快速演进，使算力需求、能效约束和软硬件生态构建成本同时上升。传统通用处理器难以持续满足领域应用的性能与能效需求，而领域定制芯片又面临设计、验证、综合和软件适配成本高企的问题。本文围绕“提升芯片设计与软件生态构建的系统生产力”这一目标，梳理本人在敏捷芯片设计与创新性编译技术方面的已有研究基础，并提出未来研究计划。

    已有工作形成了从应用需求到硬件实现、从编译适配到综合优化、从前端抽象到开源生态的协同链条：APS/Aquas 面向 ASIP 与 ISAX 构建端到端硬件-编译协同框架；ISAMORE 通过 e-graph anti-unification 自动发现跨程序可复用的自定义指令；Cement 以周期确定型 eHDL 提升 FPGA 硬件设计前端抽象；SkyEgg 将代数变换、硬件映射和调度统一到 e-graph 设计空间中进行联合优化；OriGen、HECTOR 及相关开源与教程工作进一步支撑 AI 辅助硬件设计、综合基础设施和生态推广。未来工作将围绕 IntelliC、Spine、EggMind 与 PTO Runtime distributed features，进一步探索可解释编译基础设施、验证约束下的 agentic 软硬件协同生成、自动化 e-graph 策略合成和异构任务图运行时协同。
  ],
  ckeywords: ("敏捷芯片设计", "软硬件协同", "编译器", "e-graph", "自定义指令", "高层综合"),

  eabstract: [
    This proposal studies agile chip design and compiler co-innovation for compute-constrained systems. The central goal is to improve system productivity across application-driven specialization, hardware generation, compiler retargeting, synthesis optimization, verification evidence, and open-source ecosystem construction.
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

= 绪论

== 研究背景

算力紧缺已经成为制约智能计算、数据密集型应用和边缘系统部署的核心问题之一。其矛盾并不只体现在单个芯片的峰值性能不足，也体现在应用演进速度、硬件设计复杂度和软件生态构建成本之间的张力：一方面，AI 推理、后量子密码、信号处理、点云处理和图形渲染等应用不断提出新的领域定制需求；另一方面，先进工艺收益放缓，芯片架构、验证、编译和运行时适配成本持续上升，使“算力供给”和“设计生产力”同时成为瓶颈。

领域定制处理器、FPGA 加速器和 RISC-V 自定义指令为突破能效限制提供了重要路径。RISC-V 的开放 ISA 允许设计者以 instruction-set extension 的方式把领域计算模式下沉到硬件中；FPGA 则以可重构性降低专用加速器的验证和部署门槛；MLIR、e-graph 与高层综合等编译技术为跨层优化提供了统一表达基础。然而，真正可用的领域定制系统并不是单点硬件模块，而是从应用识别、指令/微架构定制、硬件生成、编译映射、综合优化、运行时调度到验证证据的一整条工具链。

现有工具链在这条链上仍存在明显割裂。硬件侧，RTL 描述生产率低，HLS 的微架构可预测性和表达能力受限；编译侧，传统 pattern matching 难以适应复杂 ISAX 语义和程序变体；综合侧，代数变换、硬件映射和调度常被拆分为顺序启发式，导致质量损失；系统侧，AI agent 逐渐参与设计和编译，但缺乏明确语义边界、验证闭环和可审计证据。上述问题共同说明，未来的芯片设计方法需要从“单点加速”走向“可复用、可重定向、可验证、可协同”的系统生产力。

== 研究目标

本人的研究目标是围绕算力紧缺背景下的高能效计算与敏捷芯片设计，构建以创新性编译技术为核心的软硬件协同方法体系。该目标可分解为四个层次：

+ 在应用和架构之间，研究可重定向编译与端到端协同框架，使领域定制能力能够跨处理器接口、应用场景和工具链复用。
+ 在指令和微架构层，研究可复用自定义指令、微架构感知定制和自动化设计方法，降低领域定制对人工经验的依赖。
+ 在硬件前端和综合层，研究周期确定型硬件描述、综合中间表示和 e-graph 联合优化，提高从高层描述到高质量硬件实现的生产力。
+ 在未来系统层，研究面向人和 LLM agent 的可解释编译基础设施、验证约束下的软硬件协同生成、自动化优化策略和异构运行时协同。

= 国内外研究现状与挑战

== 领域定制处理器与软硬件协同

ASIP 和 ISAX 是提升领域应用能效的重要路线。商业 ASIP 工具能够提供较完整的处理器定制能力，但通常要求设计者在较低层次手工描述微架构行为，并依赖封闭工具链完成编译支持。开源 RISC-V 生态降低了处理器扩展门槛，但不同处理器和 SoC 框架使用 RoCC、CV-X-IF 等不同扩展接口，接口语义相似却难以互操作，导致相同指令扩展难以跨平台复用。

更关键的是，硬件定制必须与软件适配同步完成。简单标量或 packed SIMD 指令可以通过人工 intrinsic 或规则匹配使用，但面向 LLM、密码学和点云处理等数据密集型应用时，ISAX 可能包含复杂控制流、显式数据搬运、scratchpad 访问和接口相关时序。此时，传统编译器过早 lowering 会丢失高层语义，低层 IR 中的语法差异又会放大匹配空间，使自动映射变得脆弱。

== 硬件前端与综合优化

FPGA 与专用加速器设计长期面临前端抽象不足的问题。HDL 能精确表达硬件结构，但控制状态机、时序行为和资源交互往往需要大量手工实现。HLS 通过 C/C++ 提升描述层次，但软件顺序语义和硬件并行语义之间存在根本差异，设计者仍需通过 pragma 和工具启发式间接控制微架构，结果常常不可预测。

综合优化也存在类似割裂。传统 HLS 流程通常先做代数化简，再调度，最后绑定或映射硬件资源。对于现代 FPGA，DSP、BRAM、LUT 和 pipeline 配置共同决定时序与资源质量。若调度时不知道最终映射，容易保守；若映射时 schedule 已固定，又会错过更优的硬件组合。因此，综合方法需要在同一设计空间内同时考虑程序等价变换、硬件实现选择和调度。

== AI 辅助硬件设计与 Agentic 方法

LLM 为 RTL 生成、编译优化和设计自动化提供了新机会，但直接把自然语言交给模型生成 RTL 或优化 pass 容易带来三个问题：输入意图不完整，生成边界不清晰，验证滞后。硬件设计的正确性和性能依赖精确语义、时序约束、接口协议和执行证据，agent 必须在这些边界内工作。

因此，AI 辅助硬件设计的关键不只是提高模型生成能力，而是建立可读、可执行、可验证、可回放的中间表示与证据链。未来编译器和硬件生成框架需要让人和 agent 共享同一套语义对象、变换记录、验证 oracle 和运行时反馈。

= 已有研究基础

== 端到端协同与可重定向编译：APS 与 Aquas

本人围绕 ASIP 与 ISAX 软硬件协同，构建了 APS 与 Aquas 两条相互衔接的研究线。APS 面向敏捷 domain-specific processor 研究，针对接口分裂、ISAX-specific synthesis 和 compiler support 三个瓶颈，提出开放的硬件-软件协同框架。该框架抽象不同处理器扩展接口的共同语义，提供统一接口以支持 Rocket Chip/Chipyard 与 PULP/Croc 等平台；同时以 CADL 和 synthesis flow 支持与处理器交互、状态化行为和高低层描述混合；编译器侧则提供 pattern matching 与 bitwidth-aware vectorization，使应用能够自动利用自定义指令。

APS 的意义在于把自定义指令从“硬件模块实现”提升为“可端到端复用的协同框架”。在密码学、机器学习和 DSP 案例中，APS 对 NTT、NTT domain polynomial multiplication、BitNet BitLinear 和 DPLL 等任务实现了显著加速，其中 NTT 和多项式乘法分别达到最高 10.16x 和 14.99x，DPLL 最高达到 8.43x，且每个案例只需要较少的 ISAX 描述代码。

Aquas 进一步面向复杂数据密集 ISAX，补足 APS 在复杂接口、内存系统和 robust compiler mapping 上的能力。它在硬件侧以 memory-interface attributes 和 cache effects 为核心建模，通过 multi-level IR 携带访存机制、事务粒度和 scratchpad 决策；在编译侧利用 MLIR 结构表示与 e-graph 等价空间探索，在高层语义上做 skeleton-components matching，从而提高复杂 ISAX 自动映射的鲁棒性。Aquas 在后量子密码、点云处理、图形渲染和 CPU LLM 推理等案例中展示最高 15.61x kernel speedup 和 1.95x end-to-end speedup，并在面积约束下体现领域定制的能效优势。

这两项工作共同构成报告主线中的“协同框架层”：它们把应用、指令扩展、硬件生成和编译映射放在同一系统内，使定制能力具备跨应用、跨接口和跨平台复用的基础。

== 可复用指令定制：ISAMORE

RISC-V 让自定义指令更容易集成，但自定义指令占用核心面积，只有在多个程序片段或多个工作负载中复用，才具有系统价值。既有 instruction customization 方法多从热点出发枚举候选子图，重点优化单个程序片段的频繁执行，却难以发现语义等价但语法不同的跨程序模式。语法级合并容易生成过度特化的大指令，使用点少、面积收益差。

ISAMORE 的核心洞见是：自定义指令识别应当在程序等价空间中寻找可复用模式，而不是只在原始语法树中寻找相似子图。为此，ISAMORE 提出 reusable instruction identification 方法，利用 e-graph anti-unification 对经过 equality saturation 的程序表示进行泛化，发现至少在多个位置出现的共同语义结构。它进一步引入 structured DSL 作为 e-graph 的设计入口，用 phase-oriented iterative process 控制 EqSat 规模，用 smart AU 通过结构哈希、类型过滤和 pattern sampling 降低 anti-unification 复杂度，并结合 hardware-aware cost model、multi-objective selection 与 pattern vectorization 生成兼顾性能、面积和 data-level parallelism 的自定义指令。

评测显示，ISAMORE 在多个 benchmark 和真实开源库上超过不考虑复用性的指令定制基线，最高达到 2.69x；在不同领域开源库上相对 NOVIA 展示 1.17x-2.73x speedup，并通过 RoCC 加速器案例验证其在 quantized LLM inference 和 post-quantum cryptography 中的实际有效性。其学术意义在于把指令定制从人工经验驱动、热点驱动推进到语义复用驱动，为领域定制处理器提供了可自动化、可扩展的指令发现方法。

除 ISAMORE 外，本人在 Cayman 和 Clay 等工作中进一步探索自动加速器设计与微架构感知指令定制。Cayman 强调控制流与数据访问协同优化，Clay 强调将多样化微架构约束纳入指令定制框架。这些工作与 ISAMORE 共同支撑“指令/微架构定制自动化”方向。

== 硬件设计前端抽象：Cement 与 OriGen

敏捷芯片设计不仅需要更好的后端优化，也需要更高生产率、更可预测的硬件前端。传统 RTL 直接暴露连线和周期行为，适合精细优化，却要求设计者手工维护复杂 FSM 和跨周期控制；HLS 虽然提高抽象层次，但由于输入程序本质上是 untimed software，工具生成的硬件在微架构和性能上常常难以预测。

Cement 针对这一矛盾提出周期确定型 eHDL 与编译框架。其前端语言 CmtHDL 在标准 RTL 描述能力之外引入 event layer 和 control sub-language：event layer 捕获 guarded operations 及硬件组件连接，control sub-language 用过程化语句描述确定的跨周期行为。CmtC 编译器进一步提供 timing analysis 与 FSM synthesis，根据时序规范生成性能可预期、资源利用更高效的 FPGA 电路，并在编译期检测时序违例。

Cement 的评测显示，其在 PolyBench benchmark 上相对 HLS/DSL 工具获得 1.41x-3.49x speedup，并节省 23%-82% 资源；在 systolic array 和 sparse accelerator 案例中展示了对真实硬件设计的实用意义。该工作为敏捷硬件设计提供了一种中间路线：既不像 RTL 那样把控制实现细节完全交给人工，也不像 HLS 那样放弃对周期行为的直接表达。

在 AI 辅助硬件设计方面，OriGen 探索开源 RTL code generation 的数据和反馈闭环。它通过 code-to-code augmentation 利用知识蒸馏提升 RTL 数据质量，并通过 compiler feedback 构建 self-reflection 机制，使模型能够修复语法错误。实验显示，OriGen 在 VerilogEval-Human 上超过既有开源方案 9.8%，并在 VerilogFixEval 上相对 GPT-4 Turbo 展示 18.1% 的自反思修复优势。该工作说明，AI 辅助硬件设计需要数据质量、编译反馈和闭环修复共同支撑。

== 综合方法学与优化质量：SkyEgg 与 HECTOR

高层综合的质量瓶颈来自软件语义和硬件实现之间的多维选择。传统 HLS 把代数变换、调度和映射拆成顺序阶段：先做有限的程序变换，再基于粗略延迟估计调度，最后把操作绑定到 DSP、LUT 等资源。对于现代 heterogeneous FPGA，这种拆分会错过“某个代数变换正好启用更优硬件映射，而该映射又改变最优调度”的交叉机会。

SkyEgg 提出基于 e-graph 的 transformation- and mapping-aware scheduling。它将软件表达式、代数 rewrite 和 FPGA mapping candidates 统一编码在 e-graph 中，通过 equality saturation 构造联合设计空间，再把最终实现选择和调度表述为 e-graph 上的 ILP 问题，并提供 ASAP heuristic 提升可扩展性。这样，调度不再基于固定实现，映射也不再受预先 schedule 限制，二者可以在同一优化问题中共同决策。

评测中，SkyEgg 相对 Xilinx Vitis HLS 在多个 benchmark 上获得约 3.01x/3.10x 平均加速和最高 5.22x 加速，并保持有竞争力的资源使用；ASAP heuristic 能在较大规模设计上快速求解。该工作补足了从高层描述到高质量硬件实现的综合优化层，使 e-graph 不仅用于程序等价变换，也成为硬件实现选择与调度协同的统一表示。

在综合基础设施方面，本人还参与并推动 HECTOR 等基于 MLIR 的多层 IR 高层综合开源框架，支撑不同综合方法学的统一表达和可扩展优化。HECTOR 与 SkyEgg 形成“综合框架-优化技术”的组合：前者提供可复用 IR 与编译基础设施，后者探索联合优化方法学。

== 开源生态、专利与产学研协同

上述研究不仅形成论文成果，也逐步沉淀为开源工具链和可复用基础设施。事迹材料显示，本人围绕硬件设计方法与抽象形成两项发明专利：专利 202310967153.2“FPGA平台桥接HLS技术和硬件构造的芯片设计方法”（公布并进入实审），以及申请号 2025100662753“基于周期确定型硬件描述语义的FPGA硬件设计方法”（受理）。在生态推广方面，本人共同主讲或组织 ASP-DAC 2025、DATE 2025、ASPLOS 2025、ISEDA 2025、ASP-DAC 2026 等教程活动，持续推广开源工具链与方法体系；并参与国家重点研发计划相关课题、牵头校企合作项目推进落地验证，包括对华为 PTO 编译框架的开源贡献。

这些工作说明，本人的研究路线并非孤立论文集合，而是在持续构建“方法-工具-生态-落地”的链条。开源和教程活动扩大了方法复用范围，产学研协同则把工具链能力放入真实需求中检验。

= 未来研究计划

== 总体思路

已有研究已经覆盖应用驱动定制、编译映射、硬件前端、综合优化和部分 AI 辅助设计，但仍有三个关键问题需要继续推进。第一，编译器和硬件生成框架需要被人和 agent 共同理解、验证和扩展，而不是只作为黑盒优化器。第二，LLM agent 参与硬件与编译设计时，必须有明确语义边界、执行 oracle 和跨层证据，避免无约束生成。第三，e-graph 等强表达优化方法的效果高度依赖策略，未来需要自动化生成、迁移和验证优化策略。第四，硬件定制最终要进入异构设备和分布式任务图运行时，需要把编译、调度、数据移动和可观测性连接起来。

因此，未来工作将围绕 IntelliC、Spine、EggMind 与 PTO Runtime distributed features 展开，目标是把已有“软硬件协同设计”经验进一步推进到“可解释、可验证、可自动演化、可运行时落地”的系统方法。

== IntelliC：面向人和 Agent 的可解释编译基础设施

IntelliC 的目标是构建同时服务人类程序员和 LLM agent 的智能编译基础设施。其核心思想是将编译器表示拆分为 syntax 与 semantics：syntax 负责操作、区域、块、值、类型和规范文本；semantics 负责操作含义、执行/抽象解释、事实、事件和证据。编译动作统一记录在 TraceDB 中，使分析、rewrite、语义执行和 agent action 都能产生可追踪证据。

该方向将延续本人在 MLIR、e-graph、综合 IR 和可重定向编译方面的积累，重点解决两类问题：一是让编译器结构和语义足够可读，使人和 agent 能够共享同一套可验证对象；二是让编译变换从“直接修改 IR”转向“记录意图、产生证据、显式应用”的工作流。预期成果包括最小可执行 compiler slice、语义层 TraceDB、证据驱动的 rewrite/gate 机制，以及 agent 参与编译动作的安全边界。

== Spine：验证约束下的 Agentic 架构、硬件与编译协同生成

Spine 面向 architecture、hardware 和 compiler co-synthesis，目标不是一次性让 LLM 生成 RTL，而是把开放设计意图、算法假设、架构约束、编译需求、生成微架构、RTL、可执行代码和验证证据组织为可追踪的方法链。该框架强调 typed artifacts、deterministic semantic boundaries、executable oracles 和 cross-layer checks。

未来工作将把 Spine 作为验证约束下的 agentic 设计框架，研究从自然语言需求到统一语义边界的重构，从语义边界到受控微架构/RTL/编译 lowering 的 staged generation，以及 oracle、IR、RTL 和执行 trace 的一致性检查。该方向将吸收 Cement 的周期确定语义、OriGen 的 compiler feedback、IntelliC 的 TraceDB 和 APS/Aquas 的软硬件协同经验，形成“agent 可探索，但证据必须可验证”的设计闭环。

== EggMind：自动合成 E-Graph 优化策略

ISAMORE 和 SkyEgg 都表明，e-graph 能表达巨大的程序与硬件设计空间，但 equality saturation 的效果和资源消耗高度依赖策略。手工策略难以跨领域迁移，自动合成 rewrite rules 又可能进一步扩大搜索空间。因此，未来需要把 strategy 本身作为可显式表示、可评估、可复用的优化对象。

EggMind 将围绕 EqSatL、proof-derived rewrite motif caching 和 tractability guidance 展开：EqSatL 把 ruleset organization、schedule construction 和 e-graph simplification 表示为可检查 DSL；proof-derived memory 从成功优化中提取可复用 motif；tractability guidance 引导 LLM 避免不可控的 e-graph 爆炸。该方向预期在 vectorization、tensor graph optimization 和 logic synthesis 等场景中提升优化质量与资源效率，并为 ISAMORE、SkyEgg 等已有方法提供自动化策略层。

== PTO Runtime Distributed Features：异构任务图运行时协同

硬件和编译定制最终需要在真实异构设备中执行。PTO Runtime 已经提供面向 Ascend AICPU/AICore/Host 三类程序的 task dependency graph 执行框架，包含 host_build_graph 与 tensormap_and_ringbuffer 等运行时变体。未来 distributed features 将面向更复杂的任务图、跨设备调度、数据移动和可观测性。

该方向将研究如何把编译期生成的任务边界、数据依赖、设备约束和运行时调度策略连接起来，使软硬件协同不止停留在单核或单加速器层面，而能进入多设备、多层级 runtime。预期工作包括 distributed task graph 表示、跨设备 ready/completion 协议、TensorMap/RingBuffer 的分布式扩展、性能 profile 与编译反馈闭环，以及面向硬件仿真和真实设备的统一测试框架。

= 预期成果与计划安排

== 预期成果

预期在博士阶段后续研究中形成以下成果：

+ 面向人和 LLM agent 的可解释编译 IR、语义与证据基础设施。
+ 验证约束下的 agentic 软硬件协同生成框架，覆盖需求、语义、RTL、编译 lowering 和执行证据。
+ 可复用 e-graph 优化策略合成方法，服务指令定制、综合优化和 tensor/logic 优化。
+ 面向异构设备的 distributed runtime features，实现任务图执行、数据移动和运行时反馈。
+ 持续完善开源工具链、论文成果、教程材料和企业合作验证。

== 阶段计划

第一阶段，完善 IntelliC 的最小可执行编译器切片和 TraceDB 证据模型，形成可运行的语义执行、rewrite 和 pipeline 机制。

第二阶段，基于 Spine 构建从设计意图到 RTL/编译 lowering 的验证闭环，在小型但完整的硬件案例上打通 oracle、IR、RTL 和执行 trace。

第三阶段，推进 EggMind 的 EqSatL 与策略合成流程，将其接入 ISAMORE/SkyEgg 类优化任务，验证跨 benchmark family 的迁移能力。

第四阶段，围绕 PTO Runtime distributed features 构建跨设备任务图执行与 profile 反馈机制，把编译期优化和运行时调度连接起来。

= 总结

面向算力紧缺的芯片设计问题，本质上要求研究者同时理解体系结构、编译器、EDA、硬件描述、综合优化和运行时系统。本人已有工作围绕这一主线形成了较完整的技术基础：APS/Aquas 解决端到端协同和可重定向编译，ISAMORE 推进可复用指令定制，Cement 提升硬件前端抽象，SkyEgg 改善综合优化质量，OriGen/HECTOR 和开源生态工作进一步扩展 AI 辅助设计与基础设施影响。未来，IntelliC、Spine、EggMind 与 PTO Runtime distributed features 将把这条主线推进到更高层次的可解释、可验证、可自动演化和可运行时落地的软硬件协同体系。

#appendix()

= 待核验清单

+ 确认学院、专业、导师、开题报告格式要求和页数要求。
+ 确认各代表性工作的一作身份、正式会议状态和 BibTeX。
+ 补充 Cayman、Clay、HECTOR 的准确论文信息。
+ 安装 Typst CLI 后编译 `report/main.typ`，并根据 pkuthss 模板报错调整。

