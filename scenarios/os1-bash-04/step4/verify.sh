#!/usr/bin/env bash
set -euo pipefail
cd /root/bash04/work
[[ "$(cat uptime_checked.txt 2>/dev/null || true)" == "uptime checked" ]] || { echo "✗ Выполните uptime и создайте uptime_checked.txt по инструкции."; exit 1; }
[[ -f memory.txt ]] || { echo "✗ Нет memory.txt."; exit 1; }
grep -q '^Mem:' memory.txt || { echo "✗ memory.txt должен содержать вывод free -h со строкой Mem:."; exit 1; }
echo "✓ Сведения о времени работы и памяти получены."
