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

- 2026-05-05 00:00 Asia/Shanghai - Keep ISAMORE at least as prominent as APS/Aquas
  > 你的建议是正确的，但篇幅上，isamore是我的非常重要的工作，需要占据不少于aps/aquas的篇幅。整体的协同框架和单点的优化技术一样重要！
  - Context: Follow-up to grill-me question about APS/Aquas and ISAMORE ordering inside the first layer.
  - Related: `report/docs/report_spec.md`, `report/docs/agent_writing_guidelines.md`, `.agents/rules/report-argument.md`, `docs/writing/preferences.md`, `docs/writing/reference-report-analysis.md`
  - Agent interpretation: Use APS/Aquas first for logical framing, but allocate ISAMORE at least equal space and preserve deep technical treatment for focused optimization work.

- 2026-05-05 00:00 Asia/Shanghai - Require detailed expansion from resources and detailed ISAMORE treatment
  > 当前所有部分的文字都过于简略，事实上resources/内有充足的文字资料以供在各部分进行添加，并且整体故事的讲述也需要非常详尽。这应该变成一个重要的要求。对于问题5: 二者都要，并且都需要详细描述。
  - Context: User corrected the writing depth requirement and answered grill-me question 5.
  - Related: `.agents/rules/report-argument.md`, `.agents/rules/evidence-citations-translation.md`, `.agents/skills/report-draft-section/SKILL.md`, `report/docs/agent_writing_guidelines.md`, `report/docs/report_spec.md`, `docs/writing/preferences.md`
  - Agent interpretation: Treat current text as skeletal, require source-backed expansion from `resources/`, and describe both ISAMORE's mechanism role and anti-unification method innovation in detail.

- 2026-05-05 00:00 Asia/Shanghai - Start expansion from introduction and research goals
  > 赞成
  - Context: User agreed with grill-me recommendation to expand the introduction and research goals before detailed ISAMORE expansion.
  - Related: `report/main.typ`, `resources/aps/sec/0_intro.tex`, `resources/aquas/sec/0_intro.tex`, `resources/isamore/tex/1_introduction.tex`, `resources/cement/doc/1_Introduction.tex`, `resources/skyegg/doc/1_introduction.tex`, `resources/IntelliC/docs/story.md`, `resources/spine/docs/story.md`
  - Agent interpretation: Stabilize the overall story first, then use it as the anchor for representative-work expansions.

- 2026-05-05 00:00 Asia/Shanghai - Expand related work and challenges from resources
  > 先扩写国内外研究现状与挑战。resources/内的每篇工作都有讨论相关工作，需要仔细研读整理。
  - Context: User chose the next expansion target and emphasized careful reading of each work's related work.
  - Related: `report/main.typ`, `docs/writing/bibliography-audit.md`, `resources/aps/sec/5_related_works.tex`, `resources/isamore/tex/2_background.tex`, `resources/isamore/tex/7_related_work.tex`, `resources/cement/doc/2_Background_Motiviation.tex`, `resources/cement/doc/7_Related_Work.tex`, `resources/skyegg/doc/2_background.tex`, `resources/skyegg/doc/8_related_work.tex`, `resources/eggmind/tex/2_background.tex`, `resources/eggmind/tex/8_related_work.tex`, `resources/origen/1_Introduction.tex`, `resources/origen/2_Background.tex`
  - Agent interpretation: Build the related-work chapter from local related-work discussions, not from generic memory.

- 2026-05-05 00:00 Asia/Shanghai - Redesign whole report structure before further implementation
  > 我认为我们需要需要优先做整个报告的结构修改，详细参考“博士开题报告-陈仁泽.pdf”。具体要求为：引言部分需要是综述形式的总分结构的详细讨论，包括严密的逻辑链条、趋势分析、研究归类、问题与挑战概括、目标总结等，而非概括式的研究背景与研究目标介绍；技术部分，将现有工作的几个层次分别作为一个大章节做详细介绍，最后一个大章节来介绍未来工作，这里需要特别注意的修改是把EggMind作为现有工作的一部分呈现。我们需要先进行整体结构的spec设计，整理为一个文件并详细讨论细节，然后再重新实施，而非在现有基础上增量修改。
  - Context: User redirected from incremental expansion to whole-report structure redesign.
  - Related: `report/docs/report_structure_redesign_spec.md`, `resources/博士开题报告-陈仁泽.pdf`, `docs/writing/reference-report-analysis.md`
  - Agent interpretation: Pause incremental正文 edits, create a detailed structure spec first, move EggMind into existing work, and implement only after structure discussion.

- 2026-05-05 00:00 Asia/Shanghai - Fourth chapter should center large models and formal methods
  > 我们不需要强调开源生态和专利与产学研协同统一， 这些不属于该报告的内容。对于第四章标题，我认为需要突出大模型与形式化技术结合对软硬件生态的作用。
  - Context: User rejected the fourth-chapter framing around open-source ecosystem, patents, and industry-university collaboration.
  - Related: `report/docs/report_structure_redesign_spec.md`, `docs/writing/preferences.md`, `report/docs/agent_writing_guidelines.md`
  - Agent interpretation: Fourth chapter should focus on how large models and formal techniques jointly support hardware-software co-design methods and toolchains; nontechnical ecosystem/patent/collaboration material must not become a structural theme.

- 2026-05-05 00:00 Asia/Shanghai - Fourth chapter title confirmed
  > 支持
  - Context: User accepted the recommended title after comparing “大模型与形式化技术驱动的软硬件协同方法” with a shorter alternative.
  - Related: `report/docs/report_structure_redesign_spec.md`, `docs/writing/preferences.md`
  - Agent interpretation: Use “大模型与形式化技术驱动的软硬件协同方法” as the fixed fourth-chapter title.

- 2026-05-05 00:00 Asia/Shanghai - EggMind completion boundary confirmed
  > 按完整现有工作写“方法、系统、实验、意义”
  - Context: User answered the second structure-spec confirmation question.
  - Related: `report/docs/report_structure_redesign_spec.md`, `docs/writing/preferences.md`, `docs/writing/reference-report-analysis.md`
  - Agent interpretation: EggMind is not a future direction or preliminary basis in the main report. The fourth chapter must develop it as a complete existing work with method, system, experiments, and significance.

- 2026-05-05 00:00 Asia/Shanghai - EggMind may be referenced in future work only with strict transition
  > 可以，但必须逻辑严密不突兀
  - Context: User accepted keeping EggMind out of the future-work chapter as an independent direction, but allowed it to be referenced as existing foundation.
  - Related: `report/docs/report_structure_redesign_spec.md`, `docs/writing/preferences.md`, `docs/writing/reference-report-analysis.md`
  - Agent interpretation: Future work can refer to EggMind only after stating the remaining system problem it motivates. Avoid abrupt reuse of the name without explaining how fourth-chapter results lead to IntelliC, Spine, or PTO Runtime.
