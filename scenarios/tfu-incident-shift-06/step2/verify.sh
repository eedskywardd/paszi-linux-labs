#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu06/step1.ok ]] || { echo "✗ Сначала этап 1."; exit 1; }
f=/root/tfu06/copper.txt
[[ -f "$f" ]] || { echo "✗ Нет copper.txt"; exit 1; }
grep -Eq '^FAULT=OPEN$' "$f" || { echo "✗ Неверный FAULT."; exit 1; }
grep -Eq '^CONDUCTOR=7$' "$f" || { echo "✗ Неверный CONDUCTOR."; exit 1; }
grep -Eq '^DISTANCE=18\.9$' "$f" || { echo "✗ Неверная DISTANCE."; exit 1; }
touch /root/tfu06/step2.ok
echo "✓ Медная линия диагностирована."
