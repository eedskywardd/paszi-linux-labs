#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu10/step6.ok ]] || { echo "✗ Сначала этап 6."; exit 1; }
f=/root/tfu10/protocol.txt
[[ -f "$f" ]] || { echo "✗ Нет protocol.txt"; exit 1; }
for x in PROJECT_COMPLIANCE COPPER_LINES POE_LINES FIBER_F01 FIBER_F02 LABELING PORT_CAPACITY DOCUMENTATION FINAL_ACCEPTANCE; do
  grep -Eq "^$x=PASS$" "$f" || { echo "✗ $x не подтвержден."; exit 1; }
done
touch /root/tfu10/step7.ok
echo "✓ Протокол испытаний оформлен."
