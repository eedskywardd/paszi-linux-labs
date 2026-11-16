#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu08/step2.ok ]] || { echo "✗ Сначала этап 2."; exit 1; }
f=/root/tfu08/fiber-design.txt
[[ -f "$f" ]] || { echo "✗ Нет fiber-design.txt"; exit 1; }
grep -Eq '^F01=OM3_LC_MM_SFP$' "$f" || { echo "✗ F01 выбрана неверно."; exit 1; }
grep -Eq '^F02=OS2_LC_SM_SFP$' "$f" || { echo "✗ F02 выбрана неверно."; exit 1; }
touch /root/tfu08/step3.ok
echo "✓ Оптические магистрали спроектированы."
