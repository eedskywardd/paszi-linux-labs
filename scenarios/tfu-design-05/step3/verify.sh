#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu05/step2.ok ]] || { echo "✗ Сначала этап 2."; exit 1; }
f=/root/tfu05/fiber.txt
[[ -f "$f" ]] || { echo "✗ Нет fiber.txt"; exit 1; }
grep -Eq '^F01=OM3_LC_SFP$' "$f" || { echo "✗ F01 выбрана неверно."; exit 1; }
grep -Eq '^F02=OS2_LC_SFP$' "$f" || { echo "✗ F02 выбрана неверно."; exit 1; }
touch /root/tfu05/step3.ok
echo "✓ Оптические линии выбраны правильно."
