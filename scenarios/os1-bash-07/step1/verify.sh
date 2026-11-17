#!/usr/bin/env bash
set -euo pipefail
cd /root/bash07/work
[[ -f args.sh ]] || { echo "✗ Нет args.sh."; exit 1; }
[[ -x args.sh ]] || { echo "✗ args.sh должен быть исполняемым."; exit 1; }
grep -q '\$0' args.sh || { echo "✗ В args.sh должен использоваться \$0."; exit 1; }
grep -q '\$1' args.sh || { echo "✗ В args.sh должен использоваться \$1."; exit 1; }
grep -q '\$2' args.sh || { echo "✗ В args.sh должен использоваться \$2."; exit 1; }
[[ -f args_output.txt ]] || { echo "✗ Нет args_output.txt."; exit 1; }
grep -qx 'SCRIPT=./args.sh' args_output.txt || { echo "✗ Первая строка args_output.txt должна показывать SCRIPT=./args.sh."; exit 1; }
grep -qx 'FIRST=Ivan' args_output.txt || { echo "✗ Первый аргумент должен быть Ivan."; exit 1; }
grep -qx 'SECOND=18' args_output.txt || { echo "✗ Второй аргумент должен быть 18."; exit 1; }
[[ "$(wc -l < args_output.txt)" -eq 3 ]] || { echo "✗ В args_output.txt должно быть 3 строки."; exit 1; }
echo '✓ $0, $1 и $2 использованы правильно.'
