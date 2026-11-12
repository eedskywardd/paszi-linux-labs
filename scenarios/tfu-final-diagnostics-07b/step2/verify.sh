#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu07b/step1.ok ]] || { echo "✗ Сначала этап 1."; exit 1; }
f=/root/tfu07b/actions.txt
[[ -f "$f" ]] || { echo "✗ Нет actions.txt"; exit 1; }
norm(){ tr -d '\r' < "$1" | sed 's/[[:space:]]//g' | tr '[:lower:]' '[:upper:]'; }
v="$(norm "$f")"
grep -q '^L11_ACTION=RETERMINATE_OR_REPLACE_SECTION$' <<<"$v" || { echo "✗ Неверное действие для L11."; exit 1; }
grep -q '^L12_ACTION=RECRIMP_CORRECT_PAIRS$' <<<"$v" || { echo "✗ Неверное действие для L12."; exit 1; }
grep -q '^P18_ACTION=REPLACE_WITH_SOLID_COPPER$' <<<"$v" || { echo "✗ Неверное действие для P18."; exit 1; }
grep -q '^F07_ACTION=CLEAN_AND_RESEAT_CONNECTOR$' <<<"$v" || { echo "✗ Неверное действие для F07."; exit 1; }
touch /root/tfu07b/step2.ok
echo "✓ Ремонтные действия выбраны правильно."
