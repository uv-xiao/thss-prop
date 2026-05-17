#import "@preview/cetz:0.3.4": canvas, draw

= 未来工作

== 未来工作总体目标

前文已有工作展示了三类研究基础。第二章说明，应用需求可以通过架构接口、定制指令、微架构机制和加速器候选选择进入领域定制体系；第三章说明，架构能力经过硬件前端、中间表示、调度、综合和验证约束后，才能成为质量可控的实现；第四章说明，大语言模型与智能体方法进入硬件设计和编译优化时，需要依附于形式化对象、编译基础设施和可执行检查，避免停留在自由文本生成。三类基础共同指向一个更完整的博士阶段研究目标，即构建面向智能体可靠工作的架构-硬件-编译器协同链路，并用这条链路支撑跨硬件架构的软硬件协同方法。

后续研究将集中在两个方向。第一，研究面向智能体的架构芯片协同生成，使应用意图、架构接口、硬件结构和编译支持能够在验证约束下共同演化。第二，研究智能体编译基础设施与工作流，使编译器成为人和智能体共同使用的事实、语义、变换和记录组织系统。前者主要从敏捷芯片设计侧回答如何把开放设计意图转化为可检查的架构与硬件产物，后者主要从创新性编译技术侧回答如何把目标事实、编译中间表示、语义契约和智能体行为组织成可复用基础设施。二者合在一起，构成未来博士阶段继续推进软硬件协同研究的主线。

#figure(
  kind: image,
  canvas(length: 1pt, {
    draw.rect((0, 0), (430, 210), stroke: rgb("#5c6f82") + 0.8pt, fill: white)

    draw.rect((15, 154), (115, 190), radius: 5, stroke: rgb("#5c8a68") + 0.8pt, fill: rgb("#edf7f1"))
    draw.content((65, 172), text(size: 7.2pt)[#box(width: 86pt)[#align(center)[领域应用\ 算法、数据、服务]]])
    draw.rect((135, 154), (235, 190), radius: 5, stroke: rgb("#7a4d4d") + 0.8pt, fill: rgb("#fff1f1"))
    draw.content((185, 172), text(size: 7.2pt)[#box(width: 86pt)[#align(center)[基础处理器\ RISC-V / ASIP]]])

    draw.rect((20, 98), (104, 132), radius: 5, stroke: rgb("#5c8a68") + 0.8pt, fill: rgb("#edf7f1"))
    draw.content((62, 115), text(size: 7.1pt)[#box(width: 72pt)[#align(center)[架构能力发现\ ISAMORE]]])
    draw.rect((122, 98), (206, 132), radius: 5, stroke: rgb("#5d74a8") + 0.8pt, fill: rgb("#eef3fb"))
    draw.content((164, 115), text(size: 7.1pt)[#box(width: 72pt)[#align(center)[编译支持\ 降低与调用]]])
    draw.rect((224, 98), (308, 132), radius: 5, stroke: rgb("#8460a8") + 0.8pt, fill: rgb("#f7f0fb"))
    draw.content((266, 115), text(size: 7.1pt)[#box(width: 72pt)[#align(center)[优化与检查\ APS / Aquas]]])
    draw.rect((122, 38), (206, 72), radius: 5, stroke: rgb("#5d74a8") + 0.8pt, fill: rgb("#eef3fb"))
    draw.content((164, 55), text(size: 7.1pt)[#box(width: 72pt)[#align(center)[软件产物\ 编译代码与库]]])
    draw.rect((224, 38), (308, 72), radius: 5, stroke: rgb("#b27a35") + 0.8pt, fill: rgb("#fff7e8"))
    draw.content((266, 55), text(size: 7.1pt)[#box(width: 72pt)[#align(center)[硬件产物\ 原型与实现]]])

    draw.rect((330, 152), (420, 190), radius: 5, stroke: rgb("#5d74a8") + 0.9pt, fill: rgb("#eef3fb"))
    draw.content((375, 171), text(size: 6.9pt)[#box(width: 76pt)[#align(center)[APS / ISAMORE\ 架构-硬件探索]]])
    draw.rect((330, 92), (420, 132), radius: 5, stroke: rgb("#b27a35") + 0.9pt, fill: rgb("#fff7e8"))
    draw.content((375, 112), text(size: 6.8pt)[#box(width: 76pt)[#align(center)[Spine\ 架构模型\ 生成路径与记录]]])
    draw.rect((330, 34), (420, 74), radius: 5, stroke: rgb("#8460a8") + 0.9pt, fill: rgb("#f7f0fb"))
    draw.content((375, 54), text(size: 6.8pt)[#box(width: 76pt)[#align(center)[IntelliC\ 面向目标的\ 编译基础设施]]])

    draw.line((65, 154), (65, 132), stroke: (paint: rgb("#5c8a68"), thickness: 1pt), mark: (end: "stealth"))
    draw.line((185, 154), (266, 132), stroke: (paint: rgb("#7a4d4d"), thickness: 1pt), mark: (end: "stealth"))
    draw.line((104, 115), (122, 115), stroke: (paint: rgb("#333333"), thickness: 1pt), mark: (end: "stealth"))
    draw.line((206, 115), (224, 115), stroke: (paint: rgb("#333333"), thickness: 1pt), mark: (end: "stealth"))
    draw.line((266, 98), (266, 72), stroke: (paint: rgb("#333333"), thickness: 1pt), mark: (end: "stealth"))
    draw.line((266, 86), (164, 86), stroke: (paint: rgb("#5d74a8"), thickness: 0.8pt))
    draw.line((164, 86), (164, 72), stroke: (paint: rgb("#5d74a8"), thickness: 0.8pt), mark: (end: "stealth"))
    draw.line((308, 115), (330, 115), stroke: (paint: rgb("#333333"), thickness: 1.2pt), mark: (end: "stealth"))
    draw.line((375, 152), (375, 132), stroke: (paint: rgb("#5d74a8"), thickness: 1.1pt), mark: (end: "stealth"))
    draw.line((375, 92), (375, 74), stroke: (paint: rgb("#b27a35"), thickness: 1.1pt), mark: (end: "stealth"))
    draw.line((206, 55), (224, 55), stroke: (paint: rgb("#777777"), thickness: 0.8pt), mark: (end: "stealth"))
  }),
  caption: [APS @aps2025、ISAMORE @isamore2026、Spine @spine2026 与 IntelliC @intellic2026 的关系。APS/Aquas @aps2025 @aquas2026 和 ISAMORE 已经形成从应用和基础处理器出发的架构-硬件探索基础；Spine 计划把这些探索组织为可检查的架构模型、硬件生成路径和记录；IntelliC 则面向 Spine 描述的目标提供编译基础设施与智能体工作流。],
)

== 面向智能体的架构芯片协同生成

=== 研究背景

架构芯片协同生成承接第二章的 APS/Aquas @aps2025 @aquas2026 和第四章的 OriGen @origen2024，同时也吸收第三章硬件实现质量约束的经验。APS/Aquas 说明，应用接口、架构描述、硬件生成和编译支持可以通过统一接口组织为端到端协同流程；OriGen 说明，大语言模型可以利用编译错误、语法检查和自反思机制修复寄存器传输级代码；Cement @cement2024、Clay @clay2025 和 SkyEgg @skyegg2026 进一步说明，硬件表达、综合机制、调度和映射质量需要在生成早期就成为可检查对象。后续研究要把这些经验推进到同一个面向智能体的架构芯片协同生成框架中。

Spine @spine2026 原型提供了直接基础。Spine 的长期目标是把开放设计意图、算法假设、架构约束、编译需求、生成微架构、寄存器传输级代码、可执行程序和验证材料组织为一条可追踪的方法链。当前实现虽然仍是早期基础，但已经具备类型化 Delta actor/task 设计对象、协程式 Delta 参照执行语义、轨迹流、可编程对齐检查、执行管线边界和 Delta 到寄存器传输级设计的严格验证路径。GCD 示例中的 `determinize_refine`、`generate_rtl`、`run_oracle`、`simulate_rtl` 和 `align_reports` 五个阶段，展示了一个小规模设计如何从 Delta 语义进入寄存器传输级实现，并通过参照执行与仿真结果对齐。

外部相关工作 Assassyn @assassyn2025 也说明了这一方向的重要性。该工作用异步事件处理统一架构仿真与硬件实现，使高层性能建模、周期精确仿真和寄存器传输级生成共享同一程序对象，减少架构模型与硬件实现分离造成的对齐成本。然而，这类统一抽象仍主要依赖设计者主动把架构行为写入受限编程模型，研究重点在仿真与实现的一致性，而不是让智能体在开放设计意图、架构接口、硬件生成、编译目标描述和检查记录之间进行受约束的长程协同。因此，它为未来工作提供了清晰参照：架构仿真与硬件实现统一只是基础，博士阶段更需要研究智能体如何在统一语义边界内提出候选、定位错误、修复设计，并把这些行动沉淀为可追踪的协同生成过程。

TAIDL @taidl2025 和 ACT @act2025 从另一个角度说明架构、芯片和软件工具需要共同生成。TAIDL 把张量加速器的状态、存储模型、指令参数、约束和指令语义组织为指令集架构定义，并从这些定义自动生成可扩展测试判定基准；ACT 在此基础上把张量加速器指令集架构描述进一步用于编译后端生成，通过参数化等价饱和指令选择和约束规划存储分配连接指令语义与代码生成。这一方向与本研究高度相关，因为它说明目标硬件能力必须被写成软件工具可消费的目标事实。不过，TAIDL 和 ACT 仍以手写指令集架构描述为前提，主要解决定义到测试判定基准和编译后端的自动生成问题；面向智能体的架构芯片协同生成还需要进一步处理开放设计意图如何形成这些定义，生成硬件、目标描述和检查记录如何相互约束，以及智能体如何在失败后定位并修复跨层不一致。

这一方向的研究对象是开放设计意图如何被重构为稳定语义边界，架构与硬件产物如何在该边界内分阶段生成，编译降低和目标执行如何在同一边界下接受检查。智能体在其中承担解释、拆解、生成、修复和优化工作，但其输入、输出和修改范围需要由类型化产物、可执行判定基准、仿真结果、等价性检查、综合结果和执行轨迹共同限定。这样可以把大语言模型能力放入可检查的架构芯片协同生成过程，而不是依赖一次性寄存器传输级代码生成。

=== 关键挑战

第一，开放设计意图很难直接成为硬件生成输入。自然语言需求、算法假设、存储规则、初始化条件、协议约束和性能目标常常混杂在一起，存在隐含前提和未说明边界。若智能体直接据此生成硬件结构，错误可能在架构层、微架构层和编译层之间传播，直到最终仿真或综合阶段才暴露。

第二，架构、硬件和编译职责边界容易模糊。一个候选设计既可能包含指令扩展和存储接口，也可能包含微架构仲裁、寄存器传输级状态机、编译降低约定和目标执行检查。若没有分阶段对象和责任边界，智能体可能在同一次修改中同时改变语义、硬件结构和编译假设，使后续检查难以定位责任。

第三，验证不能只放在最终产物之后。寄存器传输级仿真和综合结果当然重要，但当错误来自语义边界、降低计划、性能模型或接口约束时，最终验证只能说明结果不匹配，难以指出问题来自哪一层。架构芯片协同生成需要在每个阶段产生可比较的执行轨迹、语义记录和检查结果，使错误能够在进入大规模生成前被发现。

第四，当前 Spine @spine2026 基础仍然小规模。Delta 设计语义、参照执行、轨迹对齐检查和 GCD 验证路径已经证明可行性，但距离完整的架构-硬件-编译协同生成仍有距离。后续需要从单个 GCD 示例扩展到更丰富的并发结构、存储层次、处理器-加速器接口、定制指令、微架构资源约束和编译目标描述。

第五，已有统一仿真与实现抽象尚未充分处理智能体协同问题。Assassyn @assassyn2025 通过同一程序对象保持架构仿真和寄存器传输级实现的一致性，但它没有把开放设计意图的澄清、候选微架构的提出、错误诊断、跨层修复和经验沉淀作为核心研究对象。面向智能体的架构芯片协同生成需要在这一基础上进一步定义哪些对象可以被智能体修改，哪些检查决定修改是否成立，哪些失败记录可以转化为下一轮生成约束。

=== 研究方法

后续研究计划从统一语义边界开始，把人的应用意图、算法结构、架构假设、存储和通信规则、初始化条件、接口协议以及性能约束重构为可解析、可执行、可检查的中间对象。这个语义边界既面向智能体，也面向工具链。智能体可以在其中补全缺失细节、提出候选拆解和修复建议；工具链则通过类型检查、语义执行、参照运行和轨迹对齐检查该边界是否一致。

在硬件侧，研究将采用分阶段生成路径。第一阶段从语义边界中抽取架构接口和执行模型，确定任务、状态、通信、存储和资源对象；第二阶段生成微架构候选，包括流水结构、仲裁逻辑、状态机、存储组织、互连拓扑和定制指令支持；第三阶段生成寄存器传输级设计和综合约束，并把仿真、时序、资源和接口检查结果回写到统一记录中。智能体可以参与候选生成和修复，但每一步都要产生显式产物和检查记录。

在编译侧，研究将同步生成目标描述和降低约定。架构接口需要被编译器理解为目标事实，包括可用操作、数据布局、存储层次、访存约束、同步语义和应用二进制接口。编译降低计划需要说明程序语义如何映射到这些目标事实，哪些变换保持语义，哪些检查由参照执行、解释器、仿真或后端执行承担。这样，硬件生成不再只是产出孤立电路，而是同时产出编译可见的目标约束。

在验证侧，研究将以可执行判定基准和跨层对齐检查为核心。Spine @spine2026 已有的参照执行、轨迹流、执行报告、对齐报告和 GCD 到寄存器传输级设计的验证路径可以扩展为通用检查机制。每个案例同时运行语义参照执行、生成硬件仿真、编译产物执行和性能模型，并把结果、性能提交事件、用户标注事件和失败记录写成可比较轨迹。若出现不一致，对齐报告应能够指出是语义边界、硬件实现、编译降低、性能模型还是目标接口发生偏离。

#figure(
  kind: image,
  canvas(length: 1pt, {
    draw.rect((0, 0), (430, 164), stroke: rgb("#5c8a68") + 0.8pt, fill: white)

    draw.rect((14, 100), (102, 140), radius: 5, stroke: rgb("#5c8a68") + 0.8pt, fill: rgb("#edf7f1"))
    draw.content((58, 120), text(size: 7.0pt)[#box(width: 76pt)[#align(center)[开放设计意图\ 算法、约束、协议]]])
    draw.rect((124, 100), (212, 140), radius: 5, stroke: rgb("#5d74a8") + 0.8pt, fill: rgb("#eef3fb"))
    draw.content((168, 120), text(size: 7.0pt)[#box(width: 76pt)[#align(center)[统一语义边界\ Delta 与参照执行]]])
    draw.rect((234, 100), (322, 140), radius: 5, stroke: rgb("#b27a35") + 0.8pt, fill: rgb("#fff7e8"))
    draw.content((278, 120), text(size: 7.0pt)[#box(width: 76pt)[#align(center)[分阶段生成\ 微架构、RTL\ 目标描述]]])
    draw.rect((344, 100), (424, 140), radius: 5, stroke: rgb("#8460a8") + 0.8pt, fill: rgb("#f7f0fb"))
    draw.content((384, 120), text(size: 7.0pt)[#box(width: 68pt)[#align(center)[跨层检查\ 参照执行\ 仿真与对齐]]])

    draw.rect((72, 30), (264, 70), radius: 5, stroke: rgb("#777777") + 0.8pt, fill: rgb("#f4f4f4"))
    draw.content((168, 50), text(size: 7.2pt)[#box(width: 168pt)[#align(center)[智能体提出候选、诊断与修复\ 受类型化产物和检查记录约束]]])

    draw.line((102, 120), (124, 120), stroke: (paint: rgb("#333333"), thickness: 1.1pt), mark: (end: "stealth"))
    draw.line((212, 120), (234, 120), stroke: (paint: rgb("#333333"), thickness: 1.1pt), mark: (end: "stealth"))
    draw.line((322, 120), (344, 120), stroke: (paint: rgb("#333333"), thickness: 1.1pt), mark: (end: "stealth"))

    draw.line((168, 100), (168, 70), stroke: (paint: rgb("#777777"), thickness: 0.9pt), mark: (end: "stealth"))
    draw.line((264, 54), (278, 54), stroke: (paint: rgb("#777777"), thickness: 0.9pt))
    draw.line((278, 54), (278, 100), stroke: (paint: rgb("#777777"), thickness: 0.9pt), mark: (end: "stealth"))
    draw.line((384, 100), (384, 84), stroke: (paint: rgb("#8460a8"), thickness: 0.9pt))
    draw.line((384, 84), (410, 84), stroke: (paint: rgb("#8460a8"), thickness: 0.9pt))
    draw.line((410, 84), (410, 18), stroke: (paint: rgb("#8460a8"), thickness: 0.9pt))
    draw.line((410, 18), (220, 18), stroke: (paint: rgb("#8460a8"), thickness: 0.9pt))
    draw.line((220, 18), (220, 30), stroke: (paint: rgb("#8460a8"), thickness: 0.9pt), mark: (end: "stealth"))
  }),
  caption: [面向智能体的架构芯片协同生成示意图。智能体参与开放意图重构、分阶段生成和修复，但每个阶段都需要通过语义边界、可执行判定基准和跨层检查限定其行动。],
)

=== 预期结果

预期形成一套面向智能体的架构芯片协同生成方法。该方法应能够把开放应用意图转化为统一语义边界，把语义边界分解为架构接口、微架构结构、寄存器传输级实现和编译目标描述，并在每一层生成可检查记录。其创新点不在于单次生成更长的硬件代码，而在于把智能体生成放入分阶段、可追踪、可复现的协同生成机制中。

预期系统产物包括扩展后的 Spine @spine2026 原型、若干非平凡设计案例、可执行判定基准、跨层对齐报告、仿真与综合检查记录，以及面向编译器的目标描述产物。评价将关注语义一致性、错误定位能力、生成过程可复现性、硬件实现质量、编译目标描述完整性和智能体修复有效性。若该方向取得预期结果，敏捷芯片设计将获得一条由语义边界、分阶段硬件生成、编译目标描述和跨层验证共同支撑的研究路线。

== 智能体编译基础设施与工作流

=== 研究背景

第二项未来工作面向智能体编译基础设施与工作流。第一章已经指出，编译接口是衔接软硬件领域的重要接口；第二、三、四章进一步说明，无论是 APS/Aquas @aps2025 @aquas2026 的端到端处理器生成、ISAMORE @isamore2026 的分阶段等价饱和与定制指令复用、SkyEgg @skyegg2026 的等价图高层综合优化，还是 EggMind @eggmind2026 的 EqSatL 策略合成，真正困难的部分都在于如何让目标事实、中间表示表达、语义约束、变换过程、后端产物和评价记录保持一致。大语言模型和智能体方法进入这一过程后，编译基础设施必须成为智能体能力提升的结构化媒介，不能退化为可运行脚本集合。

前期编译基础设施材料和种子页给出了这一方向的核心论证。面向新硬件目标的编译器需要同时接受两类输入，一类是程序员希望使用的编程界面，另一类是目标架构、存储层次、指令语义、布局约束、通信拓扑和执行边界等目标事实。二者之间缺少的中间层并非单个后端文件，而是一套由中间表示、编译遍、求解器、检查、检查记录和后端产物构成的编译基础设施。XLA、Arknife、TAIDL @taidl2025、ACT @act2025 和空间映射编译器等材料说明，目标事实可以以分层中间表示、架构/布局抽象、指令集定义、自动测试判定基准、指令集驱动后端生成和空间时间映射搜索等不同方式进入编译器。智能体适合参与这些结构化对象的构造和演化，但不适合在缺少语义和目标契约的情况下自由生成编译器。

自动算子和计算内核生成工作为这一判断提供了边界清晰的背景。AccelOpt @accelopt2026 面向 AWS Trainium 加速器计算内核，通过大语言模型智能体、优化经验记录和慢-快内核对比不断改进内核实现；Autocomp @autocomp2025 面向张量加速器代码优化，把优化过程组织为规划和代码生成两阶段提示，并把领域知识、正确性结果和硬件性能指标纳入搜索。这些工作证明智能体可以围绕具体算子或计算内核形成有效搜索，但其产物主要是内核代码、优化计划或调度策略，不是完整编译器。博士阶段的智能体编译基础设施需要在此基础上进一步研究目标事实、中间表示、语义契约、编译行为和后端产物如何被组织成可长期演化的编译系统。

这里的工作流具有独立研究意义。一个面向新目标的编译器建设过程，需要依次完成目标事实整理、理想编程界面归约、中间表示与语义契约设计、编译行为生成、检查门执行、后端产物形成和经验记录沉淀。智能体协作框架（agent harness）的作用，是把这些步骤组织为可追踪、可回放、可审阅的长程过程，使智能体每次行动都有明确输入、作用对象、检查方式和记录位置。这样，编译基础设施既是智能体使用的工具集合，也是限定智能体行动、承载经验积累并支持后续演化的工作流介质。

IntelliC @intellic2026 为这一方向提供了实现基础。其核心结构为 $"Lang" := "Surface" | "IR"$、$"Surface" := "IR" + "Construction API"$、$"IR" := S_y + S_e$。其中 $S_y$ 表示语法、结构、身份、验证、规范文本和解析，$S_e$ 表示由语义定义、语义层级键和 TraceDB 承载的语义事实。编译工作统一为 CompilerAction，分为 Fixed 和 AgentAct；AgentEvolve 作为独立工作流生成、验证并注册新的 Fixed action。这个设计使智能体能够围绕编译器原生对象行动，避免直接修改不可控的后端代码或长篇自然语言说明。

#figure(
  kind: image,
  canvas(length: 1pt, {
    draw.rect((0, 0), (430, 210), stroke: rgb("#5d74a8") + 0.8pt, fill: white)

    draw.rect((14, 160), (104, 196), radius: 5, stroke: rgb("#c05a2b") + 0.8pt, fill: rgb("#fff3ee"))
    draw.content((59, 178), text(size: 7.0pt)[#box(width: 78pt)[#align(center)[语义歧义\ 含义不清]]])
    draw.rect((118, 160), (208, 196), radius: 5, stroke: rgb("#c05a2b") + 0.8pt, fill: rgb("#fff3ee"))
    draw.content((163, 178), text(size: 7.0pt)[#box(width: 78pt)[#align(center)[后端契约\ 隐含分散]]])
    draw.rect((222, 160), (312, 196), radius: 5, stroke: rgb("#c05a2b") + 0.8pt, fill: rgb("#fff3ee"))
    draw.content((267, 178), text(size: 7.0pt)[#box(width: 78pt)[#align(center)[编译遍组合\ 顺序难定]]])
    draw.rect((326, 160), (416, 196), radius: 5, stroke: rgb("#c05a2b") + 0.8pt, fill: rgb("#fff3ee"))
    draw.content((371, 178), text(size: 7.0pt)[#box(width: 78pt)[#align(center)[长期维护\ 经验难复用]]])

    draw.rect((92, 92), (338, 126), radius: 6, stroke: rgb("#8460a8") + 1pt, fill: rgb("#f7f0fb"))
    draw.content((215, 110), text(size: 9.5pt, fill: rgb("#4b2a83"))[#strong[IntelliC-agent]])
    draw.content((215, 98), text(size: 6.8pt)[#box(width: 210pt)[#align(center)[运行在 IntelliC 之上的模型与编译器专用智能体协作框架]]])

    draw.rect((22, 14), (408, 66), radius: 6, stroke: rgb("#5d74a8") + 1pt, fill: rgb("#eef3fb"))
    draw.content((215, 57), text(size: 8pt, fill: rgb("#1f4f9a"))[#strong[IntelliC 编译基础设施]])
    draw.rect((38, 20), (146, 48), radius: 4, stroke: rgb("#5d74a8") + 0.7pt, fill: white)
    draw.content((92, 34), text(size: 6.4pt)[#box(width: 94pt)[#align(center)[$"IR" := S_y + S_e$\ 语法与语义事实]]])
    draw.rect((161, 20), (269, 48), radius: 4, stroke: rgb("#5d74a8") + 0.7pt, fill: white)
    draw.content((215, 34), text(size: 6.4pt)[#box(width: 94pt)[#align(center)[Fixed / AgentAct\ AgentEvolve]]])
    draw.rect((284, 20), (392, 48), radius: 4, stroke: rgb("#5d74a8") + 0.7pt, fill: white)
    draw.content((338, 34), text(size: 6.4pt)[#box(width: 94pt)[#align(center)[记录组织\ TraceDB 与检查结果]]])

    draw.line((59, 160), (168, 126), stroke: (paint: rgb("#c05a2b"), thickness: 0.8pt), mark: (end: "stealth"))
    draw.line((163, 160), (194, 126), stroke: (paint: rgb("#c05a2b"), thickness: 0.8pt), mark: (end: "stealth"))
    draw.line((267, 160), (236, 126), stroke: (paint: rgb("#c05a2b"), thickness: 0.8pt), mark: (end: "stealth"))
    draw.line((371, 160), (262, 126), stroke: (paint: rgb("#c05a2b"), thickness: 0.8pt), mark: (end: "stealth"))
    draw.line((215, 92), (215, 66), stroke: (paint: rgb("#8460a8"), thickness: 1.1pt), mark: (end: "stealth"))
  }),
  caption: [IntelliC-agent 与 IntelliC @intellic2026 的关系。IntelliC-agent 运行在 IntelliC 提供的中间表示、语义事实、编译行为和 TraceDB 之上，负责组织模型行动，使语义歧义、后端契约、编译遍组合和长期维护问题进入可检查的编译基础设施。],
)

=== 关键挑战

第一，目标事实分散且难以形式化。现代硬件目标包含并行层级、存储层级、布局规则、指令语义、通信与同步约束、系统应用二进制接口和性能剖析能力。这些事实往往分布在硬件手册、后端代码、测试、调试脚本和专家经验中。智能体若不能读取稳定的目标事实对象，就容易把目标约束误写进临时代码或提示词上下文。

第二，编译中间表示的语法和语义需要同时显式化。传统编译器经常把语义隐藏在编译遍实现、临时分析结果或后端约定中。人类专家可以通过经验理解这些隐含关系，智能体却需要可查询、可解释、可执行和可回放的语义事实。仅有语法树或文本中间表示不足以判断一次重写是否保持语义，也不足以说明后端证据来自哪里。

第三，智能体行为需要明确边界。一个智能体可能适合提出诊断、候选重写、局部编译遍、目标事实抽取或策略改进，但这些行为必须通过作用域、输入事实、输出记录、检查门和变更应用机制进行限制。若允许智能体直接修改编译器内部状态，局部可运行的改动可能破坏后续编译遍、目标约束或多后端一致性。

第四，编译基础设施需要支持长期演化。EggMind @eggmind2026 表明，智能体生成的优化策略应当成为可检查、可复用的策略产物；更一般的编译基础设施还需要支持 AgentEvolve 式行为，即智能体通过候选生成、测试、语义检查和人工审阅，把某些可复用流程组件固化为 Fixed action。这样才能把一次性智能体建议转化为可维护的编译能力。

第五，工作流本身需要成为可验证对象。智能体参与编译器建设时，失败往往不只来自某个候选重写规则或某段后端代码，也可能来自目标事实不完整、任务拆解不合理、检查门设置过晚、经验记录无法复用，或人工审阅没有进入后续迭代。若工作流只停留在提示词、脚本和临时日志层面，系统很难判断哪一步产生了错误，也难以把一次成功经验迁移到新的硬件目标。智能体编译基础设施因此需要把任务分解、上下文选择、行动审批、检查执行、失败归因和规则固化都纳入统一记录。

=== 研究方法

后续研究将以 IntelliC @intellic2026 为基础，构建面向智能体的编译基础设施和工作流。工作流首先从目标事实和编程界面进入。目标事实包括架构层级、存储层次、指令语义、布局约束、通信拓扑和执行边界；编程界面包括张量程序、领域语言、接口约定和用户希望保留的程序抽象。二者进入智能体协作框架后，先被转化为可查询事实、约束和任务分解，再进入中间表示、编译行为、检查门和后端产物生成过程。

第一层是 $S_y$，负责操作、区域、块、值、类型、属性、方言、结构验证、规范文本和解析。该层借鉴 MLIR/xDSL 的结构模型，但保持 IntelliC @intellic2026 原生实现，使人和智能体能够通过 Python 构造接口、builder、decorator 和 region helper 构造中间表示，同时通过规范文本和 parser 获得可交换、可回放的表示。

第二层是 $S_e$，负责把语义作为中间表示的一部分，而不是作为编译遍内部的隐含状态。一个操作可以拥有多个 SemanticDef，例如具体值语义、抽象范围语义、符号语义和后端证据语义。TraceDB 用事件和事实两类记录承载语义执行、抽象解释、诊断、义务、后端证据和智能体说明。这样，编译器能够回答一个操作是什么意思、一次重写依赖哪些事实、一个后端行为由谁承担，以及某个检查结果来自哪条记录。

第三层是统一的编译行为模型。Fixed action 承担传统编译器行为，包括分析、重写、语义执行、编译遍、检查门和后端交接；AgentAct 允许智能体在限定作用域内通过类型化接口查询事实、提出诊断、生成候选变换或写入审阅记录；AgentEvolve 则把智能体产生的候选流程转化为经过验证的 Fixed action。所有 action 的 match 和 apply 过程都需要写入 TraceDB，语法修改不能直接发生，而应先记录 mutation intent，再由 MutatorStage 通过受控语法变更接口应用，并由 PendingRecordGate 检查未处理记录。

第四层是目标事实到后端产物的工作流。前期材料表明，编译基础设施需要把目标架构、存储层次、指令语义、布局约束、通信拓扑和执行边界转化为可查询事实，再在中间表示、编译遍、求解器和检查门之间流动。目标事实和理想编程界面共同进入编译器中间层，最终产出后端代码、调度计划、配置文件、测试脚本和检查记录。智能体在其中可以参与目标事实整理、编译遍候选生成、错误诊断和经验提炼，但每个结果都必须有语义检查、执行检查或人工审阅记录。

第五层是智能体协作框架自身。该框架需要规定一次智能体任务如何开始、如何选择上下文、如何限定可操作对象、如何提出候选行动、如何调用检查门、如何接受人工审阅，以及如何把成功路径固化为新的 Fixed action。具体而言，目标事实摄取阶段形成架构和执行边界的事实库；设计阶段生成中间表示、语义定义和编译行为候选；执行阶段通过受控变更接口运行候选；检查阶段运行语义、测试、性能剖析和后端产物检查；沉淀阶段把诊断、失败原因、修复过程和可复用行为写入 TraceDB 或规则库。这个过程使智能体不再只是在一次对话中修改代码，而是在编译基础设施规定的对象、边界和检查序列中工作。

#figure(
  kind: image,
  canvas(length: 1pt, {
    draw.rect((0, 0), (430, 202), stroke: rgb("#5d74a8") + 0.8pt, fill: white)

    draw.rect((16, 132), (112, 176), radius: 5, stroke: rgb("#5c8a68") + 0.8pt, fill: rgb("#edf7f1"))
    draw.content((64, 154), text(size: 6.8pt)[#box(width: 82pt)[#align(center)[编程界面\ 张量程序、领域语言\ 接口约定]]])

    draw.rect((16, 38), (112, 82), radius: 5, stroke: rgb("#b27a35") + 0.8pt, fill: rgb("#fff7e8"))
    draw.content((64, 60), text(size: 6.8pt)[#box(width: 82pt)[#align(center)[目标事实\ 架构、存储、布局\ 指令语义]]])

    draw.rect((144, 132), (252, 176), radius: 5, stroke: rgb("#5d74a8") + 0.8pt, fill: rgb("#eef3fb"))
    draw.content((198, 154), text(size: 6.8pt)[#box(width: 94pt)[#align(center)[$"IR" := S_y + S_e$\ 语法、语义\ TraceDB]]])

    draw.rect((144, 38), (252, 82), radius: 5, stroke: rgb("#777777") + 0.8pt, fill: rgb("#f4f4f4"))
    draw.content((198, 60), text(size: 6.8pt)[#box(width: 94pt)[#align(center)[检查门\ 语义执行、测试\ 性能剖析]]])

    draw.rect((286, 132), (412, 176), radius: 5, stroke: rgb("#b27a35") + 0.8pt, fill: rgb("#fff7e8"))
    draw.content((349, 154), text(size: 6.8pt)[#box(width: 108pt)[#align(center)[编译行为\ Fixed / AgentAct\ AgentEvolve]]])

    draw.rect((286, 38), (412, 82), radius: 5, stroke: rgb("#8460a8") + 0.8pt, fill: rgb("#f7f0fb"))
    draw.content((349, 60), text(size: 6.8pt)[#box(width: 108pt)[#align(center)[后端产物\ 代码、调度、配置\ 检查记录]]])

    draw.line((112, 154), (144, 154), stroke: (paint: rgb("#333333"), thickness: 1.1pt), mark: (end: "stealth"))
    draw.line((112, 60), (144, 60), stroke: (paint: rgb("#333333"), thickness: 1.1pt), mark: (end: "stealth"))
    draw.line((252, 154), (286, 154), stroke: (paint: rgb("#333333"), thickness: 1.1pt), mark: (end: "stealth"))
    draw.line((349, 132), (349, 82), stroke: (paint: rgb("#333333"), thickness: 1.1pt), mark: (end: "stealth"))
    draw.line((252, 60), (286, 60), stroke: (paint: rgb("#333333"), thickness: 1.1pt), mark: (end: "stealth"))
    draw.line((198, 132), (198, 82), stroke: (paint: rgb("#5d74a8"), thickness: 1pt), mark: (end: "stealth"))
    draw.line((198, 82), (198, 132), stroke: (paint: rgb("#777777"), thickness: 0.8pt), mark: (end: "stealth"))
    draw.line((349, 38), (349, 20), stroke: (paint: rgb("#8460a8"), thickness: 0.8pt))
    draw.line((349, 20), (198, 20), stroke: (paint: rgb("#8460a8"), thickness: 0.8pt))
    draw.line((198, 20), (198, 38), stroke: (paint: rgb("#8460a8"), thickness: 0.8pt), mark: (end: "stealth"))
    draw.content((274, 12), text(size: 6.6pt, fill: rgb("#8460a8"))[产物记录进入下一轮事实与行为演化])
  }),
  caption: [智能体编译基础设施与工作流示意图。目标事实和编程界面进入由语法、语义和 TraceDB 共同构成的中间表示，编译行为分为确定性行为、智能体受限行为和智能体演化行为，后端产物必须带有语义、测试和性能检查记录。],
)

=== 预期结果

预期形成一套面向人和智能体共同使用的编译基础设施与工作流。该基础设施应支持规范中间表示构造、结构验证、语义定义、TraceDB 记录、固定编译行为、智能体受限行为、智能体演化行为、受控语法变更和检查门；该工作流应支持目标事实摄取、任务分解、上下文选择、候选行动、检查执行、人工审阅和经验沉淀。其核心贡献在于把智能体能力放入编译器原生对象和可追踪工作流之中，使模型行动能够被作用域、语义、目标事实、检查记录和审阅机制共同约束。

预期系统产物包括 IntelliC @intellic2026 的可执行编译基础设施原型、覆盖控制流和循环语义的示例程序、若干 Fixed action 和 AgentAct 样例、AgentEvolve 生成可复用 Fixed action 的实验路径，以及面向目标事实、后端产物和智能体任务过程的检查记录。评价将关注中间表示可读性、语义执行正确性、action 记录完整性、智能体行为边界、工作流可追踪性、生成行为固化能力、后端产物可检查性和跨案例复用能力。

从博士论文整体目标看，第一项未来工作提供架构与硬件侧的受约束生成对象，第二项未来工作提供编译侧的结构化行动和记录基础。二者共同服务于敏捷芯片设计与创新性编译技术驱动的软硬件协同，使智能体能力提升建立在语义边界、编译基础设施和验证约束体系之上。
