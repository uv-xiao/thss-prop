# Report Argument Rules

These rules apply to every substantive change to `report/main.typ`, `report/sections/`, `report/refs.bib`, and writing notes that shape the proposal.

## Proposal Purpose

- The report is an opening report for a thesis project. It must justify why the work should be done, why the proposed research questions matter, why the existing preparation is credible, and why the proposed plan is feasible.
- The report must not read like a finished paper, a software manual, or a project retrospective.
- Existing technical accumulation is supporting evidence. Future work, problem framing, research design, and feasibility deserve substantial space.
- The central relation is compiler-centered hardware-software co-design: innovative compilation techniques connect application demand, hardware structures, synthesis optimization, verification evidence, and runtime systems.
- Current report sections are skeletal drafts. Future revisions must use the abundant source material under `resources/` to make each part detailed, patient, and fully argued.
- Do not leave major work descriptions at abstract-summary depth. A representative work needs background, concrete bottleneck, design motivation, method structure, technical mechanism, evaluation evidence, limitation or remaining question, and connection to the report theme.

## Required Argument Arc

Every full-report revision must preserve this arc:

1. Industrial and engineering background: explain why the class of systems matters in practice and what current development pressure creates the research opportunity.
2. Concrete challenges: identify the bottlenecks, failure modes, or unresolved tensions that cannot be solved by routine engineering alone.
3. Scientific or research questions: summarize the challenges into explicit research questions, not vague topics.
4. Existing basis: show accumulated systems, prototypes, codebases, experiments, or related work accurately and without exaggeration.
5. Systematic analysis: compare existing methods, projects, or design choices through a consistent framework.
6. Targeted research approach: connect each future method, experiment, or system design decision to a stated challenge or research question.
7. Feasibility and schedule: state available materials, skills, implementation basis, verification plan, risks, and dated milestones.

## Reference Report Pattern

- Use `docs/writing/reference-report-analysis.md` when planning chapter structure.
- The introduction should narrow from field pressure to bottleneck, method-family limitations, research questions, completed basis, future directions, and report structure.
- Each completed-work chapter or major section should contain local problem, background/motivation, design overview, core method, evaluation evidence, related comparison, and a local conclusion when space permits.
- Each future-work direction should contain problem analysis, research question, framework design, key technical implementation, expected technical characteristics, validation/application plan, and risk.
- Do not copy wording from the reference report. Learn its organization and adapt it to this report's theme.

## Alignment Gate

- Before major restructuring, formal section drafting, or committing a new report argument, use `.agents/skills/grill-me/SKILL.md` to ask the user one decision question at a time.
- If the question can be answered from `report/`, `resources/`, `docs/writing/`, or existing harness files, inspect those files first instead of asking.
- Each grill-me round should resolve one branch of the report design tree, such as research object, industry framing, challenge taxonomy, research question wording, evidence priority, future-work scope, evaluation plan, or section length allocation.
- Record durable decisions from grill-me rounds through `.agents/skills/evolve-writing-rules/SKILL.md` when they affect future writing.

## Section-Level Requirements

- Each section must have one controlling claim. If a section only lists facts, revise it until the facts support a claim.
- Each paragraph must either establish background, narrow the problem, compare alternatives, justify a method, present evidence, or connect the argument to the next step.
- The first sentence of a paragraph should make the paragraph's role clear. Avoid opening with an unsupported broad claim.
- Transitions must carry logic, not decoration. Prefer forms such as “因此，本报告将……”, “这一限制直接导致……”, “与上述方法相比……”, and “基于这一判断……”.
- Do not introduce future work without explaining what problem it answers and how success will be assessed.
- Do not describe a system feature as research contribution unless it is linked to a research question, evaluation method, or generalizable design insight.
- In the first existing-work layer, do not let the end-to-end framework narrative crowd out ISAMORE. ISAMORE must receive no less space than APS/Aquas combined.
- Treat the overall co-design framework and focused single-point optimization techniques as equally important; the report needs both system architecture and deep technical mechanisms.
- For ISAMORE specifically, describe both sides in detail: reusable custom instructions as a key mechanism for agile chip design, and e-graph anti-unification as the core method innovation enabling reusable instruction discovery.

## Research Question Discipline

- A research question must be answerable by the proposed work.
- A research question must have a clear object, scope, and evaluation basis.
- Avoid empty forms such as “研究 X 的方法”“探索 Y 的应用”“分析 Z 的现状”.
- Prefer precise forms such as “在约束 A 下，如何通过机制 B 改善性质 C，并以指标 D 或案例 E 验证？”

## Word Budget

- The body text must be at least 5000 Chinese characters unless the user explicitly changes the institutional requirement.
- The target full-report body should normally stay within 8000-12000 Chinese characters before appendices.
- Do not let literature review and existing accumulation crowd out future research design. A healthy default allocation is:
  - background and challenges: 15%-20%;
  - literature and related systems: 20%-25%;
  - research questions and systematic analysis: 20%-25%;
  - proposed methods and future work design: 25%-30%;
  - feasibility, risks, and schedule: 10%-15%.
- For a single section edit, keep the section proportional to its role. Do not solve missing argument structure by adding long exposition.
- Length control must not be used as an excuse for superficial writing. If a section is short because it lacks evidence, mine `resources/` first and then expand with controlled structure.

## No Overclaiming

- Use “拟”“计划”“预期”“尝试”“将评估” for future work unless results already exist.
- Use “表明”“显示”“支持” only when evidence is cited or locally available.
- Avoid “首次”“显著”“领先”“完全”“根本解决”“充分证明” unless supported by explicit evidence and reviewed by the citation profile.
