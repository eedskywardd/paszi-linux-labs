#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu05/step3.ok ]] || { echo "✗ Сначала этап 3."; exit 1; }
f=/root/tfu05/poe.txt
[[ -f "$f" ]] || { echo "✗ Нет poe.txt"; exit 1; }

grep -Eq '^AP01_POE=YES$' "$f" || { echo "✗ Ошибка AP01_POE."; exit 1; }
grep -Eq '^CAM01_POE=YES$' "$f" || { echo "✗ Ошибка CAM01_POE."; exit 1; }
grep -Eq '^PC_POE=NO$' "$f" || { echo "✗ Ошибка PC_POE."; exit 1; }
grep -Eq '^SFP_F01=MM$' "$f" || { echo "✗ Для F01 нужен MM SFP."; exit 1; }
grep -Eq '^SFP_F02=SM$' "$f" || { echo "✗ Для F02 нужен SM SFP."; exit 1; }

touch /root/tfu05/step4.ok
echo "✓ PoE и SFP выбраны правильно."
