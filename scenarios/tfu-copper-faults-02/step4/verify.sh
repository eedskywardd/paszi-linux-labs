#!/usr/bin/env bash
set -euo pipefail

[[ -f /root/tfu02/step3.ok ]] || { echo "✗ Сначала завершите этап 3."; exit 1; }
f=/root/tfu02/report.txt
[[ -f "$f" ]] || { echo "✗ Не найден /root/tfu02/report.txt"; exit 1; }

grep -Eq '^L02=MISWIRE$' "$f" || { echo "✗ Неверный диагноз L02."; exit 1; }
grep -Eq '^L03=REVERSED_PAIR$' "$f" || { echo "✗ Неверный диагноз L03."; exit 1; }
grep -Eq '^L04=SPLIT_PAIR$' "$f" || { echo "✗ Неверный диагноз L04."; exit 1; }

if [[ "$(cat /root/tfu02/state 2>/dev/null)" != "OK" ]]; then
  echo "✗ Диагнозы заполнены, но линии ещё не исправлены."
  echo "Выполните repair-all."
  exit 1
fi

echo "✓ Все неисправности правильно определены и устранены."
