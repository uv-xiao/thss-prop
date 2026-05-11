# Related Work Synthesis for the Proposal Introduction

This file distills related-work discussions from the original source papers under `resources/`. It is a working reference for Chapter 1. It should not be inserted into the report verbatim. The report should use it to write survey prose organized by research interfaces, problem families, and unresolved tensions.

The bibliography boundary must come from the source-paper citation network, not from the current introduction draft. The broad reservoir is `docs/writing/related-work-bibliography.md`, generated from 24 source-paper introduction/background/related-work sections, with 286 distinct citation keys and 280 locally resolved BibTeX entries. The compact BibTeX working pool is `docs/writing/related-work-bib-reservoir.bib`. Chapter 1 should first use that reservoir to form a complete survey logic, then promote only the works it actually interprets into `report/refs.bib`.

## Source Map

The following local sources were inspected for this synthesis:

- APS: `resources/aps/sec/0_intro.tex`, `resources/aps/sec/5_related_works.tex`;
- Aquas: `resources/aquas/sec/0_intro.tex`, `resources/aquas/sec/1_preliminary.tex`;
- ISAMORE: `resources/isamore/tex/1_introduction.tex`, `resources/isamore/tex/2_background.tex`, `resources/isamore/tex/7_related_work.tex`;
- Cayman: `resources/cayman/doc/1_introduction.tex`, `resources/cayman/doc/2_background.tex`, `resources/cayman/doc/5_related_work.tex`;
- Cement: `resources/cement/doc/1_Introduction.tex`, `resources/cement/doc/2_Background_Motiviation.tex`, `resources/cement/doc/7_Related_Work.tex`;
- Clay: `resources/clay/sec/0_intro.tex`, `resources/clay/sec/1_preliminaries.tex`, `resources/clay/sec/4_related.tex`;
- SkyEgg: `resources/skyegg/doc/1_introduction.tex`, `resources/skyegg/doc/2_background.tex`, `resources/skyegg/doc/8_related_work.tex`;
- OriGen: `resources/origen/1_Introduction.tex`, `resources/origen/2_Background.tex`;
- EggMind: `resources/eggmind/tex/1_introduction.tex`, `resources/eggmind/tex/2_background.tex`, `resources/eggmind/tex/8_related_work.tex`, `resources/eggmind/doc/related_work_scan.md`.

## 1. Application-to-Architecture Interface

### Reservoir Coverage and Report Promotion

The broad reservoir includes instruction-extension interfaces, ASIP frameworks, automatic custom-instruction and accelerator discovery, and industrial heterogeneous architecture evidence. Entries already promoted into `report/refs.bib` include:

- Instruction-extension interfaces: `rocket2016`, `nice2024`, `picorv32pcpi2020`, `corevxif2025`, `scaiev2022`;
- ASIP and processor-design suites/frameworks: `cadenceTensilica`, `synopsysASIPDesigner`, `codasipStudio`, `longnail2024`, `assist2019`;
- Automated custom-instruction or custom-accelerator discovery: `clark_processor_2003`, `clark_automated_2005`, `pozzi_exact_2006`, `aditya_automatic_1999`, `goulding-hotta_greendroid_2011`, `ccores2010`, `qscores2011`, `finder2020`, `novia2021`, `AccelSeeker`, `Trireme`, plus local work keys `isamore2026` and `cayman2025`;
- Industrial heterogeneous architecture and deployment context: `tpuv4isca2023`, `nvidiaGB200NVL72`, `cloudmatrix3842025`, `ubmesh2025`.

The source papers consistently treat domain specialization as the response to application diversity and processor generality limits. APS and Aquas start from RISC-V-based ASIP specialization: RISC-V opens a path for adding instruction extensions, and existing domains include signal processing, machine learning inference, cryptography, graphics, point-cloud processing, and LLM inference. ISAMORE frames custom instructions as a way to preserve software programmability while adding specialized hardware units. Cayman broadens this point from custom instructions to custom accelerators, where program regions are offloaded from a processor to synthesized hardware.

The related-work landscape in this family has three levels. The first is instruction-extension interfaces. APS discusses RoCC, NICE, PCPI, TIGRA, CV-X-IF, and SCAIE-V as representative RISC-V ISAX interfaces. These interfaces expose instruction offloading, register-file interaction, and memory access paths, but they differ in coupling mode, portability, and microarchitectural assumptions. The second level is ASIP design frameworks. APS and Clay distinguish commercial suites such as Tensilica, Synopsys ASIP Designer, Codasip Studio, and Andes from academic or open RISC-V-oriented frameworks such as Longnail, ASSIST, and SCAIE-V-based flows. The third level is automated identification or selection of what should be specialized. ISAMORE surveys fine-grained custom-instruction enumeration, coarse-grained custom-instruction generation, syntactic merging, C-Cores, GreenDroid, QsCores, PICO, FINDER, APEX, and RADISH; Cayman surveys candidate-selection frameworks, custom functional unit synthesis, and off-core accelerator synthesis.

The main tension is not whether specialization is useful, but whether specialized capability can be expressed and reused. Existing interfaces often bind a design to one core or one coupling style. Existing automated identification methods frequently optimize hotspots or syntactic commonality, but do not treat semantic reusability as the central selection criterion. Existing candidate-selection flows often select regions without synthesizing high-quality hardware, while HLS flows can synthesize kernels but assume the user has already selected them. For the proposal introduction, this family should support the claim that agile chip design needs an architecture interface that carries application semantics, coupling choices, memory-interface facts, and compiler-visible invocation mechanisms together.

## 2. Architecture-to-Hardware Interface

### Reservoir Coverage and Report Promotion

The broad reservoir includes RTL/eHDL, HLS, hardware DSL, hardware IR, and FPGA framework lines. Entries already promoted into `report/refs.bib` include:

- Hardware languages, HLS, DSLs, and accelerator frameworks: `Chisel`, `BSV`, `Filament`, `VitisHLS`, `LegUp`, `Dynamatic`, `AutoDSE`, `ScaleHLS`, `dahlia2020`, `spatial2018`, `aetherling2020`;
- Hardware IR and infrastructure: `calyx2021`, `firrtl2017`, `hector2022`, `circt2021`;
- Local completed-work keys for the detailed technical chapters: `cement2024`, `clay2025`, `skyegg2026`, `cayman2025`.

The hardware-implementation source papers divide this family into RTL/HDL, HLS, hardware DSL, and hardware IR approaches. Cement explains the productivity gap of traditional HDLs: SystemVerilog, Chisel, BSV, and other embedded HDLs expose low-level structural connections but do not directly express inter-cycle behavior or check timing-correct control. HLS tools such as Vitis HLS and other commercial or academic flows raise the abstraction level, but rely on directives and black-box scheduling heuristics; users often need to infer microarchitectural consequences from reports and pragma behavior. DSLs such as Dahlia, Spatial, Aetherling, HeteroCL, and other domain-specific accelerator languages improve either predictability or design expressiveness in restricted domains, but often fail to support general microarchitectures with deterministic timing. Hardware IR systems such as Calyx, FIRRTL, HECTOR, ESI, and CIRCT provide structured compiler substrates for accelerator generation, controller generation, interconnect modeling, or hardware optimization.

Clay adds the ASIP-specific version of the same problem. Instruction-extension interfaces provide entry points, but the hardware implementation of an instruction still depends on coupling strategy, stateful behavior, register and memory access constraints, and target-processor microarchitectural attributes. In-pipeline coupling is light and efficient for simple combinational instructions, while coprocessor coupling is more flexible for stateful or memory-intensive behavior. Prior frameworks usually support only one coupling style or impose fixed constraints; this makes complex custom instructions difficult to synthesize efficiently.

Cayman contributes the accelerator-synthesis version. HLS and DSE systems optimize manually selected kernels, while candidate-selection systems often stop before hardware synthesis. Custom functional unit synthesis generally restricts itself to data-flow graphs and excludes control flow or memory access. Off-core accelerator synthesis can support control flow and memory access, but often uses sequential control and slow data-transfer interfaces, limiting speedup. Cayman therefore identifies a recurring interface gap: selection, control-flow optimization, memory-interface choice, performance estimation, and hardware sharing are interdependent.

For the proposal introduction, this family should support the claim that hardware generation quality depends on making timing, control, resource, coupling, and data-access facts explicit. It is not enough to move from RTL to a higher-level language. The higher-level object must preserve the hardware facts needed by synthesis, verification, and later compiler use.

## 3. Software-to-Compilation Interface

### Reservoir Coverage and Report Promotion

The broad reservoir includes retargetable compilers, multi-level IR, e-graphs, equality saturation, rule synthesis, strategy-guided rewriting, and hardware-oriented EqSat applications. Entries already promoted into `report/refs.bib` include:

- Compiler and IR substrates: `mlir2021`, `polygeist2021`, `calyx2021`;
- E-graph and equality saturation foundations: `tate2009eqsat`, `egg2021`;
- EqSat and EDA/compiler optimization families: `diospyros2021`, `isaria2024`, `seer2024`, `esyn2024`, `emorphic2025`, `eqmap2025`, `lakeroad2024`;
- Strategy, rule automation, and scalability: `nandi_rewrite_2021`, `cao_babble_2022`, `enumo2023`, `smith_scaling_2024`, `cai2025smoothe`, `aspen2025`, plus local work key `eggmind2026`.

The source papers repeatedly frame compiler infrastructure as the layer that keeps software semantics available long enough for hardware-aware decisions. APS emphasizes compiler support for custom instructions through pattern matching and bitwidth-aware vectorization. Aquas moves this further by using MLIR to represent both hardware-side ISAX behavior and software programs at compatible abstraction levels, then using an e-graph-based matching mechanism to overcome syntactic divergence and premature lowering. ISAMORE treats e-graphs and anti-unification as the means to discover semantically reusable instruction patterns rather than only syntactically similar hotspots.

SkyEgg and EggMind expand this compiler-interface family beyond custom instruction discovery. SkyEgg observes that traditional HLS separates algebraic transformation, scheduling, and hardware mapping into sequential phases. This causes suboptimality because scheduling needs mapping-aware delay and resource knowledge, while mapping needs schedule decisions and transformed algebraic forms. E-graphs allow algebraic rewrites and hardware mapping candidates to coexist in one design space before extraction is reformulated as scheduling. EggMind identifies a later bottleneck: equality saturation can represent large semantic spaces, but strategy design becomes the dominant obstacle once rewrite spaces grow. Manual schedules, guide-based methods, online search, and rule-synthesis systems address pieces of the problem, but do not fully automate reusable strategy artifacts.

The common related-work categories are MLIR-style multi-level IR, LLVM/retargetable compiler infrastructure, pattern matching and vectorization, e-graphs and equality saturation, rewrite-rule synthesis, anti-unification, extraction/scalability work, and strategy-guided equality saturation. The unresolved tension is between semantic richness and tractability. Keeping high-level semantics enables better specialization and mapping, but the resulting space can explode unless the compiler interface also carries target facts, cost models, proof or evidence objects, and reusable control strategies.

For the proposal introduction, this family should support the claim that compilation is not a back-end afterthought. It is the interface that turns application semantics into architecture use, hardware mapping, verification obligations, and reusable optimization evidence.

## 4. Architecture-Constrained Compilation Optimization

### Reservoir Coverage and Report Promotion

The broad reservoir combines compiler-infrastructure entries, system-software framework evidence, and industrial heterogeneous-architecture evidence. This family is no longer written as an independent compilation-to-runtime section in the report; it is folded into architecture-constrained compilation optimization. Entries already promoted into `report/refs.bib` include:

- Framework evidence: `pytorchCompile2026`, `tensorrtllm2026`;
- Hardware-system context: `nvidiaGB200NVL72`, `cloudmatrix3842025`, `ubmesh2025`;
- Local work keys that expose memory-interface and target-architecture constraints: `aquas2026`, `cayman2025`, `isamore2026`, `skyegg2026`, `eggmind2026`.

The local source papers show that compilation optimization is constrained by target hardware facts, not only by source-program semantics. Aquas highlights memory bandwidth, cache effects, scratchpad use, transaction granularity, and robust software offloading as key constraints for complex ISAXs. Cayman models coupled, decoupled, and scratchpad data-access interfaces because memory access choices directly affect acceleration speedup. APS and Clay show that custom instructions must be usable by compiled software, not merely synthesized as hardware. ISAMORE, SkyEgg, and EggMind further show that e-graphs, equality saturation, scheduling, and strategy synthesis only become useful when they carry target facts, cost models, and validation evidence. These source points align with external framework evidence already used in Chapter 1: PyTorch `torch.compile`/TorchDynamo and TensorRT-LLM show that modern AI systems place graph capture, backend compilation, batching, cache management, kernel fusion, and serving infrastructure into the same optimization context.

For the proposal introduction, this family should be written as a convergence line rather than a separate framework list. The key point is that architecture, system-software boundaries, data movement, batching, memory capacity, communication, fallback, profiling, and deployment constraints determine whether compiled hardware capabilities remain useful. Industrial heterogeneous systems such as NVIDIA GB200 NVL72, Huawei CloudMatrix384, and UB-Mesh make this sharper because hardware topology, interconnect, memory hierarchy, and task scheduling become part of the compiler target.

## 5. Automation Through LLMs, Agents, and Formal Methods

### Reservoir Coverage and Report Promotion

The broad reservoir includes early natural-language hardware generation, RTL generation benchmarks, controlled generation, conversational design, repair, and broader software-engineering agents. Entries already promoted into `report/refs.bib` include:

- RTL generation and repair: `dave`, `chipchat`, `chipgpt`, `betterv`, `verilogeval2023`, `verigen2023`, `rtlcoder2023`, `rtlfixer2023`, `autochip2023`, plus local work key `origen2024`;
- Agentic software and algorithm/kernel optimization evidence: `openaiCodex2025`, `anthropicClaudeCode2026`, `alphaevolve2025`, `avo2026`;
- LLM/e-graph/EDA automation: `aspen2025`, `eggmind2026`.

OriGen and EggMind provide the strongest local related-work basis for this family. OriGen surveys LLMs for Verilog generation, Verilog dataset construction, knowledge distillation, and compiler-feedback-based self-reflection. Its related work distinguishes code generation, dataset quality, synthetic RTL data, commercial-model dependence, and feedback-driven repair. This supports a constrained claim: LLMs can enter hardware generation workflows, but data quality, validation feedback, privacy, open-source model capability, and compiler/simulator feedback are necessary conditions.

EggMind moves from generated RTL to formal/compiler optimization strategy. It surveys equality-saturation substrates, rule-synthesis systems, strategic rewriting traditions, expert-designed schedules, guide-based steering, MCTS-style online search, extraction/scalability work, and recent LLM-guided compiler/e-graph optimization. Its main boundary is that free-form code evolution or online per-instance control does not directly yield reusable, checkable EqSat strategies. A reusable strategy language, proof-derived motifs, tractability guidance, and validation across related cases are needed to make LLM-guided optimization stable.

For the proposal introduction, this family should not claim that LLMs solve chip design. The correct synthesis is: agentic methods become relevant when they are embedded in a collaboration mechanism among model, tool, target constraint, execution feedback, formal or executable oracle, and evidence memory. Hardware design and compiler optimization require stricter constraints than ordinary software editing because errors can involve protocol violations, timing failure, semantic miscompilation, area and power regressions, or non-reproducible performance.

## Integration Guidance for Chapter 1

Chapter 1 should not list APS, Aquas, ISAMORE, Cayman, Cement, Clay, SkyEgg, OriGen, and EggMind one by one in the related-work section. Their role in Chapter 1 is to provide evidence for four interface-level research families:

1. Application-to-architecture: domain applications become architecture capabilities through ISAX, ASIP, and custom accelerator interfaces.
2. Architecture-to-hardware: architecture capabilities become reliable implementations only when timing, resource, control, coupling, and data-access facts are explicit.
3. Architecture-constrained compilation optimization: compiler infrastructure preserves semantics, explores equivalent forms, selects mappings, and records reusable optimization evidence under target hardware and system-software constraints.
4. Agentic methods: agentic methods need a model-tool-target-evidence collaboration mechanism constrained by IR, semantics, execution feedback, and verification.

The introduction should use the source-paper related work to establish the following overall judgment:

> Existing research has strong foundations at each interface, but the foundations are fragmented. Agile chip design requires a compiler-centered co-design framework in which architecture interfaces express reusable hardware capability, hardware frontends preserve implementation constraints, compiler interfaces organize semantic and target evidence under architecture and system-software constraints, and agentic automation remains bounded by formal or executable checks.

## Source Citation Inventory

This inventory records citation keys extracted from the inspected source-paper introduction/background/related-work sections. `in report refs` means the source key or an equivalent normalized key is now present in `report/refs.bib` and can be cited in Chapter 1. `candidate local keys` means the source section cites it, but it is not yet promoted because the report has not yet interpreted that work directly.

- `resources/aps/sec/0_intro.tex`
  - in report refs: `asanovic2016rocket -> rocket2016`, `CORE-V-XIF -> corevxif2025`, `longnail -> longnail2024`, `cadence_design_systems_inc_cadence_nodate -> cadenceTensilica`, `synopsys_inc_synopsys_nodate -> synopsysASIPDesigner`, `codasip_codasip_nodate -> codasipStudio`;
  - candidate local keys: `gautschi_near-threshold_2017`, `armeniakos_mixed-precision_2025`, `cheng_risc-v_2024`, `ferrandi_invited_2022`, `hector`, `clay`, `chipyard`, `croc`, `pulp`.
- `resources/aps/sec/5_related_works.tex`
  - in report refs: `nice -> nice2024`, `pcpi -> picorv32pcpi2020`, `CORE-V-XIF -> corevxif2025`, `scaie-v -> scaiev2022`, `codasip_codasip_nodate -> codasipStudio`, `longnail -> longnail2024`, `assist -> assist2019`;
  - candidate local keys: `rocc`, `tigra`, `tie`, `van_praet_nml_2008`, `jiang_blueface_2023`, `zagieboylo_pdl_2022`, `LLVM`, `HeteroCL`, `tvm`, `Triton`, `tree_matching`, `nuzman_auto-vectorization_2006`.
- `resources/aquas/sec/0_intro.tex` and `resources/aquas/sec/1_preliminary.tex`
  - in report refs: `synopsys_inc_asip_2025 -> synopsysASIPDesigner`, `oppermann_longnail_2024 -> longnail2024`, `openhw_group_openhwgroupcore-v-xif_2026 -> corevxif2025`, `damian_scaie-v_2022 -> scaiev2022`;
  - candidate local keys: `waterman_risc-v_2014`, `amid_chipyard_2020`, `lattner_mlir_2021`, `eldridge_mlir_2021`, `xu_hector_2022`, `ye_scalehls_2022`, `josipovic_dynamatic_2025`, `zhang_better_2023`, `zayed_dialegg_2025`, `merckx_eqsat_2025`.
- `resources/isamore/tex/1_introduction.tex`, `2_background.tex`, and `7_related_work.tex`
  - in report refs: `asanovic_rocket_2016 -> rocket2016`, `cadence_design_systems_inc_cadence_2025 -> cadenceTensilica`, `codasip_codasip_2025 -> codasipStudio`, `synopsys_inc_synopsys_2025 -> synopsysASIPDesigner`, `oppermann_longnail_2024 -> longnail2024`, `trilla_novia_2021 -> novia2021`, `venkatesh_conservation_2010 -> ccores2010`, `venkatesh_qscores_2011 -> qscores2011`, `gnanasambandapillai_finder_2020 -> finder2020`, `vanhattum_vectorization_2021 -> diospyros2021`, `thomas_automatic_2024 -> isaria2024`, `cheng_seer_2024 -> seer2024`, `chen_e-morphic_2025 -> emorphic2025`, `chen_e-syn_2024 -> esyn2024`;
  - candidate local keys: `clark_processor_2003`, `clark_automated_2005`, `pozzi_exact_2006`, `giaquinta_maximum_2015`, `gonzalez-alvarez_accelerating_2013`, `gonzalez-alvarez_mingle_2016`, `goulding-hotta_greendroid_2011`, `aditya_automatic_1999`, `melchert_apex_2023`, `willsey_iterative_2019`, `gordon_plotkin_lattice_1970`, `john_c_reynolds_transformational_1970`, `cao_babble_2022`.
- `resources/cayman/doc/1_introduction.tex` and `2_background.tex`
  - in report refs: `SCAIEV -> scaiev2022`, `ASSIST -> assist2019`, `Longnail -> longnail2024`, `FINDER -> finder2020`, `NOVIA -> novia2021`, `CCORES -> ccores2010`, `QSCORES -> qscores2011`;
  - candidate local keys: `AccelSeeker`, `Trireme`, `VitisHLS`, `Hector`, `Dynamatic`, `S2FA`, `AutoDSE`, `ScaleHLS`, `Cong04`, `Paolo03`, `Pozzi06`, `Clark03`, `APPEND`, `RegionSeeker`, `AccelMerger`, `GreenDroid`, `AccHLS`.
- `resources/cement/doc/1_Introduction.tex`, `2_Background_Motiviation.tex`, and `7_Related_Work.tex`
  - in report refs: `Dahlia -> dahlia2020`, `Spatial -> spatial2018`, `Aetherling -> aetherling2020`, `FIRRTL -> firrtl2017`, `CIRCT -> circt2021`;
  - candidate local keys: `Chisel`, `BSV`, `Filament`, `VitisHLS`, `Calyx`, `HiSparse`, `SpinalHDL`, `PyMTL`, `Magma`, `MyHDL`, `PyRTL`, `PyGears`, `Amaranth`, `Lava`, `Clash`, `Shakeflow`, `Silice`, `PipelineC`, `Rigel`, `Darkroom`, `Halide-HLS`, `ScaleHLS`, `DNNWeaver`, `P4FPGA`, `SODA`, `Fleet`, `HeteroCL`, `PolySA`, `AutoSA`, `Tensorlib`, `AutoPilot`, `LegUp`.
- `resources/clay/sec/0_intro.tex`, `1_preliminaries.tex`, and `4_related.tex`
  - in report refs: `cadence_design_systems_inc_cadence_nodate -> cadenceTensilica`, `synopsys_inc_synopsys_nodate -> synopsysASIPDesigner`, `codasip_codasip_nodate -> codasipStudio`, `nuclei_system_technology_nice_nodate -> nice2024`, `openhw_group_core-v_2025 -> corevxif2025`, `asanovic_rocket_2016 -> rocket2016`, `damian_scaie-v_2022 -> scaiev2022`, `oppermann_longnail_2024 -> longnail2024`;
  - candidate local keys: `hoffmann_methodology_2001`, `jain_asip_2001`, `ienne_customizable_2006`, `mishra_adl-driven_2008`, `liyanage_accelerating_2024`, `andes_technology_andes_nodate`, `van_praet_nml_2008`, `liu_rapid_2019`, `bluespec_inc_accelerate-hls_nodate`.
- `resources/skyegg/doc/1_introduction.tex`, `2_background.tex`, and `8_related_work.tex`
  - in report refs: `durst_type-directed_2020 -> aetherling2020`, `cheng_seer_2024 -> seer2024`, `chen_e-syn_2024 -> esyn2024`, `chen_e-morphic_2025 -> emorphic2025`, `smith_fpga_2024 -> lakeroad2024`, `hofmann_eqmap_2025 -> eqmap2025`;
  - candidate local keys: `amd_inc_vitis_2025`, `xu_hector_2022`, `josipovic_dynamically_2018`, `nigam_compiler_2021`, `canis_legup_2013`, `cabodi_speeding-up_2010`, `tan_mapping-aware_2015`, `wang_mapbuf_2023`, `coward_automatic_2022`, `smith_scaling_2024`, `guo_autobridge_2021`, `guo_tapa_2023`, `guo_rapidstream_2022`, `lau_rapidstream_2024`.
- `resources/origen/1_Introduction.tex` and `2_Background.tex`
  - in report refs: `verigen -> verigen2023`, `verilogeval -> verilogeval2023`, `rtlcoder -> rtlcoder2023`, `rtlfixer -> rtlfixer2023`, `autochip -> autochip2023`;
  - candidate local keys: `dave`, `rtllm`, `betterv`, `mcts`, `chipchat`, `chipgpt`, `gpt4aigchip`, `sweagent`, `distillation`, `stackv2`, `deepseek`, `qwen`, `chateda`, `chipnemo`.
- `resources/eggmind/tex/1_introduction.tex`, `2_background.tex`, and `8_related_work.tex`
  - in report refs: `seer_24_chen -> seer2024`, `emorphic_25_chen -> emorphic2025`, `Zhang2025ASPENLE -> aspen2025`, `thomas_automatic_2024 -> isaria2024`, `vanhattum_vectorization_2021 -> diospyros2021`, `pal_equality_2023 -> enumo2023`, `hofmann_eqmap_2025 -> eqmap2025`;
  - candidate local keys: `max_willsey_egg_2021`, `zhang_better_2023`, `cao_babble_2022`, `nandi_rewrite_2021`, `koehler_sketch_guided_eqsat_2022`, `koehler_guided_eqsat_2024`, `he2023mctsgebmontecarlotree`, `hartmann_tensor_eqsat_mcts_2024`, `cai2025smoothe`, `yin2025boost`, `visser_2001_stratego`, `borovansky_2001_elan`, `maude_strategy_language`, `novikov2025alphaevolvecodingagentscientific`, `chen2026magellanautonomousdiscoverynovel`, `qiu2026passbypassoptimizationintentdrivenir`, `mikek2026agenticcodeoptimizationcompilerllm`.

Current coverage summary: the inspected source sections contain 286 distinct local citation keys. This revision promotes 53 source keys or equivalent normalized report keys into `report/refs.bib`, focusing on works actually interpreted in Chapter 1. Candidate keys remain available above for later expansion if a future draft needs finer-grained discussion.
