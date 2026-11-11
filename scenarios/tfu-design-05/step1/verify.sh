#!/usr/bin/env bash
set -euo pipefail
f=/root/tfu05/types.txt
[[ -f "$f" ]] || { echo "✗ Не найден types.txt"; exit 1; }
grep -Eq '^COPPER=L01 L02 L03$' "$f" || { echo "✗ Неверно указаны медные линии."; exit 1; }
grep -Eq '^FIBER=F01 F02$' "$f" || { echo "✗ Неверно указаны оптические линии."; exit 1; }
touch /root/tfu05/step1.ok
echo "✓ Линии классифицированы правильно."
