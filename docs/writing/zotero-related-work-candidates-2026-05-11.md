# Zotero Related-Work Mining, 2026-05-11

本文件记录本轮从 `/Users/uvxiao/Zotero` 中补充相关工作的方式和结果。Zotero 本体未被修改；读取采用 `file:/Users/uvxiao/Zotero/zotero.sqlite?immutable=1&mode=ro`，避免与正在运行的 Zotero 写入锁冲突。

## Zotero 存储格式解析

- 元数据数据库：`/Users/uvxiao/Zotero/zotero.sqlite`。主要表包括 `items`、`itemData`、`itemDataValues`、`fields`、`itemCreators`、`creators`、`collections`、`collectionItems`、`tags`、`itemTags`、`itemAttachments`。
- 条目字段：`itemData.fieldID` 通过 `fields.fieldName` 映射到 `title`、`abstractNote`、`DOI`、`url`、`date`、`publicationTitle`、`conferenceName`、`proceedingsTitle` 等字段；实际值保存在 `itemDataValues.value`。
- 作者字段：`itemCreators` 按 `orderIndex` 连接 `creators`。
- 附件路径：PDF 附件在 `itemAttachments` 中作为 attachment item；当 `path` 形如 `storage:<filename>` 时，真实路径为 `/Users/uvxiao/Zotero/storage/<attachment item key>/<filename>`。
- 本轮候选池：先按集合名、标签、题名、摘要和字段关键词筛选，共得到 250 个候选；再优先选择有本地 PDF、与 Chapter 1.4 四类综述直接相关、且能补当前逻辑缺口的条目。

## 本轮提升到正文的条目

- `tensorright2025` / Zotero `M7B3YRUN`：TensorRight: Automated Verification of Tensor Graph Rewrites。类别：编译优化/验证。用途：张量图重写需要任意 rank/size 语义验证，支持“编译优化必须可验证”的论点。 PDF：`/Users/uvxiao/Zotero/storage/JWTGUV99/Arora et al. - 2025 - TensorRight Automated Verification of Tensor Graph Rewrites.pdf`。
- `eqsatdialect2025` / Zotero `8DMRU5VJ`：eqsat: An Equality Saturation Dialect for Non-destructive Rewriting。类别：编译优化/等价饱和。用途：把等价图状态原生表示为 MLIR 方言，支持“等价饱和进入编译器基础设施”的论点。 PDF：`/Users/uvxiao/Zotero/storage/54S54VWP/Merckx et al. - 2025 - eqsat An Equality Saturation Dialect for Non-destructive Rewriting.pdf`。
- `dialegg2025` / Zotero `3THH7HTR`：DialEgg: Dialect-Agnostic MLIR Optimizer using Equality Saturation with Egglog。类别：编译优化/等价饱和。用途：将 Egglog 与 MLIR 连接，并保持方言无关性，支持“生产编译器与等价饱和结合”的论点。 PDF：`/Users/uvxiao/Zotero/storage/7SLHZCUC/Zayed and Dubach - 2025 - DialEgg Dialect-Agnostic MLIR Optimizer using Equality Saturation with Egglog.pdf`。
- `abstractiongap2025` / Zotero `KP5BLKK3`：Mind the Abstraction Gap: Bringing Equality Saturation to Real-World ML Compilers。类别：编译优化/ML 编译器。用途：指出局部图重写会影响布局、并行、调度和内存管理，支撑“目标事实约束编译优化”。 PDF：`/Users/uvxiao/Zotero/storage/5DDTASL9/Vohra et al. - 2025 - Mind the Abstraction Gap Bringing Equality Saturation to Real-World ML Compilers.pdf`。
- `trinity2026` / Zotero `5WS2WGNP`：Trinity: Three-Dimensional Tensor Program Optimization via Tile-level Equality Saturation。类别：编译优化/张量程序。用途：用 tile 级等价饱和联合优化代数等价、内存 I/O 和计算组织。 PDF：`/Users/uvxiao/Zotero/storage/X73VUTT9/Park et al. - 2026 - Trinity Three-Dimensional Tensor Program Optimization via Tile-level Equality Saturation.pdf`。
- `allo2024` / Zotero `5VB2X4HV`：Allo: A Programming Model for Composable Accelerator Design。类别：硬件实现/DSL。用途：用可组合源语分离算法和硬件定制，补充硬件 DSL/加速器设计综述。 PDF：`/Users/uvxiao/Zotero/storage/AAZ4XQM7/Chen et al. - 2024 - Allo A Programming Model for Composable Accelerator Design.pdf`。
- `streamtensor2025` / Zotero `FVQA5PU9`：StreamTensor: Make Tensors Stream in Dataflow Accelerators for LLMs。类别：硬件实现/数据流加速。用途：用迭代张量类型表达流式布局，补充 LLM 数据流加速器设计。 PDF：`/Users/uvxiao/Zotero/storage/8FWAPTA3/Ye and Chen - 2025 - StreamTensor Make Tensors Stream in Dataflow Accelerators for LLMs.pdf`。
- `tilelang2025` / Zotero `7KYM5SA4`：TileLang: A Composable Tiled Programming Model for AI Systems。类别：编译优化/AI kernel。用途：将 tile 级数据流和调度空间分离，补充 AI 计算内核编程抽象。 PDF：`/Users/uvxiao/Zotero/storage/RI9MKL9C/Wang et al. - 2025 - TileLang A Composable Tiled Programming Model for AI Systems.pdf`。
- `act2025` / Zotero `P6MQ3M3N`：ACT: Automatically Generating Compiler Backends from Tensor Accelerator ISA Descriptions。类别：架构到编译接口。用途：从张量加速器 ISA 描述自动生成编译后端，支撑新加速器快速迭代。 PDF：`/Users/uvxiao/Zotero/storage/3PU7JCLH/Jain et al. - 2025 - ACT Automatically Generating Compiler Backends from Tensor Accelerator ISA Descriptions.pdf`。
- `pagedattention2023` / Zotero `2F67RAU2`：Efficient Memory Management for Large Language Model Serving with PagedAttention。类别：工业级异构系统。用途：KV cache 分块管理说明服务系统内存管理会限制 batch 规模。 PDF：`/Users/uvxiao/Zotero/storage/TCFGYN7W/Kwon et al. - 2023 - Efficient Memory Management for Large Language Model Serving with PagedAttention.pdf`。
- `flashinfer2025` / Zotero `Q2DP2WKU`：FlashInfer: Efficient and Customizable Attention Engine for LLM Inference Serving。类别：工业级异构系统。用途：可定制 attention 模板、KV cache 格式和负载均衡调度支撑 kernel/缓存/服务协同。 PDF：`/Users/uvxiao/Zotero/storage/TQG4ZM3Q/Ye et al. - 2025 - FlashInfer Efficient and Customizable Attention Engine for LLM Inference Serving.pdf`。
- `tritondistributed2025` / Zotero `B486B445`：Triton-distributed: Programming Overlapping Kernels on Distributed AI Systems with the Triton Compiler。类别：工业级异构编译。用途：把通信源语引入 Triton，以编译模型表达计算、访存和通信重叠。 PDF：`/Users/uvxiao/Zotero/storage/J3FLM2HS/Zheng et al. - 2025 - Triton-distributed Programming Overlapping Kernels on Distributed AI Systems with the Triton Compil.pdf`。
- `mscclpp2026` / Zotero `3PUEMF5P`：MSCCL++: Rethinking GPU Communication Abstractions for AI Inference。类别：通信抽象。用途：提供低层性能保留源语和高层 DSL，说明 AI 推理通信抽象正在专门化。 PDF：`/Users/uvxiao/Zotero/storage/M895KTUN/Hwang et al. - 2026 - MSCCL++ Rethinking GPU Communication Abstractions for AI Inference.pdf`。
- `ncclep2026` / Zotero `JUWJPG45`：NCCL EP: Towards a Unified Expert Parallel Communication API for NCCL。类别：通信抽象/MoE。用途：统一专家并行 dispatch/combine 通信 API，支持 MoE 专家并行目标事实。 PDF：`/Users/uvxiao/Zotero/storage/CFPL7FMS/Goldman et al. - 2026 - NCCL EP Towards a Unified Expert Parallel Communication API for NCCL.pdf`。
- `argus2026` / Zotero `8GZSH78L`：ARGUS: Agentic GPU Optimization Guided by Data-Flow Invariants。类别：智能体方法。用途：用数据流不变量和反例为 GPU kernel 智能体提供结构化反馈。 PDF：`/Users/uvxiao/Zotero/storage/WRCGZ3QY/Mai et al. - 2026 - ARGUS Agentic GPU Optimization Guided by Data-Flow Invariants.pdf`。
- `gpukernelagentsol2026` / Zotero `73PLLC5C`：Improving Efficiency of GPU Kernel Optimization Agents using a Domain-Specific Language and Speed-of-Light Guidance。类别：智能体方法。用途：用 DSL 与硬件上限引导减少 GPU kernel 智能体搜索成本。 PDF：`/Users/uvxiao/Zotero/storage/X2IPFVJF/Hari et al. - 2026 - Improving Efficiency of GPU Kernel Optimization Agents using a Domain-Specific Language and Speed-of.pdf`。
- `solexecbench2026` / Zotero `BQ3MPPDV`：SOL-ExecBench: Speed-of-Light Benchmarking for Real-World GPU Kernels Against Hardware Limits。类别：智能体方法/评测。用途：用硬件上限评分和 sandbox harness 重新定义 agentic kernel 优化评测。 PDF：`/Users/uvxiao/Zotero/storage/LGHHBJFJ/Lin et al. - 2026 - SOL-ExecBench Speed-of-Light Benchmarking for Real-World GPU Kernels Against Hardware Limits.pdf`。
- `ksearch2026` / Zotero `SFEDIZUK`：K-Search: LLM Kernel Generation via Co-Evolving Intrinsic World Model。类别：智能体方法。用途：用共演化世界模型分离高层规划和底层程序实例化。 PDF：`/Users/uvxiao/Zotero/storage/S7BWWWC3/Cao et al. - 2026 - K-Search LLM Kernel Generation via Co-Evolving Intrinsic World Model.pdf`。

## 未提升但后续可复查的方向

- 大模型服务和 KV cache 系统还有大量候选，如 ThunderAgent、Tokencake、KVFlow、LMCache、CodeComp、PackKV、EVICPRESS；它们更适合未来工作或具体系统章节，不宜全部塞入引言综述。
- 分布式训练与通信还有 UniEP、Concerto、FlexSP、HAP、Hetu v2、Oobleck、UCCL-EP 等候选；当前只提升了能直接支撑“通信抽象与编译目标事实”的代表项。
- 硬件/DSL 方向还有 AutoDSL、TL、MINISA、LLMCompass 等候选；可在后续章节或未来工作扩写时继续查 PDF。

