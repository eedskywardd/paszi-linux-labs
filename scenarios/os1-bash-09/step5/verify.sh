#!/usr/bin/env bash
set -euo pipefail
cd /root/bash09/work

[[ -f menu.sh ]] || { echo "✗ Нет menu.sh."; exit 1; }
[[ -x menu.sh ]] || { echo "✗ menu.sh должен быть исполняемым."; exit 1; }
grep -q 'read ' menu.sh || { echo "✗ В menu.sh должна использоваться команда read."; exit 1; }
grep -q 'case ' menu.sh || { echo "✗ В menu.sh должен использоваться case."; exit 1; }

out="$(printf '2\n' | ./menu.sh)"
last="$(printf '%s\n' "$out" | tail -n 1)"
[[ "$last" == "RESULT=$(whoami)" ]] || { echo "✗ При выборе 2 последняя строка должна содержать текущего пользователя."; exit 1; }

[[ -f menu_output.txt ]] || { echo "✗ Нет menu_output.txt."; exit 1; }
[[ "$(tail -n 1 menu_output.txt)" == "RESULT=$(whoami)" ]] || { echo "✗ menu_output.txt содержит неверный результат."; exit 1; }

echo "✓ Интерактивное меню принимает выбор пользователя."
