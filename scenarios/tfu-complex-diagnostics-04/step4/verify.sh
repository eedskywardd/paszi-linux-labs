#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu04/step3.ok ]] || { echo "✗ Сначала завершите этап 3."; exit 1; }

f=/root/tfu04/power.txt
[[ -f "$f" ]] || { echo "✗ Не найден /root/tfu04/power.txt"; exit 1; }

if [[ "$(tr -d '[:space:]' < "$f")" != "7.6" ]]; then
  echo "✗ Неверно записана общая потеря."
  echo "Посмотрите строку TOTAL LOSS."
  exit 1
fi

touch /root/tfu04/step4.ok
echo "✓ Верно: общая потеря составляет 7.6 dB."
