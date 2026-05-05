# Introduction Evidence Plan

This file records external evidence candidates for Chapter 1. It is not final report text. Before drafting, each source must be re-checked against the original paper or official page and then added to the bibliography audit.

## Purpose

The introduction should not rely only on broad claims such as "compute demand is growing" or "hardware-software co-design is important". It needs data, models, and recent architecture-conference examples that support the argument:

```text
application demand
  -> domain specialization and agile chip design
  -> design productivity and cross-architecture co-design bottlenecks
  -> LLM/agentic methods as a new engineering-automation trend
  -> compilation and architecture as key software-hardware interface layers
```

Use external evidence sparingly and precisely. Data should support the problem chain; it should not turn Chapter 1 into a literature dump.

## Evidence Buckets For Chapter 1

### 1.1 Application Demand And Domain Specialization

- Hennessy and Patterson, "A New Golden Age for Computer Architecture", Communications of the ACM, 2019.
  - Use for: end of Dennard/Moore-style easy gains, domain-specific architectures, agile chip development, vertical integration of applications, DSLs/compiler technology, architecture, and implementation.
  - Source: https://cacm.acm.org/research/a-new-golden-age-for-computer-architecture/

- TPU v4, ISCA 2023.
  - Use for: industrial DSA as evidence that co-designed ML hardware/software systems produce system-level performance and energy gains.
  - Candidate data to verify before citation: TPU v4 outperforms TPU v3 by 2.1x and improves performance/Watt by 2.7x; TPU v4 cloud deployment reports lower energy and carbon impact than typical on-premise contemporary DSA deployments.
  - Sources: https://arxiv.org/abs/2304.01433 and https://people.csail.mit.edu/suvinay/pubs/2023.tpu.isca.pdf

### 1.2 Design Productivity And Early Architecture Evaluation

- "A graph placement methodology for fast chip design", Nature, 2021; AlphaChip addendum, Nature, 2024.
  - Use for: chip design productivity pressure and AI-assisted EDA as an example of automation entering difficult design stages.
  - Writing constraint: present it as a floorplanning/design-productivity example, not as proof that AI solves chip design. Mention the limited scope.
  - Sources: https://www.nature.com/articles/s41586-021-03544-w and https://www.nature.com/articles/s41586-024-08032-5

- McKinsey, "Seizing the agentic AI advantage", 2025.
  - Use for: agentic AI as an enterprise engineering and automation trend, not only a research curiosity.
  - Candidate evidence:
    - McKinsey reports more than 78% of companies using gen AI in at least one business function, while more than 80% still report no material contribution to earnings and only 1% view their gen-AI strategy as mature.
    - The report argues for an "agentic mesh" that coordinates custom and off-the-shelf agents, supports multi-agent collaboration, and mitigates agent sprawl, autonomy drift, and lack of observability.
  - Writing constraint: use this to motivate why agentic methods need infrastructure, governance, observability, and workflow boundaries. Do not use it as direct evidence for chip-design performance.
  - Source: https://www.mckinsey.com/capabilities/quantumblack/our-insights/seizing-the-agentic-ai-advantage

- Anthropic Economic Index, 2026 reports.
  - Use for: software engineering is one of the earliest and most concentrated real-world agent/LLM usage domains, supporting the claim that LLM/agentic methods are changing complex engineering workflows.
  - Candidate evidence:
    - The January 2026 report states that computer and mathematical tasks dominate Claude usage overall, representing about one third of Claude.ai conversations and nearly half of first-party API traffic; "modifying software to correct errors" is the most common API task at about one in ten records.
    - The March 2026 report can be used as follow-up evidence on adoption and geographic/workflow diffusion if needed.
  - Writing constraint: use as broad engineering-automation evidence; do not imply chip design has the same adoption pattern unless EDA-specific sources are also cited.
  - Sources: https://www.anthropic.com/research/anthropic-economic-index-january-2026-report and https://www.anthropic.com/research/economic-index-march-2026-report

- METR, "Measuring AI Ability to Complete Long Tasks", 2025 / NeurIPS 2025 version.
  - Use for: long-horizon agent capability is improving, but reliability depends on task structure and evaluation; this supports the need for harnesses rather than free-form autonomy.
  - Candidate evidence:
    - METR proposes measuring 50%-task-completion time horizon for AI agents on software and ML research tasks.
    - The report argues that public language models' task-completion time horizon has grown rapidly and extrapolates that agents may complete a large fraction of multi-day or multi-week software tasks within years, while emphasizing methodological dependence and reliability limitations.
  - Writing constraint: treat as a capability-trend model, not a deterministic forecast. Use it to justify why doctoral work should consider agentic automation now, while insisting on verification and evidence constraints.
  - Sources: https://metr.org/blog/2025-03-19-measuring-ai-ability-to-complete-long-tasks/ and https://openreview.net/pdf?id=CGNJL6CeV0

- Siemens Fuse EDA AI Agent and Siemens DAC 2025 AI announcement.
  - Use for: major EDA vendors are explicitly framing agentic AI as semiconductor/PCB workflow automation across architecture exploration, RTL, verification, place-and-route, physical sign-off, and manufacturing readiness.
  - Candidate evidence:
    - Siemens describes Fuse EDA AI Agent as an industrial-grade agentic AI automation system for semiconductor and PCB design that orchestrates multi-tool and multi-agent workflows.
    - Siemens' product page emphasizes EDA-specific parsers, custom playbooks, RAG, MCP protocol, Agent Skills, and support across Catapult, Questa, Aprisa, Solido, Veloce, and Calibre.
  - Writing constraint: use as industry-trend evidence, not as a peer-reviewed technical result.
  - Sources: https://www.siemens.com/en-us/products/fuse-eda-ai-system/agent/ and https://newsroom.sw.siemens.com/en-US/siemens-eda-ai-dac-2025/

- Synopsys AgentEngineer / generative and agentic AI announcements.
  - Use for: another leading EDA vendor treats agentic AI as a next stage after generative AI for chip design workflows.
  - Candidate evidence:
    - Synopsys describes generative AI as the foundation for AgentEngineer technology and presents a progression from step-level single-agent actions to multi-agent actions, adaptive flow optimization, and eventually autonomous decision-making.
    - Synopsys and Microsoft showcased a DAC 2025 prototype built on Microsoft Discovery.
  - Writing constraint: use as industry-trend and roadmap evidence; avoid treating vendor vision as validated technical performance.
  - Sources: https://news.synopsys.com/2025-09-03-Synopsys-Announces-Expanding-AI-Capabilities-for-its-Leading-EDA-Solutions and https://www.synopsys.com/blogs/chip-design/generative-agentic-ai-chip-design.html

- ATLAS: "A Full-Stack Performance Evaluation Infrastructure for 3D-DRAM-based LLM Accelerators", arXiv 2604.08044, 2026.
  - Use for: emerging industrial 3D-DRAM LLM accelerators need full-stack architecture and programming abstractions, not isolated microarchitecture claims.
  - Candidate data to verify before citation: ATLAS validates against real silicon with <=8.57% simulation error and 97.26%-99.96% correlation with measured performance; derived designs report up to 3.64/1.42x speedup over GPUs and prior 3D accelerators.
  - Programming concern: paper explicitly argues existing 3D accelerators lack unified programming model/primitives and flexible software execution.
  - Source: https://arxiv.org/pdf/2604.08044

- DeepStack: "Scalable and Accurate Design Space Exploration for Distributed 3D-Stacked AI Accelerators", arXiv 2604.04750, 2026.
  - Use for: distributed 3D-stacked AI accelerators require cross-stack co-design across memory architecture, interconnect, parallelism strategy, execution scheduling, and hardware DSE.
  - Candidate data to verify before citation: DeepStack reports up to 100,000x faster runtime over state-of-the-art simulators at comparable accuracy, explores 2.5e14 design points, and achieves up to 9.5x higher throughput through co-optimized parallelism and 3D architecture search.
  - Key argument: incomplete schedule search can lead to permanently suboptimal silicon that software tuning cannot recover.
  - Source: https://arxiv.org/abs/2604.04750

### 1.3 Cross-Architecture Co-Design Interfaces

- ASPLOS 2024 "Automatic Generation of Vectorizing Compilers for Customizable Digital Signal Processors".
  - Use for: customizable architectures need generated or retargetable compiler support; compiler construction becomes part of architecture usability.
  - Source: https://jamesbornholt.com/papers/isaria-asplos24.pdf

- NVIDIA GB200 NVL72 official technical blog and IMEX documentation.
  - Use for: rack-scale heterogeneous AI systems expose programming and runtime concerns beyond single-device performance.
  - Candidate data to verify before citation: GB200 NVL72 has 72 GPUs in one NVLink domain; NVLink provides 1.8 TB/s bidirectional bandwidth per GPU and 130 TB/s total NVLink bandwidth; NVIDIA IMEX coordinates memory export/import across OS/node domains for NVLink multi-node deployments.
  - Programming concern: coherent/unified memory space, shared memory operations across OS domains, MPI/NCCL handle sharing, VA/PA/fabric-address mappings, privileged orchestration service.
  - Sources: https://developer.nvidia.com/blog/nvidia-gb200-nvl72-delivers-trillion-parameter-llm-training-and-real-time-inference/ and https://docs.nvidia.com/multi-node-nvlink-systems/imex-guide/overview.html

- NVIDIA GB200 NVL72 OCP design contribution.
  - Use for: industrial rack-scale systems create not only algorithmic but also infrastructure, cabling, cooling, and deployment complexity.
  - Candidate data to verify before citation: 72-GPU NVLink domain, 1.8 TB/s per GPU communication speed, over 5,000 copper cables, aggregate All-to-All bandwidth 130 TB/s and AllReduce bandwidth 260 TB/s; reference architecture can reduce implementation time by up to 50%.
  - Source: https://developer.nvidia.com/blog/nvidia-contributes-nvidia-gb200-nvl72-designs-to-open-compute-project/

- Huawei CloudMatrix384 and UB-Mesh.
  - Use for: industrial heterogeneous AI infrastructure requires hardware-software co-design across supernode architecture, interconnect, serving software, communication libraries, operator optimization, and runtime resource pooling.
  - Candidate evidence:
    - CloudMatrix384 integrates 384 Ascend 910 NPUs and 192 Kunpeng CPUs through Unified Bus, and CloudMatrix-Infer combines peer-to-peer serving, EP320 expert parallelism, UB-based token dispatch, specialized operators, microbatch pipelining, and INT8 quantization.
    - UB-Mesh proposes a hierarchically localized nD-FullMesh data-center network with NPU/CPU/switch/NIC building blocks, flexible IO bandwidth allocation, hardware resource pooling, All-Path-Routing, and reports 2.04x higher cost-efficiency, 7.2% higher network availability, and 95%+ linearity in LLM training tasks.
  - Sources: https://arxiv.org/abs/2506.12708 and https://arxiv.org/abs/2503.20377

- PyTorch 2 `torch.compile` / TorchDynamo.
  - Use for: the compilation-to-runtime interface in mainstream deep-learning software. PyTorch 2 shows that runtime execution now depends on graph capture, graph breaks, backend compilation, recompilation limits, and fallback behavior rather than a clean static compiler pipeline.
  - Candidate evidence:
    - `torch.compile` is introduced to solve accurate graph capture and make PyTorch programs faster.
    - TorchDynamo uses CPython Frame Evaluation API to safely capture PyTorch graphs.
    - Dynamo graph breaks split execution between compiled FX graphs and regular Python; `fullgraph=True` can require no graph breaks.
    - `torch.compile` supports custom backends, making it an interface from dynamic Python programs to specialized compiler/runtime implementations.
  - Sources: https://docs.pytorch.org/docs/2.9/torch.compiler.html, https://docs.pytorch.org/docs/main/user_guide/torch_compiler/compile/programming_model.dynamo_core_concepts.html, https://docs.pytorch.org/docs/stable/generated/torch.compile.html

- NVIDIA TensorRT-LLM.
  - Use for: production LLM inference as a compiler-runtime system, where model definition, engine building, kernel fusion, quantization, KV-cache management, in-flight batching, paged attention, C++ runtime execution, and serving integration jointly determine performance.
  - Candidate evidence:
    - TensorRT-LLM incorporates kernel fusion, quantization, runtime optimizations, KV caching, continuous in-flight batching, and paged attention.
    - Runtime components load TensorRT engines and drive execution.
    - NVIDIA technical blog notes in-flight batching and KV-cache management for high-throughput/low-latency serving, including Triton TensorRT-LLM backend production deployment.
  - Sources: https://nvidia.github.io/TensorRT-LLM/0.20.0/overview.html, https://nvidia.github.io/TensorRT-LLM/architecture/core-concepts.html, https://developer.nvidia.com/blog/nvidia-tensorrt-llm-now-accelerates-encoder-decoder-models-with-in-flight-batching/

### 1.4 Interface-Oriented Research Status

- Application to architecture:
  - Hennessy/Patterson 2019 for DSA and vertical integration.
  - TPU v4 ISCA 2023 for industrial DSA and ML hardware/software co-design.

- Architecture to hardware:
  - Nature floorplanning / AlphaChip for design productivity and automation pressure.
  - Add local sources: Cement, Clay, HECTOR.

- Software to compilation:
  - ASPLOS 2024 automatic vectorizing compiler generation for customizable DSPs.
  - Add local sources: APS, Aquas, ISAMORE, SkyEgg, EggMind.

- Compilation to runtime:
  - Primary framework evidence: PyTorch 2 `torch.compile` / TorchDynamo and NVIDIA TensorRT-LLM.
  - Use TensorRT-LLM as the main example, because inference serving clearly exposes runtime scheduling, KV-cache management, continuous batching, paged attention, latency/throughput tradeoffs, and serving backend concerns.
  - Use PyTorch/Dynamo as supporting evidence for training/general dynamic programs, showing how high-level programs are captured, broken into graphs, compiled through backends, and sometimes fall back to eager execution.
  - Writing ratio: inference should be the main thread; training should be a necessary supplement, especially to connect with Torch training operators and fused-operator optimization in future work.
  - Use NVIDIA GB200 NVL72/IMEX, Huawei CloudMatrix384/UB-Mesh, DeepStack, and ATLAS as the hardware-system context that makes compilation-to-runtime interfaces harder on industrial heterogeneous architectures.

- Automation through large models and formal techniques:
  - Nature/AlphaChip for AI-assisted floorplanning, with scope caveat.
  - McKinsey and Anthropic for broad enterprise/software-engineering agentic trend, with scope caveat.
  - Siemens Fuse EDA AI Agent and Synopsys AgentEngineer for EDA/chip-design industry trend, with vendor-roadmap caveat.
  - METR long-task measurement for long-horizon agent capability and reliability limitations.
  - "Agentic Software Engineering: Foundational Pillars and a Research Roadmap", arXiv 2509.06216, for agent execution environments, human-agent handoff, and structured engineering process.
  - "The Dawn of Agentic EDA: A Survey of Autonomous Digital Chip Design", arXiv 2512.23189, for the field-level framing that EDA is moving from point-problem AI optimization toward agentic orchestration of RTL-to-GDSII flows; use carefully because it is a survey/preprint.
  - "A Multi-Agent Generative AI Framework for IC Module-Level Verification Automation", arXiv 2507.21694 / DVCon China 2025, for verification as a bottleneck and multi-agent verification automation evidence.
  - CompilerGPT, arXiv 2506.06227 / ISC HPC C3PO 2025, for LLMs acting through compiler reports plus user-defined test/evaluation harness; candidate result: speedups up to 6.5x but not consistent across tests.
  - AwareCompiler, arXiv 2510.11759, for agentic compiler optimization challenges: semantic misalignment, inefficient agent-compiler interaction, and sparse rewards in large optimization spaces.
  - Add local sources: OriGen and EggMind.

### 1.1/1.2/1.3 Placement Of LLM/Agentic Trend

- 1.1 should introduce LLM/agentic methods as a technology and industry trend, not only as an application workload. The narrative should distinguish two roles of LLMs:
  - LLM workloads intensify compute demand and drive domain-specialized systems.
  - LLM/agentic methods are changing how complex engineering workflows are automated.
- 1.2 should connect agentic methods to chip-design productivity. Use EDA vendor evidence and AI-assisted design papers to show that the industry is exploring agents for long, multi-tool workflows, but emphasize the correctness, verification, maintainability, and observability risks.
- 1.3 should provide the thesis-level constraint: agentic methods can serve cross-hardware-architecture co-design only when architecture interfaces, compiler infrastructure, semantic gates, runtime/profiling feedback, and evidence memory provide a harness.
- 1.5 should not name a separate "agent problem". It should absorb the agent trend into the third core question: how compilation interfaces connect program semantics, hardware capabilities, runtime feedback, and verifiable reusable evidence loops.

## Writing Rules For Evidence

- Prefer evidence from large industrial organizations, industrial research labs, or widely recognized experts when it is available and technically relevant. Examples include Google/DeepMind/Google Cloud, NVIDIA, Microsoft, Intel, AMD, IBM, Meta, Amazon, Apple, TSMC/Synopsys/Cadence, and Turing Award or field-defining architecture/compiler researchers.
- Prefer primary papers, official conference pages, DOI pages, or official project pages over secondary news.
- Prefer industrial system papers, top architecture/systems/conference papers, official technical reports, and authoritative expert essays over generic surveys.
- Do not use ISCA AIO or MICRO SCAR as primary Chapter 1 evidence unless later specifically requested. Prefer ATLAS/DeepStack, Huawei CloudMatrix384/UB-Mesh, and NVIDIA GB200 NVL72/IMEX for heterogeneous architecture complexity and programming concerns.
- For each numerical claim, record metric, baseline, workload, and scope.
- Do not generalize a narrow result. For example, floorplanning automation supports "automation can reduce one difficult chip-design stage", not "AI designs complete chips".
- Do not use industry data without tying it to one of the three core research questions.
- Each subsection of Chapter 1 should contain at least one concrete data point, model, or top-conference example when possible.
- In final prose, use a small number of representative examples at key argument transitions. Maintain this evidence plan and bibliography entries for traceability.
- A short evidence table is optional, not mandatory. Add it only if it improves verifiability without disrupting the academic narrative; otherwise keep evidence tracking in this file and `.bib`.
