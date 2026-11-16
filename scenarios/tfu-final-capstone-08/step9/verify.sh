#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu08/step8.ok ]] || { echo "✗ Сначала этап 8."; exit 1; }

[[ "$(cat /root/tfu08/copper_state 2>/dev/null)" == "OK" ]] || { echo "✗ L18 ещё не восстановлена."; exit 1; }
[[ "$(cat /root/tfu08/poe_state 2>/dev/null)" == "OK" ]] || { echo "✗ P07 ещё не восстановлен."; exit 1; }
[[ "$(cat /root/tfu08/fiber_state 2>/dev/null)" == "OK" ]] || { echo "✗ F02 ещё не восстановлена."; exit 1; }

f=/root/tfu08/final-report.txt
[[ -f "$f" ]] || { echo "✗ Нет final-report.txt"; exit 1; }
grep -Eq '^PROJECT=PASS$' "$f" || { echo "✗ PROJECT заполнено неверно."; exit 1; }
grep -Eq '^OPTICAL_BUDGET=PASS$' "$f" || { echo "✗ OPTICAL_BUDGET заполнено неверно."; exit 1; }
grep -Eq '^COPPER=RESTORED$' "$f" || { echo "✗ COPPER заполнено неверно."; exit 1; }
grep -Eq '^POE=RESTORED$' "$f" || { echo "✗ POE заполнено неверно."; exit 1; }
grep -Eq '^FIBER=RESTORED$' "$f" || { echo "✗ FIBER заполнено неверно."; exit 1; }
grep -Eq '^ACCEPTANCE=PASS$' "$f" || { echo "✗ ACCEPTANCE заполнено неверно."; exit 1; }

echo "✓ ИТОГОВАЯ РАБОТА ТФУ ЗАВЕРШЕНА."
echo "✓ Проектирование, расчёты, диагностика и приёмка выполнены успешно."
