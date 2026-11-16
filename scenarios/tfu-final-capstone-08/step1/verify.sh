#!/usr/bin/env bash
set -euo pipefail
f=/root/tfu08/plan.txt
[[ -f "$f" ]] || { echo "✗ Нет plan.txt"; exit 1; }
grep -Eq '^COPPER_SEGMENTS=PC AP CAM$' "$f" || { echo "✗ Неверно указаны COPPER_SEGMENTS."; exit 1; }
grep -Eq '^FIBER_SEGMENTS=F01 F02$' "$f" || { echo "✗ Неверно указаны FIBER_SEGMENTS."; exit 1; }
grep -Eq '^POE_DEVICES=AP-01 AP-02 CAM-01 CAM-02 CAM-03$' "$f" || { echo "✗ Неверно указаны POE_DEVICES."; exit 1; }
grep -Eq '^FAULT_TICKETS=L18 P07 F02$' "$f" || { echo "✗ Неверно указаны FAULT_TICKETS."; exit 1; }
touch /root/tfu08/step1.ok
echo "✓ План объекта составлен."
