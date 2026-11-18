#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu09/step1.ok ]] || { echo "✗ Сначала этап 1."; exit 1; }
f=/root/tfu09/reasons.txt
[[ -f "$f" ]] || { echo "✗ Нет reasons.txt"; exit 1; }
grep -Eq '^ROOMS_REASON=OFFICE_UNDER_100M$' "$f" || { echo "✗ Неверное обоснование ROOMS."; exit 1; }
grep -Eq '^CAM02_REASON=EMI_NEAR_POWER$' "$f" || { echo "✗ Неверное обоснование CAM02."; exit 1; }
grep -Eq '^F01_REASON=INTERFLOOR_180M$' "$f" || { echo "✗ Неверное обоснование F01."; exit 1; }
grep -Eq '^F02_REASON=REMOTE_BUILDING_620M$' "$f" || { echo "✗ Неверное обоснование F02."; exit 1; }
touch /root/tfu09/step2.ok
echo "✓ Решения обоснованы."
