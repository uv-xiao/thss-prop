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
| hardware-software co-design | 软硬件协同 | 软硬件协同（hardware-software co-design） | 报告主题与 APS/Aquas 等已有工作 | 与用户确定的报告主题一致，强调硬件设计、编译器、软件生态、系统软件边界和目标执行环境之间的共同设计。 | 软硬协同、硬件软件协同 |
| agile chip design | 敏捷芯片设计 | 敏捷芯片设计（agile chip design） | 报告主题、APS 论文标题 | 强调芯片设计迭代速度、可复用工具链和生产力，不等同于单纯快速寄存器传输级代码生成。 | 敏捷芯片开发 |
| innovative compilation techniques | 创新性编译技术 | 创新性编译技术（innovative compilation techniques） | 用户确定的报告主题 | 覆盖可重定向编译、等价图、MLIR、多层中间表示、编译检查记录与智能体编译基础设施。 | 创新编译技术 |
| AI / artificial intelligence | 人工智能 | 人工智能（AI） | 本报告产业背景与应用压力 | 中文正文优先写“人工智能”；只有首次出现或英文摘要、专名语境保留 AI。 | AI 裸用 |
| LLM / large language model | 大语言模型 | 大语言模型（LLM） | 本报告产业背景、智能体方法和 EggMind/OriGen 章节 | 中文正文优先写“大语言模型”；LLM 只在首次括注、英文摘要、系统名或标题原文中保留。 | LLM 裸用、大模型（正式正文中少用） |
| intermediate representation / IR | 中间表示 | 中间表示（intermediate representation, IR） | LLVM/MLIR/Aquas-IR/硬件中间表示章节 | 普通叙述使用“中间表示”；系统名如 Aquas-IR、RapidStream IR 可保留英文缩写。 | IR 裸用 |
| RTL | 寄存器传输级设计 / 寄存器传输级代码 | 寄存器传输级设计（RTL） | 硬件生成、OriGen、Clay、仿真语境 | 普通叙述按上下文写“寄存器传输级设计/代码/生成/仿真”；表格、源码、英文摘要和首次括注可保留 RTL。 | RTL 裸用 |
| HLS | 高层综合 | 高层综合（HLS） | Cement/Clay/SkyEgg/FPGA 章节 | 普通叙述使用“高层综合”；Vitis HLS 等工具名和源文表格可保留 HLS。 | HLS 裸用 |
| DSL | 领域专用语言 / 领域语言 | 领域专用语言（DSL） | ISAMORE/EqSatL/硬件语言章节 | 普通叙述使用“领域专用语言”或“领域语言”；EqSatL 等专有语言名不翻译。 | DSL 裸用 |
| compiler pass / pass | 编译遍 / 编译过程 | 编译遍（compiler pass） | LLVM/MLIR/编译优化章节 | 普通优化单元写“编译遍”；当强调流程组合时可写“编译过程”。 | pass 裸用 |
| API | 接口 | 接口（API） | 系统软件或工具接口语境 | 中文正文优先写“接口”；仅在专有英文名称、代码或应用二进制接口对比中保留 API。 | API 裸用 |
| ABI | 应用二进制接口 | 应用二进制接口（ABI） | 系统边界、mailbox/blob、目标执行环境语境 | 中文正文优先写全称，避免读者误解为普通函数接口。 | ABI 裸用 |
| architecture interface | 架构接口 | 架构接口（architecture interface） | `report/main.typ` Chapter 1.3, APS/Aquas framing | 指硬件能力对软件和工具链暴露的边界，包括 ISA/ISAX、微架构机制、存储层次、互连、执行模型和软件可见资源。 | 体系结构接口（过长且不如“架构接口”稳定） |
| compilation interface / compiler interface | 编译接口 | 编译接口（compilation interface） | `report/main.typ` Chapter 1.3, `resources/compiler-infra-is-harness-medium.md` | 指软件语义进入中间表示、降低、重写、调度、代码生成、系统软件接口和性能剖析记录的边界。 | 编译器接口（容易误解为 API 层面） |
| agentic method | 智能体方法 | 智能体（agentic）方法 | Chapter 1 agentic trend discussion, `docs/writing/terminology-decisions.md` | 正文以中文为主，首次出现保留 agentic 以对应工业报告和英文论文语境。 | 智能体式方法 |
| structured record / experience record | 结构化记录 / 经验记录 | 经验记录（experience record） | IntelliC / compiler harness discussion; user correction 2026-05-12 | 正文避免“证据记忆”“证据闭环”“运行时反馈”。按语境写结构化记录、经验记录、执行记录、检查记录或性能剖析记录，用来表示智能体能力提升所需的可追踪材料。 | 证据记忆、证据闭环、运行时反馈 |
| e-graph | 等价图 | 等价图（e-graph） | ISAMORE, SkyEgg, EggMind; user confirmed 2026-05-07 | 正文以中文为主，首次出现保留英文以对应数据结构，后文普通叙述使用“等价图”。 | e-graph 泛用、等价图（不括注的首次出现） |
| equality saturation / EqSat | 等价饱和 / EqSat | 等价饱和（equality saturation, EqSat） | ISAMORE, EggMind; user corrected 2026-05-11 | 概念层面使用“等价饱和”；EggMind 策略和算法族语境可保留 EqSat。 | 等式饱和 |
| EqSatL | EqSatL | EqSatL | EggMind; user confirmed 2026-05-07 | 专有 DSL 名称，不翻译；不能写作“等价饱和”。 | 等价饱和语言 |
| motif | motif | motif | EggMind; user confirmed 2026-05-07 | EggMind 核心术语，保留英文以避免与 pattern/模式混淆。 | 模式、母题、证明派生模式 |
| rewrite rule | 重写规则 | 重写规则（rewrite rule） | e-graph / EqSat sections | 编译和形式化领域中文稳定。 | 改写规则 |
| anti-unification | 反合一 | 反合一（anti-unification） | ISAMORE reusable custom instruction discovery | 与程序综合和归纳泛化语境对应。 | 反统一 |
| extraction | 提取 | 提取（extraction） | e-graph extraction and SkyEgg scheduling formulation | 正文以中文为主，首次出现保留英文对应等价图术语。 | 抽取（不作为主用词） |
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
| profiling | 性能剖析 | 性能剖析（profiling） | 执行系统/编译优化章节 | 用户要求中英文使用更严格；正文中文优先，必要处首次括注英文。 | profiling 单独使用、性能画像 |
| runtime | 运行时 / 执行系统 | 运行时（runtime，仅在框架名或源文语境中使用） | PyTorch/TensorRT-LLM/PTO Runtime 等框架语境 | 正文不再把“运行时”作为报告级结构概念；普通论述优先用“系统软件边界”“目标执行环境”“执行系统”“性能剖析与执行轨迹”。 | 运行时协同、运行时反馈 |
| feedback | 结果 / 记录 / 评价信号 | 评价结果（feedback，仅必要时括注） | 大语言模型、工具检查、性能剖析和智能体方法语境 | 正文避免泛用“反馈”。按上下文写“编译错误信息”“测试结果”“执行结果”“执行轨迹”“评价信号”“性能剖析记录”。 | feedback 裸用、运行时反馈、验证反馈 |
| kernel | 内核 / 计算内核 | 计算内核（kernel） | 评估、执行系统和编译优化章节 | 普通技术对象在正文中中文优先；框架 API 或文件名中保留英文。 | kernel 单独泛用 |
| speedup | 加速比 | 加速比（speedup） | Evaluation sections | 中文稳定，便于开题报告叙事。 | 加速率 |
| area overhead | 面积开销 | 面积开销（area overhead） | ASIP/accelerator evaluation sections | 与 PPA 语境匹配。 | 面积负担 |
| cost model | 代价模型 | 代价模型（cost model） | Compiler/e-graph optimization sections | 编译优化常用译法。 | 成本模型 |
| cache effect | 缓存效应 | 缓存效应（cache effect） | Aquas / memory-centric ISAX sections | 中文自然，可对应存储层次影响。 | cache 影响 |
| offloading | 卸载 | 卸载（offloading） | ASIP/ISAX compiler sections | 指编译器把区域或操作交给定制硬件执行。 | 下放、外包 |
| matching / matcher | 匹配 / 匹配器 | 匹配器（matcher） | Compiler and SkyEgg mapping-rule sections | 普通行为译为“匹配”；系统对象可首次括注英文。 | matching 单独泛用 |
| intrinsic | 源语 | 源语（intrinsic） | APS compiler support; user confirmed 2026-05-07 | 编译器插入或程序员手写的 intrinsic 用“源语”表达，必要时首次括注英文。 | 内建函数、intrinsic 泛用 |
| commit/recall, issue/response, issue/wait, transfer/fetch, tag, size, memory/config | 保留英文信号名/操作名 | `commit`/`recall` 等代码体或源文形式 | APS/Aquas protocol and IR operations; user confirmed 2026-05-07 | 这些是协议信号、IR 操作或固定接口名，不按普通英文词组翻译。 | 提交/撤回、发射/等待等全文硬译 |
| executable oracle / oracle | 可执行判定基准 / 验证判定基准 | 可执行判定基准（executable oracle） | Spine/future validation workflow; user confirmed 2026-05-07 | “判定基准”强调可执行检查基准，不写作“判定器”；后文可按语境用“验证判定基准”。 | 可执行基准、验证判定器、oracle 泛用 |
| applier | 应用器 | 应用器（applier） | SkyEgg mapping-rule sections | 与 e-graph rewrite rule 结构对应。 | 施加器 |
| condition | 条件 | 条件（condition） | Mapping-rule sections | 普通术语中文化。 | condition 单独泛用 |
| event layer | 事件层 | 事件层（event layer） | Cement | 用户审阅表已倾向中文；正文中文优先。 | 时间层 |
| guard | 守卫条件 | 守卫条件（guard） | Cement event semantics | 硬件/编译语义中常用译法。 | 保护条件 |
| cycle sequence | 周期序列 | 周期序列（cycle sequence） | Cement timing analysis | 准确表达跨周期事件顺序。 | 循环序列 |
| procedural statement | 过程式语句 | 过程式语句（procedural statement） | Cement control sub-language | 与源文 procedural control 对应。 | 程序式语句 |
| static analysis | 静态分析 | 静态分析（static analysis） | Cement timing analysis | 中文稳定。 | 静态检查（范围略窄） |
| dynamic monitoring | 动态监测 | 动态监测（dynamic monitoring） | Cement timing analysis | 已在术语决策表使用。 | 动态监听 |
| timing violation | 时序违规 | 时序违规（timing violation） | Cement timing analysis | 硬件验证语境常用。 | 时序违例 |
| hardware primitive | 硬件原语 | 硬件原语（hardware primitive） | SkyEgg mapping model | 中文自然，保留对象性。 | 硬件基元 |
| parameterized IP core | 参数化 IP 核 | 参数化 IP 核（parameterized IP core） | SkyEgg mapping model | IP core 可保留英文缩写，整体中文化。 | 参数化 IP 内核 |
| preset | 预设配置 | 预设配置（preset） | SkyEgg IP configuration | 避免英文泛用。 | preset 单独使用 |
| mapping-configuration pair | 映射-配置对 | 映射-配置对（mapping-configuration pair） | SkyEgg | 准确表达联合对象。 | 映射配置对 |
| top-k path delays | 前 k 条路径延迟 | 前 k 条路径延迟（top-k path delays） | SkyEgg scheduler | 保留 k 的数学含义，正文中文优先。 | top-k 路径延迟 |
| workflow | 工作流 | 工作流（workflow） | System/method sections | 中文自然。 | workflow 单独泛用 |
