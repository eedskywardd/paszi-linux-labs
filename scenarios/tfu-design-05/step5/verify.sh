#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu05/step4.ok ]] || { echo "✗ Сначала этап 4."; exit 1; }
f=/root/tfu05/spec.txt
[[ -f "$f" ]] || { echo "✗ Нет spec.txt"; exit 1; }

grep -Eq '^PATCH_PANEL=24_PORT$' "$f" || { echo "✗ Нужна патч-панель 24 порта."; exit 1; }
grep -Eq '^RACK=YES$' "$f" || { echo "✗ RACK должен быть YES."; exit 1; }
grep -Eq '^PATCH_CORDS=14$' "$f" || { echo "✗ PATCH_CORDS должно быть 14."; exit 1; }
grep -Eq '^CABLE_MANAGER=YES$' "$f" || { echo "✗ Нужен кабельный менеджмент."; exit 1; }
grep -Eq '^OPTICAL_CROSS=YES$' "$f" || { echo "✗ Нужен оптический кросс."; exit 1; }

touch /root/tfu05/step5.ok
echo "✓ Базовая спецификация СКС собрана."
