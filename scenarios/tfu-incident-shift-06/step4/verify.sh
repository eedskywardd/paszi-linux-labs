#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu06/step3.ok ]] || { echo "✗ Сначала этап 3."; exit 1; }
f=/root/tfu06/fiber.txt
[[ -f "$f" ]] || { echo "✗ Нет fiber.txt"; exit 1; }
grep -Eq '^LOSS_DB=8\.4$' "$f" || { echo "✗ Неверный LOSS_DB."; exit 1; }
grep -Eq '^EVENT_DISTANCE=244\.0$' "$f" || { echo "✗ Неверный EVENT_DISTANCE."; exit 1; }
grep -Eq '^CAUSE=DIRTY_OR_BAD_CONNECTOR$' "$f" || { echo "✗ Неверная CAUSE."; exit 1; }
touch /root/tfu06/step4.ok
echo "✓ Оптический uplink диагностирован."
