#!/usr/bin/env bash
set -euo pipefail

[[ -f /root/tfu03/step2.ok ]] || { echo "✗ Сначала завершите этап 2."; exit 1; }

f=/root/tfu03/voltage.txt
[[ -f "$f" ]] || { echo "✗ Не найден /root/tfu03/voltage.txt"; exit 1; }

if [[ "$(tr -d '[:space:]' < "$f")" != "39.2" ]]; then
  echo "✗ Неверно записано напряжение под нагрузкой."
  echo "Посмотрите строку VOLTAGE UNDER LOAD."
  exit 1
fi

touch /root/tfu03/step3.ok
echo "✓ Верно: под нагрузкой напряжение падает до 39.2 V."
