# Human Words: Agent Harness

## Timeline

- 2026-05-05 00:00 Asia/Shanghai - Initial report harness requirements
  > 按照resources/IntelliC/.agents, 我们需要构建报告写作的agent harness系统。其中，skills需要先包括与github协作的skills。agents/rules/templates则需要根据写作迭代任务和报告审稿任务进行特调。尤其是rules, 需要包含非常详细的中文写作要求。参考https://github.com/RightCapitalHQ/chinese-style-guide， https://www.dhs.tsinghua.edu.cn/wp-content/uploads/2023/12/2024031107044595.pdf。此外，我们需要非常强的约束保证整个报告的写作篇幅合理、逻辑通畅完整、技术与英文原文对应且翻译准确恰当。因为我们是开题报告，我们需要着重突出产业背景、挑战、科学问题总结、系统性分析、解决方法的针对性研究思路，等这些方面。当然，也需要对现有技术积累进行准确的展示，但未来工作的思路和设计值得相当的篇幅。 我们还需要构建一套详细准确的无幻觉的引用（.bib），以及一套中英文术语对照表（不出现在文章中）。我们还需要一个agent机制来记录、进化我们的写作要求，及从每次对文章段落的修改意见中提炼出agent写作规则与偏好。
  - Context: User requested a thesis proposal writing harness based on `resources/IntelliC/.agents`.
  - Related: `AGENTS.md`, `.agents/`, `docs/writing/`
  - Agent interpretation: Build a repo-local harness with GitHub skills, report-writing and review workflows, detailed Chinese academic writing rules, citation and terminology controls, and a mechanism to preserve and promote user feedback into durable rules.

- 2026-05-05 00:00 Asia/Shanghai - Add grill-me for report quality improvement
  > With the skills and harness ready, 我们需要开始详细的耐心的严肃的认真的报告质量提升。你需要在项目内添加https://github.com/mattpocock/skills/blob/main/skills/productivity/grill-me/SKILL.md 这个skill，并且在报告提升过程中反复使用来和我对齐。
  - Context: User requested project-local installation of `grill-me` and repeated use during report improvement.
  - Related: `.agents/skills/grill-me/SKILL.md`, `.agents/rules/report-argument.md`, `docs/writing/preferences.md`
  - Agent interpretation: Add project-local `grill-me` and make it an alignment gate for major report design, structure, and drafting decisions.

- 2026-05-05 00:00 Asia/Shanghai - Correct report theme
  > 二者都不是很好的主题，我的报告主题应为“敏捷芯片设计与创新性编译技术驱动的软硬件协同”
  - Context: First grill-me alignment question offered two unsuitable theme framings.
  - Related: `report/main.typ`, `report/docs/report_spec.md`, `report/docs/agent_writing_guidelines.md`, `docs/writing/preferences.md`, `docs/writing/terminology.md`
  - Agent interpretation: The report should be framed around agile chip design and innovative compilation techniques as drivers of hardware-software co-design, not around AI education or intelligent programming.

- 2026-05-05 00:00 Asia/Shanghai - Confirm compiler-centered co-design relation and add reference report
  > 认同。此外，我提供了一个范文在resources/下，名为“博士开题报告-陈仁泽.pdf”，你需要提炼能学习的东西，包括结构、组织、语言要求、等等。
  - Context: User confirmed the second grill-me answer and supplied a reference opening report for structural learning.
  - Related: `resources/博士开题报告-陈仁泽.pdf`, `docs/writing/reference-report-analysis.md`, `.agents/rules/report-argument.md`, `report/docs/report_spec.md`
  - Agent interpretation: Treat compilation as the central connector in hardware-software co-design, and extract reusable report structure from the reference PDF without copying wording.

- 2026-05-05 00:00 Asia/Shanghai - Merge co-design framework and instruction customization layers
  > 你的建议是对的，但我们不需要四个技术层次，协同框架与指令/微架构定制 可以合并。
  - Context: Follow-up to grill-me question about whether to use four technical layers.
  - Related: `report/main.typ`, `report/docs/report_spec.md`, `report/docs/agent_writing_guidelines.md`, `docs/writing/reference-report-analysis.md`, `docs/writing/preferences.md`
  - Agent interpretation: Organize existing work into three technical layers and merge APS/Aquas with ISAMORE/Cayman/Clay into one domain-specialization and end-to-end co-design layer.
