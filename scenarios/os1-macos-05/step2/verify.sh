#!/usr/bin/env bash
set -euo pipefail
cd /root/os05/work
expected=$'RED=close\nYELLOW=minimize\nGREEN=maximize'
[[ -f window_controls.txt ]] || { echo "✗ Нет window_controls.txt."; exit 1; }
[[ "$(cat window_controls.txt)" == "$expected" ]] || { echo "✗ Неверно указано назначение одной из кнопок окна."; exit 1; }
echo "✓ Управление окнами macOS изучено."
