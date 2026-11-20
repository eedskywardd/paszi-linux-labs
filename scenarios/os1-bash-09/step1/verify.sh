#!/usr/bin/env bash
set -euo pipefail
cd /root/bash09/work

[[ -f functions.sh ]] || { echo "✗ Нет functions.sh."; exit 1; }
[[ -x functions.sh ]] || { echo "✗ functions.sh должен быть исполняемым."; exit 1; }
grep -q 'hello()' functions.sh || { echo "✗ В functions.sh должна быть функция hello()."; exit 1; }
grep -q 'show_course()' functions.sh || { echo "✗ В functions.sh должна быть функция show_course()."; exit 1; }

expected=$'Hello from function\nCOURSE=Operating Systems'
[[ "$(cat functions_output.txt 2>/dev/null || true)" == "$expected" ]] || { echo "✗ functions_output.txt содержит неверный вывод."; exit 1; }

echo "✓ Первые функции Bash созданы и вызваны."
