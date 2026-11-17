#!/usr/bin/env bash
set -euo pipefail
cd /root/bash06/work
expected=$'COURSE=Operating Systems\nLESSON=6\nTOPIC=Bash variables'
[[ -f variables.txt ]] || { echo "✗ Нет variables.txt."; exit 1; }
[[ "$(cat variables.txt)" == "$expected" ]] || { echo "✗ variables.txt заполнен неверно."; exit 1; }
echo "✓ Обычные переменные Bash использованы правильно."
