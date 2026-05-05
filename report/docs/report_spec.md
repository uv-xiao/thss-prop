# 开题报告撰写思路与 Spec

> Status: this early spec is kept as historical planning material. For the next structural rewrite, use `report_structure_redesign_spec.md` as the controlling spec and discuss it before changing `report/main.typ`.

## 核心命题

算力紧缺不是单纯的硬件峰值性能问题，而是“算力需求增长”和“芯片/编译/软件生态生产力不足”共同作用的系统问题。领域定制处理器、FPGA 加速器和 AI 辅助硬件设计都能提供新的能效空间，但它们只有被编译器、硬件描述、综合优化、验证证据和运行时生态连接起来，才能形成可迭代、可复用、可落地的系统能力。

本报告的研究命题是：围绕“敏捷芯片设计与创新性编译技术驱动的软硬件协同”这一主题，构建从应用需求到硬件实现再到软件适配的全链条方法体系，说明敏捷芯片设计如何打开硬件创新空间，创新性编译技术如何承担跨层连接、优化、验证和自动化职责，并以二者的协同提升系统生产力。

本报告对“软硬件协同”的中心解释是：编译技术作为连接应用需求、硬件结构、综合优化、验证证据和运行时系统的中枢，使硬件设计创新不再停留于单点模块或单次生成，而能进入可重定向、可复用、可验证、可运行时反馈的系统闭环。

## 总体叙事链

```text
算力紧缺与领域应用快速演进
  -> 通用处理器难以兼顾性能、能效与迭代速度
  -> 领域定制需要软硬件协同，但现有工具链割裂
  -> 研究目标：把定制、综合、编译、验证、运行时工具链化
  -> 已有基础：APS/Aquas/ISAMORE/Cayman/Clay + Cement/SkyEgg/HECTOR + EggMind/OriGen
  -> 现有工作：EggMind 等大模型与形式化技术结合的软硬件协同方法
  -> 未来工作：可解释编译基础设施 + 验证约束下的协同生成 + 面向工业级异构架构的算子-运行时编译协同
```

## 成果分类矩阵

| 方向 | 代表工作 | 解决的核心挑战 | 报告中的定位 |
| --- | --- | --- | --- |
| 领域定制与端到端协同 | APS, Aquas, ISAMORE, Cayman | ISAX 接口碎片化、硬件生成与编译适配割裂、复杂 ISAX 难自动映射、自定义指令复用性不足、微架构约束表达困难 | 既是报告主线的“协同框架层”，也是敏捷芯片设计落到领域定制的核心代表性工作组；Cayman 作为一作/共同一作工作应作为重要子章节展开 |
| 硬件前端与综合优化 | Cement, SkyEgg, Clay, HECTOR | RTL 生产率低、HLS 不可预测、调度/映射/代数变换割裂、硬件前端和综合基础设施不足 | 展示从高层描述到高质量硬件实现的设计生产力路径；Clay 作为一作/共同一作工作应作为重要子章节展开，HECTOR 作为二作工作着重概括 |
| 大模型与形式化技术驱动的软硬件协同方法 | EggMind、OriGen | 大模型生成与搜索能力需要形式化语义、等价约束、可验证反馈和可控优化空间 | 作为现有工作的一部分，支撑后续 IntelliC、Spine 与运行时方向 |

## 重点展开的代表性工作

第一层内部采用“APS/Aquas 先建立端到端协同框架，ISAMORE 再展开可复用指令发现”的逻辑顺序，但这不是篇幅降级。ISAMORE 是本报告非常重要的代表性工作，正文篇幅不得少于 APS/Aquas 的合计篇幅。协同框架和单点优化技术在报告中同等重要：前者说明能力如何系统化接入工具链，后者说明关键优化问题如何被深入解决并形成可复用方法。

当前正文仍然过于简略，后续扩写必须充分利用 `resources/` 下论文正文、草稿、图表、表格和 BibTeX。每个代表性工作都应从摘要级概括扩展为“背景-挑战-洞见-系统/算法-评估-意义”的完整讲述。

### ISAMORE

定位：指令定制从“热点枚举”走向“跨程序可复用模式发现”。

展开重点必须包含两条同等详细的线索：

1. 可复用自定义指令是敏捷芯片设计中连接应用模式与硬件能力的关键机制。
2. e-graph anti-unification 是发现可复用指令模式的核心方法创新。

关键叙事：

1. RISC-V 让自定义指令更可用，但定制指令面积昂贵，必须跨程序复用。
2. 既有方法重热点、轻语义复用，只能做语法级合并。
3. ISAMORE 用 e-graph anti-unification 在等价空间中发现可复用模式，并通过 phase-oriented flow、smart AU、pattern vectorization 和 hardware-aware selection 控制规模与质量。
4. 结果：在多个 benchmark、开源库和实际 RoCC 加速器案例中验证，最高相对基线 2.69x，并在案例中展示 1.17x-2.73x 速度提升。
5. 意义：把指令定制从人工经验和单程序热点迁移到可复用、可扩展的编译方法学。

### Cement

定位：硬件前端抽象从低层 RTL 手工状态机，提升到周期确定的事务/事件描述。

关键叙事：

1. FPGA 能提供高能效加速，但 HDL 生产率低，HLS 又难保证可预测微架构。
2. Cement 的 CmtHDL 引入 event layer 和 control sub-language，既保留硬件时序控制，又提升控制逻辑表达能力。
3. CmtC 提供 timing analysis 与 FSM synthesis，面向 FPGA 生成性能可预期的电路。
4. 结果：PolyBench 上相对 HLS/DSL 获得 1.41x-3.49x 加速，并节省 23%-82% 资源；案例验证 systolic array 与 sparse accelerator。
5. 意义：为“敏捷硬件设计”提供前端抽象基础。

### SkyEgg

定位：综合优化从顺序启发式走向等价空间中的联合优化。

关键叙事：

1. HLS 需要同时解决代数变换、硬件映射和调度，但传统工具将它们拆成顺序阶段。
2. 这种割裂导致 scheduler 缺少映射信息，binding 又被固定 schedule 限制。
3. SkyEgg 将 algebraic rewrites 与 FPGA mapping candidates 都编码为 e-graph rewrite rules，并把最终选择与调度表述为 ILP/ASAP 求解。
4. 结果：相对 Vitis HLS 平均 3.01x/3.10x、最高 5.22x 加速，ASAP 能在较大规模上保持可扩展。
5. 意义：补足“高层描述到高质量硬件实现”的综合优化层。

### APS/Aquas

定位：可重定向编译与端到端 ASIP/ISAX 协同框架。

关键叙事：

1. APS 解决接口分裂、ISAX-specific synthesis 和 compiler support 三个问题，提供统一接口、合成框架和编译支持。
2. Aquas 进一步面向复杂数据密集 ISAX，建模 memory-interface attributes 和 cache effects，并用 MLIR/e-graph 做 robust mapping。
3. 结果：APS 在 NTT、BitNet、DPLL 等案例中实现最高 10.16x/14.99x/8.43x；Aquas 在四类真实案例中最高 15.61x kernel speedup 和 1.95x end-to-end speedup。
4. 意义：把单点定制方法连接成可复用的硬件-编译协同系统。

## 未来工作逻辑

未来工作不另起炉灶，而是对现有体系中仍未完全解决的问题做系统扩展：

1. 可解释、可审计的编译基础设施：已有 MLIR/e-graph/编译经验显示，未来编译器不仅要能优化，还要能给人和 LLM agent 提供可读、可验证、可追踪的语义与证据；IntelliC 可作为该方向已有基础或原型。
2. 验证约束下的架构、硬件与编译协同生成：已有 AI 辅助 RTL 与硬件设计经验显示，agent 不能无约束生成，需要把设计意图、架构边界、RTL 证据和执行 oracle 串成验证闭环；Spine 可作为该方向已有基础或原型。
3. 面向工业级异构架构的算子-运行时编译协同：硬件和编译定制最终要落到工业级异构架构上的算子生成、优化、运行时编排和性能反馈闭环；PTO Runtime distributed features 可作为该方向已有基础或原型，`resources/seed-proposal.docx` 中的长程芯片算子自动优化 Agent Harness 是该方向的重要未来工作来源。

## 当前缺口

1. 需要用户确认哪些仓库对应“一作代表性工作”，尤其 APS/Aquas/SkyEgg/ISAMORE/Cement 的作者顺序。
2. 需要补充 Cayman、Clay、HECTOR 的论文 PDF/仓库或准确 BibTeX，以便正文中引用和归类。
3. 需要确认开题报告正式要求：学院、一级学科、专业、导师、页数、章节模板、是否需要中英文摘要。
4. 需要安装 Typst CLI 后编译验证。
