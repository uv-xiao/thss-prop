# 技术章节源文对齐与图表补充计划

本文件记录技术章节重写时应遵守的源文对齐要求。它不是报告正文，而是后续写作、审稿和 agent 迭代的检查表。

## 总体要求

- 代表性技术工作不能停留在摘要式概括。正文应重点参考 `resources/` 中原始 LaTeX 的章节组织，按照“问题背景、相关方法局限、系统概览、核心抽象、算法/综合流程、实现、实验与意义”的顺序展开。
- 不逐段翻译论文，但必须保持源文技术对象的先后关系。例如源文先定义接口原语，再讨论中间表示和综合算法，正文也不能先给结果再补接口细节。
- 第一作者或共同第一作者工作应按照范文的“具体工作章节”方式写作：先提出局部问题，再解释方法结构，随后给出关键机制、图示、实验数据和本报告主题下的意义。
- 图表优先从 `resources/` 直接选用。图用于呈现系统框架、流程、调度或数据结构；表用于承载定义、对比、实验设置或关键结果。避免为了堆砌材料加入破坏博士开题报告叙事流畅性的表格。
- 正文实际引用的 `resources/` 图表需要复制到 `report/assets/<work>/` 下，再由 `report/main.typ` 引用；不要在报告正文中直接用 `../resources/...` 路径。
- 对英文图内文字暂不强制重绘；图题和正文解释应使用中文，并与 `docs/writing/terminology-decisions.md` 和已确认术语保持一致。

## 各工作源文与图表候选

### APS / Aquas

- 源文重点：`resources/aps/sec/0.5_overview.tex`、`resources/aps/sec/1_architecture.tex`、`resources/aps/sec/2_synthesis.tex`、`resources/aps/sec/3_compiler.tex`、`resources/aps/sec/4_evaluation.tex`；Aquas 的 `sec/1.5_overview.tex`、`sec/2_semantics_and_synthesis.tex`、`sec/3_compiler.tex`、`sec/5_casestudy.tex`。
- 写作组织：统一处理器-加速器接口与复杂访存接口作为“端到端协同框架”的两个阶段；重点写清架构接口、硬件合成和编译支持如何闭合。
- 图表候选：APS/Aquas overview、compiler overview、synthesis flow、interface tables 和 case-study/evaluation tables。
- 当前缺口：正文已有框架叙事，但图表和接口细节不足。

### ISAMORE

- 源文重点：`resources/isamore/tex/3_overview.tex`、`4_dsl.tex`、`5_rimt.tex`、`5.5_impl.tex`、`6_evaluation.tex`。
- 写作组织：先讲可复用自定义指令的设计目标，再讲 e-graph anti-unification、候选模式发现、实现与实验。
- 图表候选：overview、DSL syntax、RIMT、smart AU、vector 示例和结果表。
- 当前缺口：需要继续确保篇幅不少于 APS/Aquas，并加入源文中的关键机制图。

### Cayman

- 源文重点：`resources/cayman/doc/3_methodology.tex`、`4_evaluation.tex`。
- 写作组织：以“领域定制与端到端协同”为主线，说明任务表示、数据通信、候选选择、加速器合并和端到端评价。
- 图表候选：framework、representation、data communication、merging、evaluation tables。
- 当前缺口：已扩写方法叙事，但仍需要补入代表性图。

### HECTOR

- 源文重点：目前仅以本地 BibTeX、Cement/SkyEgg 引用和摘要级信息为依据；扩写前需补全文。
- 写作组织：只作为早期基础设施积累着重概括，不作为一作代表性工作详细展开。
- 当前缺口：不能在未读全文前加入过细算法细节。

### Cement

- 源文重点：`resources/cement/doc/3_HDL.tex`、`4_Synthesis.tex`、`6_Evaluation.tex`。
- 写作组织：硬件前端表达、event layer、control sub-language、timing analysis、FSM synthesis、实验。
- 图表候选：framework、shuffler、timing-analysis example、control statements table、traits table、PolyBench result table。
- 当前缺口：方法已有较多文字，但缺少源文图表支撑。

### Clay

- 源文重点：`resources/clay/sec/0_intro.tex`、`1_preliminaries.tex`、`2_methodologies.tex`、`3_eval.tex`，以及 `resources/clay/tex/framework.tex`、`interface.tex`、`code-transfrom.tex`、`synthesis.tex`、`sched.tex`、`impl.tex`、`eval-desc.tex`、`eval-results.tex`。
- 写作组织：ASIP/自定义指令背景；现有流水线内耦合工具的状态化行为、控制流和访存限制；统一指令扩展接口；CADL；微架构感知综合与调度；硬件实现；实验与意义。
- 图表候选：`resources/clay/fig/framework.png`、`resources/clay/fig/schedule.png`、`resources/clay/drawio/code-transform-p1.pdf`、`resources/clay/drawio/impl-p1.pdf`，以及自定义指令描述/性能表。
- 当前缺口：优先修复。当前正文是摘要式概括，缺少 CADL、action、微架构属性、调度和实验细节。

### SkyEgg

- 源文重点：`resources/skyegg/doc/3_overview.tex`、`4_egraph.tex`、`5_formulation.tex`、`6_solving.tex`、`7_evaluation.tex`。
- 写作组织：分离式 HLS 优化局限；e-graph 设计空间；mapping e-node；timing model；调度式 extraction；ILP 与 ASAP；实验。
- 图表候选：overview、e-graph、ASAP、speedup、resource/timing。
- 当前缺口：方法文字较充分，但缺少关键图表。

### EggMind

- 源文重点：`resources/eggmind/tex/3_overview.tex`、`4_eqsatl.tex`、`5_core_method.tex`、`7_evaluation.tex`。
- 写作组织：以 EggMind 为第四章绝对重点，按 EqSatL、agentic workflow、proof-derived motif memory、tractability guidance、实验和意义展开。
- 图表候选：eggmind overview、EqSatL、search session workflow、proof memory、main comparison。
- 当前缺口：需要补充图表，并确保 agentic 方法被写成形式化约束下的策略自动化，而非自由代码生成。

### OriGen

- 源文重点：`resources/origen/3_Methodology.tex`、`4_Evaluation.tex`。
- 写作组织：中等篇幅概括 RTL 数据增强和编译反馈，不展开成一作代表性工作。
- 图表候选：data augmentation、compiler feedback、repair evaluation。
- 当前缺口：后续可补一张流程图或关键实验数据，但不能压过 EggMind。

## 执行顺序

1. 先修 Clay，因为新增 `resources/clay` 已暴露第三章技术小结过于概括的问题。
2. 然后补 EggMind、ISAMORE、SkyEgg 的关键图表与机制细节。
3. 再补 APS/Aquas、Cayman、Cement 的图表和缺失源文细节。
4. 每次扩写后更新 `docs/writing/bibliography-audit.md`，并运行 `make pdf`。
