#!/usr/bin/env bash
set -euo pipefail
d=/root/bash03/lab/permissions
[[ "$(stat -c '%a' "$d/run.sh")" == "755" ]] || { echo "✗ run.sh должен иметь права 755."; exit 1; }
[[ "$(stat -c '%a' "$d/readme.txt")" == "644" ]] || { echo "✗ readme.txt должен иметь права 644."; exit 1; }
[[ "$(stat -c '%a' "$d/private.txt")" == "600" ]] || { echo "✗ private.txt должен иметь права 600."; exit 1; }
[[ -f /root/bash03/script_output.txt ]] || { echo "✗ Нет script_output.txt."; exit 1; }
[[ "$(cat /root/bash03/script_output.txt)" == "Bash 03 script works" ]] || { echo "✗ В script_output.txt должен быть результат запуска run.sh."; exit 1; }
echo "✓ Числовые права chmod и запуск скрипта выполнены правильно."
