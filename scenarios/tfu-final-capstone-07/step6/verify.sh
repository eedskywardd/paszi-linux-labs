#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu07/step5.ok ]] || { echo "✗ Сначала этап 5."; exit 1; }
f=/root/tfu07/copper-fault.txt
[[ -f "$f" ]] || { echo "✗ Нет copper-fault.txt"; exit 1; }
grep -Eq '^FAULT=OPEN$' "$f" || { echo "✗ Неверный FAULT."; exit 1; }
grep -Eq '^CONDUCTOR=5$' "$f" || { echo "✗ Неверный CONDUCTOR."; exit 1; }
grep -Eq '^DISTANCE=36\.8$' "$f" || { echo "✗ Неверная DISTANCE."; exit 1; }
touch /root/tfu07/step6.ok
echo "✓ Неисправность L18 определена."
