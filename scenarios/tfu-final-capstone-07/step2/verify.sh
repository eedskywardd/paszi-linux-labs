#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu07/step1.ok ]] || { echo "✗ Сначала этап 1."; exit 1; }
f=/root/tfu07/copper-design.txt
[[ -f "$f" ]] || { echo "✗ Нет copper-design.txt"; exit 1; }
grep -Eq '^OFFICE=CAT6_UTP$' "$f" || { echo "✗ OFFICE выбрано неверно."; exit 1; }
grep -Eq '^AP=CAT6_UTP_POE$' "$f" || { echo "✗ AP выбрано неверно."; exit 1; }
grep -Eq '^CAM03=CAT6A_FTP_POE$' "$f" || { echo "✗ CAM03 выбрано неверно."; exit 1; }
touch /root/tfu07/step2.ok
echo "✓ Медные линии спроектированы."
