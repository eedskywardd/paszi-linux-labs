#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu07/step4.ok ]] || { echo "✗ Сначала этап 4."; exit 1; }
f=/root/tfu07/budget.txt
[[ -f "$f" ]] || { echo "✗ Нет budget.txt"; exit 1; }

grep -Eq '^FIBER_LOSS=0\.24$' "$f" || { echo "✗ FIBER_LOSS неверно."; exit 1; }
grep -Eq '^CONNECTOR_LOSS=1\.60$' "$f" || { echo "✗ CONNECTOR_LOSS неверно."; exit 1; }
grep -Eq '^SPLICE_LOSS=0\.20$' "$f" || { echo "✗ SPLICE_LOSS неверно."; exit 1; }
grep -Eq '^TOTAL_LOSS=5\.04$' "$f" || { echo "✗ TOTAL_LOSS неверно."; exit 1; }
grep -Eq '^RX_POWER=-7\.04$' "$f" || { echo "✗ RX_POWER неверно."; exit 1; }
grep -Eq '^RESULT=PASS$' "$f" || { echo "✗ Проверьте чувствительность приёмника."; exit 1; }

touch /root/tfu07/step5.ok
echo "✓ Оптический бюджет рассчитан правильно."
