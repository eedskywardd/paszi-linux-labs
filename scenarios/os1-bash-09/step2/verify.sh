#!/usr/bin/env bash
set -euo pipefail
cd /root/bash09/work

[[ -f function_args.sh ]] || { echo "✗ Нет function_args.sh."; exit 1; }
[[ -x function_args.sh ]] || { echo "✗ function_args.sh должен быть исполняемым."; exit 1; }
grep -q '\$1' function_args.sh || { echo "✗ Функция должна использовать первый аргумент."; exit 1; }
grep -q '\$2' function_args.sh || { echo "✗ Функция должна использовать второй аргумент."; exit 1; }

expected=$'NAME=Anna\nROLE=student'
[[ "$(cat function_args.txt 2>/dev/null || true)" == "$expected" ]] || { echo "✗ function_args.txt заполнен неверно."; exit 1; }

echo '✓ Аргументы $1 и $2 внутри функции использованы правильно.'
