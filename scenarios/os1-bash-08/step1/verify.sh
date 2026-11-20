#!/usr/bin/env bash
set -euo pipefail
cd /root/bash08/work
expected=$'COLOR=red\nCOLOR=green\nCOLOR=blue'
[[ -f colors.txt ]] || { echo "✗ Нет colors.txt."; exit 1; }
[[ "$(cat colors.txt)" == "$expected" ]] || { echo "✗ colors.txt должен содержать red, green и blue в правильном порядке."; exit 1; }
echo "✓ Первый цикл for выполнен правильно."
