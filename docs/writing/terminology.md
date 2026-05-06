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
| agent harness | agent harness / 智能体协作框架 | agent harness（智能体协作框架） | 本项目 `.agents` 机制 | “harness”暂无稳定中文译名，首次出现保留英文。 | 代理框架 |
| bibliography | 参考文献 / 文献目录 | 参考文献 | 清华写作指南、Typst/BibTeX 语境 | 报告正文使用“参考文献”，审计文档可用“bibliography”。 | 书目 |
| citation key | 引用键 | 引用键（citation key） | BibTeX/Typst 工作流 | 技术配置中需要区分文献条目和正文引用。 | 引文键 |
| hardware-software co-design | 软硬件协同 | 软硬件协同（hardware-software co-design） | 报告主题与 APS/Aquas 等已有工作 | 与用户确定的报告主题一致，强调硬件设计、编译器、软件生态、运行时之间的共同设计。 | 软硬协同、硬件软件协同 |
| agile chip design | 敏捷芯片设计 | 敏捷芯片设计（agile chip design） | 报告主题、APS 论文标题 | 强调芯片设计迭代速度、可复用工具链和生产力，不等同于单纯快速 RTL 生成。 | 敏捷芯片开发 |
| innovative compilation techniques | 创新性编译技术 | 创新性编译技术（innovative compilation techniques） | 用户确定的报告主题 | 覆盖可重定向编译、e-graph、MLIR、多层 IR、编译证据与 agentic 编译基础设施。 | 创新编译技术 |
| architecture interface | 架构接口 | 架构接口（architecture interface） | `report/main.typ` Chapter 1.3, APS/Aquas framing | 指硬件能力对软件和工具链暴露的边界，包括 ISA/ISAX、微架构机制、存储层次、互连、执行模型和运行时可见资源。 | 体系结构接口（过长且不如“架构接口”稳定） |
| compilation interface / compiler interface | 编译接口 | 编译接口（compilation interface） | `report/main.typ` Chapter 1.3, `resources/compiler-infra-is-harness-medium.md` | 指软件语义进入 IR、lowering、rewrite、调度、代码生成、runtime API 和 profiling feedback 的边界。 | 编译器接口（容易误解为 API 层面） |
| agentic method | agentic 方法 | agentic 方法 | Chapter 1 agentic trend discussion | “agentic”暂无稳定中文译名，报告中保留英文形容词，强调具备工具调用、反馈迭代和行动边界的智能体式方法。 | 智能体式方法（可解释但略口语化） |
| evidence memory | 证据记忆 | 证据记忆（evidence memory） | IntelliC / compiler harness discussion | 指为后续编译或 agent action 保留的结构化事实、诊断、obligation、artifact 和运行反馈，不是自然语言聊天记忆。 | 记忆库、经验库 |
