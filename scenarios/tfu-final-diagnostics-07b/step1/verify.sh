#!/usr/bin/env bash
set -euo pipefail
f=/root/tfu07b/diagnostic-card.txt
[[ -f "$f" ]] || { echo "✗ Не найден diagnostic-card.txt"; exit 1; }
norm(){ tr -d '\r' < "$1" | sed 's/[[:space:]]//g' | tr '[:lower:]' '[:upper:]'; }
v="$(norm "$f")"
grep -q '^L11=OPEN_WIRE4_22.6M$' <<<"$v" || { echo "✗ Ошибка L11."; exit 1; }
grep -q '^L12=SPLIT_PAIR$' <<<"$v" || { echo "✗ Ошибка L12."; exit 1; }
grep -q '^P18=HIGH_RESISTANCE_OR_CCA_LINE$' <<<"$v" || { echo "✗ Ошибка P18."; exit 1; }
grep -q '^F07=DIRTY_CONNECTOR_172.0M$' <<<"$v" || { echo "✗ Ошибка F07."; exit 1; }
touch /root/tfu07b/step1.ok
echo "✓ Диагностическая карта принята."
