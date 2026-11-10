#!/usr/bin/env bash
set -euo pipefail
f=/root/tfu04/suspects.txt
[[ -f "$f" ]] || { echo "✗ Не найден /root/tfu04/suspects.txt"; exit 1; }

v="$(tr -s '[:space:]' ' ' < "$f" | sed 's/^ //;s/ $//')"
if [[ "$v" != "L03 F01" && "$v" != "F01 L03" ]]; then
  echo "✗ Неверно выбраны подозрительные сегменты."
  echo "Подсказка: один сегмент DOWN, у второго много ошибок."
  exit 1
fi

touch /root/tfu04/step1.ok
echo "✓ Верно: дальнейшей диагностики требуют L03 и F01."
