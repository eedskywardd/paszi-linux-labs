#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu10/step5.ok ]] || { echo "✗ Сначала этап 5."; exit 1; }
f=/root/tfu10/capacity-docs.txt
[[ -f "$f" ]] || { echo "✗ Нет capacity-docs.txt"; exit 1; }
grep -Eq '^ACTIVE_PORTS=21$' "$f" || { echo "✗ ACTIVE_PORTS неверно."; exit 1; }
grep -Eq '^INSTALLED_PORTS=48$' "$f" || { echo "✗ INSTALLED_PORTS неверно."; exit 1; }
grep -Eq '^MIN_WITH_RESERVE=26$' "$f" || { echo "✗ MIN_WITH_RESERVE неверно."; exit 1; }
grep -Eq '^FREE_PORTS=27$' "$f" || { echo "✗ FREE_PORTS неверно."; exit 1; }
grep -Eq '^RESERVE_OK=YES$' "$f" || { echo "✗ Резерв портов не подтвержден."; exit 1; }
grep -Eq '^BOM=PASS$' "$f" || { echo "✗ BOM не подтвержден."; exit 1; }
grep -Eq '^PASSPORT=PASS$' "$f" || { echo "✗ PASSPORT не подтвержден."; exit 1; }
grep -Eq '^DOCUMENTATION_RESULT=PASS$' "$f" || { echo "✗ Документация не принята."; exit 1; }
touch /root/tfu10/step6.ok
echo "✓ Резерв портов и документация соответствуют проекту."
