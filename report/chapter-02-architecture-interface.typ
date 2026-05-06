= 面向领域定制的架构接口与端到端协同

== 引言

第一章指出，领域定制计算的核心难点不是发现某个应用热点，而是把应用需求转化为可以被软硬件系统长期使用的架构能力。本章围绕这一问题展开，讨论应用需求如何通过架构接口转化为可复用的指令、微架构和加速器能力。这里的“架构接口”既包括处理器与自定义指令单元之间的硬件协议，也包括指令语义、存储访问路径、编译器识别机制、运行时可见行为和设计者能够迭代使用的工具链产物。

本章的组织遵循“端到端协同框架 -> 定制什么 -> 微架构约束”的递进关系。首先，APS 和 Aquas 关注领域定制能力如何接入完整 ASIP/ISAX 工具链：APS 解决开放 RISC-V 生态中接口分裂、硬件合成和编译支持割裂的问题；Aquas 进一步面向复杂数据密集 ISAX，把 memory-interface attributes、cache effects、MLIR/Aquas-IR、e-graph rewrite 和 skeleton-component matching 结合起来，使硬件侧访存机制选择和软件侧自动 offloading 能够共同优化。随后，ISAMORE 将问题推进到“应该定制什么”本身，强调自定义指令面积昂贵，必须从跨程序语义等价空间中发现可复用指令模式。最后，Cayman 将补充微架构感知定制，使领域能力选择与具体微架构约束形成更紧密的端到端协同。

这三个层次共同回应第一个科学问题。APS/Aquas 说明领域能力如何进入可运行、可评估、可综合的工具链；ISAMORE 说明领域能力如何避免局部热点定制，转而成为跨工作负载可复用的架构机制；Cayman 则说明架构能力不能停留在抽象指令层，还需要结合微架构结构、接口代价和实现约束进行选择。本章并不把这些工作写成论文列表，而是把它们作为同一研究链条的不同阶段：先建立可接入系统的协同框架，再解决可复用定制能力发现，最后把定制能力与微架构事实对齐。

== ASIP/ISAX 端到端协同框架：APS 与 Aquas

ASIP/ISAX 是领域定制计算中兼顾可编程性和专用硬件效率的重要形态。与传统固定加速器相比，自定义指令和专用执行单元能够保持通用处理器的软件入口，使应用在普通控制流、库函数和系统运行环境中调用领域能力；与纯软件优化相比，它们又能把频繁出现的计算、访存或控制模式硬化到专用数据通路中。因此，ASIP/ISAX 是连接应用需求与架构能力的自然接口。但这一接口真正可用，需要同时解决硬件协议、指令语义、合成实现、编译器调用和系统级评估问题。

=== APS：统一 ISAX 接口与端到端 ASIP 工具链

APS 的出发点是开放 RISC-V ASIP 生态中的端到端割裂。RoCC 和 CV-X-IF 等接口都采用处理器与自定义单元解耦的握手式交互，但二者在 commit/recall、issue/response、内存访问和控制信号组织上存在差异。RoCC 偏向简化加速器设计，并由处理器侧保证 offloaded instruction 的提交；CV-X-IF 则显式暴露 commit channel，使带副作用的操作必须等待确认后才能执行。二者具有相近的交易语义，却因为协议细节、实现语言和平台生态不同而难以复用同一 ISAX 设计。APS 因此提出 transaction-based 的统一 ISAX 接口抽象 APS-itfc，把 issue、GPR request、recall、memory read/write、memory response 和 result response 等交互统一为 valid-ready transaction，并通过 backend adapter 自动映射到 RoCC 或 CV-X-IF @aps2025。

#figure(
  image("assets/aps/isax-itfc.pdf", width: 90%),
  caption: [APS 对 RoCC 与 CV-X-IF 处理器-定制指令接口的统一抽象。图中核心关系是把平台相关信号组织为统一 transaction 语义，再通过后端 adapter 接入不同 RISC-V SoC。],
)

APS-itfc 的意义不只是隐藏接口信号差异，而是为后续硬件合成和编译支持建立共同边界。自定义指令单元只需要面向统一 transaction 语义描述与处理器的交互，RoCC 或 CV-X-IF 的 tag、size、commit/recall 等平台细节由 adapter 处理。APS 在 Rocket/Chipyard 与 CV32E40X/Croc 两个开源 RISC-V 平台上实现这一抽象，并补充参数化 cache、Verilator cycle-accurate simulation、Yosys/OpenROAD ASIC flow 等工具链环节，使同一类定制能力能够在不同 SoC 框架中完成集成、仿真和物理实现评估。这一设计回答了 ASIP 研究中的第一层问题：领域能力必须有一个跨平台、可落地的架构接口，否则后续合成和编译优化会被具体处理器协议锁死。

在硬件侧，APS 通过 CADL 和 APS-synth 提供 ISAX-specific synthesis。CADL 允许设计者描述自定义指令的高层行为，同时直接访问统一 APS-itfc transaction 和低层硬件组件；其描述内容被降低为 Structured IR（SIR）和 Scheduled Structured IR（SSIR）。SIR 保留 sequence、block、loop、loop-carried variables、method call 等结构，便于类型推导、函数解释和程序优化；SSIR 则把调度结果表达为 pipeline/stage 结构，用于估计性能并生成硬件。APS-synth 在调度中加入自定义指令特有约束，例如 register-file read 必须位于触发阶段、latency-insensitive operations 不能错误并列以避免 deadlock，并最终构造 transaction-based dynamic pipeline。这使 APS 不仅能生成组合逻辑式指令，也能描述带状态、循环、流水和自定义组件的更复杂 ISAX 行为 @aps2025。

在软件侧，APS 提供 APS-c 编译框架，把 CADL 语义导出为编译器可用的匹配信息，并在 LLVM 中生成 intrinsic-like C wrappers、semantic-based matcher、profile-guided matcher 和 bitwidth-aware vectorization。semantic-based matcher 面向控制较简单的 IR 模式，自动识别等价指令序列并替换为 ISAX 调用；profile-guided matcher 面向复杂循环或控制区域，通过解释执行和 input-output 行为比较辅助发现可以 offload 的代码区域。bitwidth-aware vectorization 则针对 RV32 等架构中低位宽操作无法充分利用寄存器位宽的问题，把多个低位宽 scalar ISAX 调用打包为 SIMD-style ISAX，并在超过寄存器带宽时自动插入辅助 memory/config 操作。由此，APS-c 把自定义指令从“需要程序员手写 intrinsic”推进到“编译器根据硬件语义自动发现和使用”的形态 @aps2025。

#figure(
  image("assets/aps/flow.pdf", width: 92%),
  caption: [APS 端到端流程。统一接口、CADL/APS-synth、APS-c 编译支持和 SoC/ASIC 评估共同构成敏捷 ASIP 迭代链条。],
)

APS 的评估覆盖后量子密码、量化 LLM 和数字信号处理三个领域，展示了端到端工具链的实际效果。在 CRYSTALS-KYBER 中，NTT butterfly 与 PWM/Karatsuba 等 ISAX 用约 175 行 CADL 描述，并在两个 RISC-V 平台上获得明显加速；Butterflyx2 在两个平台上最高达到 10.16x，Karatsuba 对 PWM baseline 最高达到 14.99x。在 BitNet b1.58 的 BitLinear 场景中，dotprodW2A8x4 ISAX 针对 8-bit activation 与 2-bit weight 的 dot product，完整 BitLinear 层获得 2.03x 和 2.29x 加速，并可由 profile-based matcher 自动利用。在 DSP 场景中，SOS 与 IIR ISAX 支撑 DPLL 中的 IIR filter 加速，IIR 指令通过深流水和硬件 loop 消除软件调用与循环开销，在 Croc 和 Rocket 上分别获得 5.51x 和 5.18x 加速。这些结果说明 APS 的价值不仅是某个指令加速，而是把指令设计、硬件合成、编译插入、仿真评估和 ASIC PPA 反馈连成完整敏捷迭代流程 @aps2025。

然而，APS 也暴露出下一层挑战。它已经把自定义指令接入统一接口和编译流程，但在复杂数据密集应用中，性能往往受限于存储层次、接口带宽、cache 行为和更复杂的软件变体。APS 的 CADL 和编译器能够描述较一般的行为，但对块级内存访问、scratchpad 使用、burst transfer、cache hierarchy mismatch、复杂 loop transformation 和鲁棒 ISAX matching 的支持仍不充分。换言之，APS 建立了端到端协同框架，但当领域定制从 scalar/SIMD-like 指令推进到更复杂的 memory-centric ISAX 时，架构接口必须进一步显式表达访存机制和 cache effects，编译器也必须在更大的程序等价空间中进行稳健匹配。

=== Aquas：数据密集 ISAX 的硬件-软件协同优化

Aquas 正是沿着这一方向推进。它仍以 ASIP/ISAX 为对象，但把问题从“统一接口和基本端到端流程”扩展为“复杂数据密集 ISAX 的硬件-软件整体协同优化”。在硬件侧，Aquas 首先建立 core-ISAX memory interface model，用宽度、最大 beat count、in-flight transaction 数、读 lead-off latency、写完成代价和 cache-line size 等参数刻画不同访问路径。这个模型说明，接口选择并非微小实现细节：窄低延迟接口和宽高延迟接口在不同访问粒度、burst 能力和 cache 层次下会产生不同性能结果，错误选择可能引入 7 到 9 cycle 的局部延迟惩罚，并在更大设计中放大为系统性能损失 @aquas2026。

#figure(
  image("assets/aquas/overview.pdf", width: 92%),
  caption: [Aquas 的硬件-软件协同流程。硬件侧以访存接口模型和 Aquas-IR 支撑合成，软件侧以 MLIR、等价图重写和 skeleton-component matching 支撑自动 offloading。],
)

为了把这些硬件事实纳入合成，Aquas 设计了三层 Aquas-IR。functional level 接近高层软件语义，描述 transfer、fetch 等与具体访问机制无关的操作；architectural level 引入 `memitfc` 符号，把 memory operation 绑定到具体接口，并使其受到对齐、transaction size、in-flight limit 等微架构约束；temporal level 则用异步 issue/wait 和 ordering attribute 表达事务顺序、cache 层次和有限并发下的具体时序。基于这一 IR，Aquas 进行 scratchpad buffer elision、interface selection and canonicalization、transaction scheduling and ordering，以及最终硬件生成。其关键意义在于，访存接口选择不再是手工经验或后端偶然结果，而成为可分析、可搜索、可在 IR 中回放的架构决策 @aquas2026。

在软件侧，Aquas 进一步解决复杂 ISAX offloading 的鲁棒编译问题。复杂 ISAX 的语义常与应用代码存在抽象层次差异：软件表示关注 value、control flow 和 memory effect，而硬件描述中可能包含 scratchpad、寄存器交互和接口传输语义。Aquas 首先把软件代码通过 Polygeist 转到 MLIR 基础 dialect，并把 Aquas-IR functional level 中的硬件语义规范化到同一抽象层次。随后，它把 MLIR 与 e-graph 结合：MLIR 保留结构化控制流和 side-effect ordering，e-graph 非破坏性地累积等价程序变体；internal rewrites 用于代数和数据流变换，external rewrites 则通过调用 MLIR loop passes 实现 tiling、unrolling 等控制流重构。为了避免 e-graph 爆炸，Aquas 根据目标 ISAX 的 loop characteristics 有选择地触发外部重写，最后通过 skeleton-component matching 检查控制结构、数据流组件、dominance、ordering 和 effect constraints，自动插入 ISAX 调用 @aquas2026。

#figure(
  image("assets/aquas/compiler.pdf", width: 92%),
  caption: [Aquas 编译器流程。MLIR 负责结构化程序表示与外部循环变换，等价图负责累积等价变体，最终通过 skeleton-component matching 插入复杂 ISAX 调用。],
)

这种设计把 APS 中的自动 intrinsic insertion 扩展到更复杂的语义空间。APS 的 pattern matching 已经能够处理部分语义和 profile-based 场景，但 Aquas 更强调：同一个 ISAX 可能对应许多语法不同、控制流形态不同、但语义等价的软件实现；编译器若只匹配单一模式，会被 loop tiling、unrolling、代数变换、冗余语句和非 affine 表达轻易破坏。因此，Aquas 把“匹配一个模式”转化为“在受约束的等价空间中寻找与目标 ISAX skeleton/components 对齐的程序变体”。这使编译接口更接近第一章所说的 harness medium：目标事实、IR 表示、rewrite、matching、cost model 和证据共同约束 offloading 决策。

Aquas 的评估进一步说明了这一复杂协同的必要性。它在后量子密码、点云处理、图形渲染和 CPU LLM 推理四类场景中评估真实 workload。对于 code-based PQC 的 syndrome computation，Aquas 为 bitstream unpacking 和 GF(2^n) matrix multiplication 设计 ISAX，并在 Rocket baseline 上获得 7.59x 和 3.29x kernel speedup，端到端获得 1.42x speedup，面积开销小于 5.3% 且无频率下降。在点云 ICP 场景中，Aquas 针对 Euclidean distance、covariance matrix、maximum comparison 和 matrix-vector multiplication 等操作设计 ISAX，kernel speedup 达到 1.46x 到 9.27x，端到端达到 1.96x；其优势来自对不规则访存、矩阵/向量混合访问和扩展总线带宽的更好利用。在图形渲染中，Aquas 与 RISC-V vector unit Saturn 比较，多个 kernel 获得 9.47x 到 15.61x 加速，并在性能面积权衡上优于通用向量单元。在 CPU LLM 推理的 FPGA prototype 中，Aquas 针对 attention computation 设计 ISAX，在 Llama 2 110M 8-bit 量化模型上获得 9.30x TTFT 和 9.13x ITL 加速。这些结果说明，当应用具有复杂访存和控制形态时，端到端协同必须同时考虑硬件访存接口、编译等价空间和真实系统评估 @aquas2026。

从研究链条看，APS 和 Aquas 共同回答了“如何把定制能力端到端接入工具链”这一问题。APS 建立了跨 RISC-V 平台的统一接口、ISAX-specific synthesis 和自动编译插入，使领域能力能够从 CADL 和 C 程序进入可仿真、可综合、可评估的 SoC。Aquas 则进一步把复杂数据密集场景中的访存接口、cache hierarchy、MLIR/Aquas-IR、e-graph 重写和 skeleton-component matching 纳入同一流程，使定制能力不仅能接入工具链，还能在更复杂硬件事实和软件变体中被正确、鲁棒、有效地使用。二者为后续 ISAMORE 提供了基础：当端到端接入问题被系统化以后，下一步关键就变成如何从应用集合中自动发现真正值得接入这些接口的可复用架构能力。

== 可复用自定义指令识别：ISAMORE

=== 研究背景与问题建模

APS 和 Aquas 解决的是“如何把定制能力接入端到端工具链”的问题，但它们仍然预设设计者已经知道哪些能力值得定制。对于敏捷芯片设计而言，这个前提并不总成立。自定义指令会占用面积、引入验证负担，并影响处理器接口、编译器后端和系统维护；如果一个指令只服务于少数局部热点，它即使在单个 kernel 上有效，也很难成为长期可复用的架构能力。因此，在端到端接入工具链之上，还需要回答一个更前置的问题：从一组领域代表程序中，如何自动发现具有跨程序、跨工作负载价值的可复用自定义指令。

传统自动指令发现大多以程序热点和语法结构为中心。细粒度方法枚举 basic block 内的 convex subgraph，能够找到局部可替换片段，但受限于基本块范围和较小模式，容易错过更大粒度的优化机会；粗粒度方法把 basic block 或代码区域整体合并为加速单元，能够覆盖更多操作，却常生成过大的专用硬件，复用次数低，甚至包含在通用处理器上更适合执行的指令序列。二者共同的问题是过度依赖 syntactic analysis：如果两个代码片段语法不同但语义等价，它们往往被视为不同模式，最终产生多个相似但不共享的硬件单元。ISAMORE 的问题意识正来自这一点：真正适合作为 ISA 扩展的能力，不应只是某个热点中的语法片段，而应是语义上可泛化、在多个位置反复出现、且硬件代价与性能收益匹配的模式 @isamore2026。

ISAMORE 将可复用自定义指令识别建模为 reusable instruction identification，并提出 RIMT 方法。其输入是一组领域代表程序，输出是一组在性能和面积之间形成 Pareto trade-off 的自定义指令候选。这个过程首先把 LLVM IR 转换为结构化 DSL，再编码为 e-graph；随后通过 phase-oriented equality saturation 和 e-graph anti-unification 发现语义等价空间中的公共模式；最后用硬件感知 cost model 选择值得实现的模式，并通过 HLS 和 RoCC wrapper 等后端生成可评估硬件。与 APS/Aquas 相比，ISAMORE 的位置更靠前：它不只是让编译器使用已有 ISAX，而是帮助设计者决定哪些 ISAX 值得进入后续工具链。

#figure(
  image("assets/isamore/overview.pdf", width: 92%),
  caption: [ISAMORE/RIMT 总体流程。领域程序先进入结构化 DSL 和等价图表示，再经过分阶段等式饱和、反合一、向量化、硬件感知选择和后端生成，形成可复用定制指令集合。],
)

=== 结构化 DSL 与 E-graph Anti-unification

为了让一般程序能够进入 e-graph anti-unification，ISAMORE 首先设计 structured DSL。该 DSL 覆盖 arithmetic、logical、memory access 等常规操作，同时引入 `Loop` 和 `If` 表达控制流，并提供 `Vec`、vector unary/binary/ternary operations、pattern variables 和 `App` 等结构。`Loop` 以 do-while 风格表达 loop-carried variables、loop condition 和 body result，使控制流能够以结构化、数据流中心的方式进入 e-graph。该 DSL 还具有强类型系统，利用 e-class analysis 推导每个 e-class 的 result type，并对 `If` 和 `Loop` 的输入输出 tuple 施加结构约束。这个设计解决了直接把一般程序放入 e-graph 的第一层障碍：程序不再只是若干代数表达式，而是保留了循环、条件、类型和向量结构的可泛化语义对象 @isamore2026。

在此基础上，ISAMORE 的核心方法是 e-graph anti-unification。e-graph 用 e-class 表示等价项集合，equality saturation 通过重写规则暴露语义等价形式；anti-unification 则在两个项之间求 least general generalization，从而发现公共结构。例如，两个语法不同但可重写到同一等价形式的表达式，可以被泛化为带 pattern variables 的候选指令模式。这个思路把“复用”从语法匹配提升到语义等价空间：同一个自定义指令可以覆盖多个表面形态不同的程序片段，只要它们在 e-graph 中共享可泛化结构。

=== Phase-oriented RIMT 与 Smart AU

直接使用 vanilla e-graph AU 并不可行，因为真实程序的 e-class 数量和候选 AU pattern 数会迅速爆炸。ISAMORE 因此提出 phase-oriented iteration。它放弃一次性对所有重写规则做完整饱和，而是把规则按 saturating/nonsaturating、int/float、vector/scalar 等维度组织为 base rulesets，并由 phase scheduler 逐步选择规则集。早期阶段先应用不会显著增加 e-class 的 saturating rules，尽可能暴露低成本等价形式；后续阶段再以受限次数应用 nonsaturating rules，以避免 e-graph 规模失控。每个 phase 中，RIMT 会把以前识别的 pattern 作为 pattern-application rewrites 重新注入 e-graph，使后续阶段能够在已有模式的基础上进一步泛化。这样做既控制了搜索规模，又允许指令模式从局部公共结构逐渐演化为更高复用度的候选 @isamore2026。

RIMT 的第二个关键是 smart AU。vanilla AU 需要枚举大量 e-class pair，并对每对 e-node 递归生成候选 pattern，实际复杂度很快失控。smart AU 用两类启发式降低复杂度。第一是 similarity-based e-class pairing：ISAMORE 用类型信息排除 result type 不一致的 e-class，再通过 structural hashing 估计 e-class 的结构相似度，只对相似度超过阈值的 pair 做 AU。structural hashing 对字面量、参数和 pattern variables 做统一处理，强调结构而非具体常量，从而更适合寻找可复用模式。第二是 heuristic AU pattern sampling：当某个 e-node pair 的 AU 候选过多时，ISAMORE 不保留全部 Cartesian product，而用 boundary 或 kd-tree 策略根据 latency/area 特征选取代表性 pattern。前者保留特征值极端的模式以提高效率，后者在特征空间中取更广覆盖以改善质量。二者共同使 e-graph AU 从理论上有吸引力但不可用的方法，变成可以处理真实程序的指令识别机制 @isamore2026。

#figure(
  image("assets/isamore/smart_au.pdf", width: 90%),
  caption: [ISAMORE 的 smart AU 机制。相似度筛选和候选采样共同控制等价图反合一的搜索规模，使可复用指令模式发现能够扩展到真实程序。],
)

=== 向量化、硬件感知选择与真实系统评估

除了语义复用，ISAMORE 还把 data-level parallelism 纳入指令发现过程。传统指令发现往往把 scalar pattern 作为主要对象，即使程序中存在多路相似操作，也不一定生成向量化自定义指令。ISAMORE 的 pattern vectorization 把一个 vectorized pattern 看作同一个 pattern 在多个 lane 上的应用。其流程先通过 smart AU 找到可重复出现的 scalar seed，再把同一 basic block 中的多个 seed pack 成 `Vec` 节点；随后通过 lift rewrites 恢复 VecAdd、VecMul 等向量构造，并用 couple rewrites 建立 vector 到 scalar lane 的数据流；最后用 greedy extraction 和 compress-style pruning 消除 `Get-Vec-Get` cycle 与组合式 packing 爆炸，只保留高 DLP 的非重叠向量化方案。这使自定义指令发现不局限于“找到一个可复用 scalar 片段”，而能同时探索向量化、硬件 loop 和更高吞吐的数据通路 @isamore2026。

#figure(
  image("assets/isamore/vector.pdf", width: 90%),
  caption: [ISAMORE 的 pattern vectorization。多个可复用标量模式被组合为向量化模式，从而把数据级并行性纳入定制指令发现。],
)

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

#figure(
  image("assets/cayman/framework.pdf", width: 92%),
  caption: [Cayman 总体框架。应用程序经 wPST、profiling 和程序分析进入候选选择，再经接口建模、加速器合并和硬件综合形成可复用加速器。],
)

=== wPST 表示、Profiling 与程序分析

Cayman 引入 wPST 的原因在于，传统 data-flow graph 级自定义硬件生成难以处理真实程序中的控制流和跨函数结构。Program structure tree（PST）本来用于识别函数内 single-entry-single-exit（SESE）region；Cayman 将其扩展为 whole-application program structure tree，在根节点下加入函数节点，并把每个函数中的 SESE region 表示为候选区域。SESE 约束很关键：只有具有单入口和单出口的区域，才能在 offloading 后通过入口/出口处的同步与主处理器隔离执行，从而形成清晰的 processor-accelerator 边界。wPST 中的候选区域包括 basic block region 和包含 loop/conditional 的 control-flow region，使候选选择不再局限于平坦 DFG @cayman2025。

仅有区域树仍不足以决定哪些区域值得加速。Cayman 因此对应用进行 profiling，记录每个 region 的持续时间和执行次数，用于定位 hotspot 并估算潜在性能收益；同时执行程序分析，收集 memory dependency、memory access pattern 和 access footprint。具体而言，系统识别 loop-carried dependency，以判断 loop pipelining 或 unrolling 是否可行；识别 stream access pattern，以判断地址序列是否可静态生成；分析每个 memory operation 的访问范围，以估计 scratchpad 大小和缓存收益。这些分析结果直接进入后续加速器配置，而不是作为孤立的诊断信息 @cayman2025。

=== 加速器建模与数据访问接口选择

Cayman 的关键贡献之一是把 processor-accelerator data access interface 显式纳入建模。其模型包含三类接口。Coupled interface 使用 load/store unit 访问存储系统，加速器在发出访问请求后等待响应，面积开销较低但容易产生 stall。Decoupled interface 为 load/store unit 配置独立 address generation unit（AGU），使 load 可以提前发起、store 可以延后提交，从而减少加速器等待；其代价是需要 AGU 和 FIFO buffering，并且只适用于地址可静态生成的 stream access。Scratchpad interface 在加速器内部保留专用 buffer，通过 DMA 在加速器执行前后与存储系统同步，适合访问 footprint 小且重复访问多的内存区域，但需要 scratchpad buffer、DMA engine 和静态 footprint 信息 @cayman2025。

这些接口不是简单工程选项，而直接影响控制流优化是否能转化为性能收益。例如在顺序 loop 中，decoupled interface 可以减少 load stall；在 loop pipelining 中，coupled interface 可能使 initiation interval 受限，而 decoupled interface 能使 II 接近理想值；在 loop unrolling 中，scratchpad 可以为多个并行访问提供本地带宽。Cayman 因此为选定 kernel 合成多种 accelerator configuration，组合 loop unrolling、loop pipelining 和数据访问接口策略。其启发式策略是：对无 loop-carried dependency 的 loop 尝试 unrolling，对最内层 loop 做 pipelining；当访问总次数显著大于 footprint 时使用 scratchpad，当 pipelined loop 中需要提前/延后访问时使用 decoupled interface，其余情况选择 coupled interface 以节省面积 @cayman2025。

#figure(
  image("assets/cayman/data-comm-scheduling.pdf", width: 92%),
  caption: [Cayman 数据访问接口对调度的影响。coupled、decoupled 和 scratchpad 接口在顺序循环、流水循环和展开循环中的延迟/启动间隔差异直接决定加速器收益。],
)

为了避免对每个候选都完整综合硬件，Cayman 还构建性能和面积估计模型。该模型先根据配置对 kernel 做 loop unrolling，再只综合 pipelined loop region 和 sequential basic block region，最后自底向上估计外层 region 的 cycle count 和 area。对于每个基本调度单元，cycle count 来自调度延迟与 profiling execution count，area 来自综合报告；外层 region 的 latency 则由子区域累加并加上控制逻辑开销。结合原始程序总时间、被加速候选区域的 profile 时间和目标频率，Cayman 可以快速估算整体 speedup，从而支持候选选择中的大规模探索 @cayman2025。

=== 候选选择算法与加速器合并

基于 wPST，Cayman 将 candidate selection 建模为带有树形互斥约束的 knapsack problem。每个 wPST region 是一个候选 item，其 profit 是加速后的性能收益，weight 是面积开销；约束是如果选择某个 region，其所有后代 region 不能再被选择，以避免同一程序区域被重复 offload。Cayman 使用 dynamic programming 求解该问题：对每个 wPST 节点 `v`，维护其子树内 Pareto-optimal solution sequence `F[v]`；若 `v` 是 basic block，则候选来自该 basic block 的加速配置；若 `v` 是 control-flow region，则在“直接加速该 region”和“组合其子节点解”之间取 Pareto frontier；若 `v` 是根节点，则组合不同函数的解。为了控制复杂度，Cayman 还使用 profiling/analysis-based pruning 跳过不值得加速的 region，并通过 solution filtering 移除面积过近的 Pareto 解，使每个子问题的解数量保持在可控范围内 @cayman2025。

候选选择解决“哪些区域加速”的问题，但如果每个区域都生成独立加速器，面积可能迅速膨胀。Cayman 因此提出 accelerator merging。其核心观察是，多个 region 即使控制流不同，也可能包含相似的 basic block dataflow；数据通路中的浮点运算和 memory access 往往占主要面积，而控制 FSM 相对较小。因此，Cayman 将 basic block 中共享操作合并为 reconfigurable datapath unit，通过 multiplexers 和 reconfiguration bit registers 选择不同数据路径；每个原始 region 保留独立 FSM，执行时由 global control unit 发送配置并触发对应控制逻辑。系统以启发式方式估计每对 basic block 合并后的面积节省，反复合并节省最大的 pair，直到没有进一步收益 @cayman2025。

#figure(
  image("assets/cayman/accelerator-merging.pdf", width: 92%),
  caption: [Cayman 加速器合并。不同控制流区域可共享相似 basic block 数据通路，保留独立 FSM 并通过可重构数据通路降低面积。],
)

=== 实验评估与意义

Cayman 的评估使用 PolyBench、MachSuite、MediaBench 和 CoreMark-Pro 等多类 benchmark，并与 NOVIA 和 QsCores 两个 automated accelerator synthesis framework 比较。实验设置中，目标频率为 500 MHz，面积以 CVA6 RISC-V tile 为归一化基准，并评估小面积预算（25%）和大面积预算（65%）两种情况。在 25% 面积预算下，Cayman 相对 NOVIA 和 QsCores 分别取得平均 14.4x 和 8.0x speedup；在 65% 预算下，优势扩大到 27.2x 和 15.0x。这一结果来自 Cayman 对 control flow optimization 和 data access interface specialization 的联合支持，而 NOVIA 不支持 control flow/memory access，QsCores 则主要生成顺序控制流和较慢访问接口 @cayman2025。

更细的结果说明 Cayman 的收益来自机制本身，而不只是更多面积。对于 hotspot 分布均匀的程序，Cayman 在面积预算增大时选择更多 kernel；对于 hotspot 集中的程序，则把更多面积集中用于关键区域。接口选择结果显示，decoupled 和 scratchpad interface 被广泛采用，说明数据访问接口 specialization 是性能来源之一。Accelerator merging 在两个面积预算下分别节省约 36% 和 35% 面积，每个 reusable accelerator 平均加速多个程序区域；在包含相似 basic block 的 3mm benchmark 中，面积节省可达 70% 以上，而在只有单个 hotspot 的 doitgen 中收益较低。这些现象与 Cayman 的设计预期一致：当程序中存在丰富控制流、重复数据通路和复杂访存时，wPST、接口建模、候选选择和 merging 的联合设计才能发挥作用 @cayman2025。

从本报告的角度看，Cayman 的意义在于把“架构接口”从指令级扩展到更完整的 processor-accelerator 协同边界。自定义指令通常受寄存器操作数、指令编码和处理器流水线接口约束；自定义加速器则更强调 region/kernel 级语义、数据搬运、接口带宽、控制流调度和多个调用点之间的硬件复用。Cayman 补足了领域定制链条中的第三个层次：APS/Aquas 解决“如何接入”，ISAMORE 解决“定制什么”，Cayman 则强调“在何种微架构和接口约束下生成可复用加速器”。这使本章从指令扩展走向更一般的领域定制架构能力，为第三章讨论高质量硬件实现奠定了过渡基础。

== 本章小结

本章围绕第一章提出的第一个科学问题，讨论了应用需求如何通过架构接口转化为可复用的指令、微架构和加速器能力。APS 和 Aquas 从端到端工具链角度说明，领域定制能力必须同时具有硬件接口、合成实现、编译映射、系统评估和 PPA 反馈，才能从应用想法变成可迭代的 ASIP/ISAX 机制。ISAMORE 从可复用指令发现角度说明，自定义能力不能只来自局部热点，而应由程序语义、跨工作负载复用和硬件代价共同决定。Cayman 则把这一逻辑推进到 custom accelerator generation，强调 control flow、data access、processor-accelerator interface 和 accelerator merging 对领域定制能力选择的决定性作用。

这些工作共同表明，领域定制不是“发现热点并硬化”的线性过程，而是应用语义、架构接口、微架构约束、编译支持和硬件实现之间的协同过程。一个定制能力是否值得进入系统，取决于它能否跨应用复用、能否被编译器稳定识别、能否通过接口高效传输数据、能否在硬件中以合理面积和时序实现，并能否在真实 workload 中获得端到端收益。因此，本章既回答了“定制什么”和“如何接入”的问题，也自然引出下一章：当架构能力已经被识别并表达出来以后，如何把它们高质量地落到可综合、可验证、性能与资源可控的硬件实现中。

