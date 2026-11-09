#!/usr/bin/env bash
set -euo pipefail

[[ -f /root/tfu02/step1.ok ]] || { echo "✗ Сначала завершите этап 1."; exit 1; }
f=/root/tfu02/faults.txt
[[ -f "$f" ]] || { echo "✗ Не найден /root/tfu02/faults.txt"; exit 1; }

grep -Eq '^L02=MISWIRE$' "$f" || { echo "✗ Неверно определена неисправность L02."; exit 1; }
grep -Eq '^L03=REVERSED_PAIR$' "$f" || { echo "✗ Неверно определена неисправность L03."; exit 1; }

touch /root/tfu02/step2.ok
echo "✓ Верно: L02 — MISWIRE, L03 — REVERSED PAIR."
