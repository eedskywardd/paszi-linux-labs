#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu09/step6.ok ]] || { echo "✗ Сначала этап 6."; exit 1; }
f=/root/tfu09/passport.txt
[[ -f "$f" ]] || { echo "✗ Нет passport.txt"; exit 1; }
grep -Eq '^PROJECT=ENTERPRISE_SCS$' "$f" || { echo "✗ PROJECT неверно."; exit 1; }
grep -Eq '^WORKPLACES=18$' "$f" || { echo "✗ WORKPLACES неверно."; exit 1; }
grep -Eq '^COPPER_STANDARD=CAT6_UTP$' "$f" || { echo "✗ COPPER_STANDARD неверно."; exit 1; }
grep -Eq '^POE_DEVICES=3$' "$f" || { echo "✗ POE_DEVICES неверно."; exit 1; }
grep -Eq '^FIBER_BACKBONES=2$' "$f" || { echo "✗ FIBER_BACKBONES неверно."; exit 1; }
grep -Eq '^PATCH_PANEL=48_PORT$' "$f" || { echo "✗ PATCH_PANEL неверно."; exit 1; }
grep -Eq '^SWITCH_PORTS=48$' "$f" || { echo "✗ SWITCH_PORTS неверно."; exit 1; }
grep -Eq '^LABELING=A-SCHEME$' "$f" || { echo "✗ LABELING неверно."; exit 1; }
grep -Eq '^DOCUMENTATION=COMPLETE$' "$f" || { echo "✗ DOCUMENTATION неверно."; exit 1; }
grep -Eq '^PROJECT_STATUS=READY$' "$f" || { echo "✗ PROJECT_STATUS неверно."; exit 1; }
touch /root/tfu09/step7.ok
echo "✓ Паспорт СКС оформлен."
