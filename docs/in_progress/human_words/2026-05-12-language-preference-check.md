# User Feedback: Language Preference Check

Source wording:

> 我们需要一轮严格的语言偏好检查。我们需要使用人类偏好的、符合中文学术规范的语言。对于专业术语的使用应以中文有限，如AI-人工智能，LLM-大语言模型。要非常谨慎的处理英文短语/单词/缩写的首次出现，尽量翻译为中文（不确定的询问我）。不要在正文中出现文本将选题收束为...这种带过程的表达，更不要写“不是，而是”这种设计文档中常出现的语法。也需要减少使用冒号开始的罗列，强化句子间的自然衔接。这个语言检查需要覆盖全文，必须逐句详细检查和优化。

Follow-up wording:

> 然后做详细的、不允许有任何遗漏的语法偏好检查和提升

Initial interpretation:

- Report-facing prose should prefer human academic Chinese over design-document or implementation-process language.
- Technical terms should be Chinese-first. English abbreviations and names should appear only when useful for precision, preferably after a Chinese explanation at first occurrence, for example “人工智能（AI）” and “大语言模型（LLM）”.
- Avoid process-exposing phrases such as “本文将选题收束为……”; use academic statements about research questions, objects, and logic instead.
- Avoid the design-document contrast pattern “不是……而是……”; rewrite as positive academic exposition or causal progression.
- Reduce colon-led enumeration in prose. Prefer connected sentences that explain why items are grouped and how one claim leads to the next.
- The check should cover all report-facing text, not only abstracts or one chapter.
