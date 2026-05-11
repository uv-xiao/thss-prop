# 术语待确认：引用位置与英文保留检查

生成时间：2026-05-07

本文件记录本轮全文英文扫描中不适合擅自统一翻译的术语。已确定的普通英文词组已在正文中改为中文或中文优先表达；下列项目需要作者确认后再进入 `docs/writing/terminology.md` 或 `docs/writing/terminology-decisions.md`。

| 英文/缩写 | 当前正文处理 | 建议选项 | 需要确认的问题 |
| --- | --- | --- | --- |
| oracle / executable oracle | 已暂改为“验证判定基准”“可执行判定基准” | 1. 可执行判定基准；2. 可执行基准；3. 验证判定器；4. 首次写“可执行判定基准（oracle）” | 已确认：接受“判定基准”，进入正式术语表。 |
| motif / motifs | 当前保留 `motif`，并用“证明派生 motif 记忆” | 1. 保留 motif；2. 译为“重写模式”；3. 译为“证明派生模式”；4. 首次写“重写交互模式（motif）” | 已确认：保留英文 `motif`。 |
| tag chain | 当前保留 `tag chain` | 1. 标签链；2. 语义标签链；3. 保留 tag chain | 是否可统一为“语义标签链”？ |
| e-graph / EqSat / EqSatL | 当前大量保留英文，局部用“等价图”“等价饱和” | 1. 标题和普通叙述优先中文；2. 方法名/框架名保留英文；3. 首次双写，后续中文 | 已确认：支持正文优先中文；EqSatL 是 DSL 名称，必须保留英文。 |
| intrinsic | 当前保留 `intrinsic`，用“类似 intrinsic 的 C 包装函数”“手写 intrinsic” | 1. 保留 intrinsic；2. 译为“内建函数”；3. 写“类似内建函数的 C 包装函数（intrinsic-like wrapper）” | 已确认：写作“源语”。 |
| commit/recall、issue/response、tag、size、issue/wait、transfer、fetch | 当前作为协议信号/IR 操作保留英文或代码体 | 1. 全部保留英文信号名；2. 中文解释 + 英文代码体；3. 翻译为提交/撤回、发射/响应等 | 已确认：作为代码级接口名保留英文。 |
| memory/config | 当前保留 `memory/config` | 1. 保留；2. 译为“内存/配置操作”；3. 写“辅助内存/配置操作（memory/config）” | APS 源文是否将其作为固定操作名？ |
| SIMD-like / vector unit | 已改为“类 SIMD”“向量单元” | 1. 类 SIMD；2. 类向量化；3. 保留 SIMD-like | “类 SIMD 指令”是否符合你的术语偏好？ |
| modulo scheduling | 已改为“模调度” | 1. 模调度；2. 取模调度；3. 首次写“模调度（modulo scheduling）” | Clay 章节是否接受“模调度”？ |
| shuffler | 当前保留 `shuffler` | 1. 保留 shuffler；2. 译为“混洗器”；3. 首次写“混洗器（shuffler）” | Cement 图注和正文是否保留源文模块名？ |
| scratchpad / scratchpad memory | 当前正文使用“暂存存储”“暂存接口”“暂存缓冲” | 1. 统一为“暂存存储”；2. 统一为“片上暂存存储”；3. interface 场景用“暂存接口” | 是否需要区分 memory、interface、buffer 三个层次？ |
| compiler pass | 当前使用“编译遍” | 1. 编译遍；2. 编译器遍；3. 编译过程/变换过程，按语境改写 | 是否确认“编译遍”为本文固定译法？ |
