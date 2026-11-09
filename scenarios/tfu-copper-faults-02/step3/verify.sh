#!/usr/bin/env bash
set -euo pipefail

[[ -f /root/tfu02/step2.ok ]] || { echo "✗ Сначала завершите этап 2."; exit 1; }
f=/root/tfu02/split.txt
[[ -f "$f" ]] || { echo "✗ Не найден /root/tfu02/split.txt"; exit 1; }

if [[ "$(tr -d '[:space:]' < "$f")" != "SPLIT_PAIR" ]]; then
  echo "✗ Неверно определена неисправность L04."
  echo "Подсказка: pair-test показывает тип нарушения пары."
  exit 1
fi

touch /root/tfu02/step3.ok
echo "✓ Верно: L04 имеет SPLIT PAIR."
