# Reference Report Analysis: 博士开题报告-陈仁泽.pdf

Source: `resources/博士开题报告-陈仁泽.pdf`

This note extracts reusable writing patterns from the reference report. It is not report text and must not be copied into the thesis proposal.

## Basic Shape

- The document is a full doctoral topic report with cover, copyright statement, Chinese abstract, English abstract, table of contents, figure/table/code indexes, main chapters, references, and originality statement.
- The main text is organized as six chapters:
  - introduction;
  - three completed research chapters;
  - future work;
  - conclusion.
- The report uses a “central bottleneck -> completed research -> future extension” structure. The completed work chapters are not isolated paper summaries; each chapter re-enters the same central problem from a different technical angle.
- The future-work chapter is structurally explicit: research background and problem analysis, framework design, key implementation, expected technical characteristics, and validation/application plan.

## Introduction Pattern To Learn

The introduction follows a disciplined narrowing sequence:

1. Establish the broad technical field.
2. Explain the concrete pressure or bottleneck.
3. Decompose the pressure into sources.
4. Review existing method families.
5. State limitations of those method families.
6. Give core research questions.
7. List completed work as evidence of research basis.
8. List planned work as a natural continuation.
9. Explain the report structure.

For this project, the analogous sequence should be:

1. Industry demand and compute pressure.
2. Why agile chip design and domain specialization matter.
3. Why hardware innovation alone is insufficient without compilation, verification, and runtime support.
4. Review method families: ASIP/ISAX, hardware frontends, HLS/synthesis, compiler IR/e-graph, AI-assisted design, runtime systems.
5. State the toolchain fragmentation and evidence-gap limitations.
6. State research questions around compiler-centered hardware-software co-design.
7. Present APS/Aquas, ISAMORE, Cement, SkyEgg, HECTOR, EggMind, and OriGen as completed basis.
8. Present the future work as three general research directions, not tool names: explainable and auditable compiler infrastructure; verification-constrained architecture/hardware/compiler co-generation; operator optimization and runtime-compiler co-design for industrial heterogeneous architectures. Present EggMind as completed work in the large-model-and-formal-techniques chapter.
9. Explain chapter organization.

## Completed-Work Chapter Pattern

Each completed-work chapter in the reference report tends to use this internal structure:

- Chapter introduction: restate the local problem and why it belongs to the central bottleneck.
- Background and motivation: define technical objects and show why existing approaches are insufficient.
- Design overview: introduce the system idea before low-level details.
- Core method sections: explain representations, algorithms, rules, or architecture.
- Experimental evaluation: state setup, baselines, metrics, and results.
- Related work: compare against neighboring method families.
- Chapter conclusion: summarize contribution and state how it opens later work.

For this project, representative-work sections should avoid becoming publication abstracts. A strong section should answer:

- What bottleneck does this work attack?
- What abstraction or compiler idea makes the attack possible?
- What system artifact was built?
- What evidence supports the claim?
- How does it feed the larger “compiler-centered hardware-software co-design” theme?

## Future-Work Pattern

The reference report gives future work its own chapter and uses a stable subsection pattern:

- research background and problem analysis;
- framework design idea;
- key technical implementation;
- expected technical characteristics;
- validation and application planning.

This pattern is directly useful, but this project should expand it because the user wants future work to receive substantial space. For each future direction, use:

- Problem: what current limitation remains after existing work?
- Research question: what can be answered by the proposed work?
- Approach: what representation, system, algorithm, or validation mechanism will be built?
- Dependencies: which completed work provides the foundation?
- Expected output: prototype, method, paper, open-source artifact, benchmark, or evaluation result.
- Validation: benchmarks, case studies, correctness checks, performance metrics, or reproducibility evidence.
- Risk: what may fail and how the plan will adapt.

## Language and Organization Lessons

- Use direct chapter and subsection titles that expose the technical object.
- Prefer a short paragraph that states the problem before listing technical components.
- Introduce a system by its design role, not only by its name.
- Use figures, tables, algorithms, and formulas to carry system structure and evaluation evidence.
- For this report, existing-work figures should be selected from `resources/` when available. If no figure exists for the overall research story, chapter relation, or future-work closed loop, draw a new figure instead of leaving the argument purely textual.
- Put contribution bullets after the local problem and method have been explained enough to be meaningful.
- Use quantitative results only with clear metric, baseline, and condition.
- End chapters with a local conclusion that connects back to the overall thesis direction.

## Caveats

- The reference introduction contains broad field overview material. For this project, avoid spending too much space on generic background; committee readers likely need the bottleneck and research question more than a long primer.
- The reference future-work chapter is comparatively short. This project should allocate more space to future research design because the user explicitly wants future work to be substantial.
- The reference report can be used for structural learning, not for wording reuse.

## Actionable Rules For This Report

- The report should use a cross-hardware-architecture co-design relation: compilation and architecture are the two key interface layers connecting application demand, hardware capability, synthesis optimization, verification evidence, and runtime systems.
- The introduction must end with explicit research questions and a map from existing work to future work.
- Existing work should use three technical layers, not four: domain specialization and end-to-end co-design; hardware frontend and synthesis optimization; large models and formal techniques for hardware-software co-design.
- The co-design framework and instruction/microarchitecture customization work should be merged into one layer because they jointly answer how domain-specific hardware capability is discovered, generated, mapped, and reused.
- Within the first layer, APS/Aquas can establish the framework logic first, but ISAMORE must be developed with at least equal space because focused optimization techniques and the overall co-design framework are equally important.
- Cayman should be an important subsection in the domain-specialization chapter, and Clay should be an important subsection in the hardware-frontend chapter, because they are first-author/co-first-author works.
- HECTOR should be carefully summarized as supporting infrastructure, not treated as a full representative-work chapter.
- EggMind should be presented as existing work, not future work. Future work may discuss extensions that build on EggMind, but the main EggMind narrative belongs in the completed-work chapters.
- EggMind should be written using the completed-work chapter pattern: method, system, experiments, and significance.
- If the future-work chapter refers back to EggMind, the transition must identify a remaining problem that EggMind does not by itself close, such as explainable compiler infrastructure, verified hardware generation, or runtime feedback.
- Future-work section titles should be general research directions rather than tool or repository names. Tool names can appear inside the sections as foundations or prototypes.
- Open-source ecosystem, patents, awards, and industry-university collaboration are not report-level structural themes. Keep the structure focused on technical argument.
- Each existing-work section must include local problem, method idea, evidence, and connection to the main theme.
- Each future-work section must include problem, research question, approach, dependencies, expected output, validation, and risk.
- The conclusion should not merely recap papers; it should restate how the completed and planned work form a coherent hardware-software co-design program.
- Unlike the current skeletal draft, the final report should use the abundant local source material to give detailed explanation in each major section. The reference report's chapters are useful because they patiently develop background, motivation, method, evaluation, and conclusion rather than staying at abstract level.
- The target main-text length is 60-80 pages, with appropriate figures.
