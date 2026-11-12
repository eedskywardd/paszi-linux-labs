#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu07a/step1.ok ]] || { echo "✗ Сначала завершите этап 1."; exit 1; }
f=/root/tfu07a/l11.txt
[[ -f "$f" ]] || { echo "✗ Не найден l11.txt"; exit 1; }
norm(){ tr -d '\r' < "$1" | sed 's/[[:space:]]*=[[:space:]]*/=/g;s/[[:space:]]*$//' | tr '[:lower:]' '[:upper:]'; }
v="$(norm "$f")"
grep -q '^FAULT=OPEN$' <<<"$v" || { echo "✗ FAULT неверен."; exit 1; }
grep -q '^CONDUCTOR=4$' <<<"$v" || { echo "✗ CONDUCTOR — это номер жилы. Здесь нужен 4."; exit 1; }
grep -q '^DISTANCE=22.6$' <<<"$v" || { echo "✗ DISTANCE неверна."; exit 1; }
touch /root/tfu07a/step2.ok
echo "✓ L11 диагностирована правильно."
