#!/usr/bin/env bash
set -euo pipefail
cd /root/bash06/work
[[ -f environment.txt ]] || { echo "✗ Нет environment.txt."; exit 1; }
grep -qx "HOME=$HOME" environment.txt || { echo "✗ Неверно сохранён HOME."; exit 1; }
grep -qx "USER=$USER" environment.txt || { echo "✗ Неверно сохранён USER."; exit 1; }
grep -qx "SHELL=$SHELL" environment.txt || { echo "✗ Неверно сохранён SHELL."; exit 1; }
[[ "$(wc -l < environment.txt)" -eq 3 ]] || { echo "✗ В environment.txt должно быть ровно 3 строки."; exit 1; }
echo "✓ Переменные окружения определены правильно."
