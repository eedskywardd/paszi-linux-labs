#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu09/step4.ok ]] || { echo "✗ Сначала этап 4."; exit 1; }
f=/root/tfu09/labels.txt
[[ -f "$f" ]] || { echo "✗ Нет labels.txt"; exit 1; }
grep -Eq '^ROOM101_FIRST=A-PC-01$' "$f" || { echo "✗ ROOM101_FIRST неверно."; exit 1; }
grep -Eq '^ROOM101_LAST=A-PC-10$' "$f" || { echo "✗ ROOM101_LAST неверно."; exit 1; }
grep -Eq '^ROOM102_FIRST=A-PC-11$' "$f" || { echo "✗ ROOM102_FIRST неверно."; exit 1; }
grep -Eq '^ROOM102_LAST=A-PC-18$' "$f" || { echo "✗ ROOM102_LAST неверно."; exit 1; }
grep -Eq '^AP01=A-AP-01$' "$f" || { echo "✗ AP01 неверно."; exit 1; }
grep -Eq '^CAM01=A-CAM-01$' "$f" || { echo "✗ CAM01 неверно."; exit 1; }
grep -Eq '^CAM02=A-CAM-02$' "$f" || { echo "✗ CAM02 неверно."; exit 1; }
grep -Eq '^F01=A-F01$' "$f" || { echo "✗ F01 неверно."; exit 1; }
grep -Eq '^F02=A-F02$' "$f" || { echo "✗ F02 неверно."; exit 1; }
touch /root/tfu09/step5.ok
echo "✓ Система маркировки разработана."
