# 术语保留与翻译决策表（待审阅）

本文件用于审阅正文中的中英文术语策略。它是工作表，不直接出现在报告中。`docs/writing/terminology.md` 记录已确认术语；本文件先给出初始建议，等待人工确认后再批量改正文。

## 使用规则

- “保留英文”表示正文主要使用英文术语，必要时首次出现加中文解释。
- “中文为主”表示正文主要使用中文，首次出现可括注英文。
- “双语固定搭配”表示首次出现和关键定义处使用“中文（English）”，后文按建议形式使用。
- “待定”表示目前不应在全文强行统一，需结合用户偏好和学科习惯决定。

| English term | 初始建议 | 建议正文形式 | 首次出现形式 | 理由 | 备选/不建议 | 用户审阅 |
| --- | --- | --- | --- | --- | --- | --- |
| hardware-software co-design | 中文为主 | 软硬件协同 | 软硬件协同（Hardware-Software Co-design） | 报告主题核心，中文稳定、自然。 | 硬件软件协同 | 待确认 |
| agile chip design | 中文为主 | 敏捷芯片设计 | 敏捷芯片设计 | 与报告题目一致，强调快速形成、验证、映射和迭代硬件能力。 | 敏捷芯片开发 | 待确认 |
| architecture interface | 中文为主 | 架构接口 | 架构接口 | 已在第一章定义，覆盖 ISA、ISAX、存储/互连和运行时可见硬件能力。 | 体系结构接口 | 待确认 |
| compilation interface | 中文为主 | 编译接口 | 编译接口| 已定义为软件语义进入 IR、lowering、调度、代码生成和反馈的边界。 | 编译器接口 | 待确认 |
| compiler infrastructure | 中文为主 | 编译基础设施 | 编译基础设施（Compiler Infrastructure） | 比“编译器基础设施”更适合包含 IR、pass、证据、后端和运行时接口。 | 编译器基础设施 | 待确认 |
| agentic method | 中文为主 | 智能体方法 | 智能体（Agentic）方法 | “智能体式”不够稳定；当前报告与工业报告常用 agentic。 | 智能体式方法 | 待确认 |
| agent harness | 中文为主 | 智能体协作框架 | 智能体协作框架（Agent Harness） | harness 暂无稳定译法，且项目内有明确技术含义。 | 智能体框架、代理框架 | 待确认 |
| evidence memory | 中文为主 | 证据记忆 | 证据记忆（Evidence Memory） | 强调结构化 facts/events/artifacts，不是聊天历史。 | 经验库、记忆库 | 待确认 |
| target facts | 中文为主 | 目标事实 | 目标事实 | IntelliC/编译 harness 语境中的目标架构事实。 | 目标信息 | 待确认 |
| semantic contract | 中文为主 | 语义契约 | 语义契约（Semantic Contract） | 与 IR、pass、验证义务关联，中文较准确。 | 语义合同 | 待确认 |
| semantic boundary | 中文为主 | 语义边界 | 语义边界（semantic boundary） | Spine/未来工作核心概念。正文后续统一用“语义边界”。 | 语义界面 | 已采用 |
| typed artifact | 中文为主 | 类型化产物 | 类型化产物（typed artifact） | “artifact”在报告中应落到可解析、可重放对象。 | 类型化制品 | 待确认 |
| executable oracle | 中文为主 | 可执行判定基准 | 可执行判定基准（executable oracle） | 用户 2026-05-07 确认可接受“判定基准”；强调这是可执行检查基准，不写作“判定器”。 | 可执行基准、可执行判定器 | 已确认 |
| cross-layer check | 中文为主 | 跨层检查 | 跨层检查（Cross-Layer Check） | 表达清晰。 | 跨层校验 | 待确认 |
| trace | 保留英文 | trace | 执行 trace | trace 比“踪迹”自然，技术含义明确。 | 轨迹、踪迹 | 待确认 |
| TraceDB | 保留英文 | TraceDB | TraceDB | 专有系统对象，不翻译。 | 跟踪数据库 | 待确认 |
| action | 中文为主 | 编译器行为 | 编译器行为（Compiler Action） | Clay/IntelliC 中是系统对象；直接译为“动作”可能丢失专有含义。 | 动作 | 待确认 |
| fixed action | 中文为主 | 固化行为 | 固化行为（Fixed Action） | IntelliC 内部分类，不宜翻译成“固定动作”。 | 固定动作 | 待确认 |
| agent action | 中文为主 | 智能体行为 | 智能体行为（Agent Action） | IntelliC 内部分类，与 fixed action 对应。 | 智能体动作 | 待确认 |
| e-graph | 中文为主 | 等价图 | 等价图（e-graph） | 用户 2026-05-07 确认正文优先中文；首次出现可括注英文，后续普通叙述用“等价图”。 | e-graph 泛用 | 已确认 |
| equality saturation | 中文为主 | 等价饱和 | 等价饱和（equality saturation） | 用户 2026-05-11 纠正：使用“等价饱和”，不要使用“等式饱和”。 | 等式饱和 | 已确认 |
| EqSat | 中文为主 | 等价饱和 / EqSat | 等价饱和（EqSat） | EqSat 是 equality saturation 的常用简称；算法族或 EggMind 策略语境可保留 EqSat。 | 等式饱和 | 已确认 |
| EqSatL | 保留英文 | EqSatL | EqSatL | 用户 2026-05-07 明确指出 EqSatL 是 DSL 名称，不是等价饱和，必须保留英文。 | 等价饱和、等价饱和语言 | 已确认 |
| rewrite rule | 中文为主 | 重写规则 | 重写规则（rewrite rule） | 编译/形式化领域中文稳定。 | 改写规则 | 待确认 |
| ruleset | 保留英文/待定 | ruleset | ruleset（规则集） | EggMind 中 ruleset 是策略单位；“规则集”可读但可能弱化对象性。 | 规则集 | 待确认 |
| motif | 保留英文 | motif | motif | 用户 2026-05-07 确认保留英文；避免与 pattern/模式混淆。 | 模式、母题 | 已确认 |
| proof-derived motif | 保留英文 | proof-derived motif | proof-derived motif | EggMind 专有机制，保留英文便于对应论文；正文中文结构中可写“证明派生 motif 记忆”。 | 证明派生模式 | 已确认 |
| tractability guidance | 中文为主 | 可处理性引导 | 可处理性引导 | 比“可 tractable 指导”更适合中文报告。 | 可解性指导、可控性引导 | 待确认 |
| simplification hint | 中文为主 | 简化提示 | 简化提示 | EggMind 机制，中文自然。 | 简化线索 | 待确认 |
| phase | 中文为主 | 阶段 | 阶段（phase） | 一般语境可翻译；EggMind/RIMT 可首次括注。 | 相位 | 待确认 |
| anti-unification | 中文为主 | 反合一 | 反合一（anti-unification） | “反合一”对应程序综合和归纳泛化语境，首次出现保留英文。 | 反统一 | 待确认 |
| e-class | 中文为主 | 等价类 | 等价类（e-class） | e-graph 数据结构对象，保留英文。 | 等价类 | 待确认 |
| e-node | 中文为主 | 等价节点 | 等价节点（e-node） | e-graph 数据结构对象，保留英文。 | 等价节点 | 待确认 |
| mapping e-node | 保留英文 | mapping e-node | mapping e-node | SkyEgg 专有对象，保留英文清晰。 | 映射等价节点 | 待确认 |
| extraction | 中文为主 | 提取 | 提取（extraction） | e-graph 领域常用英文；中文“抽取”可首次解释。 | 提取 | 待确认 |
| custom instruction | 中文为主 | 定制指令 | 定制指令（custom instruction） | ASIP/ISAX 语境稳定。 | 定制指令 | 待确认 |
| custom instruction extension / ISAX | 中文为主 | 定制指令扩展 | 定制指令拓展（ISAX, Custom Instruction Extension ） | ISAX 是论文常用对象，正文可交替使用。 | 指令集扩展 | 待确认 |
| ASIP | 中文为主 | 应用专用指令集处理器 | 应用专用指令集处理器（ASIP，Application-Specific Instruction-Set Processor） | 首次中文展开，后文用 ASIP。 | 专用指令集处理器 | 待确认 |
| CADL | 保留英文 | CADL | CADL | APS/Clay 中具体语言名，不翻译；必要时区分 Clay ADL。 | - | 待确认 |
| Clay ADL | 保留英文 | Clay ADL / CADL | Clay Architecture Description Language（CADL） | Clay 原文使用 CADL，需避免与 APS CADL 混淆。 | Clay 架构描述语言 | 待确认 |
| coupling strategy | 中文为主 | 耦合策略 | 耦合策略（coupling strategy） | Clay 核心概念，中文自然。 | 连接策略 | 待确认 |
| in-pipeline coupling | 双语固定搭配 | 流水线内耦合 | 流水线内耦合（in-pipeline coupling） | Clay 原文关键分类。 | 管线内耦合 | 待确认 |
| coprocessor coupling | 双语固定搭配 | 协处理器耦合 | 协处理器耦合（coprocessor coupling） | Clay 原文关键分类。 | 协处理器连接 | 待确认 |
| microarchitecture-aware | 中文为主 | 微架构感知 | 微架构感知（microarchitecture-aware） | 已在正文使用，准确。 | 微体系结构感知 | 待确认 |
| microarchitectural attribute | 中文为主 | 微架构属性 | 微架构属性（microarchitectural attribute） | Clay 核心对象。 | 微体系结构属性 | 待确认 |
| action | 中文为主 | 接口原语 | 接口原语 | Clay interface 中 action 是接口原语；建议保留英文。 | 操作、动作 | 待确认 |
| protocol signal / IR operation names | 保留英文 | `commit`/`recall`、`issue`/`wait`、`transfer`/`fetch` 等 | `commit`/`recall` 等 | 用户 2026-05-07 确认 APS/Aquas 协议信号和 IR 操作作为代码级接口名保留英文。 | 提交/撤回、发射/等待等全文硬译 | 已确认 |
| request-response | 双语固定搭配 | 请求-响应 | 请求-响应（request-response）机制 | Clay/接口语境自然。 | 请求应答 | 待确认 |
| HIR / LIR / RuleIR | 保留英文 | HIR / LIR / RuleIR | HIR / LIR / RuleIR | Clay 中间表示名，不翻译。 | 高层 IR / 低层 IR（不作为主用词） | 待确认 |
| finite-state machine / FSM | 中文为主 | 有限状态机 / FSM | 有限状态机（FSM） | 中文稳定，后文可用 FSM。 | 状态机 | 待确认 |
| modulo scheduling | 保留英文/双语 | modulo scheduling | modulo scheduling（模调度） | 编译术语，中文“模调度”可辅助。 | 模数调度 | 待确认 |
| initiation interval / II | 双语固定搭配 | 启动间隔 / II | 启动间隔（initiation interval, II） | HLS/流水调度常用。 | 初始间隔 | 待确认 |
| latency-insensitive | 中文为主 | 延迟不敏感 | 延迟不敏感（latency-insensitive） | 硬件协议常用中文。 | 时延不敏感 | 待确认 |
| high-level synthesis / HLS | 中文为主 | 高层次综合 / HLS | 高层次综合（high-level synthesis, HLS） | 中文稳定，后文可用 HLS。 | 高级综合 | 待确认 |
| hardware frontend | 中文为主 | 硬件前端 | 硬件前端（hardware frontend） | 第三章主题。 | 硬件前端语言 | 待确认 |
| cycle-deterministic | 中文为主 | 周期确定型 | 周期确定型（cycle-deterministic） | Cement 核心术语。 | 周期确定性 | 待确认 |
| event layer | 中文为主 | 时间层 |事件层 （event layer） | Cement 专有层名，建议保留英文并解释。 | 事件层 | 待确认 |
| control sub-language / ctrl | 双语固定搭配 | 控制子语言 | 控制子语言（control sub-language） | Cement 原文对象。 | 控制子语言 | 待确认 |
| timing analysis | 中文为主 | 周期分析 | 周期分析（timing analysis） | 中文稳定。 | 时间分析 | 待确认 |
| dynamic monitor / monitoring | 中文为主 | 动态监测 | 动态监测（dynamic monitoring） | Cement 机制。 | 动态监听 | 待确认 |
| state tree representation | 中文为主 | 状态树表示 | 状态树表示（state tree representation） | Cement FSM synthesis。 | 状态树表达 | 待确认 |
| processor-accelerator interface | 中文为主 | 处理器-加速器接口 | 处理器-加速器接口（processor-accelerator interface） | Cayman/Clay 语境。 | 处理器加速器接口 | 待确认 |
| whole-application program structure tree / wPST | 中文为主 | 全应用程序结构树 | 全应用程序结构树（whole-application program structure tree, wPST） | Cayman 核心表示，首次中文展开。 | 整程序结构树 | 待确认 |
| single-entry-single-exit / SESE | 双语固定搭配 | 单入口单出口 / SESE | 单入口单出口（single-entry-single-exit, SESE） | 编译控制流术语。 | 单进单出 | 待确认 |
| candidate selection | 中文为主 | 候选选择 | 候选选择（candidate selection） | Cayman。 | 候选项选择 | 待确认 |
| accelerator merging | 中文为主 | 加速器合并 | 加速器合并（accelerator merging） | Cayman。 | 加速器融合 | 待确认 |
| reconfigurable datapath | 中文为主 | 可重构数据通路 | 可重构数据通路（reconfigurable datapath） | Cayman。 | 可配置数据路径 | 待确认 |
| profiling | 中文为主 | 性能剖析 | 性能剖析（profiling） | 用户反馈要求中英文使用更严格，正文中普通术语应中文优先；必要时首次括注英文。 | profiling 单独使用、性能画像 | 已采用 |
| benchmark | 中文为主 | 基准测试 | 基准测试 | 正文普通叙述使用中文，框架、数据集或图表专名可保留英文。 | benchmark 泛用 | 待确认 |
| workload | 中文为主 | 工作负载 | 工作负载（workload） | 中文“工作负载”自然；是否全译待定。 | 工作负载 | 待确认 |
| runtime | 保留中文 | 运行时 | 运行时（runtime） | “运行时”中文自然，但框架名/系统层常保留英文。 | 运行时系统 | 待确认 |
| graph break | 保留英文 | graph break | graph break | PyTorch/Dynamo 专有术语，建议保留。 | 图断裂 | 待确认 |
| backend | 中文为主 | 后端 | 后端 | 编译器后端可译，系统组件可保留。 | 后端 | 待确认 |
| intrinsic | 中文为主 | 源语 | 源语（intrinsic） | 用户 2026-05-07 确认 intrinsic 可写为“源语”。 | 内建函数、intrinsic 泛用 | 已确认 |

## 待用户重点决策

1. `agentic` 是否统一保留英文，还是改为“智能体式”。
2. `action` 在 Clay/IntelliC 中是否保留英文，还是译为“动作”。
3. `ruleset`、`extraction` 是否保留英文；`motif` 已确认保留英文。
4. `profiling`、`benchmark`、`workload` 是否在正文中保留英文。
5. `in-pipeline coupling` 是否译为“流水线内耦合”还是“管线内耦合”。
