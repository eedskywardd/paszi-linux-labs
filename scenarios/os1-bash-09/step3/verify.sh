#!/usr/bin/env bash
set -euo pipefail
cd /root/bash09/work

[[ -f check_function.sh ]] || { echo "✗ Нет check_function.sh."; exit 1; }
grep -q 'local ' check_function.sh || { echo "✗ В функции должна использоваться локальная переменная local."; exit 1; }
grep -Eq 'return[[:space:]]+0' check_function.sh || { echo "✗ Функция должна возвращать 0 при успехе."; exit 1; }
grep -Eq 'return[[:space:]]+1' check_function.sh || { echo "✗ Функция должна возвращать 1 при неуспехе."; exit 1; }

expected=$'FIRST=0\nSECOND=1'
[[ "$(cat return_codes.txt 2>/dev/null || true)" == "$expected" ]] || { echo "✗ return_codes.txt должен содержать FIRST=0 и SECOND=1."; exit 1; }

echo "✓ local и return работают правильно."
