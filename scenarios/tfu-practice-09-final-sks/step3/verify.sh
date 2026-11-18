#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu09/step2.ok ]] || { echo "✗ Сначала этап 2."; exit 1; }
f=/root/tfu09/cable.txt
[[ -f "$f" ]] || { echo "✗ Нет cable.txt"; exit 1; }
grep -Eq '^ROOM101=420$' "$f" || { echo "✗ ROOM101 рассчитан неверно."; exit 1; }
grep -Eq '^ROOM102=440$' "$f" || { echo "✗ ROOM102 рассчитан неверно."; exit 1; }
grep -Eq '^POE_TOTAL=204$' "$f" || { echo "✗ POE_TOTAL рассчитан неверно."; exit 1; }
grep -Eq '^BASE_COPPER=1064$' "$f" || { echo "✗ BASE_COPPER рассчитан неверно."; exit 1; }
grep -Eq '^RESERVE_10=106\.4$' "$f" || { echo "✗ RESERVE_10 рассчитан неверно."; exit 1; }
grep -Eq '^TOTAL_COPPER=1170\.4$' "$f" || { echo "✗ TOTAL_COPPER рассчитан неверно."; exit 1; }
grep -Eq '^F01_LENGTH=180$' "$f" || { echo "✗ F01_LENGTH неверно."; exit 1; }
grep -Eq '^F02_LENGTH=620$' "$f" || { echo "✗ F02_LENGTH неверно."; exit 1; }
touch /root/tfu09/step3.ok
echo "✓ Кабельные трассы рассчитаны."
