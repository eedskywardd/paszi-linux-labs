#!/usr/bin/env bash
set -euo pipefail
cd /root/bash08/work
[[ -f count_txt.sh ]] || { echo "✗ Нет count_txt.sh."; exit 1; }
[[ -x count_txt.sh ]] || { echo "✗ count_txt.sh должен быть исполняемым."; exit 1; }
grep -q 'for ' count_txt.sh || { echo "✗ В count_txt.sh должен использоваться цикл for."; exit 1; }
grep -q '\*.txt' count_txt.sh || { echo "✗ Скрипт должен обрабатывать маску *.txt."; exit 1; }
grep -q 'COUNT=' count_txt.sh || { echo "✗ В скрипте должен использоваться счётчик COUNT."; exit 1; }
actual="$(./count_txt.sh /root/bash08/data)"
[[ "$actual" == "TXT_COUNT=4" ]] || { echo "✗ Для /root/bash08/data скрипт должен вывести TXT_COUNT=4."; exit 1; }
[[ "$(cat count_result.txt 2>/dev/null || true)" == "TXT_COUNT=4" ]] || { echo "✗ count_result.txt должен содержать TXT_COUNT=4."; exit 1; }
echo "✓ Скрипт массового подсчёта .txt работает."
