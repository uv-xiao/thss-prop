# Terminology Table

This table is a writing aid. It must not be inserted into the report unless explicitly requested.

| English term | Chinese term | First-use form | Source/context | Rationale | Rejected translations |
| --- | --- | --- | --- | --- | --- |
| thesis proposal / topic report | 开题报告 / 选题报告 | 开题报告（或称“选题报告”） | 清华科学技术史专业《学位论文选题报告要求》 | 用户语境使用“开题报告”，制度文件同时称“选题报告”。 | 题目报告 |
| research question | 研究问题 | 研究问题（research question） | 清华科学技术史专业《学位论文选题报告要求》使用 question 解释问题。 | 首次出现可保留英文以强调不是一般主题。 | 研究课题 |
| methodology | 方法论 | 方法论（methodology） | 清华科学技术史专业《学位论文选题报告要求》 | 区分具体方法和研究立场。 | 方法 |
| argument | 论点 | 论点（argument） | 清华科学技术史专业《学位论文选题报告要求》 | 用于表示论文要证明或推进的主张。 | 参数 |
| primary sources | 一手史料 | 一手史料（primary sources） | 清华科学技术史专业《学位论文选题报告要求》 | 保持学术史语境。 | 主要来源 |
| secondary literature | 二手研究文献 | 二手研究文献（secondary literature） | 清华科学技术史专业《学位论文选题报告要求》 | 保持制度文件译法。 | 二级文献 |
| agent harness | 智能体协作框架 | 智能体协作框架（agent harness） | 本项目 `.agents` 机制、`docs/writing/terminology-decisions.md` | “harness”暂无稳定中文译名，但正文以中文为主，首次出现保留英文对应。 | 代理框架、智能体框架 |
| bibliography | 参考文献 / 文献目录 | 参考文献 | 清华写作指南、Typst/BibTeX 语境 | 报告正文使用“参考文献”，审计文档可用“bibliography”。 | 书目 |
| citation key | 引用键 | 引用键（citation key） | BibTeX/Typst 工作流 | 技术配置中需要区分文献条目和正文引用。 | 引文键 |
| hardware-software co-design | 软硬件协同 | 软硬件协同（hardware-software co-design） | 报告主题与 APS/Aquas 等已有工作 | 与用户确定的报告主题一致，强调硬件设计、编译器、软件生态、运行时之间的共同设计。 | 软硬协同、硬件软件协同 |
| agile chip design | 敏捷芯片设计 | 敏捷芯片设计（agile chip design） | 报告主题、APS 论文标题 | 强调芯片设计迭代速度、可复用工具链和生产力，不等同于单纯快速 RTL 生成。 | 敏捷芯片开发 |
| innovative compilation techniques | 创新性编译技术 | 创新性编译技术（innovative compilation techniques） | 用户确定的报告主题 | 覆盖可重定向编译、e-graph、MLIR、多层 IR、编译证据与 agentic 编译基础设施。 | 创新编译技术 |
| architecture interface | 架构接口 | 架构接口（architecture interface） | `report/main.typ` Chapter 1.3, APS/Aquas framing | 指硬件能力对软件和工具链暴露的边界，包括 ISA/ISAX、微架构机制、存储层次、互连、执行模型和运行时可见资源。 | 体系结构接口（过长且不如“架构接口”稳定） |
| compilation interface / compiler interface | 编译接口 | 编译接口（compilation interface） | `report/main.typ` Chapter 1.3, `resources/compiler-infra-is-harness-medium.md` | 指软件语义进入 IR、lowering、rewrite、调度、代码生成、runtime API 和 profiling feedback 的边界。 | 编译器接口（容易误解为 API 层面） |
| agentic method | 智能体方法 | 智能体（agentic）方法 | Chapter 1 agentic trend discussion, `docs/writing/terminology-decisions.md` | 正文以中文为主，首次出现保留 agentic 以对应工业报告和英文论文语境。 | 智能体式方法 |
| evidence memory | 证据记忆 | 证据记忆（evidence memory） | IntelliC / compiler harness discussion | 指为后续编译或 agent action 保留的结构化事实、诊断、obligation、artifact 和运行反馈，不是自然语言聊天记忆。 | 记忆库、经验库 |
| e-graph | 等价图 | 等价图（e-graph） | ISAMORE, SkyEgg, EggMind | 正文以中文为主，首次出现保留英文以对应数据结构。 | 等价图（单独使用时可能弱化 e-graph 专有结构） |
| equality saturation / EqSat | 等式饱和 | 等式饱和（equality saturation） | ISAMORE, EggMind | 形式化优化常用概念，后文可用 EqSat 指策略对象或算法族。 | 等价饱和 |
| rewrite rule | 重写规则 | 重写规则（rewrite rule） | e-graph / EqSat sections | 编译和形式化领域中文稳定。 | 改写规则 |
| anti-unification | 反合一 | 反合一（anti-unification） | ISAMORE reusable custom instruction discovery | 与程序综合和归纳泛化语境对应。 | 反统一 |
| extraction | 提取 | 提取（extraction） | e-graph extraction and SkyEgg scheduling formulation | 正文以中文为主，首次出现保留英文对应等价图术语。 | 抽取（可解释但不作为主用词） |
| custom instruction | 定制指令 | 定制指令（custom instruction） | ASIP / ISAX / Clay sections | ASIP 语境自然，区别于一般 ISA extension。 | 自定义指令（可口语化，源文直译时谨慎使用） |
| custom instruction extension / ISAX | 定制指令扩展 | 定制指令扩展（custom instruction extension, ISAX） | APS/Aquas/ISAMORE/Clay | 首次双语，后文按语境使用“定制指令扩展”或 ISAX。 | 指令集扩展（范围更宽） |
| ASIP | 应用专用指令集处理器 | 应用专用指令集处理器（ASIP，Application-Specific Instruction-Set Processor） | Clay and ASIP sections | 首次中文展开，后文可用 ASIP。 | 专用指令集处理器 |
| action | 接口原语 / 编译器行为 | 接口原语（Clay 语境）/ 编译器行为（IntelliC 语境） | Clay unified interface; IntelliC action model | 不同系统中的 action 对象含义不同。Clay 中指处理器交互接口原语；IntelliC 中指编译器行为对象。 | 动作 |
| coupling strategy | 耦合策略 | 耦合策略（coupling strategy） | Clay | Clay 核心概念，中文自然。 | 连接策略 |
| in-pipeline coupling | 流水线内耦合 | 流水线内耦合（in-pipeline coupling） | Clay | Clay 关键耦合类型。 | 管线内耦合 |
| coprocessor coupling | 协处理器耦合 | 协处理器耦合（coprocessor coupling） | Clay | Clay 关键耦合类型。 | 协处理器连接 |
| microarchitectural attribute | 微架构属性 | 微架构属性（microarchitectural attribute） | Clay | Clay 统一接口中的约束对象。 | 微体系结构属性 |
| initiation interval / II | 启动间隔 / II | 启动间隔（initiation interval, II） | Clay and HLS scheduling | HLS/流水调度常用。 | 初始间隔 |
| workload | 工作负载 | 工作负载（workload） | Evaluation sections | 中文自然，首次可保留英文。 | workload（正文中过多英文会破坏流畅性） |
| benchmark | 基准测试 | 基准测试（benchmark） | Evaluation sections | 中文自然。 | benchmark（仅在专名或图表中保留） |
| profiling | profiling | profiling（性能剖析） | Runtime/compiler optimization sections | 暂保留英文以对应工具链实践，首次用中文解释。 | 性能画像 |
| runtime | 运行时 | 运行时（runtime） | Compilation-to-runtime sections | 中文自然，框架名可保留英文。 | 运行时系统（范围略宽） |
