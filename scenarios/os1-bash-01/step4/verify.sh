#!/usr/bin/env bash
set -euo pipefail
f=/root/bash01/work/docs/notes.txt
[[ -f "$f" ]] || { echo "✗ notes.txt не найден."; exit 1; }
expected=$'Operating Systems\nBash practice'
actual="$(cat "$f")"
if [[ "$actual" != "$expected" ]]; then
  echo "✗ notes.txt должен содержать две строки:"
  echo "Operating Systems"
  echo "Bash practice"
  exit 1
fi
echo "✓ Верно. Вы увидели разницу между > и >>."
