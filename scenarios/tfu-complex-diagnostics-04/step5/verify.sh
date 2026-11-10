#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu04/step4.ok ]] || { echo "✗ Сначала завершите этап 4."; exit 1; }

f=/root/tfu04/otdr.txt
[[ -f "$f" ]] || { echo "✗ Не найден /root/tfu04/otdr.txt"; exit 1; }

grep -Eq '^EVENT_DISTANCE=181\.0$' "$f" || { echo "✗ Неверный EVENT_DISTANCE."; exit 1; }
grep -Eq '^EVENT_LOSS=4\.8$' "$f" || { echo "✗ Неверный EVENT_LOSS."; exit 1; }
grep -Eq '^FAULT=MACROBEND$' "$f" || { echo "✗ Неверный FAULT."; exit 1; }

touch /root/tfu04/step5.ok
echo "✓ OTDR: событие 4.8 dB на расстоянии 181.0 м, вероятный макроизгиб."
