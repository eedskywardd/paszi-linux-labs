#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu04/step1.ok ]] || { echo "✗ Сначала завершите этап 1."; exit 1; }

f=/root/tfu04/copper.txt
[[ -f "$f" ]] || { echo "✗ Не найден /root/tfu04/copper.txt"; exit 1; }

grep -Eq '^LINE=L03$' "$f" || { echo "✗ Неверный LINE."; exit 1; }
grep -Eq '^FAULT=OPEN$' "$f" || { echo "✗ Неверный FAULT."; exit 1; }
grep -Eq '^CONDUCTOR=6$' "$f" || { echo "✗ Неверный CONDUCTOR."; exit 1; }
grep -Eq '^DISTANCE=42\.7$' "$f" || { echo "✗ Неверная DISTANCE."; exit 1; }

touch /root/tfu04/step2.ok
echo "✓ Медная неисправность определена правильно."
