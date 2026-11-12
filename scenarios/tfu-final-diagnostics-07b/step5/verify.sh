#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu07b/step4.ok ]] || { echo "✗ Сначала этап 4."; exit 1; }
f=/root/tfu07b/acceptance.txt
[[ -f "$f" ]] || { echo "✗ Нет acceptance.txt"; exit 1; }
norm(){ tr -d '\r' < "$1" | sed 's/[[:space:]]*=[[:space:]]*/=/g;s/[[:space:]]*$//' | tr '[:lower:]' '[:upper:]'; }
v="$(norm "$f")"
grep -q '^L11=PASS$' <<<"$v" || { echo "✗ L11 должна быть PASS."; exit 1; }
grep -q '^L12=PASS$' <<<"$v" || { echo "✗ L12 должна быть PASS."; exit 1; }
grep -q '^P18_DROP=1.2$' <<<"$v" || { echo "✗ P18_DROP неверен."; exit 1; }
grep -q '^F07_LOSS=2.3$' <<<"$v" || { echo "✗ F07_LOSS неверен."; exit 1; }
touch /root/tfu07b/step5.ok
echo "✓ Приёмочные измерения соответствуют нормальному состоянию."
