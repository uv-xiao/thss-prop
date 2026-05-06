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

高性能计算系统正在同时面对两类压力：一类来自应用本身，另一类来自系统构建方式。前者表现为 AI/LLM、后量子密码、信号处理、点云处理、图形渲染等领域持续产生新的计算、访存和控制模式；后者表现为芯片设计、编译适配、验证和运行时生态构建的成本不断上升。二者叠加后，算力瓶颈不再只是单个芯片的峰值性能问题，而是应用需求增长、能效约束、硬件迭代速度和软件生态生产力共同造成的系统性矛盾。

AI/LLM 是当前最强的产业压力。以 TPU v4 为例，Google 将其定位为面向快速变化的机器学习模型的第五代领域专用架构，并在系统层面结合可重构互连、嵌入加速和云端部署环境；论文报告 TPU v4 相对 TPU v3 获得 2.1x 性能提升和 2.7x performance/Watt 提升，4096 芯片系统规模也使其成为面向大模型训练和推理的系统级基础设施 @tpuv4isca2023。这样的工业系统说明，领域定制计算的价值并不只来自某个算术单元，而来自架构、编译、互连、运行时和部署环境的共同设计。

AI/LLM 之外，后量子密码、信号处理、点云处理和图形渲染等场景进一步说明领域定制不是单点趋势。不同领域的热点结构、访存粒度、控制模式和数据复用方式不同：后量子密码强调数论变换、多项式运算和位级/字级操作，点云处理和图形渲染强调不规则数据布局与几何结构，信号处理强调流式计算、向量化和数据通路复用。APS、Aquas 和 ISAMORE 的问题背景均来自这种应用多样性：开放 RISC-V 和 ASIP 生态为自定义能力提供了硬件入口，但真正的挑战在于如何把不同应用中的可复用模式识别出来，并通过架构接口、硬件实现和编译工具链稳定接入系统 @aps2025 @aquas2026 @isamore2026。

因此，领域定制计算的趋势可以概括为两个转变。第一，硬件能力从通用核外的单点加速器，转向可通过架构接口表达、可由编译器发现和使用、可在不同平台迁移的系统能力。第二，优化对象从单个 kernel 或单个模块，转向应用语义、存储层次、指令/微架构机制、编译映射和运行时反馈的联合空间。这个趋势为“敏捷芯片设计”提出了更高要求：硬件创新不仅要能快速生成，还要能快速验证、映射、复用和迭代。

与此同时，LLM/agentic 方法正在成为另一条技术革新线索。这里需要区分 LLM 的两重角色：一方面，LLM 作为工作负载推动异构算力系统和领域专用架构发展；另一方面，LLM/agentic 方法作为工程自动化方式，正在改变软件开发、编译优化和系统构建流程。OpenAI 对 Codex 的系统说明显示，软件工程 agent 已经从代码补全扩展到独立 sandbox、代码修改、命令执行、测试和日志证据的工作流 @openaiCodex2025。这一趋势本身并不能直接证明芯片设计可以完全自动化，但它提示复杂工程流程正在从“人手工编辑产物”转向“人、模型、工具和证据共同协作”的形态。对于芯片设计与编译优化，这种变化只有在后续章节所讨论的架构接口、编译基础设施和验证证据支撑下才可能可靠落地。

== 芯片设计生产力瓶颈与敏捷设计路径

领域定制计算带来性能和能效机会，也放大了芯片设计生产力瓶颈。传统芯片设计流程高度依赖人工经验：架构设计者需要决定哪些应用模式值得硬化，硬件工程师需要实现和验证 RTL，编译器工程师需要提供指令选择、数据布局、调度和运行时接口，系统工程师还要保证这些能力能够在真实软件栈中被稳定调用。随着应用变化加快，硬件设计若仍以长期手工迭代为主，就很难支撑快速演进的领域需求。

本报告所说的“敏捷芯片设计”，并不是简单缩短 RTL 编写时间，而是快速形成、验证、映射和迭代领域硬件能力。它包含四个环节：从应用中发现值得硬化或优化的模式；通过架构接口把这些模式表达为可复用硬件能力；通过硬件前端、综合和验证流程生成质量可控的实现；通过编译和运行时系统使软件能够自动发现、调用和反馈这些能力。只有四个环节同时成立，领域定制硬件才不会停留在一次性实验模块，而能进入可复用的系统生产力链条。

现有技术路线各有价值，也各有局限。ASIP 和 ISAX 允许设计者在保持处理器可编程性的同时加入领域能力，RISC-V 生态进一步降低了指令扩展和处理器实验门槛；但不同扩展接口、SoC 框架和编译路径之间仍存在割裂，导致同一硬件能力难以跨平台复用 @aps2025。FPGA 和可重构加速器提供了比 ASIC 更快的验证与部署路径，但底层 RTL 开发成本高，而 HLS 虽提高抽象层次，却常以 pragma 和工具启发式间接控制微架构，生成结果的可预测性和可解释性仍然不足 @cement2024。硬件 IR、MLIR、e-graph 等编译基础设施为统一表示和跨层优化提供了基础，但如果缺少稳定的语义契约和证据记录，优化结果仍难以跨任务、跨平台和跨工具链迁移。

AI 辅助设计和 agentic 方法为生产力问题提供了新的可能。AlphaEvolve 将 LLM 组织为 evolutionary coding agent，通过直接修改代码并接受 evaluator 反馈来迭代改进算法，在 Google 的计算基础设施优化和算法发现任务中展示了“模型 + 工具 + evaluator”闭环的潜力 @alphaevolve2025。NVIDIA AVO 进一步把类似思想推进到性能敏感的 kernel/compiler optimization：它用 autonomous coding agent 替代固定 mutation、crossover 和手工启发式，在 Blackwell B200 GPU 的 attention kernel 优化中利用 lineage、domain knowledge 和 execution feedback 生成、修复、批判和验证实现修改 @avo2026。这些工作说明，agentic 方法的关键不只是模型能生成代码，而是模型能在可执行评价、领域知识和反馈约束中持续改进产物。

然而，芯片设计比一般软件工程和单一 kernel 优化更强调语义正确性、时序约束、接口协议、可综合性和长期维护。直接让模型生成 RTL、编译 pass 或调度策略，容易把设计意图、目标约束和验证结果混在自然语言或临时代码中，难以审计和复用。因此，敏捷芯片设计中的 agentic 自动化不能脱离架构接口、硬件 IR、编译基础设施和验证 oracle。它需要被放在可解释、可检查、可回放的系统中，成为受约束的协同机制，而不是不可控的代码生成器。

== 跨硬件架构的软硬件协同生态与关键接口

由上述趋势可见，本报告讨论的软硬件协同不是“同时设计软件和硬件”的宽泛说法，也不是若干编译优化和硬件生成工具的并列集合。它指向的是跨硬件架构的协同生态：应用需求通过架构接口转化为硬件能力，软件语义通过编译接口转化为可映射、可优化、可验证的执行形式，硬件实现通过综合和验证流程形成可部署产物，运行时反馈再把真实执行行为带回编译和架构设计。这个生态的关键不在单次生成一个模块或单次优化一个程序，而在于能否形成可复用、可解释、可验证、可持续演化的系统闭环。

在这个生态中，架构接口首先定义“硬件能够提供什么能力”。它不仅包括 ISA 或 ISAX，也包括微架构机制、存储层次、互连、加速器执行模型和运行时可见资源抽象。一个领域能力若不能通过架构接口稳定表达，就难以被编译器发现和利用；一个架构接口若只描述指令格式而不描述访存路径、执行约束和系统边界，也很难支撑复杂数据密集型应用。APS 和 Aquas 的问题意识正来自这一点：领域定制处理器需要统一扩展接口、硬件合成机制和编译支持，而复杂 ISAX 还需要把 memory-interface attributes、cache effects、scratchpad 和事务粒度等目标事实纳入协同设计 @aps2025 @aquas2026。

编译接口则定义“软件如何发现、使用、优化和验证这些能力”。它覆盖 IR、lowering、pattern/rewrite、调度、代码生成、runtime API 和 profiling feedback 等层次。编译器在这里不是后端附属工具，而是连接应用语义、架构能力、硬件实现和运行时行为的中间层。ISAMORE 通过 e-graph anti-unification 在程序等价空间中发现可复用指令模式，SkyEgg 将代数变换、硬件映射和调度放入统一 e-graph 设计空间，EggMind 进一步尝试把 LLM 的策略生成能力放入形式化可控的 EqSat 策略对象中 @isamore2026 @skyegg2026 @eggmind2026。这些工作共同说明，编译接口不仅决定“能否生成代码”，还决定“哪些硬件能力能被系统性发现、证明和复用”。

随着 agentic 方法进入工程自动化，编译基础设施还需要承担新的 harness medium 角色。其基本关系可以概括为：目标事实进入显式 IR 与语义契约，受约束变换生成可执行后端产物，语义检查、测试、benchmark 和 trace 再形成证据与反馈。这个判断可以推广到本报告的核心主张：agentic 方法只有通过 compiler-native objects、pass/action 边界、target contracts、semantic/executable checks 和 benchmark/trace evidence 进入流程，才可能可靠服务软硬件协同。否则，模型生成的硬件或编译改动即使局部可运行，也难以解释为什么正确、为什么适配目标硬件、如何跨任务复用、如何在运行时反馈后继续演化。

因此，跨硬件架构软硬件协同的关键不在于某一个硬件模块、某一条自定义指令或某一次编译优化，而在于通过架构接口定义可复用硬件能力，通过编译接口连接软件语义、硬件实现与运行时反馈，并在形式化语义、执行证据和自动化工具链支撑下形成可持续演化的系统闭环。后续章节将围绕这一判断展开：第二章讨论应用需求如何经由架构接口转化为可复用定制能力，第三章讨论这些能力如何落到高质量硬件实现，第四章讨论大模型与形式化技术如何进入可验证优化流程，第五章提出面向未来的系统闭环。

#figure(
  rect(width: 100%, height: 18em, stroke: gray + 0.8pt)[
    #align(center + horizon)[
      图示占位：跨硬件架构软硬件协同生态。正式版本将绘制应用需求、架构接口、编译接口、硬件实现、综合/验证、运行时反馈和证据闭环之间的关系。
    ]
  ],
  caption: [跨硬件架构软硬件协同生态示意图（待绘制）],
)

== 面向协同接口的国内外研究现状

前文从应用压力、设计生产力和协同生态三个角度说明了本报告的研究背景。进一步看，国内外相关研究并不是沿着单一技术线索展开，而是围绕若干关键协同接口逐步形成：应用需求如何进入架构设计，架构能力如何进入硬件实现，软件语义如何进入编译优化，编译决策如何进入运行时系统，以及自动化方法如何在模型、工具和证据之间形成受约束闭环。按这些接口梳理现状，可以更清楚地看到已有路线的成熟部分，也能避免把软硬件协同简化为若干工具的横向罗列。

第一类研究关注应用到架构的接口，即如何把领域应用中的计算、访存和控制模式转化为指令、微架构或加速器能力。领域专用架构、ASIP、RISC-V 自定义指令、张量/矩阵加速单元和领域特定加速器均属于这一方向。它们已经证明，在应用模式相对清晰时，定制硬件能够显著提升性能与能效；开放 RISC-V 生态和 SoC 生成框架也降低了指令扩展与体系结构实验门槛 @aps2025 @aquas2026。工业界 TPU v4 等系统进一步说明，面向 AI/LLM 的领域定制不仅是单芯片优化，而是芯片、互连、编译、运行时和云端部署共同形成的体系结构能力 @tpuv4isca2023。

这一接口的核心未解问题在于“可复用表达”。许多领域定制工作仍依赖专家从热点代码或特定 kernel 中抽取定制能力，容易得到过度专用的硬件单元；不同处理器扩展接口、访存路径和执行模型之间也缺少统一抽象，使同一能力难以跨 SoC、跨应用和跨编译工具链迁移。已有 ASIP 框架开始尝试把接口、合成和编译支持放入端到端流程，但复杂数据密集应用还要求设计者同时刻画 cache effect、scratchpad、事务粒度和内存带宽约束；可复用自定义指令识别则进一步要求从程序等价空间中发现具有跨程序价值的语义模式，而不是只合并局部语法相似片段 @aquas2026 @isamore2026。

第二类研究关注架构到硬件的接口，即架构能力如何落到可综合、可验证、性能与资源可控的硬件实现。传统 RTL 提供精细控制，但生产力不足；HLS 提高了抽象层次，却常通过 pragma 和工具启发式间接控制微架构，导致结果预测困难；硬件 DSL、硬件 IR 和 MLIR/CIRCT 生态则尝试在可编程抽象、时序语义、结构化 IR 与后端综合之间建立更稳定的工程界面。相关工作已经表明，把硬件设计对象从文本 RTL 提升到结构化 IR 和可分析控制/数据流，有助于进行跨层优化、自动生成和验证集成 @cement2024 @skyegg2026。

但这一方向仍面临质量闭环不足的问题。架构接口表达的“能力”往往包含隐含时序、资源共享、流水线、存储访问和协议约束；如果硬件前端不能显式表达这些事实，后续综合只能在不完整信息下搜索实现。另一方面，代数变换、实现选择、调度和资源约束常被放在不同工具阶段中处理，导致前一步看似合理的变换在后一步形成不良时序或资源结果。SkyEgg 等工作把变换、映射和调度纳入统一 e-graph 设计空间，说明硬件实现质量需要从“先优化表达、再交给综合”的顺序流程，转向语义变换与实现代价共同参与的联合优化 @skyegg2026。

第三类研究关注软件到编译的接口，即程序语义如何转化为可优化、可证明、可迁移的中间表示和优化空间。现代编译基础设施已经不再只是后端代码生成器，而是应用语义、目标硬件事实和优化证据之间的中介。MLIR 多层 IR、e-graph、等式饱和、自动向量化、pattern/rewrite 系统和 retargetable compiler construction 均试图把高层程序中的语义信息保留到足够靠后的阶段，使编译器能够针对不同硬件能力进行合法且可解释的选择 @isamore2026 @eggmind2026。

这一接口的难点在于同时满足语义保真、优化空间规模和目标适配。过早 lowering 会丢失循环、代数结构、数据布局和领域约束，使后端只能在低层表示上做局部优化；而过于宽泛的重写空间又会造成搜索爆炸，难以保证策略可迁移、结果可解释。e-graph 相关方法的价值在于把语义等价表达为可检索、可抽取、可证明的空间，但它仍需要目标事实、代价模型和策略控制，否则容易形成“正确但不可用”或“可用但不可扩展”的优化过程 @isamore2026 @eggmind2026。因此，编译接口的研究重点正在从“能否完成一次 lowering”转向“能否把目标约束、语义证据和优化策略组织成可复用基础设施”。

第四类研究关注编译到运行时的接口，即编译决策如何进入异构执行、调度、数据移动和反馈循环。深度学习框架已经清楚展示了这一趋势。PyTorch `torch.compile` 和 TorchDynamo 通过 Python frame evaluation 捕获动态图程序，将可编译区域交给后端，同时以 graph break、recompilation limit 和 eager fallback 处理动态语言与静态编译之间的边界 @pytorchCompile2026。NVIDIA TensorRT-LLM 则把 LLM 推理优化组织为模型构建、engine 生成、kernel fusion、quantization、KV cache、continuous/in-flight batching、paged attention、C++ runtime 和 serving backend 的联合系统 @tensorrtllm2026。

这类系统说明，编译和运行时之间已经不存在清晰的单向分工。编译器需要理解运行时 batch、cache、通信、内存容量和延迟/吞吐权衡；运行时也需要依赖编译器生成的 engine、kernel、layout 和调度策略。工业级异构架构进一步放大了这一问题：多 GPU、多 NPU、片间互连、分布式内存、专家并行、token dispatch、collective communication 和服务化资源管理共同决定最终性能。由此，编译到运行时的研究挑战不只是生成更快 kernel，而是建立能够跨硬件层次携带目标事实、执行证据和反馈信号的协同接口。

第五类研究关注自动化方法，尤其是大模型与 agentic 系统如何进入设计和编译流程。早期 AI for EDA 多集中在 floorplanning、设计空间探索、验证或特定优化子问题；近年的变化在于，agentic 系统开始具备读取上下文、调用工具、编辑代码、运行测试、分析日志和根据反馈迭代的工程形态。OpenAI Codex 和 Anthropic Claude Code 等系统都把软件工程 agent 放在 sandbox、命令执行、测试、日志、代码审查和人工监督构成的工作流中，而不是只把模型输出当成最终答案 @openaiCodex2025 @anthropicClaudeCode2026。

更进一步，AlphaEvolve 与 NVIDIA AVO 说明 agentic 方法正在进入更接近算法发现、编译优化和高性能 kernel 搜索的区域。AlphaEvolve 用 LLM 修改代码，并通过 evaluator 反馈进行进化式搜索；AVO 则把 autonomous coding agent 用作 variation operator，在 NVIDIA Blackwell B200 GPU 的 attention kernel 优化中结合 lineage、domain knowledge 和 execution feedback 生成、修复、批判和验证实现修改 @alphaevolve2025 @avo2026。它们共同表明，agentic 方法的技术核心不是“模型更会写代码”，而是模型能否被放入目标约束、工具调用、执行反馈和证据记忆组成的闭环中。

然而，芯片设计与编译优化对 agentic 方法提出了更高门槛。软件工程中的测试失败可以较快暴露许多错误，但硬件设计还涉及接口协议、时序、面积、功耗、可综合性、形式化等价、运行时一致性和长期维护；编译优化也需要保证语义保持、目标合法性和性能可复现。因此，自动化方法不能绕过前述四类接口，而应嵌入其中：架构接口提供目标能力和边界，硬件 IR 提供可综合对象，编译 IR 提供可检查语义，运行时提供 profiling 和执行证据，验证工具提供拒绝错误修改的 oracle。这也正是“编译基础设施作为 harness medium”的含义：agent 应当操作 compiler-native objects、pass/action 边界、target contracts、semantic/executable checks 与 benchmark/trace evidence，而不是在自然语言与临时代码之间自由漂移。

综上，国内外研究已经在领域定制架构、高层硬件实现、编译基础设施、运行时系统和 agentic 自动化方面积累了重要基础，但这些基础仍然分散在不同接口和工具链层次中。真正面向敏捷芯片设计的软硬件协同，需要把应用到架构、架构到硬件、软件到编译、编译到运行时和自动化方法五条线索组织成统一问题：如何让领域能力可表达、硬件实现可生成、编译优化可证明、运行时反馈可回流、自动化过程可审计。下一节将在此基础上收束出本文关注的核心科学问题。

== 核心科学问题与研究挑战

从上述背景与研究现状可以看到，敏捷芯片设计与创新性编译技术驱动的软硬件协同，并不是单纯追求更快的硬件生成、更强的编译优化或更自动化的代码生成。其根本矛盾在于：应用变化快于传统硬件迭代速度，硬件能力又必须通过可编程接口进入软件生态，而软件、编译器、运行时和验证系统本身也在持续演化。因此，本报告关注的核心问题不是某个单点工具的性能，而是如何在应用、架构、硬件、编译和运行时之间建立可复用、可解释、可验证的协同接口。

第一个核心科学问题是：应用需求如何通过架构接口转化为可复用的指令、微架构和加速器能力。领域应用中存在大量值得硬化或专门优化的结构，例如后量子密码中的数论变换和多项式运算，信号处理中的流式数据通路，图形和点云处理中的几何结构与不规则访存，以及 LLM 推理中的低精度算子、KV cache 与 attention 计算模式。但应用热点并不天然等价于好的硬件能力。若只从局部热点出发进行人工定制，容易得到面积代价高、适用范围窄、难以被编译器稳定调用的专用单元；若只从 ISA 格式或加速器接口出发，又可能忽略应用语义、访存路径和端到端工具链需求。因而，真正的挑战在于抽取具有跨程序、跨工作负载和跨平台价值的架构能力，并把它表达为编译器可识别、硬件可实现、运行时可调度的接口对象。第二章将围绕这一问题展开，讨论端到端 ASIP/ISAX 协同、可复用自定义指令识别和微架构感知定制等研究基础。

第二个核心科学问题是：架构能力如何高质量落到可综合、可验证、性能与资源可控的硬件实现。架构接口只定义“应当提供什么能力”，并不自动保证该能力能够以高质量硬件形式实现。现实硬件设计还受到时序、资源、流水线、存储层次、接口协议、验证覆盖和后端工具行为的共同制约。传统 RTL 能表达细节但生产力低，HLS 能提高抽象层次但常缺少对微架构结果的直接控制，硬件 IR 和 DSL 则需要在表达力、可分析性和后端可综合性之间取得平衡。因此，该问题的关键不是简单选择 RTL、HLS 或 DSL，而是建立能够把架构意图、时序结构、资源约束和综合反馈同时纳入设计过程的硬件前端与优化机制。第三章将围绕这一问题展开，梳理从高层综合基础设施、周期确定型前端，到硬件实现质量优化和变换-映射-调度联合优化的研究积累。

第三个核心科学问题是：编译接口如何连接程序语义、硬件能力和运行时反馈，形成跨硬件架构的可解释、可验证、可复用证据闭环。随着硬件能力日益异构，编译器不再只是把高层程序翻译成目标代码的后端工具，而成为软硬件协同生态中的中心接口。它需要保留程序语义，表达目标硬件约束，组织优化搜索，调用验证和测试工具，并把运行时 profiling、benchmark 和 trace 反馈转化为下一轮设计依据。大模型和 agentic 方法的出现进一步强化了这一点：模型可以提出策略、生成候选实现或执行长程搜索，但其输出必须被 IR、pass 边界、目标契约、语义检查和执行证据约束。换言之，编译基础设施应当成为 agentic 自动化的 harness medium，使自动化过程有对象可操作、有边界可审计、有证据可回放。第四章将围绕这一问题展开，重点讨论大模型与形式化技术结合后如何支撑可解释、可审计的编译优化与软硬件协同方法。

三个问题之间不是并列孤立关系，而是构成本报告的主逻辑链条。第一个问题决定领域需求能否进入架构层；第二个问题决定架构能力能否变成可靠硬件；第三个问题决定这些硬件能力能否被软件系统发现、证明、调用、反馈和演化。如果缺少第一个问题，硬件定制会失去应用来源；如果缺少第二个问题，架构想法难以形成可部署实现；如果缺少第三个问题，已有硬件能力无法进入可持续的软件生态，也无法支撑 agentic 方法在严肃工程场景中的可靠使用。

由此，本报告后续研究并不以“自动生成芯片”或“自动优化程序”作为孤立目标，而以跨硬件架构的软硬件协同生态为目标：从应用模式中抽取可复用架构能力，通过高质量硬件前端和综合机制实现这些能力，再通过编译接口、形式化语义和运行时证据把它们纳入可解释、可验证、可迭代的系统闭环。第五章将在已有研究基础上进一步提出面向未来博士阶段的研究计划，重点围绕验证约束下的架构、硬件与编译协同生成，可解释、可审计的编译基础设施，以及面向工业级异构架构的算子优化与运行时编译协同三个方向展开。

== 已有研究基础与拟开展研究

围绕上述三个核心问题，本文已有研究基础和拟开展研究形成一条连续主线。已有工作并不是彼此独立的若干论文或工具，而是从应用需求出发，经由架构接口、硬件实现、编译接口和自动化方法逐步展开的系统积累。它们共同支撑本报告的基本判断：软硬件协同的关键不是在某一层做局部最优，而是在多个层次之间建立能够被编译器理解、被硬件工具实现、被验证系统检查、被运行时反馈驱动的协同关系。

第二章首先围绕“应用需求如何通过架构接口转化为可复用的指令、微架构和加速器能力”展开。APS 和 Aquas 关注 ASIP/ISAX 的端到端协同，分别从开放 RISC-V 扩展接口、硬件合成、编译支持和复杂数据密集 ISAX 的 memory-interface attributes、cache effects、robust compiler mapping 等方面，回答领域能力如何被接入完整工具链 @aps2025 @aquas2026。ISAMORE 则进一步把问题推进到“定制什么”的层面，通过 e-graph anti-unification 从程序等价空间中发现可复用自定义指令模式，使自定义指令不只是局部热点加速，而成为可跨程序复用的架构机制 @isamore2026。Cayman 将在这一章作为领域定制与端到端协同的重要组成部分，补充微架构约束与架构能力选择之间的联系。

第三章围绕“架构能力如何高质量落到可综合、可验证、性能与资源可控的硬件实现”展开。HECTOR 作为早期高层综合与 MLIR 硬件基础设施积累，为后续硬件前端和综合优化工作提供了工具链经验与抽象基础。Cement 关注周期确定型硬件前端，试图在 RTL 精细控制与 HLS 高层抽象之间建立更可预测的表达方式 @cement2024。Clay 将作为硬件前端与综合优化的重要工作，重点讨论硬件实现质量、综合机制和设计约束之间的关系。SkyEgg 则进一步把代数变换、实现选择和调度放入统一 e-graph 设计空间中，体现从单阶段综合优化转向变换-映射-调度联合优化的思路 @skyegg2026。这一章主要回应第二个科学问题，同时通过 SkyEgg 等工作连接到第三个问题中的编译接口和形式化优化空间。

第四章围绕“编译接口如何连接程序语义、硬件能力和运行时反馈”展开，并突出大模型与形式化技术结合对软硬件生态的作用。OriGen 作为开放 RTL 生成与反馈式修复方向的探索，将被用于概括大模型进入硬件生成流程时对数据、语法、编译反馈和自反思机制的需求 @origen2024。EggMind 则是本章重点，它将 LLM 的策略生成能力放入 EqSatL、e-graph 和等式饱和语义约束下，强调自动化优化必须输出可解释、可审计、可复用的编译策略对象，而不是不可追踪的自然语言建议 @eggmind2026。第四章因此不仅回应第三个科学问题，也反向支撑前两个问题：只有编译接口能够表达和验证程序语义，架构定制和硬件实现才有可能进入长期可维护的软件生态。

第五章在已有研究基础上提出未来工作。未来工作不再只沿着某一个已有工具继续扩展，而是把三个核心科学问题合成为更完整的系统闭环。第一，研究验证约束下的架构、硬件与编译协同生成，使架构接口、硬件生成和编译支持能够在形式化约束与执行证据下共同演化。第二，研究可解释、可审计的编译基础设施，把编译器作为 agentic 方法的 harness medium，使 LLM/agent 能够围绕 IR、pass、target contract、semantic check 和 evidence memory 进行受约束协作。第三，研究面向工业级异构架构的算子优化与运行时编译协同，把 PyTorch/Dynamo、TensorRT-LLM 等框架所体现的编译-运行时边界，推进到更复杂的跨硬件架构、运行时反馈和长程优化场景中 @pytorchCompile2026 @tensorrtllm2026。

图 @problem-chapter-map 概括了上述关系。第二至第四章分别以已有工作回应三个核心科学问题，并在相邻层次之间形成支撑关系；第五章则把这些问题重新组合为面向博士阶段后续研究的三个方向。这样的组织方式有两个目的：一方面，它避免把已有成果写成论文清单，而是说明每项工作在整体研究链条中的位置；另一方面，它也明确未来研究不是对已有工作的简单延长，而是从单点方法走向跨层协同系统。

#figure(
  rect(width: 100%, height: 22em, stroke: gray + 0.8pt, inset: 1em)[
    #align(center + horizon)[
      研究问题与章节映射：问题 1（应用需求到架构接口）对应第二章；问题 2（架构能力到高质量硬件实现）对应第三章；问题 3（编译接口连接程序语义、硬件能力与运行时反馈）对应第四章；第五章将三者合成为验证约束生成、可审计编译基础设施、工业级异构架构算子与运行时协同三个未来方向。
    ]
  ],
  caption: [研究问题、已有工作章节与未来研究方向的对应关系],
) <problem-chapter-map>

= 面向领域定制的架构接口与端到端协同

== 引言

第一章指出，领域定制计算的核心难点不是发现某个应用热点，而是把应用需求转化为可以被软硬件系统长期使用的架构能力。本章围绕这一问题展开，讨论应用需求如何通过架构接口转化为可复用的指令、微架构和加速器能力。这里的“架构接口”既包括处理器与自定义指令单元之间的硬件协议，也包括指令语义、存储访问路径、编译器识别机制、运行时可见行为和设计者能够迭代使用的工具链产物。

本章的组织遵循“端到端协同框架 -> 定制什么 -> 微架构约束”的递进关系。首先，APS 和 Aquas 关注领域定制能力如何接入完整 ASIP/ISAX 工具链：APS 解决开放 RISC-V 生态中接口分裂、硬件合成和编译支持割裂的问题；Aquas 进一步面向复杂数据密集 ISAX，把 memory-interface attributes、cache effects、MLIR/Aquas-IR、e-graph rewrite 和 skeleton-component matching 结合起来，使硬件侧访存机制选择和软件侧自动 offloading 能够共同优化。随后，ISAMORE 将问题推进到“应该定制什么”本身，强调自定义指令面积昂贵，必须从跨程序语义等价空间中发现可复用指令模式。最后，Cayman 将补充微架构感知定制，使领域能力选择与具体微架构约束形成更紧密的端到端协同。

这三个层次共同回应第一个科学问题。APS/Aquas 说明领域能力如何进入可运行、可评估、可综合的工具链；ISAMORE 说明领域能力如何避免局部热点定制，转而成为跨工作负载可复用的架构机制；Cayman 则说明架构能力不能停留在抽象指令层，还需要结合微架构结构、接口代价和实现约束进行选择。本章并不把这些工作写成论文列表，而是把它们作为同一研究链条的不同阶段：先建立可接入系统的协同框架，再解决可复用定制能力发现，最后把定制能力与微架构事实对齐。

== ASIP/ISAX 端到端协同框架：APS 与 Aquas

ASIP/ISAX 是领域定制计算中兼顾可编程性和专用硬件效率的重要形态。与传统固定加速器相比，自定义指令和专用执行单元能够保持通用处理器的软件入口，使应用在普通控制流、库函数和系统运行环境中调用领域能力；与纯软件优化相比，它们又能把频繁出现的计算、访存或控制模式硬化到专用数据通路中。因此，ASIP/ISAX 是连接应用需求与架构能力的自然接口。但这一接口真正可用，需要同时解决硬件协议、指令语义、合成实现、编译器调用和系统级评估问题。

APS 的出发点是开放 RISC-V ASIP 生态中的端到端割裂。RoCC 和 CV-X-IF 等接口都采用处理器与自定义单元解耦的握手式交互，但二者在 commit/recall、issue/response、内存访问和控制信号组织上存在差异。RoCC 偏向简化加速器设计，并由处理器侧保证 offloaded instruction 的提交；CV-X-IF 则显式暴露 commit channel，使带副作用的操作必须等待确认后才能执行。二者具有相近的交易语义，却因为协议细节、实现语言和平台生态不同而难以复用同一 ISAX 设计。APS 因此提出 transaction-based 的统一 ISAX 接口抽象 APS-itfc，把 issue、GPR request、recall、memory read/write、memory response 和 result response 等交互统一为 valid-ready transaction，并通过 backend adapter 自动映射到 RoCC 或 CV-X-IF @aps2025。

APS-itfc 的意义不只是隐藏接口信号差异，而是为后续硬件合成和编译支持建立共同边界。自定义指令单元只需要面向统一 transaction 语义描述与处理器的交互，RoCC 或 CV-X-IF 的 tag、size、commit/recall 等平台细节由 adapter 处理。APS 在 Rocket/Chipyard 与 CV32E40X/Croc 两个开源 RISC-V 平台上实现这一抽象，并补充参数化 cache、Verilator cycle-accurate simulation、Yosys/OpenROAD ASIC flow 等工具链环节，使同一类定制能力能够在不同 SoC 框架中完成集成、仿真和物理实现评估。这一设计回答了 ASIP 研究中的第一层问题：领域能力必须有一个跨平台、可落地的架构接口，否则后续合成和编译优化会被具体处理器协议锁死。

在硬件侧，APS 通过 CADL 和 APS-synth 提供 ISAX-specific synthesis。CADL 允许设计者描述自定义指令的高层行为，同时直接访问统一 APS-itfc transaction 和低层硬件组件；其描述内容被降低为 Structured IR（SIR）和 Scheduled Structured IR（SSIR）。SIR 保留 sequence、block、loop、loop-carried variables、method call 等结构，便于类型推导、函数解释和程序优化；SSIR 则把调度结果表达为 pipeline/stage 结构，用于估计性能并生成硬件。APS-synth 在调度中加入自定义指令特有约束，例如 register-file read 必须位于触发阶段、latency-insensitive operations 不能错误并列以避免 deadlock，并最终构造 transaction-based dynamic pipeline。这使 APS 不仅能生成组合逻辑式指令，也能描述带状态、循环、流水和自定义组件的更复杂 ISAX 行为 @aps2025。

在软件侧，APS 提供 APS-c 编译框架，把 CADL 语义导出为编译器可用的匹配信息，并在 LLVM 中生成 intrinsic-like C wrappers、semantic-based matcher、profile-guided matcher 和 bitwidth-aware vectorization。semantic-based matcher 面向控制较简单的 IR 模式，自动识别等价指令序列并替换为 ISAX 调用；profile-guided matcher 面向复杂循环或控制区域，通过解释执行和 input-output 行为比较辅助发现可以 offload 的代码区域。bitwidth-aware vectorization 则针对 RV32 等架构中低位宽操作无法充分利用寄存器位宽的问题，把多个低位宽 scalar ISAX 调用打包为 SIMD-style ISAX，并在超过寄存器带宽时自动插入辅助 memory/config 操作。由此，APS-c 把自定义指令从“需要程序员手写 intrinsic”推进到“编译器根据硬件语义自动发现和使用”的形态 @aps2025。

APS 的评估覆盖后量子密码、量化 LLM 和数字信号处理三个领域，展示了端到端工具链的实际效果。在 CRYSTALS-KYBER 中，NTT butterfly 与 PWM/Karatsuba 等 ISAX 用约 175 行 CADL 描述，并在两个 RISC-V 平台上获得明显加速；Butterflyx2 在两个平台上最高达到 10.16x，Karatsuba 对 PWM baseline 最高达到 14.99x。在 BitNet b1.58 的 BitLinear 场景中，dotprodW2A8x4 ISAX 针对 8-bit activation 与 2-bit weight 的 dot product，完整 BitLinear 层获得 2.03x 和 2.29x 加速，并可由 profile-based matcher 自动利用。在 DSP 场景中，SOS 与 IIR ISAX 支撑 DPLL 中的 IIR filter 加速，IIR 指令通过深流水和硬件 loop 消除软件调用与循环开销，在 Croc 和 Rocket 上分别获得 5.51x 和 5.18x 加速。这些结果说明 APS 的价值不仅是某个指令加速，而是把指令设计、硬件合成、编译插入、仿真评估和 ASIC PPA 反馈连成完整敏捷迭代流程 @aps2025。

然而，APS 也暴露出下一层挑战。它已经把自定义指令接入统一接口和编译流程，但在复杂数据密集应用中，性能往往受限于存储层次、接口带宽、cache 行为和更复杂的软件变体。APS 的 CADL 和编译器能够描述较一般的行为，但对块级内存访问、scratchpad 使用、burst transfer、cache hierarchy mismatch、复杂 loop transformation 和鲁棒 ISAX matching 的支持仍不充分。换言之，APS 建立了端到端协同框架，但当领域定制从 scalar/SIMD-like 指令推进到更复杂的 memory-centric ISAX 时，架构接口必须进一步显式表达访存机制和 cache effects，编译器也必须在更大的程序等价空间中进行稳健匹配。

Aquas 正是沿着这一方向推进。它仍以 ASIP/ISAX 为对象，但把问题从“统一接口和基本端到端流程”扩展为“复杂数据密集 ISAX 的硬件-软件整体协同优化”。在硬件侧，Aquas 首先建立 core-ISAX memory interface model，用宽度、最大 beat count、in-flight transaction 数、读 lead-off latency、写完成代价和 cache-line size 等参数刻画不同访问路径。这个模型说明，接口选择并非微小实现细节：窄低延迟接口和宽高延迟接口在不同访问粒度、burst 能力和 cache 层次下会产生不同性能结果，错误选择可能引入 7 到 9 cycle 的局部延迟惩罚，并在更大设计中放大为系统性能损失 @aquas2026。

为了把这些硬件事实纳入合成，Aquas 设计了三层 Aquas-IR。functional level 接近高层软件语义，描述 transfer、fetch 等与具体访问机制无关的操作；architectural level 引入 `memitfc` 符号，把 memory operation 绑定到具体接口，并使其受到对齐、transaction size、in-flight limit 等微架构约束；temporal level 则用异步 issue/wait 和 ordering attribute 表达事务顺序、cache 层次和有限并发下的具体时序。基于这一 IR，Aquas 进行 scratchpad buffer elision、interface selection and canonicalization、transaction scheduling and ordering，以及最终硬件生成。其关键意义在于，访存接口选择不再是手工经验或后端偶然结果，而成为可分析、可搜索、可在 IR 中回放的架构决策 @aquas2026。

在软件侧，Aquas 进一步解决复杂 ISAX offloading 的鲁棒编译问题。复杂 ISAX 的语义常与应用代码存在抽象层次差异：软件表示关注 value、control flow 和 memory effect，而硬件描述中可能包含 scratchpad、寄存器交互和接口传输语义。Aquas 首先把软件代码通过 Polygeist 转到 MLIR 基础 dialect，并把 Aquas-IR functional level 中的硬件语义规范化到同一抽象层次。随后，它把 MLIR 与 e-graph 结合：MLIR 保留结构化控制流和 side-effect ordering，e-graph 非破坏性地累积等价程序变体；internal rewrites 用于代数和数据流变换，external rewrites 则通过调用 MLIR loop passes 实现 tiling、unrolling 等控制流重构。为了避免 e-graph 爆炸，Aquas 根据目标 ISAX 的 loop characteristics 有选择地触发外部重写，最后通过 skeleton-component matching 检查控制结构、数据流组件、dominance、ordering 和 effect constraints，自动插入 ISAX 调用 @aquas2026。

这种设计把 APS 中的自动 intrinsic insertion 扩展到更复杂的语义空间。APS 的 pattern matching 已经能够处理部分语义和 profile-based 场景，但 Aquas 更强调：同一个 ISAX 可能对应许多语法不同、控制流形态不同、但语义等价的软件实现；编译器若只匹配单一模式，会被 loop tiling、unrolling、代数变换、冗余语句和非 affine 表达轻易破坏。因此，Aquas 把“匹配一个模式”转化为“在受约束的等价空间中寻找与目标 ISAX skeleton/components 对齐的程序变体”。这使编译接口更接近第一章所说的 harness medium：目标事实、IR 表示、rewrite、matching、cost model 和证据共同约束 offloading 决策。

Aquas 的评估进一步说明了这一复杂协同的必要性。它在后量子密码、点云处理、图形渲染和 CPU LLM 推理四类场景中评估真实 workload。对于 code-based PQC 的 syndrome computation，Aquas 为 bitstream unpacking 和 GF(2^n) matrix multiplication 设计 ISAX，并在 Rocket baseline 上获得 7.59x 和 3.29x kernel speedup，端到端获得 1.42x speedup，面积开销小于 5.3% 且无频率下降。在点云 ICP 场景中，Aquas 针对 Euclidean distance、covariance matrix、maximum comparison 和 matrix-vector multiplication 等操作设计 ISAX，kernel speedup 达到 1.46x 到 9.27x，端到端达到 1.96x；其优势来自对不规则访存、矩阵/向量混合访问和扩展总线带宽的更好利用。在图形渲染中，Aquas 与 RISC-V vector unit Saturn 比较，多个 kernel 获得 9.47x 到 15.61x 加速，并在性能面积权衡上优于通用向量单元。在 CPU LLM 推理的 FPGA prototype 中，Aquas 针对 attention computation 设计 ISAX，在 Llama 2 110M 8-bit 量化模型上获得 9.30x TTFT 和 9.13x ITL 加速。这些结果说明，当应用具有复杂访存和控制形态时，端到端协同必须同时考虑硬件访存接口、编译等价空间和真实系统评估 @aquas2026。

从研究链条看，APS 和 Aquas 共同回答了“如何把定制能力端到端接入工具链”这一问题。APS 建立了跨 RISC-V 平台的统一接口、ISAX-specific synthesis 和自动编译插入，使领域能力能够从 CADL 和 C 程序进入可仿真、可综合、可评估的 SoC。Aquas 则进一步把复杂数据密集场景中的访存接口、cache hierarchy、MLIR/Aquas-IR、e-graph 重写和 skeleton-component matching 纳入同一流程，使定制能力不仅能接入工具链，还能在更复杂硬件事实和软件变体中被正确、鲁棒、有效地使用。二者为后续 ISAMORE 提供了基础：当端到端接入问题被系统化以后，下一步关键就变成如何从应用集合中自动发现真正值得接入这些接口的可复用架构能力。

== 可复用自定义指令识别：ISAMORE

APS 和 Aquas 解决的是“如何把定制能力接入端到端工具链”的问题，但它们仍然预设设计者已经知道哪些能力值得定制。对于敏捷芯片设计而言，这个前提并不总成立。自定义指令会占用面积、引入验证负担，并影响处理器接口、编译器后端和系统维护；如果一个指令只服务于少数局部热点，它即使在单个 kernel 上有效，也很难成为长期可复用的架构能力。因此，在端到端接入工具链之上，还需要回答一个更前置的问题：从一组领域代表程序中，如何自动发现具有跨程序、跨工作负载价值的可复用自定义指令。

传统自动指令发现大多以程序热点和语法结构为中心。细粒度方法枚举 basic block 内的 convex subgraph，能够找到局部可替换片段，但受限于基本块范围和较小模式，容易错过更大粒度的优化机会；粗粒度方法把 basic block 或代码区域整体合并为加速单元，能够覆盖更多操作，却常生成过大的专用硬件，复用次数低，甚至包含在通用处理器上更适合执行的指令序列。二者共同的问题是过度依赖 syntactic analysis：如果两个代码片段语法不同但语义等价，它们往往被视为不同模式，最终产生多个相似但不共享的硬件单元。ISAMORE 的问题意识正来自这一点：真正适合作为 ISA 扩展的能力，不应只是某个热点中的语法片段，而应是语义上可泛化、在多个位置反复出现、且硬件代价与性能收益匹配的模式 @isamore2026。

ISAMORE 将可复用自定义指令识别建模为 reusable instruction identification，并提出 RIMT 方法。其输入是一组领域代表程序，输出是一组在性能和面积之间形成 Pareto trade-off 的自定义指令候选。这个过程首先把 LLVM IR 转换为结构化 DSL，再编码为 e-graph；随后通过 phase-oriented equality saturation 和 e-graph anti-unification 发现语义等价空间中的公共模式；最后用硬件感知 cost model 选择值得实现的模式，并通过 HLS 和 RoCC wrapper 等后端生成可评估硬件。与 APS/Aquas 相比，ISAMORE 的位置更靠前：它不只是让编译器使用已有 ISAX，而是帮助设计者决定哪些 ISAX 值得进入后续工具链。

为了让一般程序能够进入 e-graph anti-unification，ISAMORE 首先设计 structured DSL。该 DSL 覆盖 arithmetic、logical、memory access 等常规操作，同时引入 `Loop` 和 `If` 表达控制流，并提供 `Vec`、vector unary/binary/ternary operations、pattern variables 和 `App` 等结构。`Loop` 以 do-while 风格表达 loop-carried variables、loop condition 和 body result，使控制流能够以结构化、数据流中心的方式进入 e-graph。该 DSL 还具有强类型系统，利用 e-class analysis 推导每个 e-class 的 result type，并对 `If` 和 `Loop` 的输入输出 tuple 施加结构约束。这个设计解决了直接把一般程序放入 e-graph 的第一层障碍：程序不再只是若干代数表达式，而是保留了循环、条件、类型和向量结构的可泛化语义对象 @isamore2026。

在此基础上，ISAMORE 的核心方法是 e-graph anti-unification。e-graph 用 e-class 表示等价项集合，equality saturation 通过重写规则暴露语义等价形式；anti-unification 则在两个项之间求 least general generalization，从而发现公共结构。例如，两个语法不同但可重写到同一等价形式的表达式，可以被泛化为带 pattern variables 的候选指令模式。这个思路把“复用”从语法匹配提升到语义等价空间：同一个自定义指令可以覆盖多个表面形态不同的程序片段，只要它们在 e-graph 中共享可泛化结构。

直接使用 vanilla e-graph AU 并不可行，因为真实程序的 e-class 数量和候选 AU pattern 数会迅速爆炸。ISAMORE 因此提出 phase-oriented iteration。它放弃一次性对所有重写规则做完整饱和，而是把规则按 saturating/nonsaturating、int/float、vector/scalar 等维度组织为 base rulesets，并由 phase scheduler 逐步选择规则集。早期阶段先应用不会显著增加 e-class 的 saturating rules，尽可能暴露低成本等价形式；后续阶段再以受限次数应用 nonsaturating rules，以避免 e-graph 规模失控。每个 phase 中，RIMT 会把以前识别的 pattern 作为 pattern-application rewrites 重新注入 e-graph，使后续阶段能够在已有模式的基础上进一步泛化。这样做既控制了搜索规模，又允许指令模式从局部公共结构逐渐演化为更高复用度的候选 @isamore2026。

RIMT 的第二个关键是 smart AU。vanilla AU 需要枚举大量 e-class pair，并对每对 e-node 递归生成候选 pattern，实际复杂度很快失控。smart AU 用两类启发式降低复杂度。第一是 similarity-based e-class pairing：ISAMORE 用类型信息排除 result type 不一致的 e-class，再通过 structural hashing 估计 e-class 的结构相似度，只对相似度超过阈值的 pair 做 AU。structural hashing 对字面量、参数和 pattern variables 做统一处理，强调结构而非具体常量，从而更适合寻找可复用模式。第二是 heuristic AU pattern sampling：当某个 e-node pair 的 AU 候选过多时，ISAMORE 不保留全部 Cartesian product，而用 boundary 或 kd-tree 策略根据 latency/area 特征选取代表性 pattern。前者保留特征值极端的模式以提高效率，后者在特征空间中取更广覆盖以改善质量。二者共同使 e-graph AU 从理论上有吸引力但不可用的方法，变成可以处理真实程序的指令识别机制 @isamore2026。

除了语义复用，ISAMORE 还把 data-level parallelism 纳入指令发现过程。传统指令发现往往把 scalar pattern 作为主要对象，即使程序中存在多路相似操作，也不一定生成向量化自定义指令。ISAMORE 的 pattern vectorization 把一个 vectorized pattern 看作同一个 pattern 在多个 lane 上的应用。其流程先通过 smart AU 找到可重复出现的 scalar seed，再把同一 basic block 中的多个 seed pack 成 `Vec` 节点；随后通过 lift rewrites 恢复 VecAdd、VecMul 等向量构造，并用 couple rewrites 建立 vector 到 scalar lane 的数据流；最后用 greedy extraction 和 compress-style pruning 消除 `Get-Vec-Get` cycle 与组合式 packing 爆炸，只保留高 DLP 的非重叠向量化方案。这使自定义指令发现不局限于“找到一个可复用 scalar 片段”，而能同时探索向量化、硬件 loop 和更高吞吐的数据通路 @isamore2026。

在选择指令候选时，ISAMORE 不使用 AST size 这类硬件无关目标，而使用 profiling-based、hardware-aware cost model。对每个 pattern，它估计该 pattern 在所有使用位置替换为硬件单元后节省的总延迟：软件延迟来自 profile 得到的 cycles-per-operation，硬件延迟来自轻量 HLS 对 pattern 行为的 scheduling，面积来自 HLS/OpenROAD 估计。RIMT 通过 e-class analysis 在 e-graph 中传播 Pareto front，把 pattern set 的 speedup 与 area overhead 作为多目标选择依据，并在 extraction 后重新计算更准确的性能面积指标进行 fidelity refinement。这个设计保证 ISAMORE 发现的不是“语法上好看”或“项数更少”的模式，而是具有实际性能收益和可接受硬件代价的架构能力 @isamore2026。

ISAMORE 的 benchmark 评估展示了这种方法的可扩展性和收益。在九个来自计算机视觉、机器感知、数字信号处理和密码学的 kernel 上，vanilla e-graph AU 因候选 pattern 爆炸而在所有案例中超过 30GB 内存限制；启用 RIMT 后，所有 benchmark 均在 145 秒内完成，内存不超过 799MB，峰值 e-graph size 相比 vanilla 方法降低 6 到 39 倍。在性能上，ISAMORE 相比 NOVIA 等语法合并方法获得更高 speedup 和更低面积开销；启用 vectorization 后，ISAMORE 相对 NOVIA 的优势平均达到 1.76x，最高达到 2.69x，并在多个 benchmark 中展示 pattern vectorization 对性能的进一步贡献。MatChain 案例还表明，structured DSL 编码控制流后，ISAMORE 可以识别可复用 hardware loop，生成 loop pipeline accelerator，获得远超基本块级方法的优化粒度 @isamore2026。

更重要的是，ISAMORE 在真实开源库和具体硬件实例中体现了“可复用架构能力”的价值。对 liquid-dsp、CImg 和 PCL 等库的研究显示，语法合并方法往往生成巨大且低复用的硬件单元，而 ISAMORE 能识别多个更小、更高复用的自定义指令。在 CImg 中，NOVIA 生成一个 size 为 167 的大硬件单元且只合并少量基本块，ISAMORE 则识别八条平均复用 93 次的指令，获得 1.18x speedup，同时面积仅为 975 平方微米，相比 NOVIA 节省 90.5% 面积。在 PCL modules 中，ISAMORE 相比 NOVIA 平均获得 1.64x speedup，最高 2.73x，并节省 93.2% 面积。这些数据说明，可复用性不是附加指标，而是决定自定义指令是否适合进入 ISA 的核心标准 @isamore2026。

ISAMORE 还在量化 LLM 和后量子密码中展示了从自动识别到真实硬件集成的可行性。对 BitNet b1.58 的 BitLinear 推理实现，ISAMORE 从 `bitnet.cpp` 风格实现中识别出 packed low-bit dot product 的向量化模式，并生成带 RoCC wrapper 的自定义硬件单元；在 Rocket tile 上通过 Verilator RTL simulation 获得 2.15x BitLinear speedup，OpenROAD 报告 4.81% area overhead 且无频率下降。对 CRYSTALS-KYBER 的 NTT 实现，ISAMORE 自动识别 forward NTT 和 inverse NTT 复用的 butterfly custom instruction，并在 Rocket tile 上获得 5.15x speedup，面积开销主要来自硬件乘法器。这些案例证明，ISAMORE 不只是静态分析工具，而能够与 RISC-V/SoC、HLS、RTL simulation 和 physical design flow 连接，进入实际敏捷芯片设计流程 @isamore2026。

从本章主线看，ISAMORE 对 APS/Aquas 形成了关键补充。APS/Aquas 使一个已知定制能力能够被架构接口承载、被硬件工具实现、被编译器调用并被系统评估；ISAMORE 则反过来从领域程序集合中发现哪些能力值得进入这一流程。其方法创新在于把 e-graph equality saturation、anti-unification、structured control-flow DSL、phase-oriented search、smart AU、pattern vectorization 和 hardware-aware selection 结合起来，使“可复用自定义指令”成为可自动发现、可量化权衡、可硬件落地的敏捷芯片设计机制。由此，领域定制不再完全依赖专家凭经验挑选热点，而可以通过程序语义、硬件代价和跨工作负载复用共同驱动。

== 微架构感知定制：Cayman

APS、Aquas 和 ISAMORE 分别从端到端接入、复杂访存协同和可复用指令发现三个角度推进了领域定制处理器研究。Cayman 则把这一链条进一步推向微架构感知的 custom accelerator generation。与 ISAX 更强调处理器指令接口不同，Cayman 面向的是从应用程序中自动选择适合硬件加速的 kernel，并生成高性能自定义加速器；它关注的重点不只是“是否把某个代码片段硬化”，而是该片段是否包含复杂控制流、如何组织数据访问、如何通过 processor-accelerator interface 降低数据移动代价，以及多个加速器之间是否可以合并和复用 @cayman2025。

Cayman 的问题背景与本章前两节自然衔接。APS 说明，如果缺少统一接口和合成/编译工具链，自定义能力难以跨平台落地；Aquas 说明，如果不显式建模访存接口和 cache effects，复杂数据密集 ISAX 会被错误的内存路径和低效数据移动限制；ISAMORE 说明，如果只从局部热点做语法合并，自定义硬件会过度专用、复用度不足。Cayman 面对的是同一矛盾在 accelerator generation 场景中的体现：HLS 可以从给定 kernel 合成硬件，但 kernel 的选择和抽取仍常依赖人工；而真实应用中的候选区域可能包含一般控制流、复杂数据访问和多个可复用加速单元，不能只靠简单 loop 或 basic-block 规则决定。

Cayman 提出 end-to-end 框架来综合具有 control-flow and data-access optimization 的高性能自定义加速器。其核心包括三个方面。第一，Cayman 使用 hierarchical program representation 自动选择硬件加速 kernel，这一表示能够捕获具有 general control flows 的候选区域，从而突破只处理简单循环或局部基本块的限制。第二，Cayman 通过 specialized processor-accelerator interfaces 优化数据访问，使加速器生成不只关注计算逻辑，还把数据移动路径、接口代价和访问模式纳入设计。第三，Cayman 引入 accelerator merging mechanism，用于综合可复用加速器，避免为相似但不完全相同的候选区域生成多个重复硬件单元 @cayman2025。

从本报告的角度看，Cayman 的意义在于把“架构接口”从指令级扩展到更完整的 processor-accelerator 协同边界。自定义指令通常受寄存器操作数、指令编码和处理器流水线接口约束；自定义加速器则更强调 region/kernel 级语义、数据搬运、接口带宽、控制流调度和多个调用点之间的硬件复用。Cayman 对 hierarchical program representation、specialized interfaces 和 accelerator merging 的强调，说明领域定制能力的选择必须与微架构实现方式共同考虑：同一个应用区域是否值得加速，不仅取决于计算密度，还取决于数据访问能否被接口支持、控制流能否被硬件高效表达、合并后的加速器能否在多个位置复用。

Cayman 在多个 benchmark 上相对两个 state-of-the-art frameworks 分别取得 8.0x 和 14.4x 的性能优势 @cayman2025。对本章而言，这一结果的含义不是单点加速数字本身，而是 Cayman 补足了领域定制链条中的第三个层次：APS/Aquas 解决“如何接入”，ISAMORE 解决“定制什么”，Cayman 则强调“在何种微架构和接口约束下生成可复用加速器”。这使本章从指令扩展走向更一般的领域定制架构能力，为第三章讨论高质量硬件实现奠定了过渡基础。

== 本章小结

本章围绕第一章提出的第一个科学问题，讨论了应用需求如何通过架构接口转化为可复用的指令、微架构和加速器能力。APS 和 Aquas 从端到端工具链角度说明，领域定制能力必须同时具有硬件接口、合成实现、编译映射、系统评估和 PPA 反馈，才能从应用想法变成可迭代的 ASIP/ISAX 机制。ISAMORE 从可复用指令发现角度说明，自定义能力不能只来自局部热点，而应由程序语义、跨工作负载复用和硬件代价共同决定。Cayman 则把这一逻辑推进到 custom accelerator generation，强调 control flow、data access、processor-accelerator interface 和 accelerator merging 对领域定制能力选择的决定性作用。

这些工作共同表明，领域定制不是“发现热点并硬化”的线性过程，而是应用语义、架构接口、微架构约束、编译支持和硬件实现之间的协同过程。一个定制能力是否值得进入系统，取决于它能否跨应用复用、能否被编译器稳定识别、能否通过接口高效传输数据、能否在硬件中以合理面积和时序实现，并能否在真实 workload 中获得端到端收益。因此，本章既回答了“定制什么”和“如何接入”的问题，也自然引出下一章：当架构能力已经被识别并表达出来以后，如何把它们高质量地落到可综合、可验证、性能与资源可控的硬件实现中。

= 面向高质量硬件实现的前端抽象与综合优化

== 引言

第二章讨论了领域能力如何被识别、表达并接入架构接口，但架构能力本身并不等于高质量硬件实现。一个自定义指令、加速器 region 或硬件前端描述，只有在时序、面积、资源、接口协议、控制逻辑和验证条件都满足目标约束时，才能真正成为可部署的系统能力。因此，本章围绕第一章提出的第二个核心科学问题展开：架构能力如何高质量落到可综合、可验证、性能与资源可控的硬件实现。

这一问题的难点在于硬件实现质量来自多个层次的共同决定。RTL 能提供细粒度控制，但抽象层次低、生产率不足；HLS 能从软件描述生成硬件，却常把关键微架构决策隐藏在 pragma 和启发式调度之后；硬件 DSL 与 IR 试图提高表达能力和可分析性，但如果不能携带时序、资源和映射信息，仍难以形成可预测结果。因此，本章按 HECTOR、Cement、Clay、SkyEgg 的顺序组织：HECTOR 作为早期多层 IR 与硬件综合基础设施积累，提供后续工作的技术背景；Cement 关注周期确定型硬件行为表达；Clay 关注面向 ASIP 的微架构感知前端与综合机制；SkyEgg 则把代数变换、硬件映射和调度放入统一 e-graph 设计空间，形成对高质量硬件实现问题的进一步推进。

== 综合基础设施积累：HECTOR

HECTOR 是本人较早参与的硬件综合基础设施工作，其意义在于把硬件综合问题从单一 HLS 工具实现，推进到基于多层 IR 的方法学表达。传统 HLS 工具、硬件生成器和领域专用 DSL 往往各自实现一套前端、IR、调度、生成和优化流程，工程成本高，方法难复用。HECTOR 提出基于 MLIR 的两层 IR：高层 IR 将 computation 与带 timing information 的 control graph 绑定，低层 IR 则用于描述硬件模块和 elastic interconnections，并可进一步转换为 synthesizable RTL @hector2022。

HECTOR 对本报告的作用不在于作为最重要的代表性工作展开，而在于提供了后续研究反复依赖的基础设施视角。它说明硬件综合可以被组织成多层 IR、转换 pass、调度信息和 RTL lowering 的组合，而不是只能依赖黑盒 HLS 或手写 RTL。基于这一思想，后续 Cement、Clay、SkyEgg 等工作都可以被理解为在不同维度上深化 HECTOR 开启的问题：Cement 强调前端语言必须显式表达周期行为和 timing constraints；Clay 强调 ASIP 指令扩展的 coupling strategy 和 microarchitectural attributes 需要进入综合约束；SkyEgg 则强调 algebraic transformation、mapping 和 scheduling 不应被拆成固定顺序的阶段。

因此，HECTOR 在本文中承担“综合基础设施积累”的角色。它为本章后续讨论提供两个重要判断。第一，硬件实现质量需要 IR 层支撑，只有把控制、时序、模块连接和 lowering 边界显式化，后续方法才有可分析对象。第二，多层 IR 本身还不够，IR 中携带哪些时序、资源、接口和映射信息，决定了工具能优化到什么程度。Cement、Clay 和 SkyEgg 分别从前端时序表达、微架构感知综合和联合优化三个方向回答这一问题。

== 周期确定型硬件前端：Cement

Cement 面向 FPGA 加速器设计中的一个长期矛盾：设计者需要硬件级别的微架构表达和时序控制，但 RTL 生产率低、HLS 结果难预测、许多 DSL 又只覆盖特定结构。HDL 能直接描述连接和寄存器传输，却缺少对跨周期行为的显式表达，复杂 FSM 和流水线控制需要大量手工设计；HLS 从 C/C++ 等软件语言出发，依赖 pragma 与启发式调度补足微架构信息，导致同一设计在不同工具版本或配置下可能产生不可预测结果；部分 DSL 提升了安全性或特定并行模式表达，但往往牺牲一般微架构能力。Cement 因此提出 cycle-deterministic eHDL CmtHDL 与 CmtC 编译器，目标是在不牺牲微架构表达力的前提下，提高硬件前端生产率和结果可预测性 @cement2024。

CmtHDL 嵌入 Rust，先利用 Rust trait 和宏系统定义 data types、bundles、interfaces、module instantiation、operations 和 port connections，再引入 event layer 与 control sub-language。event layer 用 event 表示一组带 guard 的硬件行为，并显式记录这些行为发生的 cycle sequence；control sub-language 用 `seq`、`par`、`if`、`for`、`while`、`step` 等 procedural statements 描述 event 的时序关系，使设计者能够直接表达确定的跨周期行为。与普通 RTL 只描述“每周期连接如何生效”不同，CmtHDL 允许设计者把“哪些行为在哪些周期发生”作为一等对象写入前端表示 @cement2024。

这一抽象对复杂控制逻辑尤其重要。以 shuffler 和 arbiter pipeline 为例，HDL 设计者需要手工保证发送、仲裁、接收和 resend 之间的周期对齐；HLS 版本则可能因为软件循环依赖模型和工具启发式调度而无法稳定达到 II=1。CmtHDL 可以用 `seq` statement 明确流水线不同 stage 的 timing，并由 CmtC 检查 timing violation。这种 cycle determinism 不是简单固定延迟，而是在静态或动态输入条件下保证 event 的执行周期可推导、可检查、可综合，从而降低手工 FSM 和流水线控制中的隐性错误。

CmtC 的核心编译能力包括 timing analysis 和 FSM synthesis。Timing analysis 分为 static analysis 和 dynamic monitoring：前者对 elaboration-time 可确定的 static events/statements 推导 cycle sequence，在仿真前发现数据收发周期不匹配；后者在仿真中插入 monitor signals 和 assertions，用于捕获数据相关行为下的 timing violations。FSM synthesis 则从 control sub-language 生成严格满足时序规格的控制逻辑，并用 state tree representation、transition table 和编码优化减少 FF/LUT 开销。这使 Cement 不只是前端语法改进，而是在语言、分析和综合之间形成闭环：设计者显式写出时序，编译器检查时序并生成资源优化的控制电路 @cement2024。

实验上，Cement 在 PolyBench、systolic array 和 sparse accelerator 等案例中展示了周期确定前端的实际价值。相对 Vitis HLS，Cement 在未流水和流水配置下分别获得 1.41x 和 1.52x 几何平均加速，并平均节省 23%/47% LUT 和 68%/78% FF；相对 Dahlia-Calyx flow，Cement 获得 3.49x 几何平均加速，并节省 54% LUT 和 82% FF。Systolic array case study 中，CmtHDL 通过显式周期对齐降低开发成本，并相对 EMS 节省 49% LUT 和 23% DSP，频率提升 7%，throughput per DSP 提升 33%。Sparse accelerator case study 中，CmtHDL 用更少代码描述 shuffler，并相对 Vitis HLS 方案提升频率、显著节省 LUT/FF。这些结果说明，硬件前端的价值不仅在于“写得更快”，也在于使时序行为可预测、可检查、可综合优化 @cement2024。

== 面向硬件实现质量的前端抽象与综合机制：Clay

Clay 与 Cement 不是版本递进关系，而是面向不同硬件实现问题的互补工作。Cement 关注 FPGA 设计前端如何显式表达周期行为和控制逻辑；Clay 则回到 ASIP/ISAX 场景，关注自定义指令如何在不同处理器微架构和 coupling strategy 下获得灵活、高质量实现。现有 ASIP 工具通常从高层 ADL 生成硬件和软件 artifacts，但许多工具只支持特定处理器上的 in-pipeline coupling strategy，导致两类限制：一是指令扩展被限制在 stateless behavior，难以实现高效 loop 等状态化控制；二是 register file 和 memory interaction 被固定微架构约束限制，阻碍自定义指令跨处理器部署 @clay2025。

Clay 提出 open-source high-level ASIP framework，核心是把不同 coupling strategies 抽象为 microarchitecture-agnostic actions 和 microarchitectural attributes。Clay ADL（CADL）将接口 action 与高层语法结合，用于描述一般、可带状态的 instruction behavior；microarchitecture-aware synthesis flow 则把 microarchitectural attributes 建模为约束，并为每条自定义指令选择合适 coupling strategy 与调度实现 @clay2025。这个设计相当于把第二章讨论的“架构接口”进一步细化到实现层：同一个指令语义在不同处理器、不同耦合位置、不同寄存器/内存访问路径下，其最佳实现可能不同，工具必须把这些微架构属性放入综合决策。

从本章角度看，Clay 的贡献在于把 ASIP 前端表达与硬件实现质量直接关联起来。APS 强调跨 RoCC/CV-X-IF 的统一 transaction 接口，Aquas 强调复杂访存接口选择，ISAMORE 强调可复用指令发现；Clay 则进一步追问：当一个自定义指令已经被选中并描述出来，应该以何种 coupling strategy 接入处理器流水线或协处理器接口，如何表达 stateful behavior，如何调度 register/memory interactions，如何在 Clay-core 和 Rocket-core 等不同 RISC-V processors 上获得稳定性能收益。Clay 在 diverse workloads 上展示了跨两类 RISC-V processors 的 substantial performance improvements @clay2025，这说明微架构感知不是实现细节，而是决定自定义指令能否灵活部署和高效执行的关键。

Clay 因此在本章承担连接第二章与第三章的角色。它继承第二章中领域定制与 ASIP/ISAX 的问题对象，但把关注点从“识别和接入能力”转向“如何高质量实现能力”。它也与 Cement 形成互补：Cement 通过 event/control 表达和 timing analysis 解决一般硬件行为的周期确定性；Clay 通过 microarchitecture-agnostic actions、microarchitectural attributes 和 synthesis constraints 解决 ASIP 指令扩展在不同处理器微架构上的实现质量问题。二者共同说明，高质量硬件实现需要前端表达携带足够的时序、接口和微架构事实，而不是把这些事实留给后端黑盒工具猜测。

== 变换、映射与调度联合优化：SkyEgg

前面三个小节分别从基础设施、前端时序表达和微架构感知 ASIP 综合角度讨论硬件实现质量。SkyEgg 则进一步指出，许多硬件综合质量问题并不是单个前端或调度器可以解决的，而来自 algebraic transformation、operation mapping 和 scheduling 被人为拆成固定顺序的阶段。传统 HLS 通常先进行若干前端优化，再调度到时钟周期，最后把操作绑定到资源或 IP；但调度需要知道 mapping 的精确 latency 和 resource behavior，mapping 又依赖调度决定操作在何时执行，代数变换也可能是获得更好映射的前提。把这些阶段分开，会错过需要跨层联合选择才能发现的高质量实现 @skyegg2026。

SkyEgg 采用 e-graph 统一表达 algebraic transformation 和 hardware mapping design space。它把 MLIR 程序转换为 e-graph，并把 FPGA mapping candidates 也表示为 rewrite rules，使 operation rewrites 与 mapping choices 在同一个等价空间中展开。与传统 equality saturation 在饱和后用 cost extraction 选择单个表达式不同，SkyEgg 将 extraction 改写为 scheduling problem：在饱和后的 e-graph 上用 ILP 选择合法的 mapping 和 schedule，并以全局性能为目标进行优化。这个 formulation 能同时考虑表达式变换、资源映射和时序安排，使“哪种代数形式更好”不再只由软件代价模型决定，而由具体硬件 mapping 和 schedule 的综合结果决定 @skyegg2026。

为了提高可扩展性，SkyEgg 还提出 ASAP heuristic scheduler，在保持接近 ILP 性能收益的同时显著降低求解时间。评估中，SkyEgg 相对 Xilinx Vitis HLS 在多类 benchmark 上获得 3.10x 平均加速、最高 5.22x 加速；ILP 和 ASAP scheduler 在 FF/LUT 使用上保持竞争力，并且所有 SkyEgg 设计都满足 timing constraints，而 Vitis HLS 在高目标频率下有 48% case 不能 meet timing。ASAP heuristic 可以在一秒内扩展到超过 600 个 operations，同时维持主要性能收益 @skyegg2026。

SkyEgg 是本章的方法高潮，因为它把前三节强调的几个判断合到同一个优化框架中。HECTOR 说明硬件综合需要 IR 化和多层方法学支撑；Cement 说明时序行为必须显式表达并可检查；Clay 说明微架构属性和 coupling strategy 必须进入综合约束；SkyEgg 则说明一旦这些事实进入 IR/设计空间，工具还需要避免固定 pass order 和阶段割裂，把变换、映射与调度作为联合问题求解。由此，本章从“如何表达硬件”推进到“如何在语义等价空间和硬件映射空间中选择高质量实现”。

这一点也自然引出第四章。SkyEgg 仍主要依赖预定义 rewrite rules、mapping candidates、ILP/heuristic scheduler 和工程化 cost formulation；随着设计空间变大，哪些规则应当被应用、哪些策略能在不同任务上复用、如何把专家经验和历史证明转化为可审计策略，成为新的问题。第四章中的 EggMind 正是在 SkyEgg/ISAMORE 所代表的 e-graph 优化基础上，把 LLM 的策略生成能力纳入形式化可控的 EqSat 策略对象中，进一步讨论大模型与形式化技术如何共同服务软硬件协同。

== 本章小结

本章回应第一章提出的第二个科学问题：架构能力如何高质量落到可综合、可验证、性能与资源可控的硬件实现。HECTOR 提供了基于 MLIR 多层 IR 的早期硬件综合基础设施视角，说明硬件实现质量需要结构化 IR 和 lowering 流程支撑。Cement 强调前端必须显式表达周期行为，并通过 timing analysis 与 FSM synthesis 保证硬件行为可预测、可检查、可综合优化。Clay 将这一问题带回 ASIP/ISAX 场景，强调 coupling strategy、microarchitectural attributes 和 synthesis constraints 对自定义指令实现质量的决定性作用。SkyEgg 则进一步把 algebraic transformation、operation mapping 和 scheduling 统一到 e-graph 设计空间中，避免固定阶段顺序造成的次优实现。

这些工作共同说明，高质量硬件实现不是后端工具的附属结果，而需要从前端表达、IR 设计、时序语义、微架构属性、映射选择和调度求解共同组织。它们也为下一章奠定了方法基础：当 e-graph、MLIR、硬件 IR 和综合反馈成为软硬件协同的核心对象后，大模型和 agentic 方法若要进入这一流程，就必须操作这些结构化对象，并受到形式化语义、验证检查和执行证据约束。

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
