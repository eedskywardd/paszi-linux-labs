#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu07a/step5.ok ]] || { echo "✗ Сначала завершите этап 5."; exit 1; }
f=/root/tfu07a/diagnostic-card.txt
[[ -f "$f" ]] || { echo "✗ Не найден diagnostic-card.txt"; exit 1; }
norm(){ tr -d '\r' < "$1" | sed 's/[[:space:]]//g' | tr '[:lower:]' '[:upper:]'; }
v="$(norm "$f")"
grep -q '^L11=OPEN_WIRE4_22.6M$' <<<"$v" || { echo "✗ Ошибка в строке L11."; exit 1; }
grep -q '^L12=SPLIT_PAIR$' <<<"$v" || { echo "✗ Ошибка в строке L12."; exit 1; }
grep -q '^P18=HIGH_RESISTANCE_OR_CCA_LINE$' <<<"$v" || { echo "✗ Ошибка в строке P18."; exit 1; }
grep -q '^F07=DIRTY_CONNECTOR_172.0M$' <<<"$v" || { echo "✗ Ошибка в строке F07."; exit 1; }
echo "✓ Диагностическая карта готова. Часть 7А завершена."
