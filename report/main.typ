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
