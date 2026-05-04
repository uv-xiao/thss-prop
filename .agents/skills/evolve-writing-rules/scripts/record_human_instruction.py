#!/usr/bin/env python3
"""Append source user wording to docs/in_progress/human_words."""

from __future__ import annotations

import argparse
import datetime as dt
import re
from pathlib import Path


def slugify(value: str) -> str:
    value = value.strip().lower()
    value = re.sub(r"[^a-z0-9\u4e00-\u9fff]+", "-", value)
    return value.strip("-") or "other"


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo-root", default=".")
    parser.add_argument("--category", required=True)
    parser.add_argument("--event", required=True)
    parser.add_argument("--instruction", required=True)
    parser.add_argument("--context", default="")
    parser.add_argument("--related", default="")
    parser.add_argument("--interpretation", default="")
    parser.add_argument("--timestamp", default="")
    args = parser.parse_args()

    repo_root = Path(args.repo_root).resolve()
    out_dir = repo_root / "docs" / "in_progress" / "human_words"
    out_dir.mkdir(parents=True, exist_ok=True)
    path = out_dir / f"{slugify(args.category)}.md"

    if args.timestamp:
        timestamp = args.timestamp
    else:
        timestamp = dt.datetime.now().strftime("%Y-%m-%d %H:%M")

    if path.exists():
        content = path.read_text(encoding="utf-8")
    else:
        content = f"# Human Words: {args.category}\n\n## Timeline\n"

    entry = [
        "",
        f"- {timestamp} - {args.event}",
        f"  > {args.instruction}",
    ]
    if args.context:
        entry.append(f"  - Context: {args.context}")
    if args.related:
        entry.append(f"  - Related: {args.related}")
    if args.interpretation:
        entry.append(f"  - Agent interpretation: {args.interpretation}")

    content = content.rstrip() + "\n" + "\n".join(entry) + "\n"
    path.write_text(content, encoding="utf-8")
    print(path)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
