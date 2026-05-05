# Source Memo: Compiler Infrastructure for Agentic Retargeting

This memo is written for discussion-slide preparation. It is not meant to be a
complete survey. The goal is to make the argument easy to present:

```text
Desired programming face + target facts
        |
        v
Generated compiler middle: IRs, passes, solvers, checks, evidence
        |
        v
Backend artifacts for a concrete hardware target
```

The compiler is the middle layer that fills the gap between what programmers
want to write and what the target can actually execute. IntelliC-agent should
be positioned as an agentic way to construct that middle layer while keeping the
work bounded by compiler-native artifacts.

## Core Message

Architecture-specific compiler work should not be treated as isolated backend
engineering. Across the resources, the common pattern is:

```text
target facts
  -> explicit IR and semantic contracts
  -> constrained transformations
  -> executable backend artifacts
  -> evidence and feedback
```

The reason to use compiler infrastructure as the harness is pragmatic.
Compilers already have the surfaces LLM agents need:

- structured IRs that can be inspected and transformed;
- pass boundaries that limit the scope of an action;
- target contracts that constrain what can be generated;
- semantic and executable checks that reject invalid changes;
- benchmark and trace signals that guide optimization.

The challenge is that these surfaces are usually spread across backend code,
tests, debugging tools, target manuals, and expert knowledge. IntelliC-agent
should make them explicit enough for agents to use without turning the workflow
into free-form code generation.

## Presentation Arc

The presentation should follow this logic:

1. Accelerator compilers are hard because the compiler must bridge two inputs:
   a desired programming face and target-specific hardware facts.
2. Existing compiler systems show different ways to expose target facts:
   XLA exposes layered IR and runtime boundaries; Arknife exposes reusable
   architecture/layout machinery; ACT exposes ISA-driven backend generation;
   TL exposes spatial mapping as a compiler optimization dimension.
3. Existing LLM systems show both promise and risk: agents can optimize
   compiler artifacts or assemble large systems, but they struggle with
   semantics, backend consistency, evidence quality, and long-term
   maintainability.
4. Compilers are a natural fit for agents at some points and a poor fit at
   others. Structured IRs and pass boundaries are natural fit points; semantic
   preservation, backend support, tests, and multi-pass composition are the hard
   parts.
5. IntelliC-agent is the proposed solution: it gives agents compiler-native
   objects, scoped actions, semantic facts, and evidence memory.
6. Spine strengthens the story by providing a path to architecture and hardware
   descriptions. IntelliC-agent can be the compiler-generation layer inside
   that broader architecture-hardware-compiler flow.

## Why Accelerator Compiler Construction Is The Right Problem

Modern accelerators expose performance through details that high-level programs
hide:

- parallel hierarchy: device, cluster, core, warp, vector lane, tensor unit;
- memory hierarchy: HBM, local memory, scratchpad, shared memory, registers,
  tensor memory, DMA channels;
- layout constraints: tiling, banking, alignment, operand order, physical
  layout, and instruction-specific interface requirements;
- communication and synchronization: collectives, barriers, channels, NoC
  routing, stream dependencies, and pipeline ordering;
- instruction semantics: what an instruction computes, where operands live,
  and which layouts are legal.

A tensor compiler is therefore not just a lowering stack. It is a search and
proof system. It must find a mapping that is legal, profitable, and
maintainable under a target-specific constraint surface.

The high-level slide should show two inputs:

```text
Desired programming face        Target facts
tensor ops, kernels, DSLs       architecture, memory, ISA, layout
          \                         /
           \                       /
            v                     v
          IRs + passes + solvers + evidence
                       |
                       v
                backend artifact
```

This is the cleanest framing for IntelliC-agent: it generates and operates on
the compiler middle, not only on the final backend code.

## What Existing Compiler Systems Teach Us

### XLA: Layered Evidence And Runtime Boundaries

XLA shows a mature version of a layered compiler pipeline:

```text
Framework graph
  -> StableHLO
  -> HLO optimization
  -> backend-specific HLO optimization
  -> TPU tiling, partitioning, memory, and legalization decisions
  -> PJRT and libtpu-backed execution
```

For TPU, the useful public evidence is not a simple open backend directory. It
is the HLO/SPMD/memory/layout infrastructure, TPU docs, and PJRT/libtpu
boundary:

- HLO is the working IR for optimization, dumping, replay, and debugging.
- The public source defines 132 internal HLO opcodes.
- TPU-relevant material appears around spatial partitioning, bfloat16
  conversion/propagation, tiled layouts, HBM fitting, collective overlap,
  SparseCore, and PJRT/libtpu integration.
- Some important TPU backend details live behind the runtime/compiler boundary.

The presentation lesson is not "copy XLA." The lesson is that each layer has a
contract:

- StableHLO is the portable frontend/compiler boundary.
- HLO passes perform target-independent simplification and fusion.
- Backend HLO passes add target information: layout, memory placement,
  partitioning, collectives, and hardware legality.
- TPU integration adds target-specific execution and runtime boundaries.
- Tooling makes behavior inspectable through dumps, replay, and isolation.

For IntelliC-agent, this motivates a layered evidence pipeline: generated
compiler components should be inspectable and replayable at the IR level, not
only tested at the final output.

### Arknife: Retargetable Layout Machinery

Arknife is valuable because it demonstrates reusable compiler components for
layout-constrained accelerator targets. Its abstractions separate the target
facts from the compiler machinery:

```text
Architecture abstraction:
  parallel levels
  memory spaces
  visibility and ownership
  synchronization channels

Instruction abstraction:
  loop space
  operand tensors
  required layouts
  execution level
  memory and synchronization requirements

Program abstraction:
  tensor program
  operator graph
  tensor memory assignment
  tensor layout requirements
```

The `hexagon` branch makes the retargetability concrete. The package has 13
top-level modules/subpackages, and the Hexagon target tests define:

- `thread` and `grid` parallel levels;
- `reg`, `vtcm`, and `global` memory spaces;
- named vector datatypes such as `HVX_Vector` and `HVX_VectorPair`;
- 35 instruction templates covering vector operations, DMA/VTCM movement,
  arithmetic, reductions, packing, min/max, and saturation-style operations;
- runtime support for HMX management, DMA utilities, and worker pools.

The reusable compiler part is the machinery around these facts:

```text
operator graph
  -> instruction binding and graph repair
  -> soft feasibility solve
  -> hard mapping and layout solve
  -> tiling and pipeline scheduling
  -> target kernel code
```

Arknife's reuse scope is the layout and mapping system. A new target can reuse
the architecture/memory/instruction abstractions and solver flow while changing
the target facts, instruction templates, layouts, and codegen callbacks. That
is the retargetability lesson for IntelliC-agent: generate or import target
facts, then reuse compiler components that know how to solve over those facts.

### ACT: ISA-Driven Backend Generation, With A Narrower Reuse Scope

ACT explores a more automatic backend construction path:

```text
ISA description
  -> parameterized instruction selection by equality saturation
  -> partially instantiated instruction graph
  -> constraint-programming memory allocation
  -> fallback paths for completeness
  -> assembly candidates and cost-model selection
```

Its retargetability is real but more limited than Arknife's. ACT mainly
demonstrates reuse in instruction selection and memory allocation driven by a
formal ISA description. Arknife, by contrast, exposes a broader layout system
with architecture hierarchy, memory spaces, instruction layout contracts, and
solver machinery.

The presentation should use ACT and Arknife together:

- ACT shows that ISA descriptions can generate backend behavior.
- Arknife shows that architecture/layout facts can drive reusable solving.
- IntelliC-agent needs both: target-description inputs and generated or reused
  compiler actions.

### TL: Spatial Mapping As A Compiler Optimization Dimension

TL adds another dimension: spatial dataflow mapping. On spatial architectures,
performance depends on where work runs, when it runs, and how data moves across
cores, memories, and interconnects.

Its flow is:

```text
tile-based program
  -> dataflow-agnostic MLIR
  -> hardware description of cores, memories, and interconnects
  -> spatial-temporal mapping search
  -> reuse and data-movement planning
  -> dataflow-aware MLIR
  -> backend code
```

The compiler optimization problem is not only "choose an instruction" or
"choose a layout." It also includes:

- mapping tile instances to physical cores;
- scheduling tile execution over time;
- planning local reuse;
- routing transfers across the NoC;
- checking memory and bandwidth constraints.

This is important for the slides because it expands the definition of target
facts. Target descriptions are not only ISA descriptions; they can include
topology, communication, storage, and execution timing.

Open slot for Zizhang: add the spatial RTL simulator details here, especially
how that simulator can be viewed as a domain-specific compiler or executable
target model for spatial architectures.

## What Agentic Compiler Systems Teach Us

The LLM-oriented resources should not be presented as "LLMs can write
compilers." The stronger message is more critical: LLM agents can help when the
task is bounded by compiler artifacts, and they become risky when semantics,
backend contracts, and evidence are vague.

### EggMind: LLM-Guided Compiler Optimization

EggMind is best positioned as LLM-guided compiler optimization. It does not ask
the LLM to freely rewrite an optimizer. It asks the LLM to help synthesize a
bounded strategy artifact:

```text
training cases + rewrite rules + cost model
  -> offline agentic workflow
  -> EqSatL strategy artifact
  -> online backend reuse
```

The lesson for IntelliC-agent is that an agent action should leave behind a
compiler artifact that can be inspected, replayed, evaluated, and reused.

### Magellan: LLM-Evolved Compiler Heuristics

Magellan is best positioned as LLM-evolved compiler heuristics:

```text
editable compiler policy region
  -> LLM heuristic template
  -> compiler rebuild and benchmark evaluation
  -> autotune parameters
  -> feedback and evolution
```

The output is not an answer in natural language. It is deployable compiler code
inside a narrow policy surface. The strength is that this can improve real
heuristics. The weakness is cost and scope: rebuilding and benchmarking is
expensive, and the editable region must stay narrow enough that the search does
not drift into broad compiler rewrites.

### MiMo/SysY: Long-Horizon Compiler Construction Under A Course Harness

The MiMo/SysY case is useful because it is a compact compiler-construction
trajectory rather than a general software-engineering demo. Xiaomi reports that
MiMo-V2.5-Pro implemented a SysY compiler in Rust from scratch, covering:

```text
lexer
  -> parser
  -> AST
  -> Koopa IR generation
  -> RISC-V assembly backend
  -> performance optimization
```

The PKU online course documentation makes the task shape clear: students build
a compiler that connects SysY, a C-like teaching language, to RISC-V assembly,
with Koopa IR as an intermediate representation. Xiaomi's report is useful for
our discussion because the model did not only patch toward tests. It reportedly
built the compiler layer by layer: full scaffold first, then Koopa IR
correctness, then RISC-V backend correctness, then performance optimization.
The reported trajectory also includes a regression during refactoring and
recovery, which is a concrete example of long-horizon self-correction under a
test harness.

This case strengthens the positive side of the agentic-compiler argument:

- a compiler task gives the agent natural milestones;
- IR boundaries give intermediate correctness targets;
- backend tests expose target-specific failures;
- performance tests create a separate optimization phase;
- a harness with feedback lets the model recover from regressions.

But the limitation is just as important for the presentation. SysY is a course
compiler with a narrow language, one main IR path, and one main assembly target.
The hidden test suite is a strong task verifier, but it is not a maintainability
model, a multi-backend contract, or a semantic proof system. MiMo/SysY therefore
supports our thesis precisely because it shows both sides: LLMs can execute a
compiler-building trajectory when the harness is strong, but reusable,
retargetable, long-term compiler generation still needs compiler-native
infrastructure like IntelliC.

### CCC: Agent Teams Can Build Deep Stacks, But Maintainability Is The Risk

The C compiler experiment is useful as a critical example. It shows that agent
teams can build a substantial compiler stack, but it also exposes why compiler
construction needs a stronger harness than tests and progress files.

Positive evidence:

- The project has recognizable compiler layers: frontend, IR, passes, backend,
  common utilities, driver, and binaries.
- The documented flow covers preprocessing, lexing, parsing, semantic analysis,
  alloca-style IR, SSA conversion, optimization, phi elimination, assembly,
  assembling, linking, and executable generation.
- It exposes several architecture backends, including x86-64, i686, AArch64,
  and RISC-V 64.
- The optimizer includes a realistic set of passes: simplification, DCE, GVN,
  LICM, inlining, CFG cleanup, if-conversion, narrowing, division strength
  reduction, interprocedural constant propagation, induction-variable strength
  reduction, loop analysis, and related cleanup.

Critical lessons:

- Passing tests is not the same as long-term compiler maintainability.
- Multi-backend support can be broad on paper but uneven in depth.
- Backend behavior can diverge when there is no shared target-contract model.
- Agent teams need ownership boundaries, compact evidence, and conflict
  control; otherwise parallel work can create integration debt.
- A generated compiler stack can grow quickly without a clear theory of which
  parts are reusable across targets.

For the presentation, CCC should support the challenge side of the argument:
LLM agents have enough capability to assemble compiler components, but the
hard part is preserving semantics, backend consistency, and maintainability.

### VibeTensor: Generated Runtime Stacks Need Cross-Layer Validation

VibeTensor is also a critical example. It is a generated deep-learning runtime
with frontends, dispatcher, autograd, CUDA runtime, allocator, plugins, training
checks, and generated kernels.

The useful lesson is cross-layer validation:

- Builds, tests, and differential checks can constrain generated systems.
- Local correctness is not enough; repeated composition reveals failures.
- A runtime can pass unit tests while still accumulating inconsistent
  conventions and redundant abstractions.
- Backend support can be hard to sustain when the runtime, generated kernels,
  dispatch logic, and plugins evolve together.
- Performance-sensitive behavior needs observability from the start.

For IntelliC-agent, the lesson is that backend generation cannot be validated
only at the level of a single pass or single kernel. It needs evidence across
the pipeline: IR validity, semantic preservation, backend legality, repeated
composition, and performance behavior.

## Where LLM Agents Naturally Fit, And Where They Do Not

This section is the pivot from examples to our proposal. The argument should be
clear: compilers are a natural fit for LLM agents only if the hard parts are
made explicit.

Natural fit points:

| Compiler surface | Why agents fit |
| --- | --- |
| Structured IR | Agents can inspect typed operations instead of raw text. |
| Pass boundaries | Actions can be scoped to one transformation or analysis. |
| Layered milestones | Frontend, IR, backend, and performance phases give long-horizon tasks intermediate targets. |
| Rewrite patterns | Agents can propose candidates within a known rule space. |
| Heuristic code | Agents can search policy regions and tune parameters. |
| Target descriptions | Agents can normalize manuals, examples, and architecture facts. |
| Diagnostics | Agents can use compiler feedback to repair a candidate action. |

Hard challenges:

| Challenge | Why it is hard |
| --- | --- |
| Semantics | A plausible rewrite can silently change behavior. |
| Backend contracts | Targets have hidden memory, layout, ABI, and runtime constraints. |
| Multi-backend support | A change that helps one backend can break another. |
| Pass composition | Locally valid passes can conflict later in the pipeline. |
| Testing | A hidden test suite can verify one task trajectory, but not the full semantic or maintenance space. |
| Long-term maintainability | Generated code can duplicate concepts or encode target facts in ad hoc ways. |
| Evidence volume | Large logs and dumps can overwhelm the agent rather than help it. |

The main claim is not that LLM agents are naturally good at all compiler work.
The claim is that compiler infrastructure can separate fit points from hard
challenges, then expose the right artifacts and gates at each boundary.

## IntelliC As The Challenge-Overcoming Solution

IntelliC should be presented as the mechanism that turns compiler construction
from free-form generation into bounded agentic work.

### IR = Syntax + Semantics

```text
IR = Sy + Se
```

Syntax gives agents the structured compiler object:

- operations;
- regions and blocks;
- SSA values;
- types and attributes;
- canonical text;
- parsing, printing, and verification.

Semantics gives the checks and meaning needed to reject bad transformations:

- concrete execution;
- abstract interpretation;
- symbolic facts;
- backend ownership;
- equality evidence;
- diagnostics and obligations.

This directly addresses the biggest agentic risk: a generated transformation
can look reasonable but be semantically wrong. IntelliC keeps meaning attached
to the IR instead of leaving it in comments, prompt context, or pass-local
assumptions.

### One Action Model

IntelliC should expose one action model for programmed compiler work and
agentic compiler work:

```text
Fixed action:
  programmed pass, analysis, rewrite, semantic execution, gate

AgentAct:
  scoped LLM action through typed compiler APIs

AgentEvolve:
  workflow that generates a verified Fixed action
```

This maps the resource lessons into one framework:

- EggMind-like strategy synthesis becomes bounded AgentAct or AgentEvolve over
  strategy artifacts.
- Magellan-like heuristic search becomes AgentEvolve that produces a Fixed
  compiler policy.
- ACT-like backend generation becomes AgentEvolve over ISA descriptions.
- Arknife-like solving becomes Fixed actions with target facts and evidence.
- XLA-like lowering becomes replayable Fixed actions and gates.

### Evidence Memory, Not Conversation Memory

TraceDB should be described at a high level. Its role is not to store every
detail of a run. Its role is to preserve the compact evidence needed for the
next compiler action:

```text
facts + events + obligations + diagnostics + artifacts
```

This addresses the CCC and VibeTensor failure modes. Agents need feedback, but
they should not reason from huge logs or long conversations. They should reason
from typed compiler evidence: which target facts are active, which obligations
remain, which action changed the IR, and which checks accepted or rejected the
result.

The MiMo/SysY case helps here too. Its reported progress is understandable
because the task had milestone evidence: Koopa IR tests, RISC-V backend tests,
performance tests, and a visible regression/recovery point. IntelliC should
generalize that idea beyond a course harness: every generated compiler action
should leave compact evidence that explains what layer it changed and which
obligations it satisfied.

### Multi-Backend Support

The multi-backend story should be explicit. IntelliC-agent should not generate
a separate compiler worldview for every target. It should separate:

- target-independent compiler concepts;
- target-description facts;
- backend-specific legality and cost models;
- evidence produced by each target flow.

This is how IntelliC-agent can support retargeting without turning into a pile
of backend forks. The reusable layer is the compiler harness; the variable
layer is the target contract and the actions specialized from it.

## Architecture And Hardware Advantage

The architecture/hardware work should be used to strengthen the backend
description story. The presentation does not need to claim that IntelliC-agent
directly integrates with every prior system. The cleaner logic is:

```text
APS / ISAMORE / architecture-hardware work
        |
        v
Spine: general architecture modeling, hardware-generation paths, evidence
        |
        v
IntelliC-agent: compiler generation over Spine-provided target descriptions
```

### APS / Aquas

Aquas/APS is the hardware-software co-design reference. It treats ASIP
specialization as a joint problem: memory interfaces, cache effects,
instruction extension semantics, hardware synthesis, and compiler offloading
must be optimized together.

The useful lesson is that target descriptions need to include memory paths,
interface choices, scratchpads, transaction granularity, and instruction
behavior. These are not just backend implementation details. They are compiler
inputs.

### ISAMORE

ISAMORE should be presented as a natural bridge between applications,
compilers, architecture, and hardware. Its ASPLOS best paper award is useful
because it gives credibility to the bridge: reusable custom instruction
discovery is not just a compiler trick or a hardware trick; it links
application structure, ISA design, hardware cost, and compiler usability.

The important concepts for this presentation are:

- e-graph anti-unification for reusable custom instruction discovery;
- structured DSLs for representing application structure;
- vectorized pattern discovery;
- hardware-aware Pareto selection over performance and area tradeoffs;
- custom instruction candidates as target-description facts.

IntelliC-agent should not be framed as directly depending on ISAMORE. The
cleaner framing is that ISAMORE validates the importance of ISA and hardware
descriptions as compiler-generation inputs.

### Spine

Spine is the integration point. Its significance is that it explores how to
model and describe general architectures and their hardware-generation paths.
That gives IntelliC-agent a stronger backend-description base than ad hoc
target notes or hand-written backend assumptions.

Spine's broader story is:

```text
open design intent
  -> unified semantic model and deterministic design boundary
  -> staged hardware generation and RTL evidence
  -> staged compiler lowering and target-aware optimization
  -> oracle / IR / RTL / execution alignment
  -> bounded agentic refinement
```

This matters for multi-backend support. If Spine can provide architecture
models, hardware-generation evidence, and target descriptions, IntelliC-agent
can focus on generating and validating compiler layers against those target
contracts.

The bridge should be stated carefully:

```text
Spine describes and validates architecture/hardware targets.
IntelliC-agent generates compiler infrastructure for those targets.
```

This avoids over-claiming a direct IntelliC-agent relationship with APS or
ISAMORE while still using them as strong evidence for why the Spine bridge is
valuable.

## Slide-Level Logic

The slides should not be ordered as a list of projects. They should be ordered
as an argument.

### Part 1: The Gap

Start with the two inputs:

```text
Desired programming face        Target facts
          \                         /
           \                       /
            v                     v
          compiler middle to be generated
```

The key sentence: "The compiler fills the gap between how programmers express
work and how the target must execute it."

### Part 2: What Existing Compilers Show

Use XLA, Arknife, ACT, and TL as four examples of target contracts:

```text
XLA       layered IR and runtime boundaries
Arknife   reusable layout and mapping machinery
ACT       ISA-driven instruction selection and memory allocation
TL        spatial-temporal mapping over distributed hardware
```

The transition sentence: "These systems show what the target contract must
contain."

### Part 3: What LLM Systems Show

Use EggMind and Magellan as positive bounded optimization examples, MiMo/SysY
as a positive long-horizon compiler-construction example, then CCC and
VibeTensor as critical maintainability examples:

```text
EggMind     LLM-guided compiler optimization
Magellan    LLM-evolved compiler heuristics
MiMo/SysY   long-horizon compiler construction under a course harness
CCC         agent-built compiler stack, maintainability risks
VibeTensor  generated runtime stack, cross-layer validation risks
```

The transition sentence: "Agents can help, but only if the compiler gives them
bounded artifacts and evidence."

### Part 4: Fit Points And Challenges

This is the conceptual center of the talk. Show a two-column table:

```text
Natural fit points              Hard challenges
structured IR                   semantics
pass boundaries                 backend contracts
rewrite patterns                multi-backend consistency
heuristic regions               pass composition
diagnostics                     long-term maintainability
```

The transition sentence: "IntelliC is designed to keep the fit points open
while putting gates around the hard parts."

### Part 5: IntelliC-agent

Present the solution:

```text
IR = Syntax + Semantics

Fixed action
AgentAct
AgentEvolve

TraceDB = compact compiler evidence
```

The key sentence: "Agents act through compiler APIs; the compiler records and
checks the result."

### Part 6: Spine Bridge

End with the architecture/hardware advantage:

```text
architecture/hardware exploration
        |
        v
Spine target descriptions and evidence
        |
        v
IntelliC-agent compiler generation
```

The key sentence: "The backend description does not have to come only from the
compiler side; Spine gives us a path to architecture and hardware descriptions
that compiler generation can target."

## Claims To Avoid

- Do not claim that LLMs should freely generate an entire compiler.
- Do not claim that tests alone are enough for compiler correctness.
- Do not imply that broad backend support is the same as maintainable backend
  support.
- Do not present APS or ISAMORE as direct dependencies of IntelliC-agent.
- Do not treat one hardware target as the final endpoint. The point is
  reusable retargeting through target descriptions and evidence.

## Closing Takeaway

The shortest version of the argument is:

```text
Compiler infrastructure is the harness.
```

Give agents compiler-native objects: IR, semantics, target descriptions,
passes, solvers, gates, and evidence. Then compiler generation becomes bounded,
inspectable, replayable, and retargetable.
