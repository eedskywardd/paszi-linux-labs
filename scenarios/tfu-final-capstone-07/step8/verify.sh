#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu07/step7.ok ]] || { echo "✗ Сначала этап 7."; exit 1; }
f=/root/tfu07/fiber-fault.txt
[[ -f "$f" ]] || { echo "✗ Нет fiber-fault.txt"; exit 1; }
grep -Eq '^LOSS_DB=7\.1$' "$f" || { echo "✗ Неверный LOSS_DB."; exit 1; }
grep -Eq '^EVENT_DISTANCE=462\.0$' "$f" || { echo "✗ Неверный EVENT_DISTANCE."; exit 1; }
grep -Eq '^FAULT=MACROBEND$' "$f" || { echo "✗ Неверный FAULT."; exit 1; }
touch /root/tfu07/step8.ok
echo "✓ Неисправность F02 определена."
