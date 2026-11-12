#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu06/step5.ok ]] || { echo "✗ Сначала этап 5."; exit 1; }

[[ "$(cat /root/tfu06/copper_state 2>/dev/null)" == "OK" ]] || { echo "✗ L07 ещё не восстановлена."; exit 1; }
[[ "$(cat /root/tfu06/poe_state 2>/dev/null)" == "OK" ]] || { echo "✗ P12 ещё не восстановлен."; exit 1; }
[[ "$(cat /root/tfu06/fiber_state 2>/dev/null)" == "OK" ]] || { echo "✗ F03 ещё не восстановлена."; exit 1; }

f=/root/tfu06/final-report.txt
[[ -f "$f" ]] || { echo "✗ Нет final-report.txt"; exit 1; }
grep -Eq '^COPPER=RESTORED$' "$f" || { echo "✗ COPPER заполнено неверно."; exit 1; }
grep -Eq '^POE=RESTORED$' "$f" || { echo "✗ POE заполнено неверно."; exit 1; }
grep -Eq '^FIBER=RESTORED$' "$f" || { echo "✗ FIBER заполнено неверно."; exit 1; }
grep -Eq '^FINAL_STATUS=OK$' "$f" || { echo "✗ FINAL_STATUS заполнено неверно."; exit 1; }

echo "✓ Аварийная смена завершена. Все три сегмента восстановлены."
