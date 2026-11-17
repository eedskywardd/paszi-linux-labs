#!/usr/bin/env bash
set -euo pipefail
cd /root/bash07/work
[[ -f count_args.sh ]] || { echo "✗ Нет count_args.sh."; exit 1; }
[[ -x count_args.sh ]] || { echo "✗ count_args.sh должен быть исполняемым."; exit 1; }
grep -q '\$#' count_args.sh || { echo "✗ В count_args.sh должен использоваться \$#."; exit 1; }
[[ -f count_output.txt ]] || { echo "✗ Нет count_output.txt."; exit 1; }
grep -qx 'COUNT=3' count_output.txt || { echo "✗ При трёх аргументах COUNT должен быть 3."; exit 1; }
grep -qx 'FIRST=red' count_output.txt || { echo "✗ Первый аргумент должен быть red."; exit 1; }
echo "✓ Количество аргументов через $# определено правильно."
