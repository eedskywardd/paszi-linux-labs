#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu04/step5.ok ]] || { echo "✗ Сначала завершите этап 5."; exit 1; }

f=/root/tfu04/report.txt
[[ -f "$f" ]] || { echo "✗ Не найден /root/tfu04/report.txt"; exit 1; }

grep -Eq '^FIBER=F01$' "$f" || { echo "✗ Неверный FIBER."; exit 1; }
grep -Eq '^LOSS_DB=7\.6$' "$f" || { echo "✗ Неверный LOSS_DB."; exit 1; }
grep -Eq '^EVENT_DISTANCE=181\.0$' "$f" || { echo "✗ Неверный EVENT_DISTANCE."; exit 1; }
grep -Eq '^FAULT=MACROBEND$' "$f" || { echo "✗ Неверный FAULT."; exit 1; }

[[ "$(cat /root/tfu04/copper_state 2>/dev/null)" == "OK" ]] || { echo "✗ Медная линия L03 ещё не восстановлена."; exit 1; }
[[ "$(cat /root/tfu04/fiber_state 2>/dev/null)" == "OK" ]] || { echo "✗ Оптическая линия F01 ещё не восстановлена."; exit 1; }

echo "✓ Комплексная диагностика завершена: обе неисправности устранены."
