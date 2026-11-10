#!/usr/bin/env bash
set -euo pipefail

f=/root/tfu03/problem-port.txt
[[ -f "$f" ]] || { echo "✗ Не найден /root/tfu03/problem-port.txt"; exit 1; }

if [[ "$(tr -d '[:space:]' < "$f")" != "P02" ]]; then
  echo "✗ Выбран неверный порт."
  echo "Подсказка: найдите порт со статусом POE = FAULT."
  exit 1
fi

touch /root/tfu03/step1.ok
echo "✓ Верно: проблема на порту P02."
