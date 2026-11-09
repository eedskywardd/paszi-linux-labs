#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu01/step1.ok ]] || { echo "✗ Сначала завершите этап 1."; exit 1; }
f=/root/tfu01/conductor.txt
[[ -f "$f" ]] || { echo "✗ Не найден /root/tfu01/conductor.txt"; exit 1; }
if [[ "$(tr -d '[:space:]' < "$f")" != "4" ]]; then
  echo "✗ Неверно определена жила."
  echo "Посмотрите, напротив какого контакта тестер показывает OPEN."
  exit 1
fi
touch /root/tfu01/step2.ok
echo "✓ Верно: кабельный тестер показывает обрыв жилы 4."
