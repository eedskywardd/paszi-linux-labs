#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu07a/step4.ok ]] || { echo "✗ Сначала завершите этап 4."; exit 1; }
f=/root/tfu07a/f07.txt
[[ -f "$f" ]] || { echo "✗ Не найден f07.txt"; exit 1; }
norm(){ tr -d '\r' < "$1" | sed 's/[[:space:]]*=[[:space:]]*/=/g;s/[[:space:]]*$//' | tr '[:lower:]' '[:upper:]'; }
v="$(norm "$f")"
grep -q '^VISIBLE_LEAK=NO$' <<<"$v" || { echo "✗ VISIBLE_LEAK неверен."; exit 1; }
grep -q '^LOSS_DB=6.9$' <<<"$v" || { echo "✗ LOSS_DB неверен."; exit 1; }
grep -q '^EVENT_DISTANCE=172.0$' <<<"$v" || { echo "✗ EVENT_DISTANCE неверна."; exit 1; }
grep -q '^EVENT_LOSS=4.6$' <<<"$v" || { echo "✗ EVENT_LOSS неверна."; exit 1; }
grep -q '^CAUSE=DIRTY_CONNECTOR$' <<<"$v" || { echo "✗ CAUSE неверна."; exit 1; }
touch /root/tfu07a/step5.ok
echo "✓ F07 диагностирована правильно."
