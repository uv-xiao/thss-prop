# Writing Preferences

This file records project-specific preferences that are important but less universal than `.agents/rules/`.

## Current Preferences

- During serious report-quality improvement, use the project-local `grill-me` skill repeatedly to align on one writing or research-design decision at a time.
- The report theme is “敏捷芯片设计与创新性编译技术驱动的软硬件协同”. Do not reframe it as AI education, intelligent programming education, or a narrow C/system programming learning system.
- The central relation should be cross-architecture hardware-software co-design ecology. Compilation and architecture are the two key interface layers that connect software demand, hardware capability, synthesis optimization, verification evidence, and runtime systems.
- In the introduction's related-work review, classify literature by co-design interfaces rather than by paper or technology object: application-to-architecture, architecture-to-hardware, software-to-compilation, compilation-to-runtime, and automation through large models plus formal techniques.
- Keep the introduction's five interface categories in this order: application-to-architecture, architecture-to-hardware, software-to-compilation, compilation-to-runtime, and automation through large models plus formal techniques.
- Do not add a core-question mapping table in Chapter 1.5. Use continuous academic narrative for problem convergence; use the Chapter 1.7 structure figure for mapping.
- The introduction should converge to exactly three core research questions, not four or five. The five interface categories are for literature organization; the three questions are the report's research-problem scaffold.
- At the end of the introduction, map chapters to research questions using “primary question + secondary support”. Avoid rigid one-to-one mapping, but keep each chapter's main role explicit.
- In the introduction, delay the user's own completed work until section 1.6. Sections 1.1-1.4 should build the field review and problem chain first, without turning into an achievement summary.
- Chapter 1 needs industry data and recent top architecture-conference evidence, not only qualitative claims. Use `docs/writing/introduction-evidence-plan.md` before drafting the introduction.
- Prefer introduction evidence from large-company authors, industrial research labs, authoritative experts, industrial system papers, official technical reports, and top architecture/systems conferences.
- Introduce evidence through representative examples at key argument transitions. Evidence tables are optional and should only be included if they improve verifiability without making the introduction feel like a technical report.
- For heterogeneous architecture complexity and programming concerns, prefer ATLAS/DeepStack, Huawei CloudMatrix384/UB-Mesh, and NVIDIA GB200 NVL72/IMEX over ISCA AIO or MICRO SCAR.
- For the compilation-to-runtime interface, prefer PyTorch 2 `torch.compile`/TorchDynamo and NVIDIA TensorRT-LLM as primary framework evidence; use NVL72/CloudMatrix/UB-Mesh as hardware-system context rather than as the primary framework evidence.
- In the compilation-to-runtime review, make inference the main thread and training/general dynamic programs the supplement. Use TensorRT-LLM as the primary serving-runtime example and PyTorch/Dynamo as supporting evidence for dynamic graph capture and backend compilation.
- In Chapter 1.1, use AI/LLM as the main application pressure, then use PQC, DSP, point cloud, graphics, and other domains as evidence of domain-specialization diversity. Do not make the report appear to be only about LLM serving.
- Introduce “敏捷芯片设计” in Chapter 1.2 after explaining design-productivity and iteration bottlenecks. Define it as rapid formation, verification, mapping, and iteration of domain hardware capabilities, not merely faster RTL writing.
- In Chapter 1.3, explicitly define architecture interface and compilation interface. Architecture interface defines what hardware capabilities are exposed; compilation interface defines how software discovers, uses, optimizes, and verifies those capabilities.
- The three core research questions should explicitly use architecture interface in question 1 and compilation interface in question 3.
- Keep the first chapter title as “引言”. Use subsection titles and overview figures to carry specificity.
- Add a central thesis sentence near the end of 1.3 or the start of 1.5. It should bridge the field review to the three core research questions; refine wording during drafting.
- Learn structure from `resources/博士开题报告-陈仁泽.pdf`, especially its introduction narrowing sequence, completed-work chapter loop, and future-work subsection pattern; do not copy its wording.
- Organize existing work into three technical layers. Merge “协同框架” and “指令/微架构定制” because they are one domain-specialization and end-to-end co-design layer.
- In the first layer, APS/Aquas should appear first as the framework entry, but ISAMORE must receive no less space than APS/Aquas combined.
- Cayman is an important subsection in the domain-specialization and end-to-end co-design chapter because it is first-author/co-first-author work.
- Clay is an important subsection in the hardware-frontend and synthesis-optimization chapter because it is first-author/co-first-author work.
- HECTOR should be emphasized and carefully summarized, but not expanded like first-author representative work because the user is second author.
- EggMind should be presented as existing work in a chapter about large models and formal techniques for hardware-software co-design. Do not put the main EggMind narrative in the future-work chapter.
- Write EggMind as complete existing work, with method, system, experiments, and significance. Do not soften it into only preliminary basis unless later evidence forces a narrower statement.
- In the future-work chapter, mention EggMind only as existing foundation that motivates a remaining system problem. The transition must be explicit and logically necessary, not a sudden name drop.
- Name future-work sections as general research directions, not tool or repository names. IntelliC, Spine, and PTO Runtime distributed features may appear as existing foundations, prototypes, or internal system names inside those sections.
- The third future-work direction is “面向工业级异构架构的算子优化与运行时编译协同”. Use `resources/seed-proposal.docx` as source material for this direction, especially the long-horizon chip-operator optimization Agent Harness, fused/Torch operators, profiling, validation, and formal/IR-assisted optimization loop.
- Agent Harness should appear only where it is technically needed, especially for long-horizon chip-operator optimization from `seed-proposal.docx`. Do not imply that PTO Runtime distributed features itself currently has an agent plan.
- In the third future-work direction, treat chip-operator automatic optimization Agent Harness and PTO Runtime distributed features as parallel sublines that meet at industrial heterogeneous architecture. Do not force them into an upstream/downstream closed-loop relation.
- The fourth completed-work chapter title is “大模型与形式化技术驱动的软硬件协同方法”.
- Do not make open-source ecosystem, patents, awards, or industry-university collaboration a structural theme of the report. Mention such facts only when they directly support a technical claim and are source-backed.
- Treat the overall co-design framework and focused single-point optimization techniques as equally important.
- Current report text is too skeletal. Use the abundant material in `resources/` to expand every major part into a detailed, patient, serious, and coherent story.
- For ISAMORE, describe both reusable custom instructions as an agile-chip-design mechanism and e-graph anti-unification as a method innovation in detail.
- The report should foreground industrial background, engineering challenges, scientific question formation, systematic analysis, and targeted future research design.
- Existing technical accumulation should be accurate and concrete, but it should support the opening-report argument rather than dominate it.
- Future work should receive substantial space and should include research ideas, system design, validation route, feasibility, and risks.
- Target the main text at 60-80 pages.
- Add figures where they help the argument. Prefer figures from `resources/` for existing work, and draw new figures directly when the needed overall framework or logic diagram does not exist.
- The introduction should include two newly drawn overview figures: “跨硬件架构软硬件协同生态” and “研究问题与章节映射”.
- The writing should be dense, logical, and restrained. Avoid long generic introductions.
- Translation should preserve the English source's technical modality and scope.
- The report should not include the terminology table as a visible section unless explicitly requested.

## Preferred Argument Moves

- Start from a concrete industrial or engineering pressure, then narrow to a research challenge.
- Turn a challenge into a question before proposing a method.
- Use comparisons to explain why the proposed method is targeted.
- Use existing systems as evidence of feasibility and accumulated insight.
- Make future plans measurable through artifacts, experiments, case studies, or evaluation criteria.

## Phrases To Avoid Unless Evidence Supports Them

- “具有重要意义”
- “显著提升”
- “彻底解决”
- “首次提出”
- “完整证明”
- “革命性改变”

## Source Style Baseline

- Chinese and mixed-language style baseline: RightCapitalHQ Chinese Style Guide.
- Institutional thesis-writing baseline: Tsinghua Graduate Thesis Writing Guide and the DHS thesis topic report requirements.
