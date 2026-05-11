# 相关工作覆盖审计机制与初始实施

> 状态：第一轮审计已用于 2026-05-11 的 1.4-1.6 同步改写；后续修改第一章前仍需更新。
>
> 目的：补足当前综述“不够详细”的问题。`related-work-synthesis.md` 已经把源论文 related work 汇总为四类接口问题：应用到架构、架构到硬件、架构约束下的编译优化、智能体化方法。本文件建立逐篇源论文到当前报告正文的覆盖检查机制，并给出第一轮提升意见。

## 1. 机制定义

每次重写第一章 1.4 “面向协同接口的国内外研究现状”前，必须执行以下流程。

1. 对每篇源论文读取 introduction、background、motivation、preliminary、related work 等综述性章节。
2. 从源文中提取三类信息：
   - 研究对象：源文把哪些问题、系统、方法或工具线放入相关工作；
   - 分类方式：源文如何划分相关工作，是否有接口、抽象、方法、系统或评价维度；
   - 未解决问题：源文如何指出已有工作的限制。
3. 对照 `report/chapter-01-introduction.typ`，检查三件事：
   - 是否讨论：相关工作族是否在报告中出现；
   - 是否分析：是否写出成熟点、限制和与本文主线的关系；
   - 是否归类：是否被放入四类接口问题中的正确位置，而不是只作为论文名堆叠。
4. 对每篇源论文形成覆盖状态：
   - `充分`：报告已讨论、分析、归类，并服务主线；
   - `部分`：报告已有相关段落，但分析不够细或缺少源文分类；
   - `不足`：报告仅点名或几乎未吸收源文 related work；
   - `待补源`：需要补充 BibTeX、论文原文或外部材料。
5. 形成可执行修改动作，并在正文修改后回填结果。

## 2. 当前报告的总体问题

当前 1.4 已经改为四类接口问题分类，也引用了大量代表工作，但后续仍需检查三类风险。

第一，源论文的 related work 被压缩成接口综述后，部分源文内部的分类逻辑消失。例如 APS 对 ISAX 接口、ASIP 设计套件、编译支持和可重定向工具链的层次区分，在报告中已有覆盖，但还没有充分展开这些层次为何共同构成“架构接口”问题。

第二，报告目前更擅长说明“已有研究有哪些”，但对“源论文为什么认为这些研究仍不足”展开仍需持续检查。尤其是硬件前端、HLS、硬件 IR、等价图策略控制、LLM 硬件生成、工业异构系统与系统软件边界等材料，需要把限制写成更清楚的研究张力。

第三，部分本地源文对 related work 的贡献没有被充分转化为第一章综述。例如 Cement 和 Clay 对硬件表达/综合质量的分类、EggMind 对等价饱和策略和 LLM-guided optimization 的分类、Cayman 对 candidate selection 与 hardware synthesis 脱节的分类，都应成为综述段落内部的分析骨架。

## 3. 逐篇覆盖审计

### 3.1 APS

源文位置：`resources/aps/sec/0_intro.tex`，`resources/aps/sec/5_related_works.tex`。

源文相关工作重点：

- RISC-V ISAX 接口：RoCC、NICE、PCPI、TIGRA、CV-X-IF、SCAIE-V；
- ASIP 设计套件和框架：Tensilica、Synopsys ASIP Designer、Codasip Studio、Longnail、ASSIST；
- 架构描述、硬件生成、编译支持和指令扩展使用之间的割裂；
- APS 的关键缺口是开放处理器生态中缺少统一 ISAX 接口、ISAX-specific synthesis 和可用编译支持的端到端结合。

当前报告覆盖状态：`部分`。

已有覆盖：

- 1.4 第一类已讨论 RISC-V/ASIP 接口和设计套件；
- 已把 APS 放入应用到架构接口和架构接口工具链问题。

缺口：

- 目前没有充分区分“指令卸载接口”“ASIP 设计框架”“编译支持”三层；
- 缺少 APS 源文中“接口碎片化导致硬件能力难跨平台复用”的明确分析；
- 对 bitwidth-aware vectorization、wrapper/intrinsic 生成等编译支持机制没有在综述中作为“架构接口需要编译可见性”的证据出现。

修改动作：

- 在 1.4 第一类中，把 APS 相关段落拆出三层：接口、设计框架、编译支持；
- 增加一句判断：ISAX 接口若只解决指令卸载而不解决编译可见性和综合路径，就不能构成敏捷芯片设计中的可复用系统能力。

### 3.2 Aquas

源文位置：`resources/aquas/sec/0_intro.tex`，`resources/aquas/sec/1_preliminary.tex`。

源文相关工作重点：

- 数据密集 ISAX 不只是计算单元扩展，还涉及 memory-interface attributes、cache effects、transaction scheduling 和 robust compiler mapping；
- MLIR/Aquas-IR、多层表示和 e-graph matching 用于对齐硬件侧语义和软件侧模式；
- 复杂访存和软件变体使传统 pattern matching 脆弱。

当前报告覆盖状态：`部分`。

已有覆盖：

- 1.4 第一类和第四类已提到复杂访存、缓存、暂存存储、事务粒度和运行时可见事实；
- 已将 Aquas 与架构约束下的编译优化和系统软件边界联系起来。

缺口：

- 当前没有充分说明 Aquas 为什么跨越“应用到架构”和“软件到编译”两类接口；
- 对 Aquas-IR 的多层表示、e-graph internal/external rewrites、skeleton-component matching 等源文分类没有转化为综述分析。

修改动作：

- 在第一类末尾加入 Aquas 作为“架构接口必须携带访存事实”的例子；
- 在第三类软件到编译中加入 Aquas 作为“硬件侧能力与软件侧模式需要在兼容 IR 中对齐”的例子。

### 3.3 ISAMORE

源文位置：`resources/isamore/tex/1_introduction.tex`，`resources/isamore/tex/2_background.tex`，`resources/isamore/tex/7_related_work.tex`。

源文相关工作重点：

- 定制指令发现从 fine-grained enumeration、coarse-grained synthesis、syntactic merging 到 reusable custom instruction；
- 现有方法偏热点或语法共性，缺少语义复用；
- e-graph、equality saturation、anti-unification、DLP/vectorization 和硬件感知选择共同构成方法背景。

当前报告覆盖状态：`部分`。

已有覆盖：

- 1.4 第一类已讨论定制指令和加速器发现谱系；
- 第三类已讨论 e-graph、反合一和语义复用。

缺口：

- 当前报告把 custom instruction discovery 谱系写得较短，没有体现 ISAMORE 源文 related work 对 fine-grained、coarse-grained、syntactic merging、reusability 的层次；
- 对“语义复用”为什么比“热点复用/语法复用”更适合作为架构能力来源，还需要更明确的评价。

修改动作：

- 在第一类中补一段“从热点枚举到语义复用”的演进；
- 在第三类中补一句：e-graph anti-unification 的意义不是另一个编译技巧，而是把可复用架构能力发现放入程序等价空间。

### 3.4 Cayman

源文位置：`resources/cayman/doc/1_introduction.tex`，`resources/cayman/doc/2_background.tex`，`resources/cayman/doc/5_related_work.tex`。

源文相关工作重点：

- candidate selection、custom functional unit synthesis、off-core accelerator synthesis 和 HLS/DSE 之间割裂；
- DFG-only 方法忽视控制流和复杂访存；
- manually selected kernels 与 automatic selection 之间存在断层；
- candidate selection 必须与 performance estimation、area estimation、interface selection 和 accelerator merging 联动。

当前报告覆盖状态：`部分`。

已有覆盖：

- 1.4 第一类已提到 AccelSeeker、Trireme、FINDER、NOVIA 等；
- 第二类已用 Cayman 指出控制流优化、访存接口选择、性能估计和硬件共享不能割裂。

缺口：

- 对 Cayman 源文中的四类相关工作边界没有系统展开；
- 对“选择候选”和“生成高质量硬件”之间的断裂尚未成为第一章的明确挑战。

修改动作：

- 在第一类结尾补充 candidate selection 与 hardware synthesis 脱节；
- 在第二类中补充 Cayman 作为架构到硬件接口的桥梁：候选区域、访存接口、控制流和合并策略必须共同决定实现质量。

### 3.5 Cement

源文位置：`resources/cement/doc/1_Introduction.tex`，`resources/cement/doc/2_Background_Motiviation.tex`，`resources/cement/doc/7_Related_Work.tex`。

源文相关工作重点：

- RTL/eHDL、HLS、hardware DSL、hardware IR、FPGA framework 的分类；
- HLS 提升抽象但结果依赖 pragma 和后端启发式；
- 许多 DSL 提供领域受限表达，不一定能表达通用周期行为；
- Cement 的问题焦点是 cycle behavior、control sub-language 和 timing analysis。

当前报告覆盖状态：`部分`。

已有覆盖：

- 1.4 第二类已列 HDL/HLS/DSL/IR，并提到周期确定行为和时序正确性。

缺口：

- 当前段落列举充分但分析仍略压缩；
- 源文关于“周期行为不是普通软件控制流”的关键判断需要更明确；
- Cement 对“可预测硬件前端”的贡献应服务问题 2，而不只是作为相关工作例子。

修改动作：

- 在第二类中增加“高层硬件前端必须显式表达跨周期行为”的分析句；
- 把 Cement 源文的 RTL/HLS/DSL/IR 分类转化为一个更有层次的段落，而不是继续平铺工具名。

### 3.6 Clay

源文位置：`resources/clay/sec/0_intro.tex`，`resources/clay/sec/1_preliminaries.tex`，`resources/clay/sec/4_related.tex`。

源文相关工作重点：

- ASIP 工具、ADL、ISAX 接口、HLS 和 processor-accelerator coupling；
- 指令实现质量依赖 in-pipeline coupling、coprocessor coupling、stateful behavior、register/memory constraints 和 microarchitectural attributes；
- 行为描述和实现质量控制需要分离但相互约束。

当前报告覆盖状态：`部分`。

已有覆盖：

- 1.4 第一类涉及 ASIP 设计套件；
- 第二类提到 Clay 源文相关工作对耦合方式和微架构属性的强调。

缺口：

- 当前没有充分利用 Clay 把 ASIP 前端问题从“接口可用”推进到“实现质量可控”的源文逻辑；
- 对 ADL/HLS/接口框架的差别还缺少分析。

修改动作：

- 在第一类用 Clay/APS 共同说明 ASIP 工具链的接口和描述语言基础；
- 在第二类补充“行为抽象与实现属性分离”作为架构到硬件接口的关键张力。

### 3.7 SkyEgg

源文位置：`resources/skyegg/doc/1_introduction.tex`，`resources/skyegg/doc/2_background.tex`，`resources/skyegg/doc/8_related_work.tex`。

源文相关工作重点：

- HLS phase ordering、algebraic transformation、hardware mapping、scheduling 和 binding 的割裂；
- e-graph/equality saturation 在 HLS、logic synthesis、FPGA mapping、vectorization 等方向的应用；
- extraction scalability、mapping-aware scheduling 和 ASAP heuristic。

当前报告覆盖状态：`部分`。

已有覆盖：

- 1.4 第二类和第三类均提到 SkyEgg；
- 已指出代数变换、硬件映射和调度应共同参与选择。

缺口：

- 对 phase ordering 的问题还不够突出；
- SkyEgg 源文 related work 中的 mapping/HLS/e-graph 交叉分类没有充分进入引言。

修改动作：

- 在第二类中明确 HLS 顺序阶段导致 scheduler 与 mapping 互相缺信息；
- 在第三类中将 SkyEgg 作为“编译表示保留硬件映射事实”的例子，而不是只作为硬件实现质量例子。

### 3.8 OriGen

源文位置：`resources/origen/1_Introduction.tex`，`resources/origen/2_Background.tex`。

源文相关工作重点：

- LLM for Verilog、RTL generation benchmarks、data augmentation、distillation、compiler-feedback repair；
- 大模型硬件生成需要数据质量、开源模型能力、编译反馈和可复现评测；
- 不应把 LLM 硬件生成写成自由生成。

当前报告覆盖状态：`部分`。

已有覆盖：

- 1.4 第四类已列 RTL 生成与修复相关工作；
- 已用 OriGen 支撑“LLM 进入硬件生成需要反馈约束”。

缺口：

- 对数据集、商业模型蒸馏、open-source model capability 和 feedback repair 的层次没有展开；
- OriGen 作为支持性现有工作应帮助引出更强的 agentic/verification boundary，而不仅是列入 LLM 硬件生成。

修改动作：

- 在第四类中把 LLM 硬件生成分成生成、数据、评测、反馈修复四层；
- 用 OriGen 明确连接到“生成能力必须被编译/仿真反馈约束”。

### 3.9 EggMind

源文位置：`resources/eggmind/tex/1_introduction.tex`，`resources/eggmind/tex/2_background.tex`，`resources/eggmind/tex/8_related_work.tex`，`resources/eggmind/doc/related_work_scan.md`。

源文相关工作重点：

- equality saturation substrate、strategy rewriting、rule synthesis、guided EqSat、MCTS/control、LLM-guided compiler optimization；
- free-form code evolution 或 per-instance online control 难以形成 reusable, checkable EqSat strategies；
- EqSatL、proof-derived motif memory、tractability guidance 是对策略可复用和可检查问题的回应。

当前报告覆盖状态：`部分`。

已有覆盖：

- 1.4 已在“架构约束下的编译优化”和“智能体化方法”中讨论等价饱和策略、LLM 辅助编译优化和可检查策略表示；
- 已把 EggMind 与 agentic/formal method 的边界联系起来。

缺口：

- 当前报告还没有充分展开 strategy 相关工作的谱系：人工策略、策略语言、规则生成、guided search、MCTS、LLM 编译优化；
- 对 EggMind 的 related work 应成为第四章重点，但第一章也需要更清楚地说明“策略可复用性”是问题 3 的关键组成。

修改动作：

- 在第三类中补充“等价饱和从表达优化空间走向控制优化空间”的过渡；
- 在第四类中明确区分 general coding agent、kernel/compiler agent、EqSat strategy agent 三类智能体化对象。

### 3.10 HECTOR

源文位置：`resources/hector/Introduction.tex`，`resources/hector/Background.tex`，`resources/hector/Relatedwork.tex`，`resources/hector/Overview.tex`。

源文相关工作重点：

- HLS 与硬件生成器都试图提高 RTL 之外的硬件设计生产力，但 HLS 容易缺少领域知识并导致性能或资源问题，硬件生成器常依赖特定领域语言和模板；
- HLS 工具通常经历 allocation、scheduling、binding，调度又分为 static、dynamic 和 hybrid scheduling；静态调度可资源共享但保守，动态调度可推迟运行时决策但资源开销高；
- LLVM IR 等软件 IR 缺少硬件信息，硬件 IR 则分别覆盖 FIRRTL、LLHD、uIR、hierarchical CDFG、SynASM、AHIR、Calyx、CIRCT 等方向；
- Hector 的核心定位是用 MLIR 上的两级 IR 统一多种硬件综合方法，减少 HLS 与硬件生成器重复实现，并为后续综合方法提供可扩展基础设施。

当前报告覆盖状态：`部分`。

已有覆盖：

- 1.4 第二类已点名 HECTOR，并把它放在硬件 IR 或类型系统一组；
- 1.6 已将 HECTOR 作为第三章早期高层综合与 MLIR 硬件基础设施积累。

缺口：

- 当前 1.4 没有利用 HECTOR 源文对 HLS、硬件生成器、静态/动态/混合调度、软件 IR 与硬件 IR 差异的分析；
- 当前综述只点名 HECTOR，没有把它作为“多层 IR 统一不同硬件综合方法”的早期证据；
- 第三章映射中应更准确说明 HECTOR 的角色：它不是只支撑某个后续工具，而是支撑“硬件实现方法需要公共 IR 与可组合综合流程”这一科学问题来源。

修改动作：

- 在 1.4 第二类中补充 HECTOR：HLS 和硬件生成器的割裂、静态/动态调度权衡、软件 IR 缺少硬件事实、硬件 IR 需要多层抽象；
- 在 1.5 第二个科学问题中增加“不同综合方法缺少共同可检查 IR 和可组合流程”作为挑战；
- 在 1.6 第三章映射中保留 HECTOR 的早期积累地位，但避免把它展开成与一作代表工作同等篇幅。

## 4. 第一轮引言修改优先级

### P0：先改综述组织

1. 在 1.4 开头声明：本节不是列举四类技术，而是逐类检查“接口成熟度与剩余断裂”。
2. 每类接口段落内部统一采用：
   - 代表路线；
   - 源论文 related work 给出的分类；
   - 剩余断裂；
   - 对三个科学问题的导向。

### P1：补强应用到架构

重点吸收 APS、Aquas、ISAMORE、Cayman。

建议新增/改写的分析线：

- ISAX 接口、ASIP 框架和编译支持是三层问题；
- custom instruction discovery 从热点枚举走向语义复用；
- candidate selection 与 hardware synthesis 的脱节使“什么值得定制”不能脱离实现质量。

### P1：补强架构到硬件

重点吸收 Cement、Clay、Cayman、SkyEgg。

建议新增/改写的分析线：

- 高层硬件前端必须显式承载周期、控制、资源和接口事实；
- 行为抽象与实现属性需要分离但保持约束；
- 变换、映射和调度不能被顺序阶段割裂。

### P1：补强软件到编译

重点吸收 ISAMORE、Aquas、SkyEgg、EggMind。

建议新增/改写的分析线：

- 编译接口要同时保留程序语义和目标硬件事实；
- 等价图从表达等价空间进一步承担硬件能力发现、映射选择和策略控制；
- 策略可复用性和可检查性是问题 3 的核心，不只是 Chapter 4 细节。

### P2：补强智能体化方法

重点吸收 OriGen、EggMind，并结合 AVO、AlphaEvolve、OpenAI/Anthropic。

建议新增/改写的分析线：

- LLM 硬件生成要分成生成、数据、评测、反馈修复；
- agentic compiler/kernel optimization 与 EqSat strategy automation 不是同一类对象；
- 芯片设计和编译优化的 agentic 方法必须被 IR、形式化语义、性能剖析、执行轨迹和硬件验证约束。

## 5. 下一步实施

本文件建立覆盖审计后，下一步应按以下顺序实施：

1. 用本文件 P0/P1/P2 动作重写 `report/chapter-01-introduction.typ` 的 1.4，并保持分类子章节结构。
2. 重写 1.5，使三个科学问题显式吸收每类接口的剩余断裂。
3. 检查新增引用是否已经在 `report/refs.bib`；没有则从 `docs/writing/related-work-bib-reservoir.bib` 或源文 `.bib` 中提升。
4. 运行 `make pdf`，检查引言篇幅、引用位置和术语。
5. 回填本文件的覆盖状态，将已完成动作标记为 `完成` 或继续拆分。

## 6. 2026-05-11 实施记录

已完成：

- 2026-05-11 21:31 根据用户反馈再次重写 `report/chapter-01-introduction.typ` 的 1.4，将原来没有子章节的压缩综述改为四个分类子章节，并在每个子章节中补充分类依据、内部层次、代表工作族、源文指出的限制和对本文科学问题的导向。
- `report/chapter-01-introduction.typ` 的 1.4 已按四类接口问题重新扩写，新增了每类问题的成熟基础、源文分类、剩余断裂和问题导向。
- 1.4 已吸收 HECTOR 源文，补充 HLS 与硬件生成器割裂、静态/动态/混合调度、多层硬件 IR、软件 IR 缺少硬件事实等论点。
- 1.5 已同步改写，使三个核心科学问题吸收 1.4 的剩余断裂，尤其补入“不同综合方法缺少共同可检查 IR 和可组合流程”。
- 1.6 已同步改写，使第二至第四章和第五章未来方向与三个科学问题重新对应，并明确 HECTOR 的支撑性工作定位。
- 已运行 `make pdf`，编译通过。

仍需后续细化：

- 1.4 的引用已经更密集，但仍可在下一轮根据 `related-work-bibliography.md` 检查是否有候选引用需要从 reservoir 提升到 `report/refs.bib`。
- 1.4 当前仍以叙事段落为主，尚未逐条标记每篇源论文覆盖状态为 `完成`，下一轮 review 可进一步更新 3.1-3.10 的状态。
- HECTOR 在第三章正文中仍需按 supporting-work 结构细化；本轮只处理第一章综述和映射。
