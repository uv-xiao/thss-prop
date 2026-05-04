# Rule Evolution Rules

The harness must learn from repeated writing feedback without turning every comment into an overbroad rule.

## Capture

- Record important user wording under `docs/in_progress/human_words/` before converting it into durable rules.
- Preserve the user's original wording as quote text.
- Add agent interpretation separately and mark it as non-normative.

## Promotion

Promote feedback into `.agents/rules/` or `docs/writing/preferences.md` only when at least one is true:

- the instruction will affect future writing tasks;
- the same preference appears repeatedly;
- the instruction corrects a systematic weakness;
- the instruction clarifies a domain-specific standard for this report.

## Scope

- Put mandatory behavior in `.agents/rules/`.
- Put softer preferences, examples, and rejected phrasings in `docs/writing/preferences.md`.
- Put term choices in `docs/writing/terminology.md`.
- Put citation audit findings in `docs/writing/bibliography-audit.md`.

## Conflict Handling

- Newer explicit user instruction overrides older preference notes.
- Institutional requirements override local stylistic preferences.
- Source evidence overrides attractive phrasing.
- When two durable rules conflict, update the rules during the task and reread the changed files before continuing.
