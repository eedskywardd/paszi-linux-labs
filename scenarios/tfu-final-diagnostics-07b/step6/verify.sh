#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu07b/step5.ok ]] || { echo "✗ Сначала этап 5."; exit 1; }
f=/root/tfu07b/final-act.txt
[[ -f "$f" ]] || { echo "✗ Нет final-act.txt"; exit 1; }
norm(){ tr -d '\r' < "$1" | sed 's/[[:space:]]//g' | tr '[:lower:]' '[:upper:]'; }
v="$(norm "$f")"
for line in COPPER_L11=RESTORED COPPER_L12=RESTORED POE_P18=RESTORED FIBER_F07=RESTORED ACCEPTANCE=PASS FINAL_STATUS=OK; do
  grep -q "^$line$" <<<"$v" || { echo "✗ Нет или неверна строка: $line"; exit 1; }
done
echo "✓ Итоговая работа по диагностике полностью завершена."
