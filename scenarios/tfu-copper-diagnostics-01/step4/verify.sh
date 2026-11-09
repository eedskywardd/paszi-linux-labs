#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu01/step3.ok ]] || { echo "✗ Сначала завершите этап 3."; exit 1; }
report=/root/tfu01/report.txt
[[ -f "$report" ]] || { echo "✗ Нет /root/tfu01/report.txt"; exit 1; }
grep -Eq '^LINE=L02$' "$report" || { echo "✗ LINE должно быть L02."; exit 1; }
grep -Eq '^FAULT=OPEN$' "$report" || { echo "✗ FAULT должно быть OPEN."; exit 1; }
grep -Eq '^CONDUCTOR=4$' "$report" || { echo "✗ Неверный CONDUCTOR."; exit 1; }
grep -Eq '^DISTANCE=31\.4$' "$report" || { echo "✗ Неверная DISTANCE."; exit 1; }
if [[ "$(cat /root/tfu01/state 2>/dev/null)" != "OK" ]]; then
  echo "✗ Диагноз записан, но линия ещё не восстановлена."
  echo "Выполните repair-line L02."
  exit 1
fi
echo "✓ Работа выполнена: неисправность найдена, локализована, устранена и подтверждена контрольными измерениями."
