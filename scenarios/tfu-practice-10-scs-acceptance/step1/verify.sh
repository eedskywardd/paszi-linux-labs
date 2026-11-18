#!/usr/bin/env bash
set -euo pipefail
f=/root/tfu10/project-check.txt
[[ -f "$f" ]] || { echo "✗ Нет project-check.txt"; exit 1; }
grep -Eq '^WORKPLACES=18$' "$f" || { echo "✗ WORKPLACES неверно."; exit 1; }
grep -Eq '^COPPER=CAT6_UTP$' "$f" || { echo "✗ COPPER неверно."; exit 1; }
grep -Eq '^POE_DEVICES=3$' "$f" || { echo "✗ POE_DEVICES неверно."; exit 1; }
grep -Eq '^PATCH_PANEL=48_PORT$' "$f" || { echo "✗ PATCH_PANEL неверно."; exit 1; }
grep -Eq '^SWITCH_PORTS=48$' "$f" || { echo "✗ SWITCH_PORTS неверно."; exit 1; }
grep -Eq '^FIBER_BACKBONES=2$' "$f" || { echo "✗ FIBER_BACKBONES неверно."; exit 1; }
grep -Eq '^LABELING=A-SCHEME$' "$f" || { echo "✗ LABELING неверно."; exit 1; }
grep -Eq '^DOCUMENTATION=COMPLETE$' "$f" || { echo "✗ DOCUMENTATION неверно."; exit 1; }
grep -Eq '^RESULT=PASS$' "$f" || { echo "✗ Проверьте соответствие проекту."; exit 1; }
touch /root/tfu10/step1.ok
echo "✓ Построенная СКС соответствует проекту №9."
