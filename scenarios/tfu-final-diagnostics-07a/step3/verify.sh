#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu07a/step2.ok ]] || { echo "✗ Сначала завершите этап 2."; exit 1; }
f=/root/tfu07a/l12.txt
[[ -f "$f" ]] || { echo "✗ Не найден l12.txt"; exit 1; }
norm(){ tr -d '\r' < "$1" | sed 's/[[:space:]]//g' | tr '[:lower:]' '[:upper:]'; }
v="$(norm "$f")"
grep -q '^WIREMAP=PASS$' <<<"$v" || { echo "✗ WIREMAP неверен."; exit 1; }
grep -q '^FAULT=SPLIT_PAIR$' <<<"$v" || { echo "✗ FAULT неверен."; exit 1; }
grep -q '^AFFECTED_PAIRS=1-2,3-6$' <<<"$v" || { echo "✗ AFFECTED_PAIRS неверны."; exit 1; }
touch /root/tfu07a/step3.ok
echo "✓ L12 диагностирована правильно: SPLIT PAIR."
