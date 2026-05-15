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
    人工智能与大语言模型、后量子密码、信号处理、点云处理和图形渲染等领域持续提出高能效算力需求。为了回应这些需求，芯片架构不断走向更多元的专用计算单元、更大规模的互连系统和更复杂的软件栈边界，进而放大芯片设计生产力、硬件实现质量和软件适配成本。领域定制硬件要真正服务软件需求，需要从应用语义中发现可复用架构能力，将其实现为质量可控的硬件，并通过编译接口进入可验证、可迭代的软件生态。敏捷芯片设计与创新性编译技术在这一过程中相互定义、相互约束并共同演化，是本选题研究软硬件协同的基本出发点。

    选题形成三个核心问题。应用需求如何通过架构接口转化为可复用的指令、微架构和加速器能力，架构能力如何高质量落到可综合、可验证、性能与资源可控的硬件实现，编译接口如何在架构约束下组织程序语义、硬件能力和优化过程，并形成可验证、可复用、可供智能体可靠使用的编译协同机制。研究方法以架构接口和编译接口为主线，利用形式化方法与多层抽象机制组织可分析、可实现、可检查的协同过程。

    已有研究基础沿三个层次展开，分别是面向领域定制的架构接口与端到端协同、面向高质量硬件实现的前端抽象与综合优化，以及大语言模型与形式化技术驱动的软硬件协同方法。未来研究面向智能体可靠工作的架构-硬件-编译器协同链路，重点开展架构芯片协同生成和智能体编译基础设施与工作流研究，预期把可复用硬件能力、高质量硬件实现和编译接口支撑的智能体能力组织为统一的软硬件协同方法体系。
  ],
  ckeywords: ("敏捷芯片设计", "软硬件协同", "架构接口", "编译接口", "等价图", "智能体编译基础设施"),

  eabstract: [
    Artificial intelligence, large language models, post-quantum cryptography, signal processing, point-cloud processing, and graphics rendering are placing sustained demands on high-performance and high-efficiency computing power. In response, chip architectures are moving toward more diverse domain-specific compute units, larger interconnect systems, and more complex software-stack boundaries. These changes amplify the pressure on chip-design productivity, hardware implementation quality, and software adaptation. To serve real software needs, domain-specific hardware must discover reusable architectural capabilities from application semantics, realize them as quality-controlled hardware, and expose them through compiler interfaces to a verifiable and evolvable software ecosystem. Agile chip design and innovative compilation techniques therefore define, constrain, and evolve with each other within one hardware-software co-design system.

    The topic formulates three research questions: how application demands can be transformed through architecture interfaces into reusable instructions, microarchitectures, and accelerator capabilities; how architectural capabilities can be realized as synthesizable, verifiable, and performance- and resource-controlled hardware implementations; and how compiler interfaces, under architectural constraints, can organize program semantics, hardware capabilities, and optimization processes into verifiable and reusable co-design mechanisms that agents can use reliably. Methodologically, it uses formal methods and multi-level abstraction mechanisms to organize co-design processes that can be analyzed, implemented, and checked.

    The existing work is organized into three layers: domain-specialized architecture interfaces and end-to-end co-design, front-end abstractions and synthesis optimization for high-quality hardware implementation, and hardware-software co-design methods that combine large language models with formal techniques. Future work will study architecture-chip co-generation and agentic compiler infrastructure and workflows. The expected contribution is a coherent methodology and set of systems that turn reusable hardware capabilities, quality-controlled hardware implementation, and compiler-mediated agentic capability improvement into a unified cross-architecture co-design ecology.
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
