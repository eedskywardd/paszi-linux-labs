#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu09/step3.ok ]] || { echo "✗ Сначала этап 3."; exit 1; }
f=/root/tfu09/ports.txt
[[ -f "$f" ]] || { echo "✗ Нет ports.txt"; exit 1; }
grep -Eq '^ACTIVE_PORTS=21$' "$f" || { echo "✗ ACTIVE_PORTS неверно."; exit 1; }
grep -Eq '^WITH_RESERVE=26$' "$f" || { echo "✗ WITH_RESERVE неверно."; exit 1; }
grep -Eq '^SWITCH_PORTS=48$' "$f" || { echo "✗ Нужен коммутатор на 48 портов."; exit 1; }
grep -Eq '^PATCH_PANEL=48_PORT$' "$f" || { echo "✗ PATCH_PANEL неверна."; exit 1; }
grep -Eq '^POE_PORTS=3$' "$f" || { echo "✗ POE_PORTS неверно."; exit 1; }
grep -Eq '^OPTICAL_UPLINKS=2$' "$f" || { echo "✗ OPTICAL_UPLINKS неверно."; exit 1; }
grep -Eq '^OPTICAL_CROSS=YES$' "$f" || { echo "✗ Нужен оптический кросс."; exit 1; }
grep -Eq '^CABLE_MANAGER=YES$' "$f" || { echo "✗ Нужен кабельный менеджмент."; exit 1; }
touch /root/tfu09/step4.ok
echo "✓ Порты и коммутация рассчитаны."
