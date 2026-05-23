#!/usr/bin/env bash
# snapshot-skill.sh
#
# Usage: bash snapshot-skill.sh <skill-path> <iteration-number>
#
# Copies <skill-path>/SKILL.md into the workspace at:
#   <skill-path>-workspace/skill-iter-N/SKILL.md
#
# On the first iteration (N=1), also writes:
#   <skill-path>-workspace/skill-snapshot/SKILL.md
# This is the immutable baseline reference used by the regression test for
# all subsequent iterations.
#
# Idempotent: re-running the same iteration overwrites that iteration's copy
# but leaves the snapshot alone.
#
# Exits 0 on success, 1 on bad arguments. Never modifies the source skill.

set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <skill-path> <iteration-number>" >&2
  exit 1
fi

skill_path="$1"
iteration="$2"

if [[ ! -d "$skill_path" ]]; then
  echo "Error: $skill_path is not a directory" >&2
  exit 1
fi

if [[ ! -f "$skill_path/SKILL.md" ]]; then
  echo "Error: SKILL.md not found at $skill_path/SKILL.md" >&2
  exit 1
fi

if ! [[ "$iteration" =~ ^[0-9]+$ ]]; then
  echo "Error: iteration must be a positive integer, got: $iteration" >&2
  exit 1
fi

workspace="${skill_path}-workspace"
iter_dir="$workspace/skill-iter-$iteration"
snapshot_dir="$workspace/skill-snapshot"

# Always write the iteration copy (overwrites if it exists — caller controls
# when to re-run the loop).
mkdir -p "$iter_dir"
cp "$skill_path/SKILL.md" "$iter_dir/SKILL.md"
echo "Wrote iteration copy: $iter_dir/SKILL.md"

# Write the snapshot only if it doesn't exist. The snapshot is the IMMUTABLE
# baseline — once captured, it must not change across iterations of the same
# compress run, otherwise the A/B test loses its reference point.
if [[ ! -f "$snapshot_dir/SKILL.md" ]]; then
  mkdir -p "$snapshot_dir"
  cp "$skill_path/SKILL.md" "$snapshot_dir/SKILL.md"
  echo "Wrote baseline snapshot: $snapshot_dir/SKILL.md"
else
  echo "Baseline snapshot already exists: $snapshot_dir/SKILL.md (left alone)"
fi
