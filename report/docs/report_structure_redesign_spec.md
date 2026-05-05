# 开题报告整体结构重构 Spec

## 目的

本文件定义下一轮报告重构的目标结构。后续实施应先围绕本 spec 讨论和确认，再重写 `report/main.typ`，不要在当前草稿上继续局部增量修补。

参考对象：`resources/博士开题报告-陈仁泽.pdf`。学习其章节组织、引言的综述式铺陈、已有工作分章展开、未来工作单章规划和结论收束方式；不复制其措辞。

## 顶层主题

报告主题保持为：

> 敏捷芯片设计与创新性编译技术驱动的软硬件协同

主题解释：

- “敏捷芯片设计”强调面向领域需求快速形成、验证和迭代硬件能力。
- “创新性编译技术”不是辅助工具，而是连接应用需求、硬件结构、综合优化、验证证据和运行时系统的中枢。
- “软硬件协同”不是泛泛地同时设计软件和硬件，而是围绕应用模式发现、硬件能力生成、编译映射、综合优化、证据闭环和运行时反馈构建系统方法。

## 与当前草稿的关键差异

当前草稿的问题：

- 引言仍偏“研究背景 + 研究目标”的概括写法，没有形成类似范文第一章的综述式总分结构。
- 国内外现状与挑战虽然已扩写，但应被吸收到第一章引言中，作为总论证的一部分，而不是单独作为一个短章。
- 技术部分仍以“已有研究基础”统摄多个方向，无法给代表性工作足够章节空间。
- EggMind 当前被放在未来工作中，但它应作为现有工作的一部分呈现。
- 未来工作需要单独成章，围绕尚未完成的 IntelliC、Spine、PTO Runtime distributed features 等展开，而不是混入已有工作叙述。

重构后的原则：

- 第一章是完整综述式引言，承担背景、趋势、研究归类、问题挑战、研究目标和章节安排。
- 技术部分按现有工作的几个层次分别成章，每章形成“问题-现状-方法-系统-评估-小结”的闭环。
- EggMind 放入现有工作章节，作为 e-graph 策略自动化和 agentic 编译优化积累。
- 最后一个主要技术章介绍未来工作，采用“研究背景与问题分析、框架设计思路、关键技术实现、预期技术特征、验证与应用规划”的范文式结构。

## 建议全文结构

### 摘要

摘要需要在较短篇幅内完成四件事：

1. 说明算力需求、领域定制和芯片设计生产力的矛盾。
2. 提出“敏捷芯片设计与创新性编译技术驱动的软硬件协同”主题。
3. 概括已有工作三大层次。
4. 概括未来工作目标与预期贡献。

摘要不要写成论文成果列表。每个成果只在说明主线时出现。

### 第一章 引言

第一章应是综述形式的总分结构，篇幅应显著超过当前草稿的引言。它需要像范文一样，从技术背景逐层收束到研究问题。

建议章节：

#### 1.1 算力需求演进与领域定制趋势

功能：

- 建立产业和技术背景。
- 说明 AI 推理、后量子密码、信号处理、点云处理、图形渲染等应用如何带来多样计算和访存模式。
- 说明先进工艺收益放缓、通用处理器能效限制和应用迭代速度共同推动领域定制。

写作要求：

- 不要只说“算力紧缺很重要”。
- 要解释“需求增长”和“设计生产力不足”是共同瓶颈。
- 可引用 APS/Aquas/ISAMORE/SkyEgg 等 introduction 中对应用领域的描述。

#### 1.2 敏捷芯片设计的技术路线

功能：

- 综述敏捷芯片设计的主要技术路线。
- 包括 ASIP/ISAX、RISC-V 扩展接口、FPGA/可重构加速器、HLS/硬件前端、AI 辅助硬件设计。

写作要求：

- 每类路线都要说明其价值和局限。
- 这里是综述，不介绍个人工作细节。
- 结尾需要指出：硬件创新若缺少软件、编译和验证连接，难以形成可复用系统能力。

#### 1.3 创新性编译技术在软硬件协同中的中枢作用

功能：

- 明确编译技术在报告主题中的地位。
- 从编译映射、程序等价空间、硬件综合 IR、e-graph、验证证据、运行时反馈几个角度解释“编译中枢”。

写作要求：

- 不能把编译写成后端工具。
- 要突出编译技术承担三类职责：
  - 发现：从应用中发现值得硬化或优化的模式；
  - 连接：把应用语义、硬件接口、综合实现和运行时约束连接起来；
  - 证明：产生可审计、可验证、可复现的证据。

#### 1.4 国内外研究现状归类

功能：

对相关研究做分类综述，为后文三个现有工作章建立评价坐标。

建议分为：

1. ASIP/ISAX 与端到端协同框架；
2. 自定义指令识别、复用与微架构定制；
3. 硬件前端、HLS、硬件 IR 与综合优化；
4. e-graph、EqSat 策略与编译优化自动化；
5. AI 辅助 RTL/硬件设计与 agentic 方法；
6. 异构运行时与编译-运行时协同。

写作要求：

- 这部分应系统整理 `resources/` 内各论文的 related work，不凭泛泛记忆写。
- 每一类都要有“已有路线 -> 成熟点 -> 未解决问题”的结构。
- 不要把个人工作提前作为解决方案展开，只可在小结中引出“本人已有工作围绕这些问题展开”。

#### 1.5 核心问题与挑战概括

功能：

把 1.1-1.4 的综述收束为本报告研究问题。

建议概括为三组挑战：

1. 领域定制能力如何从单点接口和单程序热点走向跨接口、跨应用、跨工具链复用；
2. 硬件前端与综合优化如何兼顾表达能力、确定性、性能和资源质量；
3. agentic 编译/硬件生成与运行时系统如何建立可解释、可验证、可复用的证据闭环。

写作要求：

- 挑战要具体，避免“研究 X 方法”式空话。
- 每个挑战需要指向后续一个技术章或未来工作章。

#### 1.6 已有研究基础与拟开展工作概览

功能：

- 用一到两页把后文结构串起来。
- 明确现有工作与未来工作边界。

现有工作三章：

1. 领域定制与端到端协同；
2. 硬件前端与综合优化；
3. 大模型与形式化技术驱动的软硬件协同方法。

未来工作一章：

1. IntelliC；
2. Spine；
3. PTO Runtime distributed features；
4. 三者之间的协同验证与里程碑。

注意：

- EggMind 在这里列为现有工作，不列为未来工作。
- IntelliC 和 Spine 若已有 repo 基础，可以说“已有基础”，但主体定位仍是未来研究计划。

#### 1.7 报告结构安排

功能：

仿照范文，逐章说明后文安排。

要求：

- 每章说明“解决什么问题”，不只列章节名。
- 应体现各章之间的递进关系。

### 第二章 领域定制与端到端软硬件协同

本章对应现有工作第一层。它不是 APS/Aquas/ISAMORE 的论文列表，而是回答：领域定制能力如何被发现、生成、映射并复用。

建议章节：

#### 2.1 引言

- 从第一章挑战 1 引出本章。
- 说明本章覆盖 APS、Aquas、ISAMORE，并概括 Cayman/Clay。
- 明确 APS/Aquas 先建立端到端协同框架，ISAMORE 详细展开可复用指令发现。
- 篇幅约束：ISAMORE 不得少于 APS/Aquas 合计篇幅。

#### 2.2 ASIP/ISAX 端到端协同框架：APS 与 Aquas

内部结构：

1. 问题背景：接口分裂、ISAX-specific synthesis、compiler support。
2. APS 方法：统一接口、CADL/synthesis flow、compiler support、bitwidth-aware vectorization。
3. Aquas 动机：复杂数据密集 ISAX、memory-interface attributes、cache effects、robust compiler mapping。
4. Aquas 方法：MLIR/Aquas-IR、多层 IR、e-graph/skeleton-components matching、硬件侧访存机制选择。
5. 评估与意义：案例、speedup、area、跨平台/跨应用复用。
6. 小结：APS/Aquas 回答“如何把定制能力端到端接入工具链”。

#### 2.3 可复用自定义指令识别：ISAMORE

内部结构：

1. 问题背景：自定义指令面积昂贵，必须跨程序和跨工作负载复用。
2. 现有方法局限：热点枚举、convex subgraph、syntactic merging、DLP 忽视。
3. 机制意义：可复用自定义指令是连接应用模式与硬件能力的关键机制。
4. 方法创新：e-graph anti-unification、semantic equivalence、least general generalization。
5. 系统挑战与解决：structured DSL、phase-oriented process、smart AU、pattern sampling、hardware-aware cost model、multi-objective selection、pattern vectorization。
6. 评估与意义：benchmark、开源库、RoCC 案例、PQC/LLM、speedup、area saving。
7. 小结：ISAMORE 回答“定制什么”和“如何自动发现可复用硬件能力”。

#### 2.4 微架构感知定制补充：Cayman 与 Clay

- 概括即可，说明它们如何补充控制流、数据访问和微架构约束。
- 需要补资源和引用后再正式写。

#### 2.5 本章小结

- 回到第一章挑战 1。
- 说明本章如何支撑后续硬件前端与综合优化章。

### 第三章 硬件前端与综合优化

本章对应现有工作第二层。它回答：有了领域定制目标后，如何高效、可预测、高质量地生成硬件。

建议章节：

#### 3.1 引言

- 从硬件实现生产力瓶颈引入。
- 说明本章覆盖 Cement、SkyEgg、HECTOR。

#### 3.2 周期确定型硬件前端：Cement

内部结构：

1. HDL/HLS/DSL/IR 现状与局限；
2. Cement 动机：生产率、周期确定性、微架构表达；
3. CmtHDL：event layer、control sub-language；
4. CmtC：timing analysis、FSM synthesis；
5. 实现与评估：PolyBench、systolic array、sparse accelerator；
6. 意义：提高敏捷硬件设计的前端表达和可预测性。

#### 3.3 变换、映射与调度联合优化：SkyEgg

内部结构：

1. HLS 顺序流程局限：algebraic transformation、mapping、scheduling 割裂；
2. e-graph 统一设计空间；
3. mapping candidates as rewrite rules；
4. ILP extraction as scheduling；
5. ASAP heuristic；
6. 评估与意义。

#### 3.4 综合基础设施：HECTOR

- HECTOR：MLIR 多层 IR、高层综合基础设施和工具链支撑。
- 注意：OriGen 移入第四章，作为“大模型与形式化技术驱动的软硬件协同方法”的已有工作之一，不在第三章重复展开。

#### 3.5 本章小结

- 回到第一章挑战 2。
- 说明本章如何支撑后续 e-graph 策略与 agentic 方法。

### 第四章 大模型与形式化技术驱动的软硬件协同方法

本章对应现有工作第三层。重构后 EggMind 放在这里，作为现有工作，不再放在未来工作。

本章标题已确认采用“大模型与形式化技术驱动的软硬件协同方法”。

本章主题不强调开源生态、专利或产学研协同。这些内容不作为报告主体。本章应突出大模型与形式化技术结合后，对软硬件协同方法体系和工具链能力的作用：大模型提供生成、搜索和策略迁移能力，形式化技术提供语义边界、等价证明、可验证反馈和可控优化空间。

建议章节：

#### 4.1 引言

- 说明前两章解决了领域定制和硬件生成，但复杂优化、硬件生成和协同设计仍需要更强的自动化能力。
- 引出核心矛盾：大模型具有生成与搜索潜力，但如果缺少形式化语义、等价约束、可验证反馈和 tractability control，容易停留在不可控的启发式生成。
- 引出 EggMind 与 OriGen：二者分别从形式化优化策略和大模型辅助硬件生成侧展示已有基础。

#### 4.2 E-graph 策略自动化：EggMind

内部结构：

1. 背景：EqSat 能表达巨大等价空间，但 rewrite space 和 e-graph growth 难控制。
2. 相关方法：expert strategy、guide-based steering、MCTS/online controller、LLM code evolution。
3. 核心问题：缺少可复用 strategy abstraction、LLM-usable feedback、tractability control。
4. 方法：EqSatL、proof-derived rewrite motif caching、tractability guidance。
5. 评估与意义：从 `resources/eggmind` 补具体实验和结果。
6. 与 ISAMORE/SkyEgg 的关系：EggMind 是策略层，服务已有 e-graph 优化任务。

#### 4.3 大模型辅助硬件生成中的形式化反馈：OriGen

内部结构：

1. 背景：LLM 能生成 RTL 或硬件设计片段，但硬件设计对语义、时序、接口和可综合性要求高。
2. 核心问题：仅靠自然语言提示或代码生成难以保证质量，需要编译器、检查器和反馈循环提供约束。
3. 方法：code-to-code augmentation、compiler feedback、self-reflection，以及与数据质量和形式化检查相关的支撑机制。
4. 评估与意义：从 `resources/origen` 补具体实验、数据集和结果。
5. 与未来 Spine 的关系：OriGen 是已有基础，Spine 进一步面向验证约束下的架构、硬件与编译协同生成。

#### 4.4 形式化约束与大模型能力的协同边界

本节不是列举成果，而是总结本章方法论：

1. 大模型适合承担候选生成、搜索启发、策略归纳和跨任务迁移。
2. 形式化技术适合承担语义边界、等价关系、反例反馈、优化空间约束和可复现证据。
3. 软硬件协同需要二者结合：没有大模型，搜索与生成成本高；没有形式化约束，生成结果难以进入芯片设计和编译工具链。
4. 该边界为第五章 IntelliC、Spine 和 PTO Runtime 的 future work 提供问题定义。

#### 4.5 本章小结

- 回到第一章挑战 3 的“自动演化”和“可验证证据闭环”部分。
- 为未来工作章引出仍未完成的系统闭环。

### 第五章 未来工作

本章是最后一个主要技术章，参考范文第五章的结构，但篇幅需要比范文更充分。

注意：

- EggMind 不再作为未来工作。
- 未来工作主要是 IntelliC、Spine、PTO Runtime distributed features，以及它们之间的集成验证。
- 如果 IntelliC/Spine 已有基础，应在每节中写“已有基础”，但仍以“拟开展研究”为主。

建议章节：

#### 5.1 未来工作总体目标

- 从前三章现有工作中提炼剩余问题。
- 总目标：构建可解释、可验证、可自动演化、可运行时落地的软硬件协同系统闭环。

#### 5.2 IntelliC：面向人和 agent 的可解释编译基础设施

按范文未来工作结构：

1. 研究背景与问题分析；
2. 框架设计思路；
3. 关键技术实现；
4. 预期技术特征；
5. 验证与应用规划。

重点：

- syntax/semantics 分离；
- TraceDB；
- rewrite/gate 证据；
- agent action 安全边界；
- 与 APS/Aquas/ISAMORE/SkyEgg/EggMind 的关系。

#### 5.3 Spine：验证约束下的架构、硬件与编译协同生成

按同样五段结构。

重点：

- semantic boundary；
- typed artifacts；
- staged hardware generation；
- staged compiler lowering；
- executable oracle；
- cross-layer checks。

#### 5.4 PTO Runtime distributed features：异构任务图运行时协同

按同样五段结构。

重点：

- task dependency graph；
- host/AICPU/AICore 或异构设备边界；
- distributed task graph；
- ready/completion protocol；
- TensorMap/RingBuffer 扩展；
- profile 与编译反馈闭环。

#### 5.5 集成路线、里程碑与风险控制

建议包括：

- 阶段 1：IntelliC 最小可执行 compiler slice 和证据模型；
- 阶段 2：Spine 小型硬件案例的 oracle-IR-RTL-codegen 闭环；
- 阶段 3：PTO Runtime distributed features 原型；
- 阶段 4：跨层案例整合与论文/开源输出；
- 风险：语义边界过大、agent 生成不可控、运行时依赖真实硬件、评估指标不统一；
- 对策：从小闭环开始、使用 typed artifacts、以可执行 oracle 和 trace 为核心证据。

### 第六章 结论

结论不能只总结论文列表。

应完成：

1. 重申核心矛盾：领域应用演进与芯片/编译/软件生态生产力不足。
2. 总结三章现有工作如何构成技术基础。
3. 总结未来工作如何从现有基础推进到系统闭环。
4. 点明预期贡献：方法体系、工具链能力和可验证软硬件协同能力。

## 篇幅建议

目标正文建议 60-80 页区间，具体依学校模板和图表数量调整。相对比例：

- 第一章引言：15%-20%。需要详细综述和问题收束。
- 第二章领域定制与端到端协同：20%-25%。ISAMORE 篇幅不得少于 APS/Aquas 合计。
- 第三章硬件前端与综合优化：18%-22%。
- 第四章大模型与形式化技术驱动的软硬件协同方法：12%-18%。
- 第五章未来工作：18%-22%。未来工作必须有实质设计，不得短于现有工作任一大章太多。
- 第六章结论：3%-5%。

## 实施计划

### 阶段 A：结构确认

1. 用户确认本 spec 的章节划分。
2. 重点确认第四章标题与 EggMind 定位。
3. 重点确认未来工作是否只保留 IntelliC、Spine、PTO Runtime distributed features，还是还需要其他方向。

### 阶段 B：正文骨架重写

1. 重写 `report/main.typ` 章节结构。
2. 暂不追求所有内容一次到位，但每节放入明确写作 TODO 和 source path。
3. 确保 `make pdf` 通过。

### 阶段 C：逐章扩写

顺序建议：

1. 第一章引言；
2. 第二章领域定制与端到端协同；
3. 第三章硬件前端与综合优化；
4. 第四章大模型与形式化技术驱动的软硬件协同方法；
5. 第五章未来工作；
6. 摘要和结论。

每章扩写前必须读取对应 `resources/` 材料，并更新 `docs/writing/bibliography-audit.md`。

## 待确认问题

1. 第四章标题已确认采用“大模型与形式化技术驱动的软硬件协同方法”。
2. EggMind 的当前完成度和可公开表述边界是什么？
3. Future work 是否包括 EggMind 后续扩展，还是完全把 EggMind 作为现有工作，不在第五章再写？
4. Cayman、Clay、HECTOR 的资料是否足够进入正文，还是暂时只概括？
5. 正文目标页数是否按范文量级，还是需要更短的开题报告版本？
