# Related Work Original-Paper Digests, 2026-05-11

本文件是 Chapter 1.4 重写的工作底稿。目标不是把本地已有工作作为综述主体，而是把这些工作引用网络中的外部论文、工具和系统逐篇整理为可写入报告的研究现状材料。

第一轮访问方式：优先使用 DOI/OpenAlex landing page、正式文档 URL 和本地 BibTeX 元数据确认题名、年份与主题；正文只提升已经被实际解释的条目。后续若继续扩写，应对 P0 条目补充 PDF 级阅读摘记。

## 应用需求到架构能力

- `riscv2019` (2019)：The RISC-V Instruction Set Manual, Volume I: Unprivileged ISA, Document Version 20190608-Base-Ratified。摘要：开放 ISA 基础，说明定制能力可以在标准扩展框架下进入软件生态。；访问：https://riscv.org/technical/specifications/
- `rocket2016` (2016)：The Rocket Chip Generator。摘要：生成式 SoC 与 RoCC 协处理器接口，体现 RISC-V 处理器扩展入口。；访问：https://people.eecs.berkeley.edu/~krste/papers/EECS-2016-17.pdf
- `amid_chipyard_2020` (2020)：Chipyard: Integrated Design, Simulation, and Implementation Framework for Custom SoCs。摘要：把处理器、互连、缓存和加速器组合进可配置 SoC 生成环境。；访问：https://doi.org/10.1109/MM.2020.2996616
- `picorv32pcpi2020` (2020)：PicoRV32 - A Size-Optimized RISC-V CPU。摘要：轻量处理器协处理器接口，体现资源受限场景的定制入口。；访问：https://github.com/YosysHQ/picorv32
- `nice2024` (2024)：NICE (Nuclei Instruction Co-unit Extension)。摘要：紧耦合 RISC-V 定制扩展接口，说明接口语义会受处理器流水线影响。；访问：https://doc.nucleisys.com/hbirdv2/core/core.html#nice
- `corevxif2025` (2025)：The OpenHW Group CORE-V-XIF Interface。摘要：CORE-V-XIF 定义开放扩展接口，突出跨核复用需求。；访问：https://docs.openhwgroup.org/projects/openhw-group-core-v-xif/en/latest/
- `tigra` (2021)：Tigra: A tightly integrated generic risc-v accelerator interface。摘要：通用 RISC-V 加速器接口，强调 tightly integrated accelerator interface。
- `scaiev2022` (2022)：SCAIE-V: An Open-Source SCAlable Interface for ISA Extensions for RISC-V Processors。摘要：把定制扩展接口生成与多处理器适配结合，突出可移植性问题。；访问：https://doi.org/10.1145/3489517.3530432
- `tie` (2008)：TIE: An ADL for designing application-specific instruction set extensions。摘要：经典 ASIP 架构描述语言，连接指令扩展、硬件资源和编译支持。
- `cadenceTensilica` (2025)：Tensilica Processor IP。摘要：工业 ASIP/IP 工具链例证，说明指令扩展需要成套软件工具。；访问：https://www.cadence.com/en_US/home/tools/ip/tensilica-ip.html
- `synopsysASIPDesigner` (2025)：Synopsys ASIP Designer。摘要：工业 ASIP 设计平台例证，覆盖架构描述、处理器生成和工具链。；访问：https://www.synopsys.com/dw/ipdir.php?ds=asip-designer
- `codasipStudio` (2025)：Codasip Studio。摘要：商业 RISC-V/ASIP 设计环境例证，说明处理器定制已进入工业流程。；访问：https://codasip.com/products/codasip-studio/
- `longnail2024` (2024)：Longnail: High-Level Synthesis of Portable Custom Instruction Set Extensions for RISC-V Processors from Descriptions in the Open-Source CoreDSL Language。摘要：用 HLS 生成可移植 RISC-V 定制指令，连接算法描述和指令扩展。；访问：https://doi.org/10.1145/3620666.3651375
- `assist2019` (2019)：Rapid Generation of High-Quality RISC-V Processors from Functional Instruction Set Specifications。摘要：面向 RISC-V 快速生成高质量 ASIP，强调敏捷处理器定制。；访问：https://doi.org/10.1145/3316781.3317890
- `clark_processor_2003` (2003)：Processor Acceleration Through Automated Instruction Set Customization。摘要：早期自动定制指令生成，建立数据流子图硬化思路。；访问：https://doi.org/10.1109/MICRO.2003.1253189
- `clark_automated_2005` (2005)：Automated Custom Instruction Generation for Domain-Specific Processor Acceleration。摘要：系统讨论自动定制指令生成，处理收益、面积和接口约束。；访问：https://doi.org/10.1109/TC.2005.156
- `pozzi_exact_2006` (2006)：Exact and Approximate Algorithms for the Extension of Embedded Processor Instruction Sets。摘要：提供定制指令扩展的精确与近似搜索算法。；访问：https://doi.org/10.1109/TCAD.2005.855950
- `aditya_automatic_1999` (1999)：Automatic Architectural Synthesis of VLIW and EPIC Processors。摘要：面向 VLIW/EPIC 的架构综合，体现从程序并行性到处理器结构的映射。；访问：https://doi.org/10.1109/ISSS.1999.814268
- `ccores2010` (2010)：Conservation Cores: Reducing the Energy of Mature Computations。摘要：Conservation Cores 说明成熟计算片段可以硬化以降低能耗。；访问：https://doi.org/10.1145/1735970.1736044
- `goulding-hotta_greendroid_2011` (2011)：The GreenDroid Mobile Application Processor: An Architecture for Silicon's Dark Future。摘要：GreenDroid 以移动平台为背景展示能效核心路线。；访问：https://doi.org/10.1109/MM.2011.18
- `qscores2011` (2011)：QSCORES: Trading Dark Silicon for Scalable Energy Efficiency with Quasi-Specific Cores。摘要：以更大程序区域为对象的专门化核心，推动粗粒度硬化。
- `finder2020` (2020)：FINDER: Find Efficient Parallel Instructions for ASIPs to Improve Performance of Large Applications。摘要：自动发现内联加速器，连接程序区域识别和专用硬件。；访问：https://doi.org/10.1109/TCAD.2020.3012211
- `novia2021` (2021)：NOVIA: A Framework for Discovering Non-Conventional Inline Accelerators。摘要：从多个应用中寻找非常规内联加速器，强调跨程序复用。；访问：https://doi.org/10.1145/3466752.3480094
- `AccelSeeker` (2019)：Compiler-Assisted Selection of Hardware Acceleration Candidates from Application Source Code。摘要：LLVM IR 分析选择硬件加速候选，避免过早依赖耗时综合。；访问：https://doi.org/10.1109/ICCD46524.2019.00024
- `Trireme` (2023)：Trireme: Exploration of Hierarchical Multi-Level Parallelism for Hardware Acceleration。摘要：探索层次化多级并行性，说明候选选择需覆盖循环、函数和并行层次。；访问：https://doi.org/10.1145/3580394
- `tpuv4isca2023` (2023)：TPU v4: An Optically Reconfigurable Supercomputer for Machine Learning with Hardware Support for Embeddings。摘要：工业 TPU 系统例证，架构能力扩展到计算、互连和云端部署。；访问：https://arxiv.org/abs/2304.01433
- `atlas2026` (2026)：A Full-Stack Performance Evaluation Infrastructure for 3D-DRAM-based LLM Accelerators。摘要：面向 3D-DRAM LLM 加速器的全栈评估基础设施，强调系统架构抽象、编程原语和性能建模必须共同设计。；访问：https://arxiv.org/abs/2604.08044
- `deepstack2026` (2026)：DeepStack: Scalable and Accurate Design Space Exploration for Distributed 3D-Stacked AI Accelerators。摘要：面向分布式 3D-stacked AI 加速器的设计空间探索，强调存储事务、互连、并行策略和执行调度的共同建模。；访问：https://arxiv.org/abs/2604.04750
- `nvidiaGB200NVL72` (2026)：NVIDIA GB200 NVL72。摘要：机架级 GPU 系统例证，说明大模型硬件能力跨越芯片和互连。；访问：https://www.nvidia.com/en-us/data-center/gb200-nvl72/
- `cloudmatrix3842025` (2025)：Serving Large Language Models on Huawei CloudMatrix384。摘要：华为 CloudMatrix384 例证，支持大模型服务中的多 NPU 系统复杂性。；访问：https://arxiv.org/abs/2506.12708
- `ubmesh2025` (2025)：UB-Mesh: A Hierarchically Localized nD-FullMesh Datacenter Network Architecture。摘要：数据中心网络拓扑例证，说明 AI 系统架构能力包含通信局部性。；访问：https://arxiv.org/abs/2503.20377

## 架构能力到硬件实现

- `Chisel` (2012)：Chisel: Constructing Hardware in a Scala Embedded Language。摘要：嵌入式硬件构造语言，提高参数化和生成式硬件生产力。；访问：https://doi.org/10.1145/2228360.2228584
- `BSV` (2004)：Bluespec System Verilog: Efficient, Correct RTL from High Level Specifications。摘要：基于规则的硬件语言，强调并发行为和正确 RTL 生成。；访问：https://doi.org/10.1109/MEMCOD.2004.1459818
- `firrtl2017` (2017)：Reusability is FIRRTL Ground: Hardware Construction Languages, Compiler Frameworks, and Transformations。摘要：Chisel 后端 IR，说明生成式硬件需要可优化中间表示。；访问：https://doi.org/10.1109/ICCAD.2017.8203780
- `VitisHLS` (2024)：Vitis High-Level Synthesis User Guide。摘要：工业 HLS 工具代表，体现 C/C++ 到硬件的高层生成路径。；访问：https://docs.amd.com/r/en-US/ug1399-vitis-hls
- `LegUp` (2011)：LegUp: High-Level Synthesis for FPGA-Based Processor/Accelerator Systems。摘要：学术 HLS 系统代表，展示软件程序到 FPGA 硬件的综合。；访问：https://doi.org/10.1145/1950413.1950423
- `Dynamatic` (2018)：Dynamically Scheduled High-Level Synthesis。摘要：动态调度 HLS 路线，处理控制/数据流和延迟不确定性。；访问：https://doi.org/10.1145/3174243.3174264
- `AutoDSE` (2021)：AutoDSE: Enabling Software Programmers Design Efficient FPGA Accelerators。摘要：HLS 设计空间探索工具，代表 pragma 和程序变换驱动优化。；访问：https://doi.org/10.1145/3431920.3439464
- `ScaleHLS` (2021)：ScaleHLS: A New Scalable High-Level Synthesis Framework on Multi-Level Intermediate Representation。摘要：基于 MLIR 的 HLS 优化，说明多层 IR 对硬件生成的重要性。；访问：https://doi.org/10.48550/arXiv.2107.11673
- `dahlia2020` (2020)：Predictable Accelerator Design with Time-Sensitive Affine Types。摘要：用时间敏感仿射类型约束加速器设计，强调可预测性。；访问：https://doi.org/10.1145/3385412.3385974
- `spatial2018` (2018)：Spatial: A Language and Compiler for Application Accelerators。摘要：面向空间加速器的语言和编译器，表达并行、流水和存储层次。；访问：https://doi.org/10.1145/3192366.3192379
- `aetherling2020` (2020)：Type-Directed Scheduling of Streaming Accelerators。摘要：流式加速器的类型引导调度，突出时序和数据率约束。；访问：https://doi.org/10.1145/3385412.3385983
- `HeteroCL` (2019)：HeteroCL: A Multi-Paradigm Programming Infrastructure for Software-Defined Reconfigurable Computing。摘要：把算法、调度、数据类型和后端选择分离，面向可重构计算。；访问：https://doi.org/10.1145/3289602.3293910
- `calyx2021` (2021)：A Compiler Infrastructure for Accelerator Generators。摘要：控制/数据通路分离的加速器编译 IR，支撑生成器复用。；访问：https://arxiv.org/abs/2102.09713
- `Filament` (2023)：Modular Hardware Design with Timeline Types。摘要：timeline types 显式表达硬件接口时序，突出时序类型化。；访问：https://doi.org/10.1145/3591234
- `circt2021` (2022)：CIRCT: Circuit IR Compilers and Tools。摘要：MLIR 生态中的硬件编译基础设施，连接多种硬件方言和后端。；访问：https://github.com/llvm/circt
- `mlir2021` (2021)：MLIR: A Compiler Infrastructure for the End of Moore's Law。摘要：多层 IR 基础设施，支撑硬件、张量和目标后端在不同层次表达。；访问：https://arxiv.org/abs/2002.11054
- `guo_autobridge_2021` (2021)：AutoBridge: Coupling Coarse-Grained Floorplanning and Pipelining for High-Frequency HLS Design on Multi-Die FPGAs。摘要：将粗粒度布局和流水线结合，说明物理约束影响 HLS 质量。；访问：https://doi.org/10.1145/3431920.3439289
- `guo_tapa_2023` (2023)：TAPA: A Scalable Task-parallel Dataflow Programming Framework for Modern FPGAs with Co-optimization of HLS and Physical Design。摘要：任务并行数据流 FPGA 框架，强调编程模型与物理实现共同优化。；访问：https://doi.org/10.1145/3609335
- `guo_rapidstream_2022` (2022)：RapidStream: Parallel Physical Implementation of FPGA HLS Designs。摘要：并行物理实现 HLS 设计，体现高层物理综合的重要性。；访问：https://doi.org/10.1145/3490422.3502361
- `lau_rapidstream_2024` (2024)：RapidStream IR: Infrastructure for FPGA High-Level Physical Synthesis。摘要：RapidStream IR 为 FPGA 高层物理综合提供基础设施。；访问：https://doi.org/10.1145/3676536.3676649
- `FADO` (2023)：FADO: Floorplan-Aware Directive Optimization for High-Level Synthesis Designs on Multi-Die FPGAs。摘要：多芯粒 FPGA 的布局感知指令优化，说明物理拓扑约束进入高层 DSE。；访问：https://doi.org/10.1145/3543622.3573188

## 架构约束下的编译优化

- `LLVM` (2004)：LLVM: A Compilation Framework for Lifelong Program Analysis \& Transformation。摘要：可重用编译基础设施代表，提供 IR、pass 和多目标后端框架。
- `mlir2021` (2021)：MLIR: A Compiler Infrastructure for the End of Moore's Law。摘要：多层 IR 基础设施，支撑硬件、张量和目标后端在不同层次表达。；访问：https://arxiv.org/abs/2002.11054
- `polygeist2021` (2021)：Polygeist: Raising C to Polyhedral MLIR。摘要：将 C/C++ 提升到 MLIR，多面体友好表示保留高层优化机会。；访问：https://research.google/pubs/polygeist-raising-c-to-polyhedral-mlir/
- `tvm` (2018)：TVM: An Automated End-to-End Optimizing Compiler for Deep Learning。摘要：端到端深度学习编译器，整合算子、调度搜索和多后端生成。；访问：https://www.usenix.org/conference/osdi18/presentation/chen
- `Triton` (2019)：Triton: an intermediate language and compiler for tiled neural network computations。摘要：面向 tiled 神经网络计算的语言和编译器，接近硬件执行模型。；访问：https://doi.org/10.1145/3315508.3329973
- `larsen_exploting_2000` (2000)：Exploiting superword level parallelism with multimedia instruction sets。摘要：SLP 自动向量化经典工作，把标量独立操作打包为 SIMD。；访问：https://doi.org/10.1145/349299.349320
- `nuzman_auto-vectorization_2006` (2006)：Auto-vectorization of interleaved data for SIMD。摘要：处理交错数据的自动向量化，说明数据布局影响指令选择。；访问：https://doi.org/10.1145/1133981.1133997
- `diospyros2021` (2021)：Vectorization for Digital Signal Processors via Equality Saturation。摘要：用等价饱和进行 DSP 向量化，展示语义空间对目标源语选择的价值。；访问：https://doi.org/10.1145/3445814.3446707
- `isaria2024` (2024)：Automatic Generation of Vectorizing Compilers for Customizable Digital Signal Processors。摘要：自动生成向量化编译器，结合规则合成和可定制 DSP。；访问：https://doi.org/10.1145/3617232.3624873
- `tate2009eqsat` (2009)：Equality Saturation: A New Approach to Optimization。摘要：提出等价饱和优化范式，分离等价空间探索和最终选择。；访问：https://doi.org/10.1145/1480881.1480915
- `egg2021` (2021)：egg: Fast and Extensible Equality Saturation。摘要：高效可扩展等价饱和基础设施，推动 e-graph 工程化。；访问：https://arxiv.org/abs/2004.03082
- `nandi_rewrite_2021` (2021)：Rewrite Rule Inference Using Equality Saturation。摘要：用等价饱和推断重写规则，降低手写规则负担。；访问：https://doi.org/10.1145/3485496
- `cao_babble_2022` (2022)：babble: Learning Better Abstractions with E-Graphs and Anti-Unification。摘要：用 e-graph 与反合一学习抽象，支撑可复用变换知识。；访问：https://doi.org/10.48550/arXiv.2212.04596
- `enumo2023` (2023)：Equality Saturation Theory Exploration \`a la Carte。摘要：等价饱和理论探索，补充规则和搜索组织视角。；访问：https://doi.org/10.1145/3622834
- `pal_equality_2023` (2023)：Equality Saturation Theory Exploration \`a la Carte。摘要：以模块化理论组织等价饱和，说明语义基础可组合。；访问：https://doi.org/10.1145/3622834
- `zhang_better_2023` (2023)：Better Together: Unifying Datalog and Equality Saturation。摘要：结合 Datalog 与等价饱和，扩展关系式分析和重写表达。；访问：https://doi.org/10.1145/3591239
- `seer2024` (2024)：SEER: Super-Optimization Explorer for High-Level Synthesis Using E-Graph Rewriting。摘要：将 e-graph 用于 HLS 超优化，连接程序重写与硬件数据通路。；访问：https://doi.org/10.1145/3620665.3640392
- `esyn2024` (2024)：E-Syn: E-Graph Rewriting with Technology-Aware Cost Functions for Logic Synthesis。摘要：把技术感知代价函数放入逻辑综合 e-graph 重写。；访问：https://arxiv.org/abs/2403.14242
- `emorphic2025` (2025)：E-morphic: Scalable Equality Saturation for Structural Exploration in Logic Synthesis。摘要：面向逻辑综合结构探索的可扩展等价饱和。；访问：https://arxiv.org/abs/2504.11574
- `eqmap2025` (2025)：EqMap: FPGA LUT Remapping Using E-Graphs。摘要：FPGA LUT 映射中的等价表示和提取。；访问：https://doi.org/10.1109/ICCAD66269.2025.11240672
- `lakeroad2024` (2024)：FPGA Technology Mapping Using Sketch-Guided Program Synthesis。摘要：面向复杂 FPGA 原语映射的等价饱和框架。；访问：https://doi.org/10.1145/3620665.3640387
- `smith_scaling_2024` (2024)：Scaling Program Synthesis Based Technology Mapping with Equality Saturation。摘要：扩展程序合成式 technology mapping，关注等价饱和可扩展性。；访问：https://doi.org/10.48550/arXiv.2411.11036
- `cai2025smoothe` (2025)：Smoothe: Differentiable E-Graph Extraction。摘要：可微 e-graph 提取，缓解复杂搜索空间中的提取瓶颈。；访问：https://doi.org/10.1145/3669940.3707262
- `pytorchCompile2026` (2026)：torch.compile。摘要：动态图捕获与后端编译框架，说明编译需处理动态语言边界。；访问：https://docs.pytorch.org/docs/stable/generated/torch.compile.html
- `tensorrtllm2026` (2026)：NVIDIA TensorRT-LLM Documentation。摘要：大模型推理优化框架，整合引擎、kernel、量化、KV cache 和服务系统。；访问：https://docs.nvidia.com/tensorrt-llm/
- `nvidiaGB200NVL72` (2026)：NVIDIA GB200 NVL72。摘要：机架级 GPU 系统例证，说明大模型硬件能力跨越芯片和互连。；访问：https://www.nvidia.com/en-us/data-center/gb200-nvl72/
- `cloudmatrix3842025` (2025)：Serving Large Language Models on Huawei CloudMatrix384。摘要：华为 CloudMatrix384 例证，支持大模型服务中的多 NPU 系统复杂性。；访问：https://arxiv.org/abs/2506.12708
- `ubmesh2025` (2025)：UB-Mesh: A Hierarchically Localized nD-FullMesh Datacenter Network Architecture。摘要：数据中心网络拓扑例证，说明 AI 系统架构能力包含通信局部性。；访问：https://arxiv.org/abs/2503.20377

## 智能体化方法

- `dave` (2020)：DAVE: Deriving Automatically Verilog from English。摘要：从英文生成 Verilog 的早期尝试，展示自然语言硬件生成的起点。
- `chipchat` (2023)：Chip-Chat: Challenges and Opportunities in Conversational Hardware Design。摘要：对话式硬件设计研究，分析 LLM 参与硬件设计的机会和挑战。
- `chipgpt` (2023)：ChipGPT: How Far Are We from Natural Language Hardware Design。摘要：评估自然语言硬件设计能力，暴露代码质量和正确性问题。
- `verilogeval2023` (2023)：VerilogEval: Evaluating Large Language Models for Verilog Code Generation。摘要：Verilog 生成评测基准，为模型能力比较提供任务集合。
- `rtllm` (2024)：RTLLM: An open-source benchmark for design rtl generation with large language model。摘要：开源 RTL 生成 benchmark，强调硬件生成评测标准化。
- `verigen2023` (2023)：Verigen: A Large Language Model for Verilog Code Generation。摘要：面向 Verilog 代码生成的大模型，展示开源模型路线。
- `rtlcoder2023` (2023)：RTLCoder: Outperforming GPT-3.5 in Design RTL Generation with Our Open-Source Dataset and Lightweight Solution。摘要：提升开源 RTL 代码生成能力，强调数据和模型适配。；访问：https://arxiv.org/abs/2312.08617
- `betterv` (2024)：BetterV: Controlled Verilog Generation with Discriminative Guidance。摘要：受控 Verilog 生成，强调约束和判别信号对输出质量的作用。
- `rtlfixer2023` (2023)：RTLFixer: Automatically Fixing RTL Syntax Errors with Large Language Models。摘要：利用编译/仿真错误自动修复 RTL，体现工具反馈约束。；访问：https://arxiv.org/abs/2311.16543
- `autochip2023` (2023)：AutoChip: Automating HDL Generation Using LLM Feedback。摘要：自动化 HDL 生成和迭代流程，连接模型、编译器和测试。；访问：https://arxiv.org/abs/2311.04887
- `chipnemo` (2023)：Chipnemo: Domain-adapted llms for chip design。摘要：芯片设计领域适配 LLM，说明领域语料和工具知识的重要性。
- `dataisallyouneed` (2024)：Data is all you need: Finetuning LLMs for Chip Design via an Automated design-data augmentation framework。摘要：自动化设计数据增强与微调，强调数据质量对芯片 LLM 的影响。
- `sweagent` (2024)：SWE-agent: Agent Computer Interfaces Enable Software Engineering Language Models。摘要：软件工程智能体接口，展示仓库阅读、编辑、测试和修复闭环流程。
- `openaiCodex2025` (2025)：Introducing Codex。摘要：工程智能体系统说明，强调沙箱、命令执行、测试和人工监督。；访问：https://openai.com/index/introducing-codex/
- `anthropicClaudeCode2026` (2026)：Claude Code Overview。摘要：代码智能体产品形态，展示模型进入真实工程工作流。；访问：https://docs.anthropic.com/en/docs/claude-code/overview
- `alphaevolve2025` (2025)：AlphaEvolve: A Coding Agent for Scientific and Algorithmic Discovery。摘要：编码智能体用于算法发现和基础设施优化，依赖评价器选择候选。；访问：https://arxiv.org/abs/2506.13131
- `avo2026` (2026)：AVO: Agentic Variation Operators for Autonomous Evolutionary Search。摘要：NVIDIA AVO 用 agentic 变异优化 GPU kernel，强调生成、修复、批判和验证。；访问：https://arxiv.org/abs/2603.24517
- `tate2009eqsat` (2009)：Equality Saturation: A New Approach to Optimization。摘要：提出等价饱和优化范式，分离等价空间探索和最终选择。；访问：https://doi.org/10.1145/1480881.1480915
- `egg2021` (2021)：egg: Fast and Extensible Equality Saturation。摘要：高效可扩展等价饱和基础设施，推动 e-graph 工程化。；访问：https://arxiv.org/abs/2004.03082
- `nandi_rewrite_2021` (2021)：Rewrite Rule Inference Using Equality Saturation。摘要：用等价饱和推断重写规则，降低手写规则负担。；访问：https://doi.org/10.1145/3485496
- `cao_babble_2022` (2022)：babble: Learning Better Abstractions with E-Graphs and Anti-Unification。摘要：用 e-graph 与反合一学习抽象，支撑可复用变换知识。；访问：https://doi.org/10.48550/arXiv.2212.04596
- `isaria2024` (2024)：Automatic Generation of Vectorizing Compilers for Customizable Digital Signal Processors。摘要：自动生成向量化编译器，结合规则合成和可定制 DSP。；访问：https://doi.org/10.1145/3617232.3624873
- `aspen2025` (2025)：ASPEN: LLM-Guided E-Graph Rewriting for RTL Datapath Optimization。摘要：LLM 辅助等价饱和/优化相关工作，体现模型进入形式化优化控制。；访问：https://doi.org/10.1109/MLCAD65511.2025.11189222

## 当前写入正文的用法

- 1.4 不再使用本地已有工作作为“国内外现状”的叙述主体；本地工作只在 1.6 和后续技术章节出现。
- 1.4 的四个子节分别吸收上述外部工作，并在每个子节末尾收束出与科学问题相关的缺口。
- 引用位置采用“工作名紧跟引用”的方式，避免句末堆叠引用。
