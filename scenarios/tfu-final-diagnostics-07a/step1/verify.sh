#!/usr/bin/env bash
set -euo pipefail
f=/root/tfu07a/plan.txt
[[ -f "$f" ]] || { echo "✗ Не найден plan.txt"; exit 1; }
norm(){ tr -d '\r' < "$1" | sed 's/[[:space:]]//g' | tr '[:upper:]' '[:lower:]'; }
v="$(norm "$f")"
grep -q '^l11=cable-test,tdr$' <<<"$v" || { echo "✗ L11: нужен cable-test,tdr"; exit 1; }
grep -q '^l12=cable-test,pair-test$' <<<"$v" || { echo "✗ L12: нужен cable-test,pair-test"; exit 1; }
grep -q '^p18=poe-test,load-test$' <<<"$v" || { echo "✗ P18: нужен poe-test,load-test"; exit 1; }
grep -q '^f07=vfl,power-meter,otdr$' <<<"$v" || { echo "✗ F07: нужен vfl,power-meter,otdr"; exit 1; }
touch /root/tfu07a/step1.ok
echo "✓ План диагностики составлен правильно."
