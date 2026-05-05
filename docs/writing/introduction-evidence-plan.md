# Introduction Evidence Plan

This file records external evidence candidates for Chapter 1. It is not final report text. Before drafting, each source must be re-checked against the original paper or official page and then added to the bibliography audit.

## Purpose

The introduction should not rely only on broad claims such as "compute demand is growing" or "hardware-software co-design is important". It needs data, models, and recent architecture-conference examples that support the argument:

```text
application demand
  -> domain specialization and agile chip design
  -> design productivity and cross-architecture co-design bottlenecks
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

- AIO: "An Abstraction for Performance Analysis Across Diverse Accelerator Architectures", ISCA 2024.
  - Use for: diverse accelerator architectures and the need for architecture-independent early performance analysis to preserve software/system/architecture productivity.
  - Source: https://colab.ws/articles/10.1109%2Fisca59077.2024.00043

### 1.3 Cross-Architecture Co-Design Interfaces

- ISCA 2024 AIO.
  - Use for: cross-accelerator abstraction and "application/algorithm work item remains comparable across accelerator classes" style argument.
  - Supports: architecture and compilation as interfaces between algorithm-level work and accelerator choice.

- ASPLOS 2024 "Automatic Generation of Vectorizing Compilers for Customizable Digital Signal Processors".
  - Use for: customizable architectures need generated or retargetable compiler support; compiler construction becomes part of architecture usability.
  - Source: https://jamesbornholt.com/papers/isaria-asplos24.pdf

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
  - SCAR, MICRO 2024.
    - Use for: heterogeneous multi-chiplet accelerator scheduling complexity.
    - Candidate data to verify before citation: scheduling search space reaches O(10^56) for two-model workloads on 6x6 chiplets; reported lower EDP than homogeneous baselines in datacenter and AR/VR settings.
    - Sources: https://arxiv.org/abs/2405.00790 and https://its.uci.edu/research_products/conference-paper-scar-scheduling-multi-model-ai-workloads-on-heterogeneous-multi-chiplet-module-accelerators/

- Automation through large models and formal techniques:
  - Nature/AlphaChip for AI-assisted floorplanning, with scope caveat.
  - Add local sources: OriGen and EggMind.

## Writing Rules For Evidence

- Prefer primary papers, official conference pages, DOI pages, or official project pages over secondary news.
- For each numerical claim, record metric, baseline, workload, and scope.
- Do not generalize a narrow result. For example, floorplanning automation supports "automation can reduce one difficult chip-design stage", not "AI designs complete chips".
- Do not use industry data without tying it to one of the three core research questions.
- Each subsection of Chapter 1 should contain at least one concrete data point, model, or top-conference example when possible.
