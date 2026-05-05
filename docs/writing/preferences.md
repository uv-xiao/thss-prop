# Writing Preferences

This file records project-specific preferences that are important but less universal than `.agents/rules/`.

## Current Preferences

- During serious report-quality improvement, use the project-local `grill-me` skill repeatedly to align on one writing or research-design decision at a time.
- The report theme is “敏捷芯片设计与创新性编译技术驱动的软硬件协同”. Do not reframe it as AI education, intelligent programming education, or a narrow C/system programming learning system.
- The central relation should be “编译技术作为连接应用需求、硬件结构、综合优化、验证证据和运行时系统的中枢”.
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
- The third future-work direction is “面向工业级异构架构的算子-运行时编译协同”. Use `resources/seed-proposal.docx` as source material for this direction, especially the long-horizon chip-operator optimization Agent Harness, fused/Torch operators, profiling, validation, and formal/IR-assisted optimization loop.
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
