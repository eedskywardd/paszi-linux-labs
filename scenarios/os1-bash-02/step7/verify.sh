#!/usr/bin/env bash
set -euo pipefail
cd /root/bash02
[[ -f final_report.txt ]] || { echo "✗ final_report.txt не найден."; exit 1; }
expected=$'ERRORS=3\nUNIQUE_USERS=4\n2026-11-06 09:08 ERROR network unreachable'
actual="$(cat final_report.txt)"
if [[ "$actual" != "$expected" ]]; then
  echo "✗ Отчёт пока не совпадает."
  echo "Нужно ровно:"
  printf '%s\n' "$expected"
  exit 1
fi
echo "✓ Bash 02 завершён. Вы умеете искать, сортировать, считать и соединять команды конвейером."
