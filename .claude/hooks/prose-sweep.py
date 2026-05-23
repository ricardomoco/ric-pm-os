#!/usr/bin/env python3
"""
PostToolUse hook: scans written/edited .md files for prose violations.
Checks for em-dashes and numbered aliases in prose.
Informational only — always exits 0.
"""
import json
import os
import re
import sys

data = json.load(sys.stdin)
file_path = data.get("tool_input", {}).get("file_path", "")

if not file_path or not file_path.endswith(".md"):
    sys.exit(0)

if not os.path.exists(file_path):
    sys.exit(0)

with open(file_path, encoding="utf-8") as f:
    lines = f.readlines()

issues = []
for i, line in enumerate(lines, 1):
    if "—" in line:
        issues.append(f"  L{i} [em-dash]: {line.rstrip()[:120]}")
    if re.search(r"\b(stream|step|phase)\s+[0-9]", line, re.IGNORECASE):
        issues.append(f"  L{i} [numbered alias]: {line.rstrip()[:120]}")

if issues:
    print(f"\n[prose-sweep] {os.path.basename(file_path)}")
    for issue in issues:
        print(issue)
    print()

sys.exit(0)
