#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu06/step2.ok ]] || { echo "✗ Сначала этап 2."; exit 1; }
f=/root/tfu06/poe.txt
[[ -f "$f" ]] || { echo "✗ Нет poe.txt"; exit 1; }
grep -Eq '^FAULT=EXCESSIVE_VOLTAGE_DROP$' "$f" || { echo "✗ Неверный FAULT."; exit 1; }
grep -Eq '^CAUSE=HIGH_RESISTANCE_CONTACT$' "$f" || { echo "✗ Неверная CAUSE."; exit 1; }
touch /root/tfu06/step3.ok
echo "✓ PoE-линия диагностирована."
