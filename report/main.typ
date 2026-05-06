// 开题报告初稿
// Build after installing Typst:
//   typst compile main.typ
//   typst compile main.typ --input alwaysstartodd=false

#import "@preview/modern-pku-thesis:0.2.3": appendix, conf
#import "@preview/codly:1.3.0": *

#show: codly-init.with()
#codly(
  display-icon: false,
  display-name: false,
  lang-format: none,
  number-format: none,
  inset: (x: 0.32em, y: 0.08em),
  radius: 0pt,
)

#show: conf.with(
  cauthor: "肖有为",
  eauthor: "Youwei Xiao",
  studentid: "2201111592",
  blindid: "TODO",
  cthesisname: "博士研究生开题报告",
  cheader: "北京大学博士研究生开题报告",
  ctitle: "敏捷芯片设计与创新性编译技术驱动的软硬件协同",
  etitle: "Hardware-Software Co-Design Driven by Agile Chip Design and Innovative Compilation Techniques",
  school: "TODO",
  cfirstmajor: "TODO",
  cmajor: "TODO",
  emajor: "TODO",
  direction: "敏捷芯片设计与编译技术",
  csupervisor: "TODO",
  esupervisor: "TODO",
  date: (year: 2026, month: 5),
  degree-type: "academic",

  cabstract: [
    AI 与数据密集型应用快速演进，使算力需求、能效约束、芯片设计生产力和软硬件生态构建成本同时成为系统瓶颈。领域定制计算能够提升性能与能效，但只有在架构接口、硬件实现、编译映射、验证证据和运行时反馈之间形成可复用闭环时，才能成为持续演化的系统能力。本文围绕“敏捷芯片设计与创新性编译技术驱动的软硬件协同”这一主题，系统梳理本人已有研究基础，并提出面向后续博士阶段的研究计划。

    已有工作分为三个层次：面向领域定制的架构接口与端到端协同，研究应用需求如何通过架构接口转化为可复用的指令、微架构和加速器能力；面向高质量硬件实现的前端抽象与综合优化，研究架构能力如何落到可综合、可验证、性能与资源可控的硬件实现；大模型与形式化技术驱动的软硬件协同方法，研究编译接口如何连接程序语义、硬件能力与验证反馈。未来工作将进一步围绕验证约束下的架构、硬件与编译协同生成，可解释、可审计的编译基础设施，以及面向工业级异构架构的算子优化与运行时编译协同，构建可解释、可验证、可自动演化、可运行时落地的软硬件协同系统闭环。
  ],
  ckeywords: ("敏捷芯片设计", "软硬件协同", "编译器", "e-graph", "自定义指令", "高层综合"),

  eabstract: [
    This proposal studies hardware-software co-design driven by agile chip design and innovative compilation techniques. The central goal is to improve system productivity across application-driven specialization, architecture interfaces, hardware generation, compiler retargeting, synthesis optimization, verification evidence, and runtime feedback.
  ],
  ekeywords: ("agile chip design", "hardware-software co-design", "compiler", "e-graph", "custom instruction", "HLS"),

  acknowledgements: [
    TODO: 正式版本补充致谢。
  ],

  bibcontent: read("refs.bib"),
  bibstyle: "numeric",
  bibversion: "2015",
  listofimage: false,
  listoftable: false,
  listofcode: false,
  alwaysstartodd: false,
)

#include "chapter-01-introduction.typ"
#include "chapter-02-architecture-interface.typ"
#include "chapter-03-hardware-implementation.typ"
#include "chapter-04-llm-formal-codesign.typ"
#include "chapter-05-future-work.typ"
#include "chapter-06-conclusion.typ"
#appendix()
#include "appendix-checklist.typ"
