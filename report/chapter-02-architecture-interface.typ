#import "@preview/algorithmic:1.0.7"
#import algorithmic: style-algorithm, algorithm-figure
#show: style-algorithm

= 面向领域定制的架构接口与端到端协同

== 引言

第一章指出，领域定制计算的核心难点不是发现某个应用热点，而是把应用需求转化为可以被软硬件系统长期使用的架构能力。本章围绕这一问题展开，讨论应用需求如何通过架构接口转化为可复用的指令、微架构和加速器能力。这里的“架构接口”既包括处理器与自定义指令单元之间的硬件协议，也包括指令语义、存储访问路径、编译器识别机制、运行时可见行为和设计者能够迭代使用的工具链产物。

本章的组织遵循“端到端协同框架 -> 定制什么 -> 微架构约束”的递进关系。首先，APS 和 Aquas 关注领域定制能力如何接入完整 ASIP/ISAX 工具链：APS 解决开放 RISC-V 生态中接口分裂、硬件合成和编译支持割裂的问题；Aquas 进一步面向复杂数据密集 ISAX，把访存接口属性、缓存效应、MLIR/Aquas-IR、等价图重写和骨架-组件匹配结合起来，使硬件侧访存机制选择和软件侧自动卸载 能够共同优化。随后，ISAMORE 将问题推进到“应该定制什么”本身，强调自定义指令面积昂贵，必须从跨程序语义等价空间中发现可复用指令模式。最后，Cayman 将补充微架构感知定制，使领域能力选择与具体微架构约束形成更紧密的端到端协同。

这三个层次共同回应第一个科学问题。APS/Aquas 说明领域能力如何进入可运行、可评估、可综合的工具链；ISAMORE 说明领域能力如何避免局部热点定制，转而成为跨工作负载可复用的架构机制；Cayman 则说明架构能力不能停留在抽象指令层，还需要结合微架构结构、接口代价和实现约束进行选择。本章并不把这些工作写成论文列表，而是把它们作为同一研究链条的不同阶段：先建立可接入系统的协同框架，再解决可复用定制能力发现，最后把定制能力与微架构事实对齐。

== 应用专用处理器与定制指令的端到端协同

ASIP/ISAX 是领域定制计算中兼顾可编程性和专用硬件效率的重要形态。与传统固定加速器相比，自定义指令和专用执行单元能够保持通用处理器的软件入口，使应用在普通控制流、库函数和系统运行环境中调用领域能力；与纯软件优化相比，它们又能把频繁出现的计算、访存或控制模式硬化到专用数据通路中。因此，ASIP/ISAX 是连接应用需求与架构能力的自然接口。但这一接口真正可用，需要同时解决硬件协议、指令语义、合成实现、编译器调用和系统级评估问题。

=== 统一定制指令接口与端到端工具链

APS 的出发点是开放 RISC-V ASIP 生态中的端到端割裂。RoCC 和 CV-X-IF 等接口都采用处理器与自定义单元解耦的握手式交互，但二者在 commit/recall、issue/response、内存访问和控制信号组织上存在差异。RoCC 偏向简化加速器设计，并由处理器侧保证被卸载指令的提交；CV-X-IF 则显式暴露 commit channel，使带副作用的操作必须等待确认后才能执行。二者具有相近的交易语义，却因为协议细节、实现语言和平台生态不同而难以复用同一 ISAX 设计。APS 因此提出 基于事务的统一 ISAX 接口抽象 APS-itfc，把 issue、GPR request、recall、memory read/write、memory response 和 result response 等交互统一为 valid-ready transaction，并通过后端适配器自动映射到 RoCC 或 CV-X-IF @aps2025。

#figure(
  image("assets/aps/isax-itfc.pdf", width: 84%),
  caption: [APS 对 RoCC 与 CV-X-IF 处理器-定制指令接口的统一抽象。图中核心关系是把平台相关信号组织为统一 transaction 语义，再通过后端 adapter 接入不同 RISC-V SoC。],
)

APS-itfc 的意义不只是隐藏接口信号差异，而是为后续硬件合成和编译支持建立共同边界。自定义指令单元只需要面向统一 transaction 语义描述与处理器的交互，RoCC 或 CV-X-IF 的 tag、size、commit/recall 等平台细节由 adapter 处理。APS 在 Rocket/Chipyard 与 CV32E40X/Croc 两个开源 RISC-V 平台上实现这一抽象，并补充参数化缓存、Verilator 周期精确仿真、Yosys/OpenROAD ASIC 流程等工具链环节，使同一类定制能力能够在不同 SoC 框架中完成集成、仿真和物理实现评估。这一设计回答了 ASIP 研究中的第一层问题：领域能力必须有一个跨平台、可落地的架构接口，否则后续合成和编译优化会被具体处理器协议锁死。

在硬件侧，APS 通过 CADL 和 APS-synth 提供定制指令扩展专用综合。CADL 允许设计者描述自定义指令的高层行为，同时直接访问统一 APS-itfc transaction 和低层硬件组件；其描述内容被降低为结构化中间表示（SIR）和调度后结构化中间表示（SSIR）。SIR 保留序列、块、循环、循环携带变量、方法调用等结构，便于类型推导、函数解释和程序优化；SSIR 则把调度结果表达为流水线/阶段结构，用于估计性能并生成硬件。APS-synth 在调度中加入自定义指令特有约束，例如寄存器文件读取必须位于触发阶段、延迟不敏感操作不能错误并列以避免死锁，并最终构造基于事务的动态流水线。这使 APS 不仅能生成组合逻辑式指令，也能描述带状态、循环、流水和自定义组件的更复杂 ISAX 行为 @aps2025。

在软件侧，APS 提供 APS-c 编译框架，把 CADL 语义导出为编译器可用的匹配信息，并在 LLVM 中生成 类 intrinsic 的 C 包装函数、基于语义的匹配器、基于性能剖析的匹配器和位宽感知向量化。基于语义的匹配器面向控制较简单的 IR 模式，自动识别等价指令序列并替换为 ISAX 调用；基于性能剖析的匹配器面向复杂循环或控制区域，通过解释执行和 输入输出行为比较辅助发现可以卸载的代码区域。位宽感知向量化则针对 RV32 等架构中低位宽操作无法充分利用寄存器位宽的问题，把多个低位宽 标量 ISAX 调用打包为 SIMD 风格 ISAX，并在超过寄存器带宽时自动插入辅助 memory/config 操作。由此，APS-c 把自定义指令从“需要程序员手写 intrinsic”推进到“编译器根据硬件语义自动发现和使用”的形态 @aps2025。

#figure(
  image("assets/aps/flow.pdf", width: 82%),
  caption: [APS 端到端流程。统一接口、CADL/APS-synth、APS-c 编译支持和 SoC/ASIC 评估共同构成敏捷 ASIP 迭代链条。],
)

APS 的评估覆盖后量子密码、量化 LLM 和数字信号处理三个领域，展示了端到端工具链的实际效果。在 CRYSTALS-KYBER 中，NTT butterfly 与 PWM/Karatsuba 等 ISAX 用约 175 行 CADL 描述，并在两个 RISC-V 平台上获得明显加速；Butterflyx2 在两个平台上最高达到 10.16x，Karatsuba 对 PWM 基线 最高达到 14.99x。在 BitNet b1.58 的 BitLinear 场景中，dotprodW2A8x4 ISAX 针对 8 位激活与 2 位权重的点积，完整 BitLinear 层获得 2.03x 和 2.29x 加速，并可由 基于性能剖析的匹配器自动利用。在 DSP 场景中，SOS 与 IIR ISAX 支撑 DPLL 中的 IIR filter 加速，IIR 指令通过深流水和硬件 loop 消除软件调用与循环开销，在 Croc 和 Rocket 上分别获得 5.51x 和 5.18x 加速。这些结果说明 APS 的价值不仅是某个指令加速，而是把指令设计、硬件合成、编译插入、仿真评估和 ASIC PPA 反馈连成完整敏捷迭代流程 @aps2025。

然而，APS 也暴露出下一层挑战。它已经把自定义指令接入统一接口和编译流程，但在复杂数据密集应用中，性能往往受限于存储层次、接口带宽、缓存行为和更复杂的软件变体。APS 的 CADL 和编译器能够描述较一般的行为，但对块级内存访问、scratchpad 使用、突发传输、缓存层次不匹配、复杂循环变换和鲁棒 ISAX 匹配 的支持仍不充分。换言之，APS 建立了端到端协同框架，但当领域定制从 scalar/SIMD-like 指令推进到更复杂的 访存中心型 ISAX 时，架构接口必须进一步显式表达访存机制和缓存效应，编译器也必须在更大的程序等价空间中进行稳健匹配。

=== 面向数据密集指令的软硬件协同优化

Aquas 正是沿着这一方向推进。它仍以 ASIP/ISAX 为对象，但把问题从“统一接口和基本端到端流程”扩展为“复杂数据密集 ISAX 的硬件-软件整体协同优化”。在硬件侧，Aquas 首先建立 core-ISAX 访存接口模型，用宽度、最大节拍数、在途事务数、读启动延迟、写完成代价和缓存行大小 等参数刻画不同访问路径。这个模型说明，接口选择并非微小实现细节：窄低延迟接口和宽高延迟接口在不同访问粒度、burst 能力和 cache 层次下会产生不同性能结果，错误选择可能引入 7 到 9 cycle 的局部延迟惩罚，并在更大设计中放大为系统性能损失 @aquas2026。

#figure(
  image("assets/aquas/overview.pdf", width: 82%),
  caption: [Aquas 的硬件-软件协同流程。硬件侧以访存接口模型和 Aquas-IR 支撑合成，软件侧以 MLIR、等价图重写和 骨架-组件匹配支撑自动卸载。],
)

为了把这些硬件事实纳入合成，Aquas 设计了三层 Aquas-IR。功能层接近高层软件语义，描述 transfer、fetch 等与具体访问机制无关的操作；架构层引入 `memitfc` 符号，把访存操作 绑定到具体接口，并使其受到对齐、transaction size、in-flight limit 等微架构约束；时序层则用异步 issue/wait 和 顺序属性 表达事务顺序、cache 层次和有限并发下的具体时序。基于这一 IR，Aquas 进行暂存缓冲消除、接口选择与规范化、事务调度与排序，以及最终硬件生成。其关键意义在于，访存接口选择不再是手工经验或后端偶然结果，而成为可分析、可搜索、可在 IR 中回放的架构决策 @aquas2026。

在软件侧，Aquas 进一步解决复杂 ISAX 卸载的鲁棒编译问题。复杂 ISAX 的语义常与应用代码存在抽象层次差异：软件表示关注值、控制流和访存效应，而硬件描述中可能包含 scratchpad、寄存器交互和接口传输语义。Aquas 首先把软件代码通过 Polygeist 转到 MLIR 基础 dialect，并把 Aquas-IR 功能层中的硬件语义规范化到同一抽象层次。随后，它把 MLIR 与 e-graph 结合：MLIR 保留结构化控制流和副作用顺序，e-graph 非破坏性地累积等价程序变体；内部重写用于代数和数据流变换，外部重写则通过调用 MLIR 循环变换 pass 实现分块、展开等控制流重构。为了避免 e-graph 爆炸，Aquas 根据目标 ISAX 的循环特征 有选择地触发外部重写，最后通过骨架-组件匹配 检查控制结构、数据流组件、支配关系、排序和效应约束，自动插入 ISAX 调用 @aquas2026。

#figure(
  image("assets/aquas/compiler.pdf", width: 96%),
  caption: [Aquas 编译器流程。MLIR 负责结构化程序表示与外部循环变换，等价图负责累积等价变体，最终通过骨架-组件匹配插入复杂 ISAX 调用。],
)

这种设计把 APS 中的自动 intrinsic 插入扩展到更复杂的语义空间。APS 的模式匹配已经能够处理部分语义和 基于性能剖析的场景，但 Aquas 更强调：同一个 ISAX 可能对应许多语法不同、控制流形态不同、但语义等价的软件实现；编译器若只匹配单一模式，会被循环分块、展开、代数变换、冗余语句和非仿射表达轻易破坏。因此，Aquas 把“匹配一个模式”转化为“在受约束的等价空间中寻找与目标 ISAX 骨架/组件对齐的程序变体”。这使编译接口更接近第一章所说的协作媒介：目标事实、IR 表示、重写、匹配、代价模型和证据共同约束卸载决策。

Aquas 的评估进一步说明了这一复杂协同的必要性。它在后量子密码、点云处理、图形渲染和 CPU LLM 推理四类场景中评估真实工作负载。对于基于编码的后量子密码 syndrome computation，Aquas 为 bitstream unpacking 和 GF(2^n) matrix multiplication 设计 ISAX，并在 Rocket 基线上获得 7.59x 和 3.29x 内核加速比，端到端获得 1.42x 加速比，面积开销小于 5.3% 且无频率下降。在点云 ICP 场景中，Aquas 针对 Euclidean distance、covariance matrix、maximum comparison 和 matrix-vector multiplication 等操作设计 ISAX，内核加速比达到 1.46x 到 9.27x，端到端达到 1.96x；其优势来自对不规则访存、矩阵/向量混合访问和扩展总线带宽的更好利用。在图形渲染中，Aquas 与 RISC-V vector unit Saturn 比较，多个内核获得 9.47x 到 15.61x 加速，并在性能面积权衡上优于通用向量单元。在 CPU LLM 推理的 FPGA prototype 中，Aquas 针对 attention computation 设计 ISAX，在 Llama 2 110M 8-bit 量化模型上获得 9.30x TTFT 和 9.13x ITL 加速。这些结果说明，当应用具有复杂访存和控制形态时，端到端协同必须同时考虑硬件访存接口、编译等价空间和真实系统评估 @aquas2026。

从研究链条看，APS 和 Aquas 共同回答了“如何把定制能力端到端接入工具链”这一问题。APS 建立了跨 RISC-V 平台的统一接口、定制指令扩展专用综合和自动编译插入，使领域能力能够从 CADL 和 C 程序进入可仿真、可综合、可评估的 SoC。Aquas 则进一步把复杂数据密集场景中的访存接口、缓存层次、MLIR/Aquas-IR、e-graph 重写和骨架-组件匹配纳入同一流程，使定制能力不仅能接入工具链，还能在更复杂硬件事实和软件变体中被正确、鲁棒、有效地使用。二者为后续 ISAMORE 提供了基础：当端到端接入问题被系统化以后，下一步关键就变成如何从应用集合中自动发现真正值得接入这些接口的可复用架构能力。

== 可复用定制指令发现

=== 研究背景与问题建模

APS 和 Aquas 解决的是“如何把定制能力接入端到端工具链”的问题，但它们仍然预设设计者已经知道哪些能力值得定制。对于敏捷芯片设计而言，这个前提并不总成立。自定义指令会占用面积、引入验证负担，并影响处理器接口、编译器后端和系统维护；如果一个指令只服务于少数局部热点，它即使在单个内核上有效，也很难成为长期可复用的架构能力。因此，在端到端接入工具链之上，还需要回答一个更前置的问题：从一组领域代表程序中，如何自动发现具有跨程序、跨工作负载价值的可复用自定义指令。

传统自动指令发现大多以程序热点和语法结构为中心。细粒度方法枚举 basic block 内的 convex subgraph，能够找到局部可替换片段，但受限于基本块范围和较小模式，容易错过更大粒度的优化机会；粗粒度方法把 basic block 或代码区域整体合并为加速单元，能够覆盖更多操作，却常生成过大的专用硬件，复用次数低，甚至包含在通用处理器上更适合执行的指令序列。二者共同的问题是过度依赖 syntactic analysis：如果两个代码片段语法不同但语义等价，它们往往被视为不同模式，最终产生多个相似但不共享的硬件单元。ISAMORE 的问题意识正来自这一点：真正适合作为 ISA 扩展的能力，不应只是某个热点中的语法片段，而应是语义上可泛化、在多个位置反复出现、且硬件代价与性能收益匹配的模式 @isamore2026。

ISAMORE 将可复用自定义指令识别建模为 reusable instruction identification，并提出 RIMT 方法。其输入是一组领域代表程序，输出是一组在性能和面积之间形成 Pareto trade-off 的自定义指令候选。这个过程首先把 LLVM IR 转换为结构化 DSL，再编码为 e-graph；随后通过 phase-oriented equality saturation 和 e-graph anti-unification 发现语义等价空间中的公共模式；最后用硬件感知代价模型选择值得实现的模式，并通过 HLS 和 RoCC wrapper 等后端生成可评估硬件。与 APS/Aquas 相比，ISAMORE 的位置更靠前：它不只是让编译器使用已有 ISAX，而是帮助设计者决定哪些 ISAX 值得进入后续工具链。

#figure(
  image("assets/isamore/overview.pdf", width: 90%),
  caption: [ISAMORE/RIMT 总体流程。领域程序先进入结构化 DSL 和等价图表示，再经过分阶段等式饱和、反合一、向量化、硬件感知选择和后端生成，形成可复用定制指令集合。],
)

=== 结构化表示与等价图反合一

为了让一般程序能够进入 e-graph anti-unification，ISAMORE 首先设计 structured DSL。该 DSL 覆盖 arithmetic、logical、memory access 等常规操作，同时引入 `Loop` 和 `If` 表达控制流，并提供 `Vec`、vector unary/binary/ternary 运算、pattern variables 和 `App` 等结构。`Loop` 以 do-while 风格表达 loop-carried variables、loop 条件 和 body result，使控制流能够以结构化、数据流中心的方式进入 e-graph。该 DSL 还具有强类型系统，利用 e-class analysis 推导每个 e-class 的 result type，并对 `If` 和 `Loop` 的输入输出 tuple 施加结构约束。这个设计解决了直接把一般程序放入 e-graph 的第一层障碍：程序不再只是若干代数表达式，而是保留了循环、条件、类型和向量结构的可泛化语义对象 @isamore2026。

在此基础上，ISAMORE 的核心方法是 e-graph anti-unification。e-graph 用 e-class 表示等价项集合，equality saturation 通过重写规则暴露语义等价形式；anti-unification 则在两个项之间求 least general generalization，从而发现公共结构。例如，两个语法不同但可重写到同一等价形式的表达式，可以被泛化为带 pattern variables 的候选指令模式。这个思路把“复用”从语法匹配提升到语义等价空间：同一个自定义指令可以覆盖多个表面形态不同的程序片段，只要它们在 e-graph 中共享可泛化结构。

=== 分阶段识别流程与可扩展反合一

直接使用 vanilla e-graph AU 并不可行，因为真实程序的 e-class 数量和候选 AU pattern 数会迅速爆炸。ISAMORE 因此提出 phase-oriented iteration。它放弃一次性对所有重写规则做完整饱和，而是把规则按 saturating/nonsaturating、int/float、vector/scalar 等维度组织为 base 规则集，并由 phase scheduler 逐步选择规则集。早期阶段先应用不会显著增加 e-class 的 saturating rules，尽可能暴露低成本等价形式；后续阶段再以受限次数应用 nonsaturating rules，以避免 e-graph 规模失控。每个阶段 中，RIMT 会把以前识别的 pattern 作为 pattern-application rewrites 重新注入 e-graph，使后续阶段能够在已有模式的基础上进一步泛化。这样做既控制了搜索规模，又允许指令模式从局部公共结构逐渐演化为更高复用度的候选 @isamore2026。

RIMT 的第二个关键是 smart AU。vanilla AU 需要枚举大量 e-class pair，并对每对 e-node 递归生成候选 pattern，实际复杂度很快失控。smart AU 用两类启发式降低复杂度。第一是 similarity-based e-class pairing：ISAMORE 用类型信息排除 result type 不一致的 e-class，再通过 structural hashing 估计 e-class 的结构相似度，只对相似度超过阈值的 pair 做 AU。structural hashing 对字面量、参数和 pattern variables 做统一处理，强调结构而非具体常量，从而更适合寻找可复用模式。第二是 heuristic AU pattern sampling：当某个 e-node pair 的 AU 候选过多时，ISAMORE 不保留全部 Cartesian product，而用 boundary 或 kd-tree 策略根据 latency/area 特征选取代表性 pattern。前者保留特征值极端的模式以提高效率，后者在特征空间中取更广覆盖以改善质量。二者共同使 e-graph AU 从理论上有吸引力但不可用的方法，变成可以处理真实程序的指令识别机制 @isamore2026。

#figure(
  image("assets/isamore/smart_au.pdf", width: 94%),
  caption: [ISAMORE 的 smart AU 机制。相似度筛选和候选采样共同控制等价图反合一的搜索规模，使可复用指令模式发现能够扩展到真实程序。],
)

=== 向量化、硬件感知选择与真实系统评估

除了语义复用，ISAMORE 还把 data-level parallelism 纳入指令发现过程。传统指令发现往往把 scalar pattern 作为主要对象，即使程序中存在多路相似操作，也不一定生成向量化自定义指令。ISAMORE 的 pattern vectorization 把一个 vectorized pattern 看作同一个 pattern 在多个 lane 上的应用。其流程先通过 smart AU 找到可重复出现的 scalar seed，再把同一 basic block 中的多个 seed pack 成 `Vec` 节点；随后通过 lift rewrites 恢复 VecAdd、VecMul 等向量构造，并用 couple rewrites 建立 vector 到 scalar lane 的数据流；最后用 greedy extraction 和 compress-style pruning 消除 `Get-Vec-Get` cycle 与组合式 packing 爆炸，只保留高 DLP 的非重叠向量化方案。这使自定义指令发现不局限于“找到一个可复用 scalar 片段”，而能同时探索向量化、硬件 loop 和更高吞吐的数据通路 @isamore2026。

#figure(
  image("assets/isamore/vector.pdf", width: 84%),
  caption: [ISAMORE 的 pattern vectorization。多个可复用标量模式被组合为向量化模式，从而把数据级并行性纳入定制指令发现。],
)

在选择指令候选时，ISAMORE 不使用抽象语法树规模这类硬件无关目标，而使用基于性能剖析、硬件感知的代价模型。对每个模式，它估计该模式在所有使用位置替换为硬件单元后节省的总延迟：软件延迟来自剖析得到的单操作周期数，硬件延迟来自轻量 HLS 对模式行为的调度，面积来自 HLS/OpenROAD 估计。RIMT 通过等价类分析在等价图中传播帕累托前沿，把模式集合的加速比与面积开销作为多目标选择依据，并在提取后重新计算更准确的性能面积指标进行保真度修正。这个设计保证 ISAMORE 发现的不是“语法上好看”或“项数更少”的模式，而是具有实际性能收益和可接受硬件代价的架构能力 @isamore2026。

ISAMORE 的基准测试评估展示了这种方法的可扩展性和收益。在九个来自计算机视觉、机器感知、数字信号处理和密码学的内核上，vanilla e-graph AU 因候选 pattern 爆炸而在所有案例中超过 30GB 内存限制；启用 RIMT 后，所有基准测试均在 145 秒内完成，内存不超过 799MB，峰值 e-graph size 相比 vanilla 方法降低 6 到 39 倍。在性能上，ISAMORE 相比 NOVIA 等语法合并方法获得更高加速比 和更低面积开销；启用 vectorization 后，ISAMORE 相对 NOVIA 的优势平均达到 1.76x，最高达到 2.69x，并在多个基准测试中展示 pattern vectorization 对性能的进一步贡献。MatChain 案例还表明，structured DSL 编码控制流后，ISAMORE 可以识别可复用硬件循环，生成 loop pipeline accelerator，获得远超基本块级方法的优化粒度 @isamore2026。

更重要的是，ISAMORE 在真实开源库和具体硬件实例中体现了“可复用架构能力”的价值。对 liquid-dsp、CImg 和 PCL 等库的研究显示，语法合并方法往往生成巨大且低复用的硬件单元，而 ISAMORE 能识别多个更小、更高复用的自定义指令。在 CImg 中，NOVIA 生成一个 size 为 167 的大硬件单元且只合并少量基本块，ISAMORE 则识别八条平均复用 93 次的指令，获得 1.18x 加速比，同时面积仅为 975 平方微米，相比 NOVIA 节省 90.5% 面积。在 PCL modules 中，ISAMORE 相比 NOVIA 平均获得 1.64x 加速比，最高 2.73x，并节省 93.2% 面积。这些数据说明，可复用性不是附加指标，而是决定自定义指令是否适合进入 ISA 的核心标准 @isamore2026。

ISAMORE 还在量化 LLM 和后量子密码中展示了从自动识别到真实硬件集成的可行性。对 BitNet b1.58 的 BitLinear 推理实现，ISAMORE 从 `bitnet.cpp` 风格实现中识别出 打包低比特点积的向量化模式，并生成带 RoCC wrapper 的自定义硬件单元；在 Rocket tile 上通过 Verilator RTL simulation 获得 2.15x BitLinear 加速比，OpenROAD 报告 4.81% 面积开销且无频率下降。对 CRYSTALS-KYBER 的 NTT 实现，ISAMORE 自动识别 forward NTT 和 inverse NTT 复用的 butterfly custom instruction，并在 Rocket tile 上获得 5.15x 加速比，面积开销主要来自硬件乘法器。这些案例证明，ISAMORE 不只是静态分析工具，而能够与 RISC-V/SoC、HLS、RTL simulation 和 physical design flow 连接，进入实际敏捷芯片设计流程 @isamore2026。

从本章主线看，ISAMORE 对 APS/Aquas 形成了关键补充。APS/Aquas 使一个已知定制能力能够被架构接口承载、被硬件工具实现、被编译器调用并被系统评估；ISAMORE 则反过来从领域程序集合中发现哪些能力值得进入这一流程。其方法创新在于把 e-graph equality saturation、anti-unification、structured control-flow DSL、phase-oriented search、smart AU、pattern vectorization 和 hardware-aware selection 结合起来，使“可复用自定义指令”成为可自动发现、可量化权衡、可硬件落地的敏捷芯片设计机制。由此，领域定制不再完全依赖专家凭经验挑选热点，而可以通过程序语义、硬件代价和跨工作负载复用共同驱动。

== 微架构感知的领域加速器定制

=== 研究背景与整体框架

APS、Aquas 和 ISAMORE 分别从端到端接入、复杂访存协同和可复用指令发现三个角度推进了领域定制处理器研究。Cayman 则把这一链条进一步推向微架构感知的自定义加速器生成。与 ISAX 更强调处理器指令接口不同，Cayman 面向的是从应用程序中自动选择适合硬件加速的内核，并生成高性能自定义加速器；它关注的重点不只是“是否把某个代码片段硬化”，而是该片段是否包含复杂控制流、如何组织数据访问、如何通过处理器-加速器接口降低数据移动代价，以及多个加速器之间是否可以合并和复用 @cayman2025。

Cayman 的问题背景与本章前两节自然衔接。APS 说明，如果缺少统一接口和合成/编译工具链，自定义能力难以跨平台落地；Aquas 说明，如果不显式建模访存接口和缓存效应，复杂数据密集 ISAX 会被错误的内存路径和低效数据移动限制；ISAMORE 说明，如果只从局部热点做语法合并，自定义硬件会过度专用、复用度不足。Cayman 面对的是同一矛盾在加速器生成场景中的体现：HLS 可以从给定内核合成硬件，但内核的选择和抽取仍常依赖人工；而真实应用中的候选区域可能包含一般控制流、复杂数据访问和多个可复用加速单元，不能只靠简单 loop 或 basic-block 规则决定。

Cayman 的整体流程从应用程序出发，将程序编译到 LLVM IR，并构建全应用程序结构树（whole-application program structure tree, wPST）表示；同时，系统通过性能剖析和 LLVM 程序分析收集每个候选区域的运行时间、执行次数、内存依赖、访问模式和访存足迹。随后，Cayman 基于 wPST 和分析结果进行候选选择，生成由多个内核与加速器配置组成的候选解；对每个候选解，系统进一步执行加速器合并，得到可复用加速器，并最终综合硬件设计。这个流程把“候选区域选择”和“硬件实现质量”放入同一框架，而不是让 HLS 后端被动接受人工选择的内核 @cayman2025。

#figure(
  image("assets/cayman/framework.pdf", width: 76%),
  caption: [Cayman 总体框架。应用程序经全应用结构表示、性能剖析和程序分析进入候选选择，再经接口建模、加速器合并和硬件综合形成可复用加速器。],
)

=== 全应用表示、性能剖析与程序分析

Cayman 引入 wPST 的原因在于，传统数据流图级自定义硬件生成难以处理真实程序中的控制流和跨函数结构。程序结构树（program structure tree, PST）本来用于识别函数内单入口单出口区域；Cayman 将其扩展为全应用程序结构树，在根节点下加入函数节点，并把每个函数中的单入口单出口区域表示为候选区域。单入口单出口约束很关键：只有具有单一入口和单一出口的区域，才能在卸载后通过入口/出口处的同步与主处理器隔离执行，从而形成清晰的处理器-加速器边界。wPST 中的候选区域包括基本块区域和包含循环/条件的控制流区域，使候选选择不再局限于平坦数据流图 @cayman2025。

仅有区域树仍不足以决定哪些区域值得加速。Cayman 因此对应用进行性能剖析，记录每个区域的持续时间和执行次数，用于定位热点并估算潜在性能收益；同时执行程序分析，收集内存依赖、访存模式和访存足迹。具体而言，系统识别循环携带依赖，以判断循环流水化或展开是否可行；识别流式访问模式，以判断地址序列是否可静态生成；分析每个访存操作的访问范围，以估计暂存存储大小和缓存收益。这些分析结果直接进入后续加速器配置，而不是作为孤立的诊断信息 @cayman2025。

=== 加速器建模与数据访问接口选择

Cayman 的关键贡献之一是把处理器-加速器数据访问接口显式纳入建模。其模型包含三类接口。耦合接口使用加载/存储单元访问存储系统，加速器在发出访问请求后等待响应，面积开销较低但容易产生停顿。解耦接口为加载/存储单元配置独立地址生成单元，使读取可以提前发起、写入可以延后提交，从而减少加速器等待；其代价是需要地址生成单元和先进先出缓冲，并且只适用于地址可静态生成的流式访问。暂存接口在加速器内部保留专用缓冲，通过 DMA 在加速器执行前后与存储系统同步，适合访问足迹小且重复访问多的内存区域，但需要暂存缓冲、DMA 引擎和静态访存足迹信息 @cayman2025。

这些接口不是简单工程选项，而直接影响控制流优化是否能转化为性能收益。例如在顺序循环中，解耦接口可以减少读取停顿；在循环流水化中，耦合接口可能使启动间隔受限，而解耦接口能使启动间隔接近理想值；在循环展开中，暂存存储可以为多个并行访问提供本地带宽。Cayman 因此为选定内核合成多种加速器配置，组合循环展开、循环流水化和数据访问接口策略。其启发式策略是：对无循环携带依赖的循环尝试展开，对最内层循环做流水化；当访问总次数显著大于访存足迹时使用暂存存储，当流水化循环中需要提前/延后访问时使用解耦接口，其余情况选择耦合接口以节省面积 @cayman2025。

#figure(
  image("assets/cayman/data-comm-scheduling.pdf", width: 86%),
  caption: [Cayman 数据访问接口对调度的影响。coupled、decoupled 和 scratchpad 接口在顺序循环、流水循环和展开循环中的延迟/启动间隔差异直接决定加速器收益。],
)

为了避免对每个候选都完整综合硬件，Cayman 还构建性能和面积估计模型。该模型先根据配置对内核做循环展开，再只综合流水化循环区域和顺序基本块区域，最后自底向上估计外层区域的周期数和面积。对于每个基本调度单元，周期数来自调度延迟与性能剖析得到的执行次数，面积来自综合报告；外层区域的延迟则由子区域累加并加上控制逻辑开销。结合原始程序总时间、被加速候选区域的剖析时间和目标频率，Cayman 可以快速估算整体加速比，从而支持候选选择中的大规模探索 @cayman2025。

=== 候选选择算法与加速器合并

基于 wPST，Cayman 将候选选择建模为带有树形互斥约束的背包问题。每个 wPST 区域是一个候选项，其收益是加速后的性能收益，权重是面积开销；约束是如果选择某个区域，其所有后代区域不能再被选择，以避免同一程序区域被重复卸载。Cayman 使用动态规划求解该问题：对每个 wPST 节点 `v`，维护其子树内帕累托最优解序列 `F[v]`；若 `v` 是基本块，则候选来自该基本块的加速配置；若 `v` 是控制流区域，则在“直接加速该区域”和“组合其子节点解”之间取帕累托前沿；若 `v` 是根节点，则组合不同函数的解。为了控制复杂度，Cayman 还使用基于性能剖析和程序分析的剪枝跳过不值得加速的区域，并通过解过滤移除面积过近的帕累托解，使每个子问题的解数量保持在可控范围内 @cayman2025。

#pagebreak()

#block(breakable: false)[
  #rect(width: 100%, inset: 6pt, stroke: gray + 0.7pt)[
    #align(center)[Cayman 源文中的性能估计、候选选择递推和过滤规则]
    #text(size: 7.4pt)[
      收益估计：`Speedup = T_all / (T_all - T_cand + Cycle_cand / F)`，其中 `T_all` 是原程序总时间，`T_cand` 是候选区域剖析时间，`Cycle_cand` 是候选加速器估计周期数，`F` 是目标频率。\
      状态转移：若 `v` 为基本块，`F[v] <- pareto(accel(v, R))`；若 `v` 为控制流区域，`F[v] <- pareto(accel(v, R) union tensor_(u in v.children) F[u])`；否则 `F[v] <- pareto(tensor_(u in v.children) F[u])`。\
      兄弟组合：`F[u_1] tensor F[u_2] = pareto({phi_1 union phi_2 | phi_1 in F[u_1], phi_2 in F[u_2]})`，用于组合互不重叠子树候选。\
      解过滤与复杂度：若首个满足 `a_j > alpha a_i` 的解为 `phi_j`，则移除 `{phi_(i+1), ..., phi_(j-1)}`，候选序列规模由 `A` 降为 `log_alpha A` 量级；总复杂度为 `O(N log_alpha^2 A + E)`。
    ]
  ]
]

#algorithm-figure(
  "Candidate Selection",
  supplement: "算法",
  inset: 0.25em,
  indent: 0.7em,
  vstroke: .5pt + luma(200),
  {
    import algorithmic: *
    Function("DP", ($v$, $R$), {
      If($"prune"(v, R)$, {
        Return[$emptyset$]
      })
      If($"is-basic-block"(v)$, {
        Assign[$F[v]$][$"filter"("pareto"("accel"(v, R)))$]
      })
      Else({
        Assign[$F[v]$][$emptyset$]
        For($u in "children"(v)$, {
          Assign[$F[v]$][$"filter"(F[v] \otimes F[u])$]
        })
        If($"is-control-region"(v)$, {
          Assign[$F[v]$][$"filter"(F[v] union "pareto"("accel"(v, R)))$]
        })
      })
    })
    Function("Candidate-Selection", ($T$, $R$), {
      Assign[$F["root"]$][$"DP"(T."root", R)$]
      Return[$F[T."root"]$]
    })
  },
  caption: [Cayman 源文 Algorithm 1 的候选选择算法。该动态规划在全应用程序结构树上自底向上组合候选，同时用剪枝、帕累托前沿和过滤控制搜索规模。],
)

候选选择解决“哪些区域加速”的问题，但如果每个区域都生成独立加速器，面积可能迅速膨胀。Cayman 因此提出加速器合并。其核心观察是，多个区域即使控制流不同，也可能包含相似的基本块数据流；数据通路中的浮点运算和访存往往占主要面积，而控制有限状态机相对较小。因此，Cayman 将基本块中共享操作合并为可重构数据通路单元，通过多路选择器和重配置位寄存器选择不同数据路径；每个原始区域保留独立有限状态机，执行时由全局控制单元发送配置并触发对应控制逻辑。系统以启发式方式估计每对基本块合并后的面积节省，反复合并节省最大的候选对，直到没有进一步收益 @cayman2025。

#figure(
  image("assets/cayman/accelerator-merging.pdf", width: 90%),
  caption: [Cayman 加速器合并。不同控制流区域可共享相似基本块数据通路，保留独立有限状态机并通过可重构数据通路降低面积。],
)

=== 实验评估与意义

Cayman 的评估使用 PolyBench、MachSuite、MediaBench 和 CoreMark-Pro 等多类基准测试，并与 NOVIA 和 QsCores 两个自动化加速器综合框架比较。实验设置中，目标频率为 500 MHz，面积以 CVA6 RISC-V tile 为归一化基准，并评估小面积预算（25%）和大面积预算（65%）两种情况。在 25% 面积预算下，Cayman 相对 NOVIA 和 QsCores 分别取得平均 14.4x 和 8.0x 加速比；在 65% 预算下，优势扩大到 27.2x 和 15.0x。这一结果来自 Cayman 对控制流优化和数据访问接口专门化的联合支持，而 NOVIA 不支持控制流/访存，QsCores 则主要生成顺序控制流和较慢访问接口 @cayman2025。

更细的结果说明 Cayman 的收益来自机制本身，而不只是更多面积。对于热点分布均匀的程序，Cayman 在面积预算增大时选择更多内核；对于热点集中的程序，则把更多面积集中用于关键区域。接口选择结果显示，解耦接口和暂存接口被广泛采用，说明数据访问接口专门化是性能来源之一。加速器合并在两个面积预算下分别节省约 36% 和 35% 面积，每个可复用加速器平均加速多个程序区域；在包含相似基本块的 3mm 基准测试中，面积节省可达 70% 以上，而在只有单个热点的 doitgen 中收益较低。这些现象与 Cayman 的设计预期一致：当程序中存在丰富控制流、重复数据通路和复杂访存时，wPST、接口建模、候选选择和加速器合并的联合设计才能发挥作用 @cayman2025。

从本报告的角度看，Cayman 的意义在于把“架构接口”从指令级扩展到更完整的处理器-加速器协同边界。自定义指令通常受寄存器操作数、指令编码和处理器流水线接口约束；自定义加速器则更强调区域/内核级语义、数据搬运、接口带宽、控制流调度和多个调用点之间的硬件复用。Cayman 补足了领域定制链条中的第三个层次：APS/Aquas 解决“如何接入”，ISAMORE 解决“定制什么”，Cayman 则强调“在何种微架构和接口约束下生成可复用加速器”。这使本章从指令扩展走向更一般的领域定制架构能力，为第三章讨论高质量硬件实现奠定了过渡基础。

== 本章小结

本章围绕第一章提出的第一个科学问题，讨论了应用需求如何通过架构接口转化为可复用的指令、微架构和加速器能力。APS 和 Aquas 从端到端工具链角度说明，领域定制能力必须同时具有硬件接口、合成实现、编译映射、系统评估和性能-功耗-面积反馈，才能从应用想法变成可迭代的应用专用处理器与定制指令扩展机制。ISAMORE 从可复用指令发现角度说明，自定义能力不能只来自局部热点，而应由程序语义、跨工作负载复用和硬件代价共同决定。Cayman 则把这一逻辑推进到自定义加速器生成，强调控制流、数据访问、处理器-加速器接口和加速器合并对领域定制能力选择的决定性作用。

这些工作共同表明，领域定制不是“发现热点并硬化”的线性过程，而是应用语义、架构接口、微架构约束、编译支持和硬件实现之间的协同过程。一个定制能力是否值得进入系统，取决于它能否跨应用复用、能否被编译器稳定识别、能否通过接口高效传输数据、能否在硬件中以合理面积和时序实现，并能否在真实工作负载中获得端到端收益。因此，本章既回答了“定制什么”和“如何接入”的问题，也自然引出下一章：当架构能力已经被识别并表达出来以后，如何把它们高质量地落到可综合、可验证、性能与资源可控的硬件实现中。
