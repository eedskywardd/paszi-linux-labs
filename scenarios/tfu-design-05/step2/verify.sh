#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu05/step1.ok ]] || { echo "✗ Сначала этап 1."; exit 1; }
f=/root/tfu05/copper.txt
[[ -f "$f" ]] || { echo "✗ Нет copper.txt"; exit 1; }
grep -Eq '^L01=CAT6_UTP$' "$f" || { echo "✗ L01 выбрана неверно."; exit 1; }
grep -Eq '^L02=CAT6_UTP_POE$' "$f" || { echo "✗ L02 выбрана неверно."; exit 1; }
grep -Eq '^L03=CAT6A_FTP_POE$' "$f" || { echo "✗ L03 выбрана неверно."; exit 1; }
touch /root/tfu05/step2.ok
echo "✓ Медные линии выбраны правильно."
