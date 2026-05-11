// 开题报告初稿
// Build after installing Typst:
//   make pdf
//   typst compile main.typ --input alwaysstartodd=false

#import "pku-topic-template.typ": conf
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
  cthesisname: "北京大学集成电路学院博士研究生选题报告",
  cheader: "北京大学集成电路学院博士研究生选题报告",
  ctitle: "敏捷芯片设计与创新性编译技术\n驱动的软硬件协同",
  etitle: "Hardware-Software Co-Design Driven by Agile Chip Design and Innovative Compilation Techniques",
  school: "TODO",
  cfirstmajor: "集成电路科学与工程",
  cmajor: "集成电路科学与工程",
  emajor: "Integrated Circuit Science and Engineering",
  direction: "敏捷芯片设计与编译技术",
  csupervisor: "梁云",
  esupervisor: "Yun Liang",
  date: (year: 2026, month: 5),
  degree-type: "academic",

  cabstract: [
    AI 与 LLM、数据密集型应用和工业级异构架构快速演进，使芯片设计生产力与软件栈适配同时成为系统瓶颈。领域定制硬件只有在软件语义能够被发现为可复用架构能力、这些能力能够被实现为质量可控的硬件、并能够通过编译接口进入可验证的软件生态时，才能从一次性加速单元转化为可持续演化的系统能力。本文围绕“敏捷芯片设计与创新性编译技术驱动的软硬件协同”，研究敏捷芯片设计与创新性编译技术如何在同一软硬件协同体系中相互定义、相互约束和共同演化。

    本文将选题收束为三个核心问题：应用需求如何通过架构接口转化为可复用的指令、微架构和加速器能力；架构能力如何高质量落到可综合、可验证、性能与资源可控的硬件实现；编译接口如何在架构约束下组织程序语义、硬件能力和优化过程，形成可验证、可复用、可供智能体可靠使用的编译协同机制。方法上，本文以架构接口和编译接口为主线，结合等价图、反合一、等价饱和、多层硬件中间表示、调度建模和可执行判定基准，组织可分析、可实现、可检查的协同过程。

    已有研究基础沿三个层次展开：面向领域定制的架构接口与端到端协同，面向高质量硬件实现的前端抽象与综合优化，以及大模型与形式化技术驱动的软硬件协同方法。未来研究将进一步围绕验证约束下的架构、硬件与编译协同生成、智能体编译基础设施、面向工业级异构架构的算子优化与智能体化编译协同展开，目标是在跨硬件架构场景中把可复用硬件能力、高质量硬件实现和编译接口支撑的智能体能力提升组织为统一的软硬件协同方法体系。
  ],
  ckeywords: ("敏捷芯片设计", "软硬件协同", "架构接口", "编译接口", "等价图", "智能体编译基础设施"),

  eabstract: [
    Rapid advances in AI and LLM workloads, data-intensive applications, and industrial heterogeneous architectures are making chip-design productivity and software-stack adaptation coupled system bottlenecks. Domain-specific hardware can become a sustainable capability only when software semantics can be discovered as reusable architectural capabilities, when those capabilities can be implemented as quality-controlled hardware, and when compiler interfaces can expose them to a verifiable software ecosystem. This proposal studies hardware-software co-design driven by agile chip design and innovative compilation techniques, emphasizing the coordinated relation through which agile hardware capability formation and compiler infrastructure define, constrain, and evolve with each other.

    The proposal formulates three research questions: how application demands can be transformed through architecture interfaces into reusable instructions, microarchitectures, and accelerator capabilities; how architectural capabilities can be realized as synthesizable, verifiable, and performance- and resource-controlled hardware implementations; and how compiler interfaces, under architectural constraints, can organize program semantics, hardware capabilities, and optimization processes into verifiable and reusable co-design mechanisms that agents can use reliably. Methodologically, it connects architecture and compiler interfaces with e-graphs, anti-unification, equality saturation, multi-level hardware IRs, scheduling models, and executable oracles.

    The existing work is organized into three layers: domain-specialized architecture interfaces and end-to-end co-design, front-end abstractions and synthesis optimization for high-quality hardware implementation, and hardware-software co-design methods that combine LLMs with formal techniques. Future work will integrate these foundations around validation-constrained architecture-hardware-compiler co-generation, agentic compiler infrastructure, and operator optimization with agentic compilation for industrial heterogeneous architectures. The expected contribution is a coherent methodology and set of systems that turn reusable hardware capabilities, quality-controlled hardware implementation, and compiler-mediated agentic optimization into a unified cross-architecture co-design ecology.
  ],
  ekeywords: ("agile chip design", "hardware-software co-design", "architecture interface", "compiler interface", "e-graph", "agentic compiler infrastructure"),

  acknowledgements: [],

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
