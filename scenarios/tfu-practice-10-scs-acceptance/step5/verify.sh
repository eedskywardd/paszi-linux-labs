#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu10/step4.ok ]] || { echo "✗ Сначала этап 4."; exit 1; }
f=/root/tfu10/labels-check.txt
[[ -f "$f" ]] || { echo "✗ Нет labels-check.txt"; exit 1; }
for x in WORKPLACE_LABELS POE_LABELS FIBER_LABELS PATCH_PANEL_LABELS OUTLET_LABELS RESULT; do
  grep -Eq "^$x=PASS$" "$f" || { echo "✗ $x не подтверждено."; exit 1; }
done
touch /root/tfu10/step5.ok
echo "✓ Маркировка и коммутация соответствуют проекту."
