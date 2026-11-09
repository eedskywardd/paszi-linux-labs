#!/usr/bin/env bash
set -euo pipefail

f=/root/tfu02/suspects.txt
[[ -f "$f" ]] || { echo "✗ Не найден /root/tfu02/suspects.txt"; exit 1; }

v="$(tr -s '[:space:]' ' ' < "$f" | sed 's/^ //;s/ $//')"
if [[ "$v" != "L02 L03 L04" ]]; then
  echo "✗ Выбраны не все подозрительные линии."
  echo "Подсказка: смотрите LINK, SPEED и ERRORS."
  exit 1
fi

touch /root/tfu02/step1.ok
echo "✓ Верно: L02, L03 и L04 требуют диагностики."
