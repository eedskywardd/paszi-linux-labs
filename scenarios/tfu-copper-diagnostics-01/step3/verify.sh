#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu01/step2.ok ]] || { echo "✗ Сначала завершите этап 2."; exit 1; }
f=/root/tfu01/distance.txt
[[ -f "$f" ]] || { echo "✗ Не найден /root/tfu01/distance.txt"; exit 1; }
if [[ "$(tr -d '[:space:]' < "$f")" != "31.4" ]]; then
  echo "✗ Неверное расстояние."
  echo "Посмотрите строку FAULT DISTANCE в выводе tdr L02."
  exit 1
fi
touch /root/tfu01/step3.ok
echo "✓ Верно: дефект локализован примерно в 31.4 м от точки измерения."
