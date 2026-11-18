#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu09/step5.ok ]] || { echo "✗ Сначала этап 5."; exit 1; }
f=/root/tfu09/bom.txt
[[ -f "$f" ]] || { echo "✗ Нет bom.txt"; exit 1; }
grep -Eq '^COPPER_CABLE_M=1170\.4$' "$f" || { echo "✗ COPPER_CABLE_M неверно."; exit 1; }
grep -Eq '^PATCH_PANEL_48=1$' "$f" || { echo "✗ PATCH_PANEL_48 неверно."; exit 1; }
grep -Eq '^SWITCH_48=1$' "$f" || { echo "✗ SWITCH_48 неверно."; exit 1; }
grep -Eq '^POE_REQUIRED=YES$' "$f" || { echo "✗ POE_REQUIRED неверно."; exit 1; }
grep -Eq '^OPTICAL_CROSS=1$' "$f" || { echo "✗ OPTICAL_CROSS неверно."; exit 1; }
grep -Eq '^MM_SFP_PAIRS=1$' "$f" || { echo "✗ MM_SFP_PAIRS неверно."; exit 1; }
grep -Eq '^SM_SFP_PAIRS=1$' "$f" || { echo "✗ SM_SFP_PAIRS неверно."; exit 1; }
grep -Eq '^F01_FIBER_M=180$' "$f" || { echo "✗ F01_FIBER_M неверно."; exit 1; }
grep -Eq '^F02_FIBER_M=620$' "$f" || { echo "✗ F02_FIBER_M неверно."; exit 1; }
grep -Eq '^CABLE_MANAGER=YES$' "$f" || { echo "✗ CABLE_MANAGER неверно."; exit 1; }
touch /root/tfu09/step6.ok
echo "✓ Спецификация составлена."
