#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu08/step6.ok ]] || { echo "✗ Сначала этап 6."; exit 1; }
f=/root/tfu08/poe-fault.txt
[[ -f "$f" ]] || { echo "✗ Нет poe-fault.txt"; exit 1; }
grep -Eq '^FAULT=EXCESSIVE_VOLTAGE_DROP$' "$f" || { echo "✗ Неверный FAULT."; exit 1; }
grep -Eq '^CAUSE=HIGH_RESISTANCE_CONTACT$' "$f" || { echo "✗ Неверная CAUSE."; exit 1; }
touch /root/tfu08/step7.ok
echo "✓ Неисправность P07 определена."
