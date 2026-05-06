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

=== APS：统一 ISAX 接口与端到端 ASIP 工具链

APS 的出发点是开放 RISC-V ASIP 生态中的端到端割裂。RoCC 和 CV-X-IF 等接口都采用处理器与自定义单元解耦的握手式交互，但二者在 commit/recall、issue/response、内存访问和控制信号组织上存在差异。RoCC 偏向简化加速器设计，并由处理器侧保证 offloaded instruction 的提交；CV-X-IF 则显式暴露 commit channel，使带副作用的操作必须等待确认后才能执行。二者具有相近的交易语义，却因为协议细节、实现语言和平台生态不同而难以复用同一 ISAX 设计。APS 因此提出 transaction-based 的统一 ISAX 接口抽象 APS-itfc，把 issue、GPR request、recall、memory read/write、memory response 和 result response 等交互统一为 valid-ready transaction，并通过 backend adapter 自动映射到 RoCC 或 CV-X-IF @aps2025。

APS-itfc 的意义不只是隐藏接口信号差异，而是为后续硬件合成和编译支持建立共同边界。自定义指令单元只需要面向统一 transaction 语义描述与处理器的交互，RoCC 或 CV-X-IF 的 tag、size、commit/recall 等平台细节由 adapter 处理。APS 在 Rocket/Chipyard 与 CV32E40X/Croc 两个开源 RISC-V 平台上实现这一抽象，并补充参数化 cache、Verilator cycle-accurate simulation、Yosys/OpenROAD ASIC flow 等工具链环节，使同一类定制能力能够在不同 SoC 框架中完成集成、仿真和物理实现评估。这一设计回答了 ASIP 研究中的第一层问题：领域能力必须有一个跨平台、可落地的架构接口，否则后续合成和编译优化会被具体处理器协议锁死。

在硬件侧，APS 通过 CADL 和 APS-synth 提供 ISAX-specific synthesis。CADL 允许设计者描述自定义指令的高层行为，同时直接访问统一 APS-itfc transaction 和低层硬件组件；其描述内容被降低为 Structured IR（SIR）和 Scheduled Structured IR（SSIR）。SIR 保留 sequence、block、loop、loop-carried variables、method call 等结构，便于类型推导、函数解释和程序优化；SSIR 则把调度结果表达为 pipeline/stage 结构，用于估计性能并生成硬件。APS-synth 在调度中加入自定义指令特有约束，例如 register-file read 必须位于触发阶段、latency-insensitive operations 不能错误并列以避免 deadlock，并最终构造 transaction-based dynamic pipeline。这使 APS 不仅能生成组合逻辑式指令，也能描述带状态、循环、流水和自定义组件的更复杂 ISAX 行为 @aps2025。

在软件侧，APS 提供 APS-c 编译框架，把 CADL 语义导出为编译器可用的匹配信息，并在 LLVM 中生成 intrinsic-like C wrappers、semantic-based matcher、profile-guided matcher 和 bitwidth-aware vectorization。semantic-based matcher 面向控制较简单的 IR 模式，自动识别等价指令序列并替换为 ISAX 调用；profile-guided matcher 面向复杂循环或控制区域，通过解释执行和 input-output 行为比较辅助发现可以 offload 的代码区域。bitwidth-aware vectorization 则针对 RV32 等架构中低位宽操作无法充分利用寄存器位宽的问题，把多个低位宽 scalar ISAX 调用打包为 SIMD-style ISAX，并在超过寄存器带宽时自动插入辅助 memory/config 操作。由此，APS-c 把自定义指令从“需要程序员手写 intrinsic”推进到“编译器根据硬件语义自动发现和使用”的形态 @aps2025。

APS 的评估覆盖后量子密码、量化 LLM 和数字信号处理三个领域，展示了端到端工具链的实际效果。在 CRYSTALS-KYBER 中，NTT butterfly 与 PWM/Karatsuba 等 ISAX 用约 175 行 CADL 描述，并在两个 RISC-V 平台上获得明显加速；Butterflyx2 在两个平台上最高达到 10.16x，Karatsuba 对 PWM baseline 最高达到 14.99x。在 BitNet b1.58 的 BitLinear 场景中，dotprodW2A8x4 ISAX 针对 8-bit activation 与 2-bit weight 的 dot product，完整 BitLinear 层获得 2.03x 和 2.29x 加速，并可由 profile-based matcher 自动利用。在 DSP 场景中，SOS 与 IIR ISAX 支撑 DPLL 中的 IIR filter 加速，IIR 指令通过深流水和硬件 loop 消除软件调用与循环开销，在 Croc 和 Rocket 上分别获得 5.51x 和 5.18x 加速。这些结果说明 APS 的价值不仅是某个指令加速，而是把指令设计、硬件合成、编译插入、仿真评估和 ASIC PPA 反馈连成完整敏捷迭代流程 @aps2025。

然而，APS 也暴露出下一层挑战。它已经把自定义指令接入统一接口和编译流程，但在复杂数据密集应用中，性能往往受限于存储层次、接口带宽、cache 行为和更复杂的软件变体。APS 的 CADL 和编译器能够描述较一般的行为，但对块级内存访问、scratchpad 使用、burst transfer、cache hierarchy mismatch、复杂 loop transformation 和鲁棒 ISAX matching 的支持仍不充分。换言之，APS 建立了端到端协同框架，但当领域定制从 scalar/SIMD-like 指令推进到更复杂的 memory-centric ISAX 时，架构接口必须进一步显式表达访存机制和 cache effects，编译器也必须在更大的程序等价空间中进行稳健匹配。

=== Aquas：数据密集 ISAX 的硬件-软件协同优化

Aquas 正是沿着这一方向推进。它仍以 ASIP/ISAX 为对象，但把问题从“统一接口和基本端到端流程”扩展为“复杂数据密集 ISAX 的硬件-软件整体协同优化”。在硬件侧，Aquas 首先建立 core-ISAX memory interface model，用宽度、最大 beat count、in-flight transaction 数、读 lead-off latency、写完成代价和 cache-line size 等参数刻画不同访问路径。这个模型说明，接口选择并非微小实现细节：窄低延迟接口和宽高延迟接口在不同访问粒度、burst 能力和 cache 层次下会产生不同性能结果，错误选择可能引入 7 到 9 cycle 的局部延迟惩罚，并在更大设计中放大为系统性能损失 @aquas2026。

为了把这些硬件事实纳入合成，Aquas 设计了三层 Aquas-IR。functional level 接近高层软件语义，描述 transfer、fetch 等与具体访问机制无关的操作；architectural level 引入 `memitfc` 符号，把 memory operation 绑定到具体接口，并使其受到对齐、transaction size、in-flight limit 等微架构约束；temporal level 则用异步 issue/wait 和 ordering attribute 表达事务顺序、cache 层次和有限并发下的具体时序。基于这一 IR，Aquas 进行 scratchpad buffer elision、interface selection and canonicalization、transaction scheduling and ordering，以及最终硬件生成。其关键意义在于，访存接口选择不再是手工经验或后端偶然结果，而成为可分析、可搜索、可在 IR 中回放的架构决策 @aquas2026。

在软件侧，Aquas 进一步解决复杂 ISAX offloading 的鲁棒编译问题。复杂 ISAX 的语义常与应用代码存在抽象层次差异：软件表示关注 value、control flow 和 memory effect，而硬件描述中可能包含 scratchpad、寄存器交互和接口传输语义。Aquas 首先把软件代码通过 Polygeist 转到 MLIR 基础 dialect，并把 Aquas-IR functional level 中的硬件语义规范化到同一抽象层次。随后，它把 MLIR 与 e-graph 结合：MLIR 保留结构化控制流和 side-effect ordering，e-graph 非破坏性地累积等价程序变体；internal rewrites 用于代数和数据流变换，external rewrites 则通过调用 MLIR loop passes 实现 tiling、unrolling 等控制流重构。为了避免 e-graph 爆炸，Aquas 根据目标 ISAX 的 loop characteristics 有选择地触发外部重写，最后通过 skeleton-component matching 检查控制结构、数据流组件、dominance、ordering 和 effect constraints，自动插入 ISAX 调用 @aquas2026。

这种设计把 APS 中的自动 intrinsic insertion 扩展到更复杂的语义空间。APS 的 pattern matching 已经能够处理部分语义和 profile-based 场景，但 Aquas 更强调：同一个 ISAX 可能对应许多语法不同、控制流形态不同、但语义等价的软件实现；编译器若只匹配单一模式，会被 loop tiling、unrolling、代数变换、冗余语句和非 affine 表达轻易破坏。因此，Aquas 把“匹配一个模式”转化为“在受约束的等价空间中寻找与目标 ISAX skeleton/components 对齐的程序变体”。这使编译接口更接近第一章所说的 harness medium：目标事实、IR 表示、rewrite、matching、cost model 和证据共同约束 offloading 决策。

Aquas 的评估进一步说明了这一复杂协同的必要性。它在后量子密码、点云处理、图形渲染和 CPU LLM 推理四类场景中评估真实 workload。对于 code-based PQC 的 syndrome computation，Aquas 为 bitstream unpacking 和 GF(2^n) matrix multiplication 设计 ISAX，并在 Rocket baseline 上获得 7.59x 和 3.29x kernel speedup，端到端获得 1.42x speedup，面积开销小于 5.3% 且无频率下降。在点云 ICP 场景中，Aquas 针对 Euclidean distance、covariance matrix、maximum comparison 和 matrix-vector multiplication 等操作设计 ISAX，kernel speedup 达到 1.46x 到 9.27x，端到端达到 1.96x；其优势来自对不规则访存、矩阵/向量混合访问和扩展总线带宽的更好利用。在图形渲染中，Aquas 与 RISC-V vector unit Saturn 比较，多个 kernel 获得 9.47x 到 15.61x 加速，并在性能面积权衡上优于通用向量单元。在 CPU LLM 推理的 FPGA prototype 中，Aquas 针对 attention computation 设计 ISAX，在 Llama 2 110M 8-bit 量化模型上获得 9.30x TTFT 和 9.13x ITL 加速。这些结果说明，当应用具有复杂访存和控制形态时，端到端协同必须同时考虑硬件访存接口、编译等价空间和真实系统评估 @aquas2026。

从研究链条看，APS 和 Aquas 共同回答了“如何把定制能力端到端接入工具链”这一问题。APS 建立了跨 RISC-V 平台的统一接口、ISAX-specific synthesis 和自动编译插入，使领域能力能够从 CADL 和 C 程序进入可仿真、可综合、可评估的 SoC。Aquas 则进一步把复杂数据密集场景中的访存接口、cache hierarchy、MLIR/Aquas-IR、e-graph 重写和 skeleton-component matching 纳入同一流程，使定制能力不仅能接入工具链，还能在更复杂硬件事实和软件变体中被正确、鲁棒、有效地使用。二者为后续 ISAMORE 提供了基础：当端到端接入问题被系统化以后，下一步关键就变成如何从应用集合中自动发现真正值得接入这些接口的可复用架构能力。

== 可复用自定义指令识别：ISAMORE

=== 研究背景与问题建模

APS 和 Aquas 解决的是“如何把定制能力接入端到端工具链”的问题，但它们仍然预设设计者已经知道哪些能力值得定制。对于敏捷芯片设计而言，这个前提并不总成立。自定义指令会占用面积、引入验证负担，并影响处理器接口、编译器后端和系统维护；如果一个指令只服务于少数局部热点，它即使在单个 kernel 上有效，也很难成为长期可复用的架构能力。因此，在端到端接入工具链之上，还需要回答一个更前置的问题：从一组领域代表程序中，如何自动发现具有跨程序、跨工作负载价值的可复用自定义指令。

传统自动指令发现大多以程序热点和语法结构为中心。细粒度方法枚举 basic block 内的 convex subgraph，能够找到局部可替换片段，但受限于基本块范围和较小模式，容易错过更大粒度的优化机会；粗粒度方法把 basic block 或代码区域整体合并为加速单元，能够覆盖更多操作，却常生成过大的专用硬件，复用次数低，甚至包含在通用处理器上更适合执行的指令序列。二者共同的问题是过度依赖 syntactic analysis：如果两个代码片段语法不同但语义等价，它们往往被视为不同模式，最终产生多个相似但不共享的硬件单元。ISAMORE 的问题意识正来自这一点：真正适合作为 ISA 扩展的能力，不应只是某个热点中的语法片段，而应是语义上可泛化、在多个位置反复出现、且硬件代价与性能收益匹配的模式 @isamore2026。

ISAMORE 将可复用自定义指令识别建模为 reusable instruction identification，并提出 RIMT 方法。其输入是一组领域代表程序，输出是一组在性能和面积之间形成 Pareto trade-off 的自定义指令候选。这个过程首先把 LLVM IR 转换为结构化 DSL，再编码为 e-graph；随后通过 phase-oriented equality saturation 和 e-graph anti-unification 发现语义等价空间中的公共模式；最后用硬件感知 cost model 选择值得实现的模式，并通过 HLS 和 RoCC wrapper 等后端生成可评估硬件。与 APS/Aquas 相比，ISAMORE 的位置更靠前：它不只是让编译器使用已有 ISAX，而是帮助设计者决定哪些 ISAX 值得进入后续工具链。

=== 结构化 DSL 与 E-graph Anti-unification

为了让一般程序能够进入 e-graph anti-unification，ISAMORE 首先设计 structured DSL。该 DSL 覆盖 arithmetic、logical、memory access 等常规操作，同时引入 `Loop` 和 `If` 表达控制流，并提供 `Vec`、vector unary/binary/ternary operations、pattern variables 和 `App` 等结构。`Loop` 以 do-while 风格表达 loop-carried variables、loop condition 和 body result，使控制流能够以结构化、数据流中心的方式进入 e-graph。该 DSL 还具有强类型系统，利用 e-class analysis 推导每个 e-class 的 result type，并对 `If` 和 `Loop` 的输入输出 tuple 施加结构约束。这个设计解决了直接把一般程序放入 e-graph 的第一层障碍：程序不再只是若干代数表达式，而是保留了循环、条件、类型和向量结构的可泛化语义对象 @isamore2026。

在此基础上，ISAMORE 的核心方法是 e-graph anti-unification。e-graph 用 e-class 表示等价项集合，equality saturation 通过重写规则暴露语义等价形式；anti-unification 则在两个项之间求 least general generalization，从而发现公共结构。例如，两个语法不同但可重写到同一等价形式的表达式，可以被泛化为带 pattern variables 的候选指令模式。这个思路把“复用”从语法匹配提升到语义等价空间：同一个自定义指令可以覆盖多个表面形态不同的程序片段，只要它们在 e-graph 中共享可泛化结构。

=== Phase-oriented RIMT 与 Smart AU

直接使用 vanilla e-graph AU 并不可行，因为真实程序的 e-class 数量和候选 AU pattern 数会迅速爆炸。ISAMORE 因此提出 phase-oriented iteration。它放弃一次性对所有重写规则做完整饱和，而是把规则按 saturating/nonsaturating、int/float、vector/scalar 等维度组织为 base rulesets，并由 phase scheduler 逐步选择规则集。早期阶段先应用不会显著增加 e-class 的 saturating rules，尽可能暴露低成本等价形式；后续阶段再以受限次数应用 nonsaturating rules，以避免 e-graph 规模失控。每个 phase 中，RIMT 会把以前识别的 pattern 作为 pattern-application rewrites 重新注入 e-graph，使后续阶段能够在已有模式的基础上进一步泛化。这样做既控制了搜索规模，又允许指令模式从局部公共结构逐渐演化为更高复用度的候选 @isamore2026。

RIMT 的第二个关键是 smart AU。vanilla AU 需要枚举大量 e-class pair，并对每对 e-node 递归生成候选 pattern，实际复杂度很快失控。smart AU 用两类启发式降低复杂度。第一是 similarity-based e-class pairing：ISAMORE 用类型信息排除 result type 不一致的 e-class，再通过 structural hashing 估计 e-class 的结构相似度，只对相似度超过阈值的 pair 做 AU。structural hashing 对字面量、参数和 pattern variables 做统一处理，强调结构而非具体常量，从而更适合寻找可复用模式。第二是 heuristic AU pattern sampling：当某个 e-node pair 的 AU 候选过多时，ISAMORE 不保留全部 Cartesian product，而用 boundary 或 kd-tree 策略根据 latency/area 特征选取代表性 pattern。前者保留特征值极端的模式以提高效率，后者在特征空间中取更广覆盖以改善质量。二者共同使 e-graph AU 从理论上有吸引力但不可用的方法，变成可以处理真实程序的指令识别机制 @isamore2026。

=== 向量化、硬件感知选择与真实系统评估

除了语义复用，ISAMORE 还把 data-level parallelism 纳入指令发现过程。传统指令发现往往把 scalar pattern 作为主要对象，即使程序中存在多路相似操作，也不一定生成向量化自定义指令。ISAMORE 的 pattern vectorization 把一个 vectorized pattern 看作同一个 pattern 在多个 lane 上的应用。其流程先通过 smart AU 找到可重复出现的 scalar seed，再把同一 basic block 中的多个 seed pack 成 `Vec` 节点；随后通过 lift rewrites 恢复 VecAdd、VecMul 等向量构造，并用 couple rewrites 建立 vector 到 scalar lane 的数据流；最后用 greedy extraction 和 compress-style pruning 消除 `Get-Vec-Get` cycle 与组合式 packing 爆炸，只保留高 DLP 的非重叠向量化方案。这使自定义指令发现不局限于“找到一个可复用 scalar 片段”，而能同时探索向量化、硬件 loop 和更高吞吐的数据通路 @isamore2026。

在选择指令候选时，ISAMORE 不使用 AST size 这类硬件无关目标，而使用 profiling-based、hardware-aware cost model。对每个 pattern，它估计该 pattern 在所有使用位置替换为硬件单元后节省的总延迟：软件延迟来自 profile 得到的 cycles-per-operation，硬件延迟来自轻量 HLS 对 pattern 行为的 scheduling，面积来自 HLS/OpenROAD 估计。RIMT 通过 e-class analysis 在 e-graph 中传播 Pareto front，把 pattern set 的 speedup 与 area overhead 作为多目标选择依据，并在 extraction 后重新计算更准确的性能面积指标进行 fidelity refinement。这个设计保证 ISAMORE 发现的不是“语法上好看”或“项数更少”的模式，而是具有实际性能收益和可接受硬件代价的架构能力 @isamore2026。

ISAMORE 的 benchmark 评估展示了这种方法的可扩展性和收益。在九个来自计算机视觉、机器感知、数字信号处理和密码学的 kernel 上，vanilla e-graph AU 因候选 pattern 爆炸而在所有案例中超过 30GB 内存限制；启用 RIMT 后，所有 benchmark 均在 145 秒内完成，内存不超过 799MB，峰值 e-graph size 相比 vanilla 方法降低 6 到 39 倍。在性能上，ISAMORE 相比 NOVIA 等语法合并方法获得更高 speedup 和更低面积开销；启用 vectorization 后，ISAMORE 相对 NOVIA 的优势平均达到 1.76x，最高达到 2.69x，并在多个 benchmark 中展示 pattern vectorization 对性能的进一步贡献。MatChain 案例还表明，structured DSL 编码控制流后，ISAMORE 可以识别可复用 hardware loop，生成 loop pipeline accelerator，获得远超基本块级方法的优化粒度 @isamore2026。

更重要的是，ISAMORE 在真实开源库和具体硬件实例中体现了“可复用架构能力”的价值。对 liquid-dsp、CImg 和 PCL 等库的研究显示，语法合并方法往往生成巨大且低复用的硬件单元，而 ISAMORE 能识别多个更小、更高复用的自定义指令。在 CImg 中，NOVIA 生成一个 size 为 167 的大硬件单元且只合并少量基本块，ISAMORE 则识别八条平均复用 93 次的指令，获得 1.18x speedup，同时面积仅为 975 平方微米，相比 NOVIA 节省 90.5% 面积。在 PCL modules 中，ISAMORE 相比 NOVIA 平均获得 1.64x speedup，最高 2.73x，并节省 93.2% 面积。这些数据说明，可复用性不是附加指标，而是决定自定义指令是否适合进入 ISA 的核心标准 @isamore2026。

ISAMORE 还在量化 LLM 和后量子密码中展示了从自动识别到真实硬件集成的可行性。对 BitNet b1.58 的 BitLinear 推理实现，ISAMORE 从 `bitnet.cpp` 风格实现中识别出 packed low-bit dot product 的向量化模式，并生成带 RoCC wrapper 的自定义硬件单元；在 Rocket tile 上通过 Verilator RTL simulation 获得 2.15x BitLinear speedup，OpenROAD 报告 4.81% area overhead 且无频率下降。对 CRYSTALS-KYBER 的 NTT 实现，ISAMORE 自动识别 forward NTT 和 inverse NTT 复用的 butterfly custom instruction，并在 Rocket tile 上获得 5.15x speedup，面积开销主要来自硬件乘法器。这些案例证明，ISAMORE 不只是静态分析工具，而能够与 RISC-V/SoC、HLS、RTL simulation 和 physical design flow 连接，进入实际敏捷芯片设计流程 @isamore2026。

从本章主线看，ISAMORE 对 APS/Aquas 形成了关键补充。APS/Aquas 使一个已知定制能力能够被架构接口承载、被硬件工具实现、被编译器调用并被系统评估；ISAMORE 则反过来从领域程序集合中发现哪些能力值得进入这一流程。其方法创新在于把 e-graph equality saturation、anti-unification、structured control-flow DSL、phase-oriented search、smart AU、pattern vectorization 和 hardware-aware selection 结合起来，使“可复用自定义指令”成为可自动发现、可量化权衡、可硬件落地的敏捷芯片设计机制。由此，领域定制不再完全依赖专家凭经验挑选热点，而可以通过程序语义、硬件代价和跨工作负载复用共同驱动。

== 微架构感知定制：Cayman

=== 研究背景与整体框架

APS、Aquas 和 ISAMORE 分别从端到端接入、复杂访存协同和可复用指令发现三个角度推进了领域定制处理器研究。Cayman 则把这一链条进一步推向微架构感知的 custom accelerator generation。与 ISAX 更强调处理器指令接口不同，Cayman 面向的是从应用程序中自动选择适合硬件加速的 kernel，并生成高性能自定义加速器；它关注的重点不只是“是否把某个代码片段硬化”，而是该片段是否包含复杂控制流、如何组织数据访问、如何通过 processor-accelerator interface 降低数据移动代价，以及多个加速器之间是否可以合并和复用 @cayman2025。

Cayman 的问题背景与本章前两节自然衔接。APS 说明，如果缺少统一接口和合成/编译工具链，自定义能力难以跨平台落地；Aquas 说明，如果不显式建模访存接口和 cache effects，复杂数据密集 ISAX 会被错误的内存路径和低效数据移动限制；ISAMORE 说明，如果只从局部热点做语法合并，自定义硬件会过度专用、复用度不足。Cayman 面对的是同一矛盾在 accelerator generation 场景中的体现：HLS 可以从给定 kernel 合成硬件，但 kernel 的选择和抽取仍常依赖人工；而真实应用中的候选区域可能包含一般控制流、复杂数据访问和多个可复用加速单元，不能只靠简单 loop 或 basic-block 规则决定。

Cayman 的整体流程从应用程序出发，将程序编译到 LLVM IR，并构建 whole-application program structure tree（wPST）表示；同时，系统通过 profiling 和 LLVM program analysis 收集每个候选区域的运行时间、执行次数、内存依赖、访问模式和 footprint。随后，Cayman 基于 wPST 和分析结果进行 candidate selection，生成由多个 kernel 与 accelerator configuration 组成的候选解；对每个候选解，系统进一步执行 accelerator merging，得到可复用加速器，并最终综合硬件设计。这个流程把“候选区域选择”和“硬件实现质量”放入同一框架，而不是让 HLS 后端被动接受人工选择的 kernel @cayman2025。

=== wPST 表示、Profiling 与程序分析

Cayman 引入 wPST 的原因在于，传统 data-flow graph 级自定义硬件生成难以处理真实程序中的控制流和跨函数结构。Program structure tree（PST）本来用于识别函数内 single-entry-single-exit（SESE）region；Cayman 将其扩展为 whole-application program structure tree，在根节点下加入函数节点，并把每个函数中的 SESE region 表示为候选区域。SESE 约束很关键：只有具有单入口和单出口的区域，才能在 offloading 后通过入口/出口处的同步与主处理器隔离执行，从而形成清晰的 processor-accelerator 边界。wPST 中的候选区域包括 basic block region 和包含 loop/conditional 的 control-flow region，使候选选择不再局限于平坦 DFG @cayman2025。

仅有区域树仍不足以决定哪些区域值得加速。Cayman 因此对应用进行 profiling，记录每个 region 的持续时间和执行次数，用于定位 hotspot 并估算潜在性能收益；同时执行程序分析，收集 memory dependency、memory access pattern 和 access footprint。具体而言，系统识别 loop-carried dependency，以判断 loop pipelining 或 unrolling 是否可行；识别 stream access pattern，以判断地址序列是否可静态生成；分析每个 memory operation 的访问范围，以估计 scratchpad 大小和缓存收益。这些分析结果直接进入后续加速器配置，而不是作为孤立的诊断信息 @cayman2025。

=== 加速器建模与数据访问接口选择

Cayman 的关键贡献之一是把 processor-accelerator data access interface 显式纳入建模。其模型包含三类接口。Coupled interface 使用 load/store unit 访问存储系统，加速器在发出访问请求后等待响应，面积开销较低但容易产生 stall。Decoupled interface 为 load/store unit 配置独立 address generation unit（AGU），使 load 可以提前发起、store 可以延后提交，从而减少加速器等待；其代价是需要 AGU 和 FIFO buffering，并且只适用于地址可静态生成的 stream access。Scratchpad interface 在加速器内部保留专用 buffer，通过 DMA 在加速器执行前后与存储系统同步，适合访问 footprint 小且重复访问多的内存区域，但需要 scratchpad buffer、DMA engine 和静态 footprint 信息 @cayman2025。

这些接口不是简单工程选项，而直接影响控制流优化是否能转化为性能收益。例如在顺序 loop 中，decoupled interface 可以减少 load stall；在 loop pipelining 中，coupled interface 可能使 initiation interval 受限，而 decoupled interface 能使 II 接近理想值；在 loop unrolling 中，scratchpad 可以为多个并行访问提供本地带宽。Cayman 因此为选定 kernel 合成多种 accelerator configuration，组合 loop unrolling、loop pipelining 和数据访问接口策略。其启发式策略是：对无 loop-carried dependency 的 loop 尝试 unrolling，对最内层 loop 做 pipelining；当访问总次数显著大于 footprint 时使用 scratchpad，当 pipelined loop 中需要提前/延后访问时使用 decoupled interface，其余情况选择 coupled interface 以节省面积 @cayman2025。

为了避免对每个候选都完整综合硬件，Cayman 还构建性能和面积估计模型。该模型先根据配置对 kernel 做 loop unrolling，再只综合 pipelined loop region 和 sequential basic block region，最后自底向上估计外层 region 的 cycle count 和 area。对于每个基本调度单元，cycle count 来自调度延迟与 profiling execution count，area 来自综合报告；外层 region 的 latency 则由子区域累加并加上控制逻辑开销。结合原始程序总时间、被加速候选区域的 profile 时间和目标频率，Cayman 可以快速估算整体 speedup，从而支持候选选择中的大规模探索 @cayman2025。

=== 候选选择算法与加速器合并

基于 wPST，Cayman 将 candidate selection 建模为带有树形互斥约束的 knapsack problem。每个 wPST region 是一个候选 item，其 profit 是加速后的性能收益，weight 是面积开销；约束是如果选择某个 region，其所有后代 region 不能再被选择，以避免同一程序区域被重复 offload。Cayman 使用 dynamic programming 求解该问题：对每个 wPST 节点 `v`，维护其子树内 Pareto-optimal solution sequence `F[v]`；若 `v` 是 basic block，则候选来自该 basic block 的加速配置；若 `v` 是 control-flow region，则在“直接加速该 region”和“组合其子节点解”之间取 Pareto frontier；若 `v` 是根节点，则组合不同函数的解。为了控制复杂度，Cayman 还使用 profiling/analysis-based pruning 跳过不值得加速的 region，并通过 solution filtering 移除面积过近的 Pareto 解，使每个子问题的解数量保持在可控范围内 @cayman2025。

候选选择解决“哪些区域加速”的问题，但如果每个区域都生成独立加速器，面积可能迅速膨胀。Cayman 因此提出 accelerator merging。其核心观察是，多个 region 即使控制流不同，也可能包含相似的 basic block dataflow；数据通路中的浮点运算和 memory access 往往占主要面积，而控制 FSM 相对较小。因此，Cayman 将 basic block 中共享操作合并为 reconfigurable datapath unit，通过 multiplexers 和 reconfiguration bit registers 选择不同数据路径；每个原始 region 保留独立 FSM，执行时由 global control unit 发送配置并触发对应控制逻辑。系统以启发式方式估计每对 basic block 合并后的面积节省，反复合并节省最大的 pair，直到没有进一步收益 @cayman2025。

=== 实验评估与意义

Cayman 的评估使用 PolyBench、MachSuite、MediaBench 和 CoreMark-Pro 等多类 benchmark，并与 NOVIA 和 QsCores 两个 automated accelerator synthesis framework 比较。实验设置中，目标频率为 500 MHz，面积以 CVA6 RISC-V tile 为归一化基准，并评估小面积预算（25%）和大面积预算（65%）两种情况。在 25% 面积预算下，Cayman 相对 NOVIA 和 QsCores 分别取得平均 14.4x 和 8.0x speedup；在 65% 预算下，优势扩大到 27.2x 和 15.0x。这一结果来自 Cayman 对 control flow optimization 和 data access interface specialization 的联合支持，而 NOVIA 不支持 control flow/memory access，QsCores 则主要生成顺序控制流和较慢访问接口 @cayman2025。

更细的结果说明 Cayman 的收益来自机制本身，而不只是更多面积。对于 hotspot 分布均匀的程序，Cayman 在面积预算增大时选择更多 kernel；对于 hotspot 集中的程序，则把更多面积集中用于关键区域。接口选择结果显示，decoupled 和 scratchpad interface 被广泛采用，说明数据访问接口 specialization 是性能来源之一。Accelerator merging 在两个面积预算下分别节省约 36% 和 35% 面积，每个 reusable accelerator 平均加速多个程序区域；在包含相似 basic block 的 3mm benchmark 中，面积节省可达 70% 以上，而在只有单个 hotspot 的 doitgen 中收益较低。这些现象与 Cayman 的设计预期一致：当程序中存在丰富控制流、重复数据通路和复杂访存时，wPST、接口建模、候选选择和 merging 的联合设计才能发挥作用 @cayman2025。

从本报告的角度看，Cayman 的意义在于把“架构接口”从指令级扩展到更完整的 processor-accelerator 协同边界。自定义指令通常受寄存器操作数、指令编码和处理器流水线接口约束；自定义加速器则更强调 region/kernel 级语义、数据搬运、接口带宽、控制流调度和多个调用点之间的硬件复用。Cayman 补足了领域定制链条中的第三个层次：APS/Aquas 解决“如何接入”，ISAMORE 解决“定制什么”，Cayman 则强调“在何种微架构和接口约束下生成可复用加速器”。这使本章从指令扩展走向更一般的领域定制架构能力，为第三章讨论高质量硬件实现奠定了过渡基础。

== 本章小结

本章围绕第一章提出的第一个科学问题，讨论了应用需求如何通过架构接口转化为可复用的指令、微架构和加速器能力。APS 和 Aquas 从端到端工具链角度说明，领域定制能力必须同时具有硬件接口、合成实现、编译映射、系统评估和 PPA 反馈，才能从应用想法变成可迭代的 ASIP/ISAX 机制。ISAMORE 从可复用指令发现角度说明，自定义能力不能只来自局部热点，而应由程序语义、跨工作负载复用和硬件代价共同决定。Cayman 则把这一逻辑推进到 custom accelerator generation，强调 control flow、data access、processor-accelerator interface 和 accelerator merging 对领域定制能力选择的决定性作用。

这些工作共同表明，领域定制不是“发现热点并硬化”的线性过程，而是应用语义、架构接口、微架构约束、编译支持和硬件实现之间的协同过程。一个定制能力是否值得进入系统，取决于它能否跨应用复用、能否被编译器稳定识别、能否通过接口高效传输数据、能否在硬件中以合理面积和时序实现，并能否在真实 workload 中获得端到端收益。因此，本章既回答了“定制什么”和“如何接入”的问题，也自然引出下一章：当架构能力已经被识别并表达出来以后，如何把它们高质量地落到可综合、可验证、性能与资源可控的硬件实现中。

= 面向高质量硬件实现的前端抽象与综合优化

== 引言

第二章讨论了领域能力如何被识别、表达并接入架构接口，但架构能力本身并不等于高质量硬件实现。一个自定义指令、加速器 region 或硬件前端描述，只有在时序、面积、资源、接口协议、控制逻辑和验证条件都满足目标约束时，才能真正成为可部署的系统能力。因此，本章围绕第一章提出的第二个核心科学问题展开：架构能力如何高质量落到可综合、可验证、性能与资源可控的硬件实现。

这一问题的难点在于硬件实现质量来自多个层次的共同决定。RTL 能提供细粒度控制，但抽象层次低、生产率不足；HLS 能从软件描述生成硬件，却常把关键微架构决策隐藏在 pragma 和启发式调度之后；硬件 DSL 与 IR 试图提高表达能力和可分析性，但如果不能携带时序、资源和映射信息，仍难以形成可预测结果。因此，本章按 HECTOR、Cement、Clay、SkyEgg 的顺序组织：HECTOR 作为早期多层 IR 与硬件综合基础设施积累，提供后续工作的技术背景；Cement 关注周期确定型硬件行为表达；Clay 关注面向 ASIP 的微架构感知前端与综合机制；SkyEgg 则把代数变换、硬件映射和调度放入统一 e-graph 设计空间，形成对高质量硬件实现问题的进一步推进。

== 综合基础设施积累：HECTOR

=== 问题定位与技术框架

HECTOR 是本人较早参与的硬件综合基础设施工作，其意义在于把硬件综合问题从单一 HLS 工具实现，推进到基于多层 IR 的方法学表达。传统 HLS 工具、硬件生成器和领域专用 DSL 往往各自实现一套前端、IR、调度、生成和优化流程，工程成本高，方法难复用。HECTOR 提出基于 MLIR 的两层 IR：高层 IR 将 computation 与带 timing information 的 control graph 绑定，低层 IR 则用于描述硬件模块和 elastic interconnections，并可进一步转换为 synthesizable RTL @hector2022。

HECTOR 对本报告的作用不在于作为最重要的代表性工作展开，而在于提供了后续研究反复依赖的基础设施视角。它说明硬件综合可以被组织成多层 IR、转换 pass、调度信息和 RTL lowering 的组合，而不是只能依赖黑盒 HLS 或手写 RTL。基于这一思想，后续 Cement、Clay、SkyEgg 等工作都可以被理解为在不同维度上深化 HECTOR 开启的问题：Cement 强调前端语言必须显式表达周期行为和 timing constraints；Clay 强调 ASIP 指令扩展的 coupling strategy 和 microarchitectural attributes 需要进入综合约束；SkyEgg 则强调 algebraic transformation、mapping 和 scheduling 不应被拆成固定顺序的阶段。

=== 对后续工作的支撑

因此，HECTOR 在本文中承担“综合基础设施积累”的角色。它为本章后续讨论提供两个重要判断。第一，硬件实现质量需要 IR 层支撑，只有把控制、时序、模块连接和 lowering 边界显式化，后续方法才有可分析对象。第二，多层 IR 本身还不够，IR 中携带哪些时序、资源、接口和映射信息，决定了工具能优化到什么程度。Cement、Clay 和 SkyEgg 分别从前端时序表达、微架构感知综合和联合优化三个方向回答这一问题。

== 周期确定型硬件前端：Cement

=== 研究背景与设计目标

Cement 面向 FPGA 加速器设计中的一个长期矛盾：设计者需要硬件级别的微架构表达和时序控制，但 RTL 生产率低、HLS 结果难预测、许多 DSL 又只覆盖特定结构。HDL 能直接描述连接和寄存器传输，却缺少对跨周期行为的显式表达，复杂 FSM 和流水线控制需要大量手工设计；HLS 从 C/C++ 等软件语言出发，依赖 pragma 与启发式调度补足微架构信息，导致同一设计在不同工具版本或配置下可能产生不可预测结果；部分 DSL 提升了安全性或特定并行模式表达，但往往牺牲一般微架构能力。Cement 因此提出 cycle-deterministic eHDL CmtHDL 与 CmtC 编译器，目标是在不牺牲微架构表达力的前提下，提高硬件前端生产率和结果可预测性 @cement2024。

=== CmtHDL、Event Layer 与 Ctrl 子语言

CmtHDL 嵌入 Rust，先利用 Rust trait 和宏系统定义 data types、bundles、interfaces、module instantiation、operations 和 port connections，再引入 event layer 与 control sub-language。event layer 用 event 表示一组带 guard 的硬件行为，并显式记录这些行为发生的 cycle sequence；control sub-language 用 `seq`、`par`、`if`、`for`、`while`、`step` 等 procedural statements 描述 event 的时序关系，使设计者能够直接表达确定的跨周期行为。与普通 RTL 只描述“每周期连接如何生效”不同，CmtHDL 允许设计者把“哪些行为在哪些周期发生”作为一等对象写入前端表示 @cement2024。

这一抽象对复杂控制逻辑尤其重要。以 shuffler 和 arbiter pipeline 为例，HDL 设计者需要手工保证发送、仲裁、接收和 resend 之间的周期对齐；HLS 版本则可能因为软件循环依赖模型和工具启发式调度而无法稳定达到 II=1。CmtHDL 可以用 `seq` statement 明确流水线不同 stage 的 timing，并由 CmtC 检查 timing violation。这种 cycle determinism 不是简单固定延迟，而是在静态或动态输入条件下保证 event 的执行周期可推导、可检查、可综合，从而降低手工 FSM 和流水线控制中的隐性错误。

=== Timing Analysis 与 FSM Synthesis

CmtC 的核心编译能力包括 timing analysis 和 FSM synthesis。Timing analysis 分为 static analysis 和 dynamic monitoring：前者对 elaboration-time 可确定的 static events/statements 推导 cycle sequence，在仿真前发现数据收发周期不匹配；后者在仿真中插入 monitor signals 和 assertions，用于捕获数据相关行为下的 timing violations。FSM synthesis 则从 control sub-language 生成严格满足时序规格的控制逻辑，并用 state tree representation、transition table 和编码优化减少 FF/LUT 开销。这使 Cement 不只是前端语法改进，而是在语言、分析和综合之间形成闭环：设计者显式写出时序，编译器检查时序并生成资源优化的控制电路 @cement2024。

具体而言，static timing analysis 首先识别 cycle sequence 可在 elaboration time 确定的 static events/statements，然后自底向上推导 statement latency，再自顶向下推导每个 event 的执行周期，并比较每个 port/wire 的发送与接收周期。如果发送周期与接收周期不一致，系统可以在仿真前报告 invalid-data 或 data-loss 风险。dynamic monitoring 则把 event 是否在当前周期发生编码为 boolean signals，为端口收发生成监测信号并插入 SystemVerilog assertions，从而处理数据相关控制流下的时序违规。FSM synthesis 使用 state tree representation 表达 control sub-language 的状态空间：叶节点对应状态，边携带状态编码片段，transition table 描述输入条件与下一状态；随后通过编码优化在 FF 数、LUT 数和解码延迟之间折中。这些机制使 CmtHDL 的“周期确定性”落到编译器可检查、可综合、可优化的具体对象上。

=== 实验评估与意义

实验上，Cement 在 PolyBench、systolic array 和 sparse accelerator 等案例中展示了周期确定前端的实际价值。相对 Vitis HLS，Cement 在未流水和流水配置下分别获得 1.41x 和 1.52x 几何平均加速，并平均节省 23%/47% LUT 和 68%/78% FF；相对 Dahlia-Calyx flow，Cement 获得 3.49x 几何平均加速，并节省 54% LUT 和 82% FF。Systolic array case study 中，CmtHDL 通过显式周期对齐降低开发成本，并相对 EMS 节省 49% LUT 和 23% DSP，频率提升 7%，throughput per DSP 提升 33%。Sparse accelerator case study 中，CmtHDL 用更少代码描述 shuffler，并相对 Vitis HLS 方案提升频率、显著节省 LUT/FF。这些结果说明，硬件前端的价值不仅在于“写得更快”，也在于使时序行为可预测、可检查、可综合优化 @cement2024。

== 面向硬件实现质量的前端抽象与综合机制：Clay

=== 研究背景与设计目标

Clay 与 Cement 不是版本递进关系，而是面向不同硬件实现问题的互补工作。Cement 关注 FPGA 设计前端如何显式表达周期行为和控制逻辑；Clay 则回到 ASIP 和自定义指令场景，关注一条指令扩展如何在不同处理器微架构、不同耦合策略和不同寄存器/访存路径下获得灵活、高质量实现。RISC-V 生态降低了指令扩展实验门槛，但现有 ASIP 框架往往把指令描述、耦合位置和微架构约束绑定在特定处理器模板中，使“能写出一条自定义指令”和“能把它高质量接入不同微架构”之间仍存在明显距离 @clay2025。

这一距离首先体现在流水线内耦合的限制上。流水线内耦合能够复用主处理器已有控制和数据通路，适合组合逻辑型指令扩展，因此许多工具优先选择这种方式；但它也会把自定义指令限制在处理器流水线已有资源和时序边界内。Clay 源文指出，这类方法难以支持任意状态化行为和复杂控制流，循环往往需要常数循环次数或提前展开；同时，寄存器文件端口数、访存通道和执行阶段位置等约束也会限制一条指令中可表达的寄存器与内存交互 @clay2025。对于机器学习、信号处理和流式数据处理中的指令扩展，这些限制会直接影响设计者能否把多次访存、循环和私有状态封装成一个可复用架构能力。

Clay 的研究目标正是把这些原本隐含在处理器模板中的接口事实显式化。它提出一个高层 ASIP 框架，以统一指令扩展接口连接 CADL 前端和微架构感知综合流程。设计者在 CADL 中描述指令编码、私有状态和无时序行为语义；工具再根据目标处理器提供的耦合策略、接口动作、阶段范围、延迟和资源限制，自动选择流水线内耦合或协处理器耦合，并生成对应硬件实现 @clay2025。这个设计把第二章讨论的“架构接口”进一步推进到实现层：同一个指令语义是否适合放进流水线、是否需要协处理器、每次寄存器/访存动作应该排在哪个阶段，并不是后端局部选择，而是影响指令扩展可移植性和性能的核心综合问题。

#figure(
  image("../resources/clay/fig/framework.png", width: 92%),
  caption: [Clay 的 CADL 前端、指令流、综合流程和目标处理器生成关系。图中展示了自定义状态、接口原语、指令流、阶段划分、流水线调度和微架构生成之间的连接。],
)

=== 统一指令扩展接口与 CADL

Clay 的关键抽象是统一指令扩展接口。源文把不同处理器耦合机制抽象成与微架构无关的 action，例如寄存器读请求/响应、寄存器写请求、内存读请求/响应、内存写请求和程序计数器更新；每个 action 再由目标微架构给出延迟、可放置阶段范围和并发资源上限等属性 @clay2025。这样，流水线内耦合和协处理器耦合不再是两套完全不同的前端目标，而是同一指令语义在不同接口属性下的不同实现候选。对综合器而言，action 描述“需要发生什么接口行为”，微架构属性描述“这些行为何时、何地、以多少资源发生才合法”。

#table(
  columns: (1fr, 2.1fr, 2.2fr),
  align: horizon,
  table.header([接口对象], [技术含义], [在综合中的作用]),
  [action], [寄存器读写、访存读写、程序计数器更新等指令与处理器交互原语], [形成调度对象，使指令行为能在流水线或协处理器接口上实现],
  [阶段范围], [一个 action 可放入的处理器流水线阶段区间], [约束流水线内耦合时的合法放置位置],
  [延迟], [请求、响应或计算动作之间的时序关系], [参与依赖约束和状态机/流水线调度],
  [资源上限], [同一周期可并发使用的端口、通道或功能资源数量], [限制寄存器读写、访存和功能单元使用，决定调度可行性],
)

CADL 则在这个接口之上提供面向设计者的行为描述语言。它包含指令编码、私有状态和行为三部分：编码描述指令格式和 decode 逻辑，私有状态可以是自定义寄存器或 scratchpad memory，行为部分用接口操作和高层控制流描述自定义指令语义 @clay2025。重要的是，CADL 中的行为是无时序的，设计者不需要在前端手写请求-响应握手、流水线阶段或协处理器状态机；这些时序细节由后续综合流程根据目标微架构属性推导。与此同时，CADL 保留了 `if`、`for`、`while` 等控制流，循环边界可以来自解码变量或控制寄存器，因此能够表达传统流水线内自定义指令工具难以支持的状态化行为和变长循环。

在编译流程中，CADL 先被转换为 HIR。HIR 包含指令识别/解码逻辑和对应行为的控制数据流图，随后经过 if-conversion、用户指定循环展开等变换，进入面向调度和硬件生成的后续表示 @clay2025。这个层次划分的意义在于，Clay 并没有把“指令是什么”和“指令如何接入某个处理器”混在同一个描述中，而是先保留高层语义，再把目标处理器事实作为综合约束逐步引入。由此，CADL 既能保持 ASIP 前端的可写性，又能为后端生成微架构相关实现留下足够信息。

=== 微架构感知综合与调度

Clay 的综合流程以自定义指令集合和候选耦合策略为输入。对于每条指令，系统按优先级尝试候选策略，通常先尝试开销较低的流水线内耦合，再尝试表达能力更强的协处理器耦合；每次尝试前先进行合法性检查，例如多 basic block 的状态化指令不能直接作为流水线内耦合实现，而需要程序计数器更新的指令也不能放入普通协处理器接口 @clay2025。通过这种先筛选、再调度、再生成的流程，Clay 把“选择哪类接口”从人工经验变成可由工具检查和搜索的综合步骤。

调度是 Clay 实现质量的核心。源文将微架构属性转化为整数线性规划中的约束：每个 action 有延迟和可放置阶段范围，每类资源有并发上限，每个操作消耗相应资源；请求-响应式 action 的依赖关系由请求延迟和响应动作共同约束 @clay2025。对于不含复杂控制流的指令，综合器进行普通调度；对于状态化、多 basic block 指令，综合器先对 basic block 调度，再生成有限状态机；对于协处理器中包含循环的指令，内层循环可以采用 modulo scheduling，并逐步增大 II 直到找到合法 schedule。这样，Clay 可以在同一框架内覆盖简单组合指令、状态化控制流、复杂访存和协处理器长延迟行为。

#figure(
  image("../resources/clay/fig/schedule.png", width: 92%),
  caption: [Clay 调度示例。源文通过不同访存端口和资源约束下的调度展示微架构属性如何影响 II、延迟和最终硬件实现。],
)

`stream_add` 示例清楚体现了这种微架构感知的必要性。该指令包含循环、连续内存读取和写回，传统流水线内自定义指令工具难以直接支持。Clay 在双端口存储接口下可以得到 II=2、总延迟约为 `2n+1` 的调度；在单端口存储接口下，由于读写资源冲突，II 增加到 3、总延迟约为 `3n` @clay2025。同一 CADL 行为在不同微架构上产生不同调度结果，说明高层指令语义、接口资源和最终性能之间存在直接耦合。如果工具只把自定义指令看作一段待综合逻辑，而不把寄存器/访存端口、流水线阶段和响应延迟显式纳入约束，就很难得到可移植且质量可控的实现。

=== 硬件实现与接口生成

在硬件生成阶段，Clay 将调度后的 HIR 降低到 LIR 和 RuleIR。LIR 由已经排好周期的 basic block 组成，RuleIR 则进一步把每个周期或阶段中的行为组织成规则；当数据跨规则使用时，工具自动插入流水寄存器 @clay2025。对于包含多个 basic block 的状态化指令，Clay 根据控制流生成有限状态机，用状态 guard 控制规则触发，并用 transition logic 连接不同状态。这个过程把 CADL 中的高层控制流转化为明确的硬件状态和时序行为，使状态化自定义指令不再依赖设计者手工编写协处理器控制器。

不同耦合策略在这一阶段被具体化。对于流水线内耦合，规则绑定到目标处理器的流水线阶段，并由阶段范围约束保证 decode、寄存器读、执行、访存和写回等动作落在合法位置。对于协处理器耦合，Clay 生成请求-响应接口、内部状态机和必要的数据通路；当响应延迟不可预测时，例如 RoCC 接口后接 cache 层次结构，生成逻辑采用延迟不敏感的停顿机制等待数据返回 @clay2025。最终实现通过 cmt2 生成 SystemVerilog。这一流程使 Clay 既能为简单指令生成轻量级流水线内扩展，也能为复杂状态化指令生成协处理器式实现。

=== 实验评估与意义

Clay 的评估覆盖两类 RISC-V 处理器：Clay-core 是 RV32I、五级全旁路、无 cache、读写通道分离的处理器，支持流水线内耦合和协处理器耦合；Rocket-core 是 RV32IMAC 五级处理器，带 cache 层次结构和 RoCC 协处理器接口，实验中主要使用协处理器耦合 @clay2025。评估的自定义指令包括 `simd`、`complex_mul`、`sbox`、`autoinc`、`crc`、`cordic`、`gemm2x2` 和 `stream_add`。除查表型 `sbox` 外，多数 CADL 描述不超过 30 行，RTL 生成时间低于 1 秒；这说明 Clay 的前端并不是以牺牲描述成本换取实现能力，而是把复杂接口和时序问题后移给综合器处理。

单指令实验展示了不同机制的作用。简单组合指令可以通过流水线内耦合获得低开销实现，例如 `simd` 在 Clay-core 上周期数下降 95%，对应 20.0x 加速；`complex_mul` 在 Clay-core 上获得 203.2x 加速，但也带来更长时钟周期，这说明高性能自定义算术逻辑需要同时考察周期数和时序代价 @clay2025。状态化指令则展示了 Clay 超出传统流水线内工具的能力：`cordic` 若完全展开会造成严重时序压力，而迭代式协处理器实现能够避免组合路径过长；`crc` 因位操作延迟较低，循环展开反而可能更合适；`stream_add` 的变长循环和多次访存也需要借助协处理器与调度约束处理 @clay2025。这些结果说明，耦合策略不能由固定规则决定，而应由指令行为和目标微架构共同决定。

端到端 workload 进一步验证了 Clay 的实用性。EdgeDet 将 rgba2gray、3x3 Sobel、3x3 erode 和 3x3 dilate 等图像处理操作定制为指令，4 条自定义指令共 87 行 CADL，优化后程序仅含 17 条指令，并在面积增加约 39% 且频率基本保持的情况下获得端到端收益 @clay2025。CFOEst 则定制 complex_mean、complex_mul 和 cordic，3 条自定义指令共 50 行 CADL，将动态指令数从 1113 条降至 9 条，并获得 33.9x 加速；其面积和时钟周期增加主要来自乘法器、CORDIC 数据通路和自定义状态 @clay2025。相较只报告单个 kernel 加速，这些 workload 结果更能说明 Clay 面向的是可落地的 ASIP 设计流程：设计者用较少前端代码描述复杂指令行为，工具根据目标微架构生成不同实现，并通过周期、时序和面积共同评价结果。

从本报告角度看，Clay 在第三章中承担连接第二章与第三章的关键角色。第二章强调应用需求和可复用指令/微架构能力如何通过架构接口被发现和表达；Clay 进一步回答，当一条能力已经成为自定义指令后，如何让它在不同处理器微架构上以合适的耦合策略、时序安排和资源使用落到硬件实现。它也与 Cement 形成清晰分工：Cement 解决一般硬件前端如何表达周期确定行为，Clay 解决 ASIP 指令扩展如何把微架构属性纳入综合约束。二者共同说明，高质量硬件实现不是后端黑盒综合的附属结果，而需要在前端抽象、接口原语、时序属性、资源约束和综合算法之间形成可检查的闭环。

== 变换、映射与调度联合优化：SkyEgg

=== 研究背景与设计目标

前面三个小节分别从基础设施、前端时序表达和微架构感知 ASIP 综合角度讨论硬件实现质量。SkyEgg 则进一步指出，许多硬件综合质量问题并不是单个前端或调度器可以解决的，而来自 algebraic transformation、operation mapping 和 scheduling 被人为拆成固定顺序的阶段。传统 HLS 通常先进行若干前端优化，再调度到时钟周期，最后把操作绑定到资源或 IP；但调度需要知道 mapping 的精确 latency 和 resource behavior，mapping 又依赖调度决定操作在何时执行，代数变换也可能是获得更好映射的前提。把这些阶段分开，会错过需要跨层联合选择才能发现的高质量实现 @skyegg2026。

=== E-graph 设计空间与 Mapping 表示

SkyEgg 采用 e-graph 统一表达 algebraic transformation 和 hardware mapping design space。它把 MLIR 程序转换为 e-graph，并把 FPGA mapping candidates 也表示为 rewrite rules，使 operation rewrites 与 mapping choices 在同一个等价空间中展开。与传统 equality saturation 在饱和后用 cost extraction 选择单个表达式不同，SkyEgg 将 extraction 改写为 scheduling problem：在饱和后的 e-graph 上用 ILP 选择合法的 mapping 和 schedule，并以全局性能为目标进行优化。这个 formulation 能同时考虑表达式变换、资源映射和时序安排，使“哪种代数形式更好”不再只由软件代价模型决定，而由具体硬件 mapping 和 schedule 的综合结果决定 @skyegg2026。

SkyEgg 的 e-graph 中包含普通软件 operation e-node 和专门的 mapping e-node。mapping e-node 形如 `id(Vec(arg1, arg2, ...))`，其中 `id` 表示一个具体硬件 mapping，例如 DSP 或 LUT，`Vec` 的参数表示该 mapping 的输入。每条 mapping rule 由 matcher、applier 和 condition 组成：matcher 描述硬件单元支持的软件代数模式，applier 插入对应 mapping e-node，condition 则约束数据类型、位宽或硬件原语限制。这样，DSP48E2 之类硬件原语的功能、配置和约束不再隐藏在后端绑定阶段，而是在 e-graph 饱和过程中与代数 rewrite 一起扩展设计空间。SkyEgg 还区分 basic logic、hardware primitive 和 parameterized IP core 三类 mapping configuration，并把 pipeline register、configurable latency 和资源 preset 等信息编码到 mapping id 中，使每个 mapping-configuration pair 都具有确定的调度属性 @skyegg2026。

=== Timing Model 与调度式 Extraction

为了让 mapping 选择真正影响调度，SkyEgg 为每个 target mapping 建立 timing property model。一个 mapping 具有 latency、input delay、output delay 和 register-to-register delay 等属性；对于组合 mapping，input delay 描述输入端到输出端的组合路径；对于 sequential mapping，input/output delay 分别描述输入到第一级寄存器、末级寄存器到输出的路径，register-to-register delay 约束流水线最小时钟周期。由于 FPGA primitive 的 vendor timing data 往往不公开，SkyEgg 通过提前综合 profile 目标 mapping/configuration，建立 timing property database。随后，系统在 e-graph 上分析 mapping 之间的 valid structural path delay，判断两个操作能否在一个 cycle 内 chaining，或需要插入 pipeline register 切断组合路径 @skyegg2026。

在 formulation 上，SkyEgg 将 extraction 转化为 transformation- and mapping-aware scheduling ILP。决策变量同时包括 e-class 是否被选中、mapping e-node 是否被选中、mapping 的 start/finish time，以及 e-class 的完成时间。约束分为两类：completeness constraints 保证 root e-class 被计算、被选中的 e-class 至少选择一个 mapping、被选中的 mapping 的 child e-classes 也被计算；scheduling constraints 保证依赖关系、latency、e-class finish time 和 chaining/timing closure。目标是最小化 root e-class 的完成时间，并用较小惩罚项减少不必要 mapping。这个 formulation 的关键是，它不先从 e-graph 中抽取表达式再单独调度，而是在同一个优化问题中决定表达式形态、硬件 mapping 和时钟周期安排 @skyegg2026。

=== Efficient Solving 与实验评估

为了提高可扩展性，SkyEgg 还提出 ASAP heuristic scheduler，在保持接近 ILP 性能收益的同时显著降低求解时间。评估中，SkyEgg 相对 Xilinx Vitis HLS 在多类 benchmark 上获得 3.10x 平均加速、最高 5.22x 加速；ILP 和 ASAP scheduler 在 FF/LUT 使用上保持竞争力，并且所有 SkyEgg 设计都满足 timing constraints，而 Vitis HLS 在高目标频率下有 48% case 不能 meet timing。ASAP heuristic 可以在一秒内扩展到超过 600 个 operations，同时维持主要性能收益 @skyegg2026。

SkyEgg 的求解难点主要来自 chaining constraints，因为饱和 e-graph 中许多 mapping pair 之间存在大量可行路径。若只保留最大 path delay，可能因为最大路径上的 mapping 最终未被选中而导致实际 timing path 未被约束；若保留全部路径，ILP 又难以扩展。SkyEgg 因此使用 top-k path delays，在每对 mapping 之间保留若干最长路径作为约束，默认 `k=3` 即可使实验设计满足目标时钟周期。ASAP scheduler 则按拓扑顺序遍历 e-class，为每个 e-class 选择 earliest finish time 的 mapping，并同时考虑 dependency constraints 和 top-k chaining constraints。它不保证全局最优，但在多数 case 中接近 ILP 解，同时大幅降低求解时间 @skyegg2026。

=== 本节小结：从前端表达到联合优化

SkyEgg 是本章的方法高潮，因为它把前三节强调的几个判断合到同一个优化框架中。HECTOR 说明硬件综合需要 IR 化和多层方法学支撑；Cement 说明时序行为必须显式表达并可检查；Clay 说明微架构属性和 coupling strategy 必须进入综合约束；SkyEgg 则说明一旦这些事实进入 IR/设计空间，工具还需要避免固定 pass order 和阶段割裂，把变换、映射与调度作为联合问题求解。由此，本章从“如何表达硬件”推进到“如何在语义等价空间和硬件映射空间中选择高质量实现”。

这一点也自然引出第四章。SkyEgg 仍主要依赖预定义 rewrite rules、mapping candidates、ILP/heuristic scheduler 和工程化 cost formulation；随着设计空间变大，哪些规则应当被应用、哪些策略能在不同任务上复用、如何把专家经验和历史证明转化为可审计策略，成为新的问题。第四章中的 EggMind 正是在 SkyEgg/ISAMORE 所代表的 e-graph 优化基础上，把 LLM 的策略生成能力纳入形式化可控的 EqSat 策略对象中，进一步讨论大模型与形式化技术如何共同服务软硬件协同。

== 本章小结

本章回应第一章提出的第二个科学问题：架构能力如何高质量落到可综合、可验证、性能与资源可控的硬件实现。HECTOR 提供了基于 MLIR 多层 IR 的早期硬件综合基础设施视角，说明硬件实现质量需要结构化 IR 和 lowering 流程支撑。Cement 强调前端必须显式表达周期行为，并通过 timing analysis 与 FSM synthesis 保证硬件行为可预测、可检查、可综合优化。Clay 将这一问题带回 ASIP/ISAX 场景，强调 coupling strategy、microarchitectural attributes 和 synthesis constraints 对自定义指令实现质量的决定性作用。SkyEgg 则进一步把 algebraic transformation、operation mapping 和 scheduling 统一到 e-graph 设计空间中，避免固定阶段顺序造成的次优实现。

这些工作共同说明，高质量硬件实现不是后端工具的附属结果，而需要从前端表达、IR 设计、时序语义、微架构属性、映射选择和调度求解共同组织。它们也为下一章奠定了方法基础：当 e-graph、MLIR、硬件 IR 和综合反馈成为软硬件协同的核心对象后，大模型和 agentic 方法若要进入这一流程，就必须操作这些结构化对象，并受到形式化语义、验证检查和执行证据约束。

= 大模型与形式化技术驱动的软硬件协同方法

== 引言

前两章分别讨论了领域能力如何进入架构接口，以及这些能力如何落到高质量硬件实现。本章进一步讨论一个新的方法层问题：当大模型和 agentic 方法开始进入代码生成、硬件生成、编译优化和工程自动化流程时，如何使它们真正服务软硬件协同，而不是退化为不可审计的文本生成。第一章已经指出，LLM/agentic 方法是一条重要技术趋势，但芯片设计与编译优化对语义正确性、接口协议、时序、资源、验证和长期维护提出了远高于一般代码补全的要求。因此，本章的重点不是证明“大模型能写硬件或编译器”，而是说明大模型能力必须通过形式化对象、编译基础设施、验证反馈和证据记忆进入协同流程。

本章包含两类已有研究基础。EggMind 是本章重点，它不把 LLM 作为直接生成最终优化代码的自由 agent，而是把 LLM 的策略生成能力约束在 EqSatL、e-graph、proof-derived motif memory 和 tractability guidance 组成的形式化优化框架中。OriGen 则代表 LLM 进入 RTL 生成流程的探索，其核心价值在于认识到硬件生成不能只依赖自然语言到代码的单次映射，而需要高质量 RTL 数据、code-to-code augmentation、compiler-feedback self-reflection 和专门的修复评测。二者共同说明，大模型与形式化技术结合后，对软硬件协同的作用并不是替代编译器或验证器，而是把策略搜索、证据组织和自动化迭代纳入可检查的工具链对象。

== E-graph 策略自动化：EggMind

=== 研究背景与设计目标

EggMind 直接回应了第一章和第三章共同提出的编译接口问题：当 e-graph、EqSat 和 rewrite-based optimization 已经成为硬件综合、编译优化和 ISA 定制的重要方法，如何进一步自动化这些优化过程中的策略设计。Equality saturation 的优势在于用 e-graph 紧凑表示大量语义等价程序，避免过早承诺某条 rewrite sequence；ISAMORE 和 SkyEgg 分别利用这一思想发现可复用自定义指令、联合探索硬件变换/映射/调度空间。但 EqSat 的实用瓶颈同样明显：rewrite space 一旦变大，e-graph 会快速膨胀，运行时间和内存成为主要限制，最终结果很大程度上取决于规则如何分组、何时应用、应用多少轮、何时简化。

因此，EggMind 把自动化目标从“让 LLM 直接写 egglog 代码”转向“合成可复用 EqSat strategy artifact”。在 EggMind 中，strategy 指组织 EqSat search 的控制结构，包括 ruleset partitioning、saturation scheduling、e-graph simplification 和 budget control。这个对象位于 rewrite rules 和 backend execution 之间：它不改变语义规则本身，但决定哪些规则可以互相作用，怎样分阶段暴露优化机会，以及如何在搜索过程中收缩冗余状态。这样，LLM 不再直接操作庞大的 raw e-graph 或低层 egglog 细节，而是围绕一个可检查、可复用、可评估的策略对象进行搜索 @eggmind2026。

=== EqSatL：可审计的策略对象

EggMind 的第一个核心抽象是 EqSatL。EqSatL 是表示 EqSat strategies 的 DSL，目标是在 compactness、formal validation 和 expressiveness 之间取得平衡。它把策略设计分解为三个控制面。第一是 ruleset partitioning，用 semantic tags 将 rewrite vocabulary 分为具有含义的 rulesets，而不是暴露冗长规则列表，使 LLM 能在更高层级表达“哪些规则应当一起或分开作用”。第二是 schedule construction，用 flow tree 组织 phases、sequences 和 `repeat` regions，使规则交互可以被分阶段、可重复但有界地执行。第三是 simplification control，把 `simplify` 显式化为一等控制节点，通过强度参数和可选 LLM hints 决定何时、如何收缩 e-graph，避免无约束增长 @eggmind2026。

这一设计的关键在于，EqSatL 将战略意图与 backend implementation 解耦。传统 raw egglog 脚本把策略、规则应用细节和执行机制混在一起，LLM 需要反复修补低层代码，反馈也难以解释。EqSatL 则把 strategy artifact 放在稳定边界上：它足够紧凑，便于 LLM 生成和修改；它足够显式，便于检查 partition、schedule 和 simplification 是否合理；它也足够有表达力，能控制规则互动、重复搜索和状态收缩。对软硬件协同而言，这种 artifact boundary 非常重要，因为可审计自动化必须操作稳定对象，而不是依赖一段不可解释的低层脚本。

=== Agentic Workflow：离线策略合成与在线复用

EggMind 的第二个核心是 agentic workflow。它把离线策略合成组织为 Strategist、Generator、Evaluator、Partitioner 和 Simplifier 的受控循环。workflow memory 中维护 strategy repository，包括当前 best strategy、promising strategies 和 pending strategies；每轮迭代中，Strategist 根据当前证据选择动作，Generator 产生或修改 EqSatL 策略，Evaluator 以不同预算执行 EqSat 并返回质量、时间和内存反馈，Partitioner 与 Simplifier 则提供 ruleset partition 和 simplification hints。评估后，系统更新 best/promising/pending 状态，并把成功运行中的证据写回 memory。这样，agentic workflow 不依赖开放式对话历史，而依赖明确的策略对象、评估结果和可复用证据 @eggmind2026。

从系统结构看，EggMind 将策略发现分为 offline synthesis 和 online reuse 两个阶段。离线阶段以一组 evolution cases、rewrite rules 和 cost model 为输入，由 agentic workflow 生成 EqSatL strategy artifacts；在线阶段则把选定策略应用到新 case，由 backend 将 EqSatL lowering 为可执行 EqSat 代码并运行。这个分离具有重要工程意义：昂贵的策略探索成本在离线阶段支付，并通过可复用策略摊销到后续优化任务；在线优化阶段不需要让 LLM 反复进入执行路径，从而降低不可控性和运行开销。对博士开题报告而言，这一点说明 EggMind 不是一般意义的“LLM 调参”，而是一种把策略搜索、执行评价和证据记忆分层组织的编译自动化系统。

=== Proof-derived Motif Memory：从证明中提取可复用经验

第三个核心是 proof-derived rewrite motif caching。EqSat 运行若产生更优结果，backend 可以给出初始表达式到最终表达式的 equivalence proof；但原始 proof tree 通常庞大、包含大量 congruence/transitivity bookkeeping，不适合作为 LLM 上下文。EggMind 因此从 proof tree 中提取局部 rewrite motifs，将具体 rule chain 提升为 semantic tag chain，例如某类 vector lifting 后接某类 vector optimization。motif cache 根据相对 cost reduction 和跨 case frequency 保留高价值 motifs，并在后续策略生成中提供紧凑结构证据。这样，系统记忆的不是模糊经验描述，而是来自成功证明路径的可复用 rewrite interaction @eggmind2026。

这一机制解决了 agentic 编译优化中的一个关键问题：经验如何不变成不可审计的自然语言偏好。EggMind 首先定位 proof tree 中的 local proof regions，用 congruence path 标记子表达式上下文；随后把局部 rewrite chain 通过 rule-to-tag mapping 提升为语义 tag chain，并对重复 motif 进行去重和排序。motif 的评分同时考虑 relative gain 和跨 case frequency，因此 cache 保留的是在成功优化中反复出现、且能带来实际 cost reduction 的结构证据。后续 Generator 或 Strategist 使用这些 motif 时，看到的是来自等价证明的 compact guidance，而不是未经验证的人工经验。

=== Tractability Guidance：规则交互风险与简化提示

第四个核心是 tractability guidance。EggMind 用 dependency-based ruleset risk model 为 ruleset partition 提供稳定性指导：它把 rewrite vocabulary 建模为 rule dependency graph，根据 RHS/LHS enablement、operator overlap 和 subtree matchability 估计规则之间的互相激活风险；partition objective 奖励前向阶段依赖，惩罚 backflow、phase-1 inflow 和 same-phase entanglement，从而使规则交互更接近稳定的 forward activation。与此同时，LLM-guided simplification hints 为不同 phase 提供 preferred/pruned pattern pairs，将 simplification 从单一全局 cost pruning 变成 phase-local structural preference。二者共同服务一个目标：让 LLM 搜索停留在稳定、可执行、可复用的策略空间中，而不是不断触发 e-graph explosion @eggmind2026。

具体地，dependency-based ruleset risk model 将 rewrite rules 作为图节点，用有向边表示一条规则可能启发另一条规则的强度；phase assignment 的目标是鼓励规则依赖从前一阶段流向后一阶段，同时抑制后向激活、首阶段反复被后续规则激活，以及同阶段规则强耦合。LLM-guided simplification hints 则在每个 phase 给出少量 preferred/pruned pattern pairs，形成局部简化偏序，并通过 bounded penalty 改变 e-class 内候选的保留优先级。这种做法没有把 LLM 提示作为硬删除规则，而是让 evaluation 继续检验提示是否过强或损害后续优化；如果提示不合适，后续迭代可以修正。因此，EggMind 对 LLM 的使用始终围绕可执行评价和可回退控制，而不是让模型直接决定最终正确性。

=== 实验评估与对软硬件协同的意义

EggMind 的评估说明，这种“LLM + 形式化策略对象 + 证据闭环”的组合确实改善了 EqSat 优化。Vectorization benchmark 上，EggMind 相对 full EqSat 将 final cost 几何平均降低 45.1%，相对专家调优 Isaria strategy 降低 20.6%；在线运行相对 Isaria 获得 2.21x 几何平均加速，并相对 full EqSat 将 peak memory 几何平均降低 69.1%。Ablation 显示，motif caching、`repeat` construct、Strategist 和 Partitioner 均对质量或稳定性有贡献，尤其缺少 motif caching 或 repeat 会显著恶化 cost、runtime 和 memory @eggmind2026。

EggMind 还展示了跨领域迁移能力。在 XLA-based tensor compiler benchmark 中，合成策略在 17 个 case 中 13 个获得低于 unguided baseline 的 final cost，其余 4 个持平，同时相对 full EqSat 获得 11.89x 几何平均运行时加速。在 EqMap logic synthesis case study 中，EggMind 使用 augmented rewrite space，在 carry-chain benchmarks 上取得最好的质量效率权衡，相对原始规则 $i=4$ 和 $i=5$ 分别降低 33.76% 和 8.75% cost，并相对 unguided 高预算搜索降低 51.94% peak memory @eggmind2026。这些结果说明，EggMind 不是为单个 vectorization benchmark 手工调参，而是在不同 e-graph 优化域中学习和复用策略组织方式。

从本报告主线看，EggMind 是 ISAMORE 和 SkyEgg 的策略层延伸。ISAMORE 依赖 e-graph AU 和 phased EqSat 发现可复用自定义指令，SkyEgg 依赖 e-graph 表达硬件变换与 mapping choices；二者都面临 rewrite space 如何组织、搜索如何收敛、策略如何迁移的问题。EggMind 的贡献是把这些策略从隐含经验提升为显式、可审计、可复用的 EqSatL artifact，并用 agentic workflow、proof-derived motif memory 和 tractability guidance 对 LLM 搜索施加结构化约束。这也是本报告中“大模型与形式化技术结合”的核心含义：LLM 负责提出和改进策略，形式化对象负责限定可操作边界，proof 和 evaluator 负责提供证据，编译基础设施负责执行和检查。

== 大模型辅助硬件生成中的形式化反馈：OriGen

=== 问题定位

OriGen 面向 RTL code generation，是大模型进入硬件设计流程的早期探索之一。其问题背景很直接：商业 LLM 已经在 C++、Python 等软件代码生成上展示了较强能力，也能生成一定质量的 RTL，但闭源模型带来隐私、安全、可定制性和研究可复现问题；开源代码模型虽然便于部署和微调，却因为高质量 RTL 数据不足，在 Verilog/RTL 生成任务上明显落后。硬件设计中的 RTL 往往包含 IP 和专有设计知识，不能简单依赖商业模型远程生成；同时，RTL 语法、时序、综合风格和验证要求又明显不同于普通软件代码，通用代码数据难以充分覆盖 @origen2024。

=== 数据增强与 RTL 生成能力提升

OriGen 的第一条思路是提升 RTL 数据质量。现有 Verilog 数据集要么来自 GitHub 等开源仓库，规模较大但质量参差不齐；要么由商业模型根据关键词或自然语言描述合成，质量较高但规模和多样性受限。OriGen 提出 code-to-code augmentation：从开源 RTL 中抽取高层代码描述，再利用 teacher model 对代码进行 refined generation，以知识蒸馏方式改善开源 RTL 数据。这一方法不是只让模型“凭空写代码”，而是把已有开源 RTL、自然语言描述和教师模型能力组织成数据增强流程，试图在规模与质量之间取得平衡 @origen2024。

=== 编译反馈自反思与修复评测

第二条思路是引入 compiler-feedback self-reflection。硬件设计流程天然包含编译、仿真和验证反馈；如果 LLM 生成的 RTL 不能通过编译器或 simulator，模型应当利用错误信息定位问题并修复代码。OriGen 因此构建 VerilogFixEval，由 VerilogEval 中 221 个编译失败案例组成，用于评测模型基于 compiler error messages 修复 RTL 的能力。训练数据中包含 natural language instructions、erroneous code、compiler error messages 和 corrected code，使开源模型学习从错误反馈到代码修复的映射 @origen2024。

=== 结果与启示

OriGen 的意义在于把大模型硬件生成从“一次性生成 RTL”推进到“数据、生成、编译反馈和修复”的闭环。实验报告显示，OriGen 在 VerilogEval-Human 上超过此前开源 RTL 生成模型，并在 VerilogFixEval 上展示了较强 self-reflection 能力 @origen2024。对本文而言，这一工作更重要的启示是：硬件生成中的 LLM 能力必须与工具反馈结合，编译器错误、语法检查、仿真结果和修复样例都应成为模型学习和迭代的证据来源。后续面向验证约束的架构、硬件与编译协同生成，也需要继承这一思想，但进一步把反馈从编译错误扩展到形式化约束、接口协议、等价性检查、综合结果和运行时证据。

== 形式化约束与大模型能力的协同边界

通过 EggMind 和 OriGen 可以看到，大模型与形式化技术的关系不是替代关系，而是分工关系。大模型适合在开放空间中提出候选、总结策略、迁移经验、生成修复和组织长程搜索；形式化技术、编译 IR、验证工具和执行反馈则负责限定语义边界、检查等价关系、提供反例和性能证据、约束优化空间，并保证过程可复现。没有大模型，许多策略设计和跨任务经验迁移仍高度依赖专家；没有形式化与工具反馈，大模型输出又难以满足硬件和编译系统对正确性与可维护性的要求。

这一边界为第五章未来工作提供了方法定义。验证约束下的架构、硬件与编译协同生成，需要让模型在架构描述、硬件 IR、编译 pass 和验证 oracle 之间提出候选并接受反例；可解释、可审计的编译基础设施，需要把策略、证据、目标契约和运行记录作为一等对象；面向工业级异构架构的算子优化与运行时编译协同，则需要让 agentic 方法在 profiling、benchmark、runtime trace 和 target constraints 中进行长期迭代。三者共同要求大模型能力必须进入 harness，而不是停留在自由文本接口。

== 本章小结

本章回应第一章提出的第三个科学问题：编译接口如何连接程序语义、硬件能力和运行时反馈，形成跨硬件架构的可解释、可验证、可复用证据闭环。EggMind 展示了在编译优化和 e-graph 搜索中，LLM 应当通过 EqSatL、agentic workflow、proof-derived motif memory 和 tractability guidance 等结构化对象进入流程；OriGen 展示了 LLM 进入 RTL 生成时必须面对数据质量、编译反馈和自反思能力问题。二者共同说明，大模型方法的价值不在于绕过硬件工具链，而在于帮助工具链进行策略生成、错误修复、证据积累和长程优化。

这也为第五章未来工作奠定了方法基础。后续研究需要把 OriGen 所体现的反馈式硬件生成、EggMind 所体现的可审计策略生成，以及第二、三章中的架构接口和硬件综合机制结合起来，进一步构建验证约束下的架构、硬件与编译协同生成，可解释、可审计的编译基础设施，以及面向工业级异构架构的算子优化与运行时编译协同。换言之，未来工作不是让 agent 自由生成设计，而是让 agent 在明确的架构接口、IR 对象、形式化约束、测试/benchmark 和运行时证据中进行受控协作。

= 未来工作

== 未来工作总体目标

前文的现有工作展示了三条已经形成基础的研究线索：面向应用和架构的可编程接口能够降低领域定制门槛，面向硬件实现的前端抽象和综合优化能够提高 RTL 生成与硬件设计效率，大模型与形式化技术结合能够把策略生成、反馈修复和证据积累引入编译与硬件设计流程。但这些工作也共同暴露出更深层的剩余矛盾：软硬件协同的对象已经从单个模块、单条 pass 或单个 kernel 扩展到架构接口、硬件结构、编译流程、运行时调度和产业级系统部署的联合空间，而现有工具链仍然缺少一个能够同时保持语义边界、生成能力、验证证据和运行反馈的系统化方法。

因此，未来工作不应被理解为若干已有项目的线性延伸，而应围绕“敏捷芯片设计与创新性编译技术驱动的软硬件协同”这一主题，进一步回答三个问题。第一，在架构、硬件和编译支持都需要快速生成与协同演化的情况下，如何让生成过程始终受验证约束，而不是退化为不可审计的自由生成。第二，当编译器成为连接应用语义、架构事实、硬件能力和运行时反馈的核心接口时，如何构建对人和 agent 都可解释、可审计、可复现的编译基础设施。第三，在工业级异构架构上，如何把算子优化、编译决策、运行时任务图、数据移动和 profiling 反馈组织为长期演化的工程闭环，使单点优化技术能够落到复杂系统中。

围绕上述问题，本章提出三个相互支撑但各有侧重的未来方向：验证约束下的架构、硬件与编译协同生成；可解释、可审计的编译基础设施；面向工业级异构架构的算子优化与运行时编译协同。三者之间不是简单上下游关系。第一个方向关注生成对象的跨层一致性，第二个方向关注编译接口和证据组织方式，第三个方向关注产业级异构系统中的性能闭环。它们共同构成从方法、基础设施到场景落地的研究路线。

== 验证约束下的架构、硬件与编译协同生成

第一项未来工作面向架构、硬件与编译支持的协同生成。第二章中的 APS/Aquas 已经说明，若应用接口、架构描述、编译 IR 和硬件生成流程能够被统一组织，领域定制处理器和近数据处理系统就可以从“手工拼接工具链”转向“由接口驱动的端到端协同”。第四章中的 OriGen 则说明，大模型可以在 RTL 生成中利用 compiler feedback 进行修复和迭代，但其对象仍主要停留在局部 RTL 代码和编译错误反馈。下一步需要把这两类思路结合起来：让大模型进入架构、硬件和编译的联合生成过程，但让语义边界、类型化产物和可执行验证始终作为权威约束。

该方向的核心判断是，软硬件协同生成不能把自然语言需求直接映射为不可分解的 RTL 或编译器代码，而应先建立明确的 semantic boundary。该边界把人的需求、算法意图、架构约束和 agent 提案转化为类型化 artifact，例如接口描述、任务/actor 语义、硬件阶段性表示、编译 lowering 计划、验证 obligation 和执行 trace。自然语言可以帮助解释需求、提出候选和组织修复，但不能成为系统事实本身；系统事实必须由可解析、可执行、可重放的对象承载。

在具体方法上，未来工作将研究 staged hardware generation 与 staged compiler lowering 的协同框架。硬件侧不一次性生成完整实现，而是从架构接口、并发语义、通信协议和存储结构开始，逐步进入 microarchitecture、RTL 和综合约束；编译侧也不直接生成目标后端，而是从程序语义、target facts、IR lowering、pass sequence 和 runtime ABI 逐步推进。两个过程通过共同的 executable oracle 和 cross-layer checks 对齐：同一个任务或算子应当能够在高层语义模型、硬件原型、编译产物和运行时执行之间产生可比较的 trace；若 trace 不一致，系统应能定位责任边界，例如接口语义错误、lowering 错误、调度错误或硬件实现错误。

这种方法也是对 Spine 原型思路的系统化提升。已有基础已经包含 Delta actor/task surface、generator-backed execution、trace stream、case report 和严格 GCD Delta-to-RTL validation path 等要素，说明小规模语义 oracle、任务执行和 RTL 对齐可以被组织为可重放证据。未来研究需要进一步扩大该机制的覆盖面：一方面，使架构描述能够表达 APS/Aquas 类系统中的处理器-加速器接口、存储/缓存约束和 domain-specific operation；另一方面，使 agent 能够在 bounded action space 中提出接口修订、硬件结构候选、编译 lowering 候选和修复建议，并由类型检查、仿真、等价性检查、综合反馈和运行 trace 共同筛选。

预期贡献不是单纯“用大模型生成硬件”，而是提出一套验证约束下的协同生成方法。其关键科学问题包括：如何定义跨层语义边界，使架构、硬件和编译对象可以共同引用同一组事实；如何设计 typed artifacts，使 agent 的修改具有明确所有权、输入输出和验证责任；如何组织 executable oracle，使高层语义、硬件实现和编译产物可以持续对齐；以及如何将反例和 trace 转化为可复用的修复知识。若该方向能够成立，敏捷芯片设计将不再只依赖更快的单点生成器，而可以依赖一个带有语义、证据和反馈的协同生成系统。

== 可解释、可审计的编译基础设施

第二项未来工作面向可解释、可审计的编译基础设施。第一章已经指出，编译与架构是衔接软硬件领域的重要接口；第二、三、四章进一步说明，无论是 APS/Aquas 的端到端处理器生成、ISAMORE 的 phased EqSat 与 custom instruction 复用、SkyEgg 的 e-graph HLS 优化，还是 EggMind 的 EqSatL 策略合成，真正困难的部分都不是孤立 pass 的实现，而是如何让目标事实、IR 表达、语义约束、变换过程、后端产物和评价证据保持一致。大模型和 agentic 方法进入这一过程后，编译基础设施更不能只是“可运行”的脚本集合，而必须成为可解释、可审计、可复现的 harness medium。

该方向将以“目标事实 -> 显式 IR 与语义契约 -> 受约束变换 -> 可执行后端产物 -> 证据与反馈”为基本链条。目标事实包括并行层级、存储层级、通信与同步约束、指令语义、layout 限制、runtime ABI 和 profiling 能力；显式 IR 负责承载程序结构与变换边界；语义契约负责说明 operation、region、dialect 和 backend artifact 的含义；受约束变换负责把 analysis、rewrite、pass、gate、semantic execution 和 agent action 统一到可记录的 action 机制中；后端产物包括可执行代码、调度计划、kernel、runtime 配置和验证脚本；证据与反馈则包括 TraceDB 中的 facts/events、rewrite 证据、gate 结果、测试输出、profiling 数据和人工审阅记录。

IntelliC 的未来研究重点正是构建这样一类编译基础设施。其基础设计将 IR 拆分为 `Sy + Se`：`Sy` 负责 syntax、结构、identity、verification、canonical text 和 parsing，`Se` 负责由 typed SemanticDef、semantic level keys 和 TraceDB 承载的语义定义。这样的拆分避免把语义隐藏在 parser 或 pass 的临时状态中，也避免把 agent 的解释当作编译事实。一个 operation 可以有 concrete value、abstract range、symbol、backend evidence 等多个语义层级；同一个 pass pipeline 可以通过 TraceDB 记录 match、mutation intent、semantic fact、diagnostic、obligation 和 evidence link，从而让人和 agent 都能追踪“为什么发生了这个变换、它依赖哪些事实、通过了哪些 gate、产生了哪些后端证据”。

在 agent 参与方面，编译基础设施需要明确区分 fixed action、agent action 和 agent-evolved fixed action。固定 action 可以是传统编译 pass、验证 gate 或后端 handoff；agent action 可以在受限输入、受限输出和明确 evidence schema 下提出候选变换、候选 pass sequence 或诊断解释；agent-evolved fixed action 则需要经过测试、语义检查和审计后，才被固化为可复用的 pipeline 组件。这样的边界是必要的，因为编译器中的错误往往具有跨层传播性：一个看似局部的 rewrite 可能破坏 layout 假设、别名关系、同步语义或后端 ABI。若没有 TraceDB、gate 和 mutation intent 等显式证据，agent 的“合理解释”很难转化为可信编译行为。

该方向与前一方向互补。验证约束下的协同生成需要架构/硬件目标描述、可执行 oracle 和跨层 trace；可解释编译基础设施则提供 IR、语义、action、pass、backend handoff 和 evidence memory。换言之，前一方向回答“生成对象如何跨架构、硬件和编译保持一致”，本方向回答“编译层如何把这些对象变成可检查、可演化、可被 agent 使用的基础设施”。预期成果包括一个最小可执行 compiler slice：从 Python construction surface 生成 MLIR/xDSL 风格 IR，经过结构验证、语义执行、canonicalization、rewrite/gate、backend evidence 和 TraceDB 审计，并用包含 loop-carried semantics 的非平凡例子证明该链条不是玩具级直线程序。

== 面向工业级异构架构的算子优化与运行时编译协同

第三项未来工作面向工业级异构架构的算子优化与运行时编译协同。它不是前两个方向的简单应用，而是一个独立的产业级压力测试：当目标从单个可控硬件原型扩展到真实异构系统时，编译器不仅要生成高性能 kernel，还要面对动态图捕获、runtime scheduling、memory movement、multi-device communication、serving latency、throughput、profiling 和回归稳定性等问题。PyTorch `torch.compile`/TorchDynamo 已经把动态图程序、graph break、backend compilation 和 eager fallback 组织为编译-运行时边界 @pytorchCompile2026；TensorRT-LLM 则展示了 LLM 推理系统中 engine building、kernel fusion、quantization、KV cache、continuous batching、paged attention 和 serving backend 的共同作用 @tensorrtllm2026。这些系统说明，工业级异构架构上的优化对象天然跨越编译与运行时。

本方向采用并列的两条子线。第一条子线研究工业级异构架构上的芯片算子自动优化。其目标不是只自动生成单个算子实现，而是构建面向复杂 fused operator、Torch 训练/推理核心算子和长程优化任务的 Agent Harness。该 harness 的输入应包括芯片架构描述、ISA 与存储层级、编译约束、算子语义和性能目标；其动作空间应覆盖候选实现生成、IR rewrite、pass 组合、profiling 调用、形式化辅助建模、回归测试和经验记忆更新；其输出不只是一段 kernel 代码，而应包括正确性证据、性能证据、适用配置、失败案例和可复用优化经验。

NVIDIA AVO 是这一方向的重要外部证据，但不应被理解为狭义 baseline。AVO 说明，在 Blackwell B200 GPU attention kernel 优化中，autonomous coding agent 可以结合 lineage、domain knowledge 和 execution feedback 作为 variation operator，进入性能敏感的 kernel/compiler optimization 流程 @avo2026。这证明“agent + evaluator + execution feedback”在工业硬件附近是技术上真实的趋势。然而，本报告拟研究的问题更宽：目标算子不局限于 attention kernel，目标硬件不局限于单一 GPU，优化过程不应停留在代码变异，而需要结合 target IR、compiler pass、profiling trace、formal constraints、regression validation 和长期经验记忆。也就是说，AVO 支撑方向正确性，但剩余问题仍是如何把 agentic search 嵌入可维护、可审计、可迁移的编译和算子优化基础设施。

第二条子线研究运行时分布式协同。PTO Runtime 的层级运行时原型提供了重要基础：系统用 L0--L6 层级对应 Ascend NPU cluster 拓扑，其中 L2 是 chip boundary，L3 以上由 Orchestrator、Scheduler 和 Worker 递归组合；Orchestrator 通过 TensorMap 从 TaskArgs 的 INPUT/OUTPUT/INOUT 等标签推导依赖，Ring 提供带 back-pressure 的 slot pool，Scheduler 负责 wiring queue、ready queue 和 completion queue，WorkerThread 在 THREAD 或 PROCESS 模式下把 Callable、TaskArgs 和 CallConfig 分发给下一级执行单元。L2 chip-level runtime 又包含 host runtime、AICPU scheduler 和 AICore worker 的三程序模型，形成从 host orchestration 到 device task execution 的明确边界。

基于这一基础，未来工作需要把运行时协同从“可执行任务图”推进到“可被编译器和 agent 使用的运行时证据系统”。一方面，TensorMap、RingBuffer、ready/completion protocol、group task、CallConfig 和 mailbox/blob ABI 可以扩展为描述数据依赖、设备边界、执行配置和任务完成状态的结构化对象；另一方面，profiling、tensor dump、PMU、runtime trace 和 failure reports 应进入统一证据层，反馈给算子优化和编译决策。这样，运行时不只是被动执行编译产物，而能向编译器暴露数据移动瓶颈、任务粒度失衡、设备边界开销、memory hierarchy 压力和调度等待原因。

两条子线在“工业级异构架构”处汇合，但并不强行写成单向闭环。算子自动优化需要运行时提供真实反馈和部署约束，运行时分布式协同也需要编译器提供任务图、kernel、layout 和配置决策；二者共同面向的是跨硬件架构的软硬件协同生态。未来研究将优先选择能够被自动验证和重复评估的核心场景，例如 Torch 训练算子、LLM 推理 fused operator、multi-device task graph 和 runtime scheduling case，通过 correctness test、performance profiling、trace replay、regression benchmark 和人工审计共同评价。其预期贡献是把单点 kernel 优化、编译 pass 组合和运行时调度反馈提升为可长期演化的系统能力。

== 集成路线、里程碑与风险控制

上述三个方向需要分阶段推进，以避免一开始就落入过大的系统范围。第一阶段聚焦验证约束下协同生成的小型闭环，选择语义明确、接口清晰、验证成本可控的硬件案例，完成 oracle、IR、RTL/codegen 和 trace alignment 的端到端验证。该阶段的目标不是覆盖复杂设计，而是证明 semantic boundary、typed artifacts、staged generation 和 executable oracle 能够共同工作，并形成可重放证据。

第二阶段聚焦可解释编译基础设施的最小可执行 slice。该阶段应完成 syntax/semantics 分离的核心对象模型、canonical IR parser/printer、TraceDB、semantic execution、fixed action、rewrite/gate 和 backend evidence 的基本链条，并用包含循环、region、loop-carried value 和至少一种优化变换的例子检验基础设施深度。该阶段的评价重点是可解释性和可审计性：每一次变换都应能够追溯依赖事实、语义义务、mutation intent、gate 结果和最终证据。

第三阶段聚焦工业级异构架构中的算子优化与运行时协同。一方面，推进复杂 fused operator 和 Torch 训练/推理算子的长程自动优化 harness，形成候选生成、验证、profiling、回归和经验记忆循环；另一方面，推进 PTO Runtime 分布式特性的任务图协同、数据移动、ready/completion protocol 和可观测性建设，使运行时 trace 能够反馈到编译和优化决策。该阶段的核心评价不只是单次性能提升，而是多轮迭代的稳定性、可维护性、跨配置迁移能力和错误恢复能力。

第四阶段进行跨层案例整合。理想的综合案例应同时包含架构/硬件约束、编译 IR 与 pass、算子或任务图优化、运行时执行和 trace 反馈，使前三个方向能够在同一系统中相互验证。该阶段应产出论文、开源工具链、可复现实验和文档化证据，强调研究方法而非只展示工程功能。

主要风险有四类。第一，语义边界过大，导致系统难以实现和验证；应从小闭环开始，先证明一个窄而深的路径，再逐步扩展 artifact 类型。第二，agent 生成不可控，产生不可审计或不可维护的修改；应限制 agent action 的输入输出，使用 typed artifacts、TraceDB、gate 和 replay 约束其行为。第三，运行时研究依赖真实硬件和复杂部署环境；应同时保留 simulation、unit benchmark、trace replay 和真实硬件验证路径，避免评价完全被硬件可用性阻塞。第四，评估指标不统一，导致正确性、性能、可维护性和研究贡献彼此脱节；应为每个阶段明确 correctness、performance、evidence quality、reproducibility 和 human audit cost 等多维指标，并把失败案例纳入证据库。

= 结论

本报告围绕“敏捷芯片设计与创新性编译技术驱动的软硬件协同”展开，核心判断是：领域应用、人工智能模型和产业级异构系统正在快速演进，但芯片设计、编译基础设施和运行时软件生态的生产力仍难以匹配这种演进速度。传统依赖人工经验、固定工具边界和局部优化的研发方式，已经难以支撑从算法需求到架构接口、硬件实现、编译优化和运行时部署的跨层协同。软硬件协同研究因此不能只追求某个单点工具的性能提升，而需要同时关注接口抽象、生成方法、验证证据、编译基础设施和系统反馈。

已有工作构成了本研究继续推进的技术基础。面向领域定制的架构接口与端到端协同工作表明，应用语义、架构描述和编译支持可以通过明确接口被共同组织，APS/Aquas、ISAMORE 和 Cayman 分别从处理器生成、可复用自定义指令和端到端接口协同等角度展示了领域定制的可行路径。面向高质量硬件实现的前端抽象与综合优化工作表明，硬件前端、IR 设计和综合优化能够显著影响设计质量和生产效率，HECTOR、Cement、Clay 和 SkyEgg 分别提供了多层 IR 积累、硬件建模、ASIP 设计和 HLS 优化的技术支撑。大模型与形式化技术驱动的软硬件协同工作进一步说明，LLM/agent 的价值不在于替代工具链，而在于进入 EqSat、RTL 生成、编译反馈和证据驱动优化等流程，帮助策略生成、错误修复和经验迁移；EggMind 和 OriGen 分别展示了这一方向在编译优化与硬件生成中的潜力。

在此基础上，未来研究将从三个方向推进到更完整的系统闭环。验证约束下的架构、硬件与编译协同生成，旨在让架构接口、硬件实现和编译支持在 typed artifacts、semantic boundary、executable oracle 和 cross-layer checks 中共同演化。可解释、可审计的编译基础设施，旨在把编译器建设为 agentic 方法的 harness medium，使目标事实、IR、语义契约、pass、gate、backend artifact 和 evidence memory 能够被人和 agent 共同使用。面向工业级异构架构的算子优化与运行时编译协同，旨在把复杂 fused operator、Torch 训练/推理算子、运行时任务图、数据移动和 profiling trace 纳入长期优化流程，使单点优化能力能够面向真实系统持续演化。

预期而言，本研究的贡献将体现在三个层面。方法层面，形成面向敏捷芯片设计的验证约束协同生成方法，以及面向编译优化的 agentic、formal 和 evidence-driven 方法体系。基础设施层面，构建可解释、可审计、可复现的编译与运行时 harness，使软硬件协同过程中的事实、变换和证据能够被系统化管理。应用层面，在领域定制处理器、高质量硬件实现、编译优化和工业级异构架构算子/运行时协同场景中验证上述方法，最终支撑更高生产力、更强可验证性和更好可迁移性的软硬件协同研发流程。

#appendix()

= 待核验清单

+ 确认学院、专业、导师、开题报告格式要求和页数要求。
+ 确认各代表性工作的一作身份、正式会议状态和 BibTeX。
+ 补充 Cayman、Clay、HECTOR 的准确论文信息。
+ 安装 Typst CLI 后编译 `report/main.typ`，并根据 pkuthss 模板报错调整。
