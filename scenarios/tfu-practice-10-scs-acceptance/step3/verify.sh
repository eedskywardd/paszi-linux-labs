#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu10/step2.ok ]] || { echo "✗ Сначала этап 2."; exit 1; }
f=/root/tfu10/poe-test.txt
[[ -f "$f" ]] || { echo "✗ Нет poe-test.txt"; exit 1; }
grep -Eq '^AP01=PASS$' "$f" || { echo "✗ AP01 неверно."; exit 1; }
grep -Eq '^CAM01=PASS$' "$f" || { echo "✗ CAM01 неверно."; exit 1; }
grep -Eq '^CAM02=PASS$' "$f" || { echo "✗ CAM02 неверно."; exit 1; }
grep -Eq '^CAM02_SHIELDING=PRESENT$' "$f" || { echo "✗ Проверьте экранирование CAM02."; exit 1; }
grep -Eq '^NEGOTIATION=PASS$' "$f" || { echo "✗ NEGOTIATION неверно."; exit 1; }
grep -Eq '^RESULT=PASS$' "$f" || { echo "✗ RESULT неверен."; exit 1; }
touch /root/tfu10/step3.ok
echo "✓ PoE-инфраструктура прошла проверку."
