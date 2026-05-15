# User Figure Feedback: IntelliC and Future-Work Diagrams

## Original Wording

> 图5.1, 5.2 的箭头布局不够美观，图1.1、1.2仍缺失。缺少明确intellic-agent与intellic关系的图（如上传的图1），也缺少把aps/isamore/spine/intellic结合起来的图，如上传的图2

> 图1.1中存在箭头和图形的重叠，不允许这种布局问题出现。5.2中有箭头朝向问题”统一语义边界未垂直指向智能体提出候选、诊断与修复“，且存在箭头的交叉（尽量避免）。图5.3 存在文字超出图形的问题，5.4的文字离图形边界也太近，这些需要调整行间距或扩大图形。

> 图1.1中仍有箭头没有垂直于目标图形的问题。且行间距还有问题。

## Interpretation

- Chapter 1 overview figures must be actual rendered diagrams, not placeholders.
- Future-work figures should have clean arrow routing, with arrows connected to modules and not crossing text.
- The report needs an explicit figure explaining that IntelliC-agent works over IntelliC rather than replacing it.
- The report needs an explicit figure connecting APS/Aquas, ISAMORE, Spine, and IntelliC as a future-work stack.
- Figure QA must reject overlap between arrows and modules, incorrect arrow direction, avoidable crossing, text overflow, and text too close to box boundaries.
- In overview diagrams, arrows should enter boxes orthogonally through horizontal or vertical edges; avoid diagonal arrowheads into target modules.
