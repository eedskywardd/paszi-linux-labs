#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu06/step4.ok ]] || { echo "✗ Сначала этап 4."; exit 1; }
f=/root/tfu06/actions.txt
[[ -f "$f" ]] || { echo "✗ Нет actions.txt"; exit 1; }
grep -Eq '^L07_ACTION=RETERMINATE$' "$f" || { echo "✗ Для L07 выбрано неверное действие."; exit 1; }
grep -Eq '^P12_ACTION=REPLACE_CONTACT$' "$f" || { echo "✗ Для P12 выбрано неверное действие."; exit 1; }
grep -Eq '^F03_ACTION=CLEAN_OR_RESEAT_CONNECTOR$' "$f" || { echo "✗ Для F03 выбрано неверное действие."; exit 1; }
touch /root/tfu06/step5.ok
echo "✓ План ремонта выбран правильно."
