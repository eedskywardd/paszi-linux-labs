#!/usr/bin/env bash
set -euo pipefail
f=/root/tfu09/design.txt
[[ -f "$f" ]] || { echo "✗ Нет design.txt"; exit 1; }
grep -Eq '^ROOMS=CAT6_UTP$' "$f" || { echo "✗ Неверно выбраны линии рабочих мест."; exit 1; }
grep -Eq '^AP01=CAT6_UTP_POE$' "$f" || { echo "✗ Неверно выбрана линия AP-01."; exit 1; }
grep -Eq '^CAM01=CAT6_UTP_POE$' "$f" || { echo "✗ Неверно выбрана линия CAM-01."; exit 1; }
grep -Eq '^CAM02=CAT6A_FTP_POE$' "$f" || { echo "✗ CAM-02 требует экранирования."; exit 1; }
grep -Eq '^F01=OM3_LC_MM_SFP$' "$f" || { echo "✗ Неверно выбрана F01."; exit 1; }
grep -Eq '^F02=OS2_LC_SM_SFP$' "$f" || { echo "✗ Неверно выбрана F02."; exit 1; }
touch /root/tfu09/step1.ok
echo "✓ Кабельные решения выбраны."
