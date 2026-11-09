#!/usr/bin/env bash
set -euo pipefail

f=/root/tfu01/problem-line.txt
if [[ ! -f "$f" ]]; then
  echo "✗ Не найден /root/tfu01/problem-line.txt"
  echo "Сначала выполните link-status и запишите номер проблемной линии."
  exit 1
fi
if [[ "$(tr -d '[:space:]' < "$f")" != "L02" ]]; then
  echo "✗ Вы выбрали не ту линию."
  echo "Подсказка: посмотрите, где LINK имеет состояние DOWN."
  exit 1
fi
touch /root/tfu01/step1.ok
echo "✓ Верно: проблема находится на линии L02 к PC-02."
