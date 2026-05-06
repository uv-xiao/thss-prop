= 大模型与形式化技术驱动的软硬件协同方法

== 引言

前两章分别讨论了领域能力如何进入架构接口，以及这些能力如何落到高质量硬件实现。本章进一步讨论一个新的方法层问题：当大模型和 agentic 方法开始进入代码生成、硬件生成、编译优化和工程自动化流程时，如何使它们真正服务软硬件协同，而不是退化为不可审计的文本生成。第一章已经指出，LLM/agentic 方法是一条重要技术趋势，但芯片设计与编译优化对语义正确性、接口协议、时序、资源、验证和长期维护提出了远高于一般代码补全的要求。因此，本章的重点不是证明“大模型能写硬件或编译器”，而是说明大模型能力必须通过形式化对象、编译基础设施、验证反馈和证据记忆进入协同流程。

本章包含两类已有研究基础。EggMind 是本章重点，它不把 LLM 作为直接生成最终优化代码的自由 agent，而是把 LLM 的策略生成能力约束在 EqSatL、e-graph、proof-derived motif memory 和 tractability guidance 组成的形式化优化框架中。OriGen 则代表 LLM 进入 RTL 生成流程的探索，其核心价值在于认识到硬件生成不能只依赖自然语言到代码的单次映射，而需要高质量 RTL 数据、code-to-code augmentation、compiler-feedback self-reflection 和专门的修复评测。二者共同说明，大模型与形式化技术结合后，对软硬件协同的作用并不是替代编译器或验证器，而是把策略搜索、证据组织和自动化迭代纳入可检查的工具链对象。

#figure(
  image("assets/eggmind/overview.pdf", width: 94%),
  caption: [EggMind 总体流程。离线阶段通过智能体工作流合成 EqSatL 策略，在线阶段由后端将策略降低为可执行 EqSat 代码并复用到新优化任务。],
)

== 等价图策略自动化

=== 研究背景与设计目标

EggMind 直接回应了第一章和第三章共同提出的编译接口问题：当 e-graph、EqSat 和 rewrite-based optimization 已经成为硬件综合、编译优化和 ISA 定制的重要方法，如何进一步自动化这些优化过程中的策略设计。Equality saturation 的优势在于用 e-graph 紧凑表示大量语义等价程序，避免过早承诺某条 rewrite sequence；ISAMORE 和 SkyEgg 分别利用这一思想发现可复用自定义指令、联合探索硬件变换/映射/调度空间。但 EqSat 的实用瓶颈同样明显：rewrite space 一旦变大，e-graph 会快速膨胀，运行时间和内存成为主要限制，最终结果很大程度上取决于规则如何分组、何时应用、应用多少轮、何时简化。

因此，EggMind 把自动化目标从“让 LLM 直接写 egglog 代码”转向“合成可复用 EqSat strategy artifact”。在 EggMind 中，strategy 指组织 EqSat search 的控制结构，包括 ruleset partitioning、saturation scheduling、e-graph simplification 和 budget control。这个对象位于 rewrite rules 和 backend execution 之间：它不改变语义规则本身，但决定哪些规则可以互相作用，怎样分阶段暴露优化机会，以及如何在搜索过程中收缩冗余状态。这样，LLM 不再直接操作庞大的 raw e-graph 或低层 egglog 细节，而是围绕一个可检查、可复用、可评估的策略对象进行搜索 @eggmind2026。

=== 可审计的策略对象

EggMind 的第一个核心抽象是 EqSatL。EqSatL 是表示 EqSat strategies 的 DSL，目标是在 compactness、formal validation 和 expressiveness 之间取得平衡。它把策略设计分解为三个控制面。第一是 ruleset partitioning，用 semantic tags 将 rewrite vocabulary 分为具有含义的 rulesets，而不是暴露冗长规则列表，使 LLM 能在更高层级表达“哪些规则应当一起或分开作用”。第二是 schedule construction，用 flow tree 组织 phases、sequences 和 `repeat` regions，使规则交互可以被分阶段、可重复但有界地执行。第三是 simplification control，把 `simplify` 显式化为一等控制节点，通过强度参数和可选 LLM hints 决定何时、如何收缩 e-graph，避免无约束增长 @eggmind2026。

#figure(
  image("assets/eggmind/eqsatl.pdf", width: 86%),
  caption: [EqSatL 策略示例。策略对象将规则集划分、阶段化调度、repeat 结构和 simplify 控制显式化，便于大模型生成、工具验证和后端执行。],
)

这一设计的关键在于，EqSatL 将战略意图与 backend implementation 解耦。传统 raw egglog 脚本把策略、规则应用细节和执行机制混在一起，LLM 需要反复修补低层代码，反馈也难以解释。EqSatL 则把 strategy artifact 放在稳定边界上：它足够紧凑，便于 LLM 生成和修改；它足够显式，便于检查 partition、schedule 和 simplification 是否合理；它也足够有表达力，能控制规则互动、重复搜索和状态收缩。对软硬件协同而言，这种 artifact boundary 非常重要，因为可审计自动化必须操作稳定对象，而不是依赖一段不可解释的低层脚本。

=== 智能体工作流：离线策略合成与在线复用

EggMind 的第二个核心是 agentic workflow。它把离线策略合成组织为 Strategist、Generator、Evaluator、Partitioner 和 Simplifier 的受控循环。workflow memory 中维护 strategy repository，包括当前 best strategy、promising strategies 和 pending strategies；每轮迭代中，Strategist 根据当前证据选择动作，Generator 产生或修改 EqSatL 策略，Evaluator 以不同预算执行 EqSat 并返回质量、时间和内存反馈，Partitioner 与 Simplifier 则提供 ruleset partition 和 simplification hints。评估后，系统更新 best/promising/pending 状态，并把成功运行中的证据写回 memory。这样，agentic workflow 不依赖开放式对话历史，而依赖明确的策略对象、评估结果和可复用证据 @eggmind2026。

从系统结构看，EggMind 将策略发现分为 offline synthesis 和 online reuse 两个阶段。离线阶段以一组 evolution cases、rewrite rules 和 cost model 为输入，由 agentic workflow 生成 EqSatL strategy artifacts；在线阶段则把选定策略应用到新 case，由 backend 将 EqSatL lowering 为可执行 EqSat 代码并运行。这个分离具有重要工程意义：昂贵的策略探索成本在离线阶段支付，并通过可复用策略摊销到后续优化任务；在线优化阶段不需要让 LLM 反复进入执行路径，从而降低不可控性和运行开销。对博士开题报告而言，这一点说明 EggMind 不是一般意义的“LLM 调参”，而是一种把策略搜索、执行评价和证据记忆分层组织的编译自动化系统。

=== 证明驱动的经验记忆

第三个核心是 proof-derived rewrite motif caching。EqSat 运行若产生更优结果，backend 可以给出初始表达式到最终表达式的 equivalence proof；但原始 proof tree 通常庞大、包含大量 congruence/transitivity bookkeeping，不适合作为 LLM 上下文。EggMind 因此从 proof tree 中提取局部 rewrite motifs，将具体 rule chain 提升为 semantic tag chain，例如某类 vector lifting 后接某类 vector optimization。motif cache 根据相对 cost reduction 和跨 case frequency 保留高价值 motifs，并在后续策略生成中提供紧凑结构证据。这样，系统记忆的不是模糊经验描述，而是来自成功证明路径的可复用 rewrite interaction @eggmind2026。

这一机制解决了 agentic 编译优化中的一个关键问题：经验如何不变成不可审计的自然语言偏好。EggMind 首先定位 proof tree 中的 local proof regions，用 congruence path 标记子表达式上下文；随后把局部 rewrite chain 通过 rule-to-tag mapping 提升为语义 tag chain，并对重复 motif 进行去重和排序。motif 的评分同时考虑 relative gain 和跨 case frequency，因此 cache 保留的是在成功优化中反复出现、且能带来实际 cost reduction 的结构证据。后续 Generator 或 Strategist 使用这些 motif 时，看到的是来自等价证明的 compact guidance，而不是未经验证的人工经验。

#figure(
  image("assets/eggmind/proof-memory.pdf", width: 82%),
  caption: [EggMind proof-derived motif memory。系统从等价证明中抽取局部重写 motif，并将其转化为可复用、可审计的策略证据。],
)

=== 可处理性引导与简化提示

第四个核心是 tractability guidance。EggMind 用 dependency-based ruleset risk model 为 ruleset partition 提供稳定性指导：它把 rewrite vocabulary 建模为 rule dependency graph，根据 RHS/LHS enablement、operator overlap 和 subtree matchability 估计规则之间的互相激活风险；partition objective 奖励前向阶段依赖，惩罚 backflow、phase-1 inflow 和 same-phase entanglement，从而使规则交互更接近稳定的 forward activation。与此同时，LLM-guided simplification hints 为不同 phase 提供 preferred/pruned pattern pairs，将 simplification 从单一全局 cost pruning 变成 phase-local structural preference。二者共同服务一个目标：让 LLM 搜索停留在稳定、可执行、可复用的策略空间中，而不是不断触发 e-graph explosion @eggmind2026。

具体地，dependency-based ruleset risk model 将 rewrite rules 作为图节点，用有向边表示一条规则可能启发另一条规则的强度；phase assignment 的目标是鼓励规则依赖从前一阶段流向后一阶段，同时抑制后向激活、首阶段反复被后续规则激活，以及同阶段规则强耦合。LLM-guided simplification hints 则在每个 phase 给出少量 preferred/pruned pattern pairs，形成局部简化偏序，并通过 bounded penalty 改变 e-class 内候选的保留优先级。这种做法没有把 LLM 提示作为硬删除规则，而是让 evaluation 继续检验提示是否过强或损害后续优化；如果提示不合适，后续迭代可以修正。因此，EggMind 对 LLM 的使用始终围绕可执行评价和可回退控制，而不是让模型直接决定最终正确性。

=== 实验评估与对软硬件协同的意义

EggMind 的评估说明，这种“LLM + 形式化策略对象 + 证据闭环”的组合确实改善了 EqSat 优化。Vectorization benchmark 上，EggMind 相对 full EqSat 将 final cost 几何平均降低 45.1%，相对专家调优 Isaria strategy 降低 20.6%；在线运行相对 Isaria 获得 2.21x 几何平均加速，并相对 full EqSat 将 peak memory 几何平均降低 69.1%。Ablation 显示，motif caching、`repeat` construct、Strategist 和 Partitioner 均对质量或稳定性有贡献，尤其缺少 motif caching 或 repeat 会显著恶化 cost、runtime 和 memory @eggmind2026。

#figure(
  image("assets/eggmind/isaria-main-comparison.pdf", width: 92%),
  caption: [EggMind 在 Isaria/vectorization 基准上的主要结果。该结果支持正文关于策略质量、运行时间和内存占用改善的论断。],
)

EggMind 还展示了跨领域迁移能力。在 XLA-based tensor compiler benchmark 中，合成策略在 17 个 case 中 13 个获得低于 unguided baseline 的 final cost，其余 4 个持平，同时相对 full EqSat 获得 11.89x 几何平均运行时加速。在 EqMap logic synthesis case study 中，EggMind 使用 augmented rewrite space，在 carry-chain benchmarks 上取得最好的质量效率权衡，相对原始规则 $i=4$ 和 $i=5$ 分别降低 33.76% 和 8.75% cost，并相对 unguided 高预算搜索降低 51.94% peak memory @eggmind2026。这些结果说明，EggMind 不是为单个 vectorization benchmark 手工调参，而是在不同 e-graph 优化域中学习和复用策略组织方式。

从本报告主线看，EggMind 是 ISAMORE 和 SkyEgg 的策略层延伸。ISAMORE 依赖 e-graph AU 和 phased EqSat 发现可复用自定义指令，SkyEgg 依赖 e-graph 表达硬件变换与 mapping choices；二者都面临 rewrite space 如何组织、搜索如何收敛、策略如何迁移的问题。EggMind 的贡献是把这些策略从隐含经验提升为显式、可审计、可复用的 EqSatL artifact，并用 agentic workflow、proof-derived motif memory 和 tractability guidance 对 LLM 搜索施加结构化约束。这也是本报告中“大模型与形式化技术结合”的核心含义：LLM 负责提出和改进策略，形式化对象负责限定可操作边界，proof 和 evaluator 负责提供证据，编译基础设施负责执行和检查。

== 大模型辅助硬件生成中的形式化反馈

=== 问题定位

OriGen 面向 RTL code generation，是大模型进入硬件设计流程的早期探索之一。其问题背景很直接：商业 LLM 已经在 C++、Python 等软件代码生成上展示了较强能力，也能生成一定质量的 RTL，但闭源模型带来隐私、安全、可定制性和研究可复现问题；开源代码模型虽然便于部署和微调，却因为高质量 RTL 数据不足，在 Verilog/RTL 生成任务上明显落后。硬件设计中的 RTL 往往包含 IP 和专有设计知识，不能简单依赖商业模型远程生成；同时，RTL 语法、时序、综合风格和验证要求又明显不同于普通软件代码，通用代码数据难以充分覆盖 @origen2024。

=== 数据增强与硬件代码生成能力提升

OriGen 的第一条思路是提升 RTL 数据质量。现有 Verilog 数据集要么来自 GitHub 等开源仓库，规模较大但质量参差不齐；要么由商业模型根据关键词或自然语言描述合成，质量较高但规模和多样性受限。OriGen 提出 code-to-code augmentation：从开源 RTL 中抽取高层代码描述，再利用 teacher model 对代码进行 refined generation，以知识蒸馏方式改善开源 RTL 数据。这一方法不是只让模型“凭空写代码”，而是把已有开源 RTL、自然语言描述和教师模型能力组织成数据增强流程，试图在规模与质量之间取得平衡 @origen2024。

#figure(
  image("assets/origen/code-to-code.pdf", width: 96%),
  caption: [OriGen 的 code-to-code augmentation 流程。开源 RTL、描述抽取和 teacher model 共同构成更高质量的 RTL 数据增强路径。],
)

=== 编译反馈自反思与修复评测

第二条思路是引入 compiler-feedback self-reflection。硬件设计流程天然包含编译、仿真和验证反馈；如果 LLM 生成的 RTL 不能通过编译器或 simulator，模型应当利用错误信息定位问题并修复代码。OriGen 因此构建 VerilogFixEval，由 VerilogEval 中 221 个编译失败案例组成，用于评测模型基于 compiler error messages 修复 RTL 的能力。训练数据中包含 natural language instructions、erroneous code、compiler error messages 和 corrected code，使开源模型学习从错误反馈到代码修复的映射 @origen2024。

#figure(
  image("assets/origen/generation.pdf", width: 92%),
  caption: [OriGen 的 RTL 生成与反馈修复流程。编译错误、错误 RTL 和修正代码共同构成模型自反思训练与评测的证据来源。],
)

=== 结果与启示

OriGen 的意义在于把大模型硬件生成从“一次性生成 RTL”推进到“数据、生成、编译反馈和修复”的闭环。实验报告显示，OriGen 在 VerilogEval-Human 上超过此前开源 RTL 生成模型，并在 VerilogFixEval 上展示了较强 self-reflection 能力 @origen2024。对本文而言，这一工作更重要的启示是：硬件生成中的 LLM 能力必须与工具反馈结合，编译器错误、语法检查、仿真结果和修复样例都应成为模型学习和迭代的证据来源。后续面向验证约束的架构、硬件与编译协同生成，也需要继承这一思想，但进一步把反馈从编译错误扩展到形式化约束、接口协议、等价性检查、综合结果和运行时证据。

== 形式化约束与大模型能力的协同边界

通过 EggMind 和 OriGen 可以看到，大模型与形式化技术的关系不是替代关系，而是分工关系。大模型适合在开放空间中提出候选、总结策略、迁移经验、生成修复和组织长程搜索；形式化技术、编译 IR、验证工具和执行反馈则负责限定语义边界、检查等价关系、提供反例和性能证据、约束优化空间，并保证过程可复现。没有大模型，许多策略设计和跨任务经验迁移仍高度依赖专家；没有形式化与工具反馈，大模型输出又难以满足硬件和编译系统对正确性与可维护性的要求。

这一边界为第五章未来工作提供了方法定义。验证约束下的架构、硬件与编译协同生成，需要让模型在架构描述、硬件 IR、编译过程和验证 oracle 之间提出候选并接受反例；可解释、可审计的编译基础设施，需要把策略、证据、目标契约和运行记录作为一等对象；面向工业级异构架构的算子优化与运行时编译协同，则需要让智能体方法在性能剖析、基准测试、运行时轨迹和目标约束中进行长期迭代。三者共同要求大模型能力必须进入智能体协作框架，而不是停留在自由文本接口。

== 本章小结

本章回应第一章提出的第三个科学问题：编译接口如何连接程序语义、硬件能力和运行时反馈，形成跨硬件架构的可解释、可验证、可复用证据闭环。EggMind 展示了在编译优化和 e-graph 搜索中，LLM 应当通过 EqSatL、agentic workflow、proof-derived motif memory 和 tractability guidance 等结构化对象进入流程；OriGen 展示了 LLM 进入 RTL 生成时必须面对数据质量、编译反馈和自反思能力问题。二者共同说明，大模型方法的价值不在于绕过硬件工具链，而在于帮助工具链进行策略生成、错误修复、证据积累和长程优化。

这也为第五章未来工作奠定了方法基础。后续研究需要把 OriGen 所体现的反馈式硬件生成、EggMind 所体现的可审计策略生成，以及第二、三章中的架构接口和硬件综合机制结合起来，进一步构建验证约束下的架构、硬件与编译协同生成，可解释、可审计的编译基础设施，以及面向工业级异构架构的算子优化与运行时编译协同。换言之，未来工作不是让 agent 自由生成设计，而是让 agent 在明确的架构接口、IR 对象、形式化约束、测试/benchmark 和运行时证据中进行受控协作。
