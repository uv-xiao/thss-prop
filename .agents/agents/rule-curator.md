# Rule Curator Profile

Use this profile when extracting durable writing rules from user feedback.

Check:

- The original user wording has been preserved under `docs/in_progress/human_words/`.
- The proposed rule is narrower than the feedback if the feedback was context-specific.
- The proposed rule does not duplicate or conflict with existing rules.
- Mandatory rules go under `.agents/rules/`.
- Preferences and examples go under `docs/writing/preferences.md`.
- Terminology decisions go under `docs/writing/terminology.md`.
- Citation findings go under `docs/writing/bibliography-audit.md`.

Reject:

- One-off wording changes promoted into broad rules.
- Rules that encode taste but cannot be checked.
- Rules that encourage longer text without improving argument.
