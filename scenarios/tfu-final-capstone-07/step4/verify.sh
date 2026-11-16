#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu07/step3.ok ]] || { echo "✗ Сначала этап 3."; exit 1; }
f=/root/tfu07/ports.txt
[[ -f "$f" ]] || { echo "✗ Нет ports.txt"; exit 1; }
grep -Eq '^ACTIVE_COPPER=29$' "$f" || { echo "✗ ACTIVE_COPPER должно быть 29."; exit 1; }
grep -Eq '^WITH_RESERVE=35$' "$f" || { echo "✗ WITH_RESERVE должно быть 35."; exit 1; }
grep -Eq '^SWITCH_PORTS=48$' "$f" || { echo "✗ Нужна ёмкость 48 портов."; exit 1; }
grep -Eq '^PATCH_PANEL=48_PORT$' "$f" || { echo "✗ PATCH_PANEL выбрана неверно."; exit 1; }
grep -Eq '^OPTICAL_CROSS=YES$' "$f" || { echo "✗ Нужен оптический кросс."; exit 1; }
grep -Eq '^CABLE_MANAGER=YES$' "$f" || { echo "✗ Нужен кабельный менеджмент."; exit 1; }
touch /root/tfu07/step4.ok
echo "✓ Порты и компоненты СКС рассчитаны."
