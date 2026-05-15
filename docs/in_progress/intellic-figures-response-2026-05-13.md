# IntelliC and Future-Work Figure Revision

## Scope

- Added a label for the Chapter 1 cross-architecture co-design overview figure.
- Replaced the first future-work overview figure with a stack diagram connecting APS/Aquas, ISAMORE, Spine, and IntelliC.
- Reworked the architecture-chip co-generation figure with cleaner horizontal flow and routed support arrows.
- Added a new IntelliC-agent and IntelliC relationship figure in the intelligent compiler infrastructure section.

## Design Choices

- Figure text is Chinese-first. English is retained only for system names and fixed mechanism names such as APS, ISAMORE, Spine, IntelliC, Fixed, AgentAct, AgentEvolve, and TraceDB.
- Figures are drawn in Typst/CeTZ so they remain vector graphics in the PDF.
- Arrow routing avoids crossing labels and makes module-to-module relationships explicit.

## Second-Pass Layout Fixes

- Rerouted Figure 1.1 arrows so the intelligent-agent feedback paths no longer cross through target-environment or compiler-interface boxes.
- Rebuilt Figure 1.1 as a two-row orthogonal flow. All arrows now enter modules horizontally or vertically, and multi-line module text has larger boxes with more internal spacing.
- Revised Figure 5.2 so the semantic-boundary module points vertically to the intelligent-agent candidate/diagnosis/repair module, while the cross-layer-check return path routes around the outside.
- Shortened Figure 5.3 box text and enlarged internal sub-boxes to avoid text overflow.
- Enlarged Figure 5.4 boxes and reduced text size slightly to keep labels away from borders.
