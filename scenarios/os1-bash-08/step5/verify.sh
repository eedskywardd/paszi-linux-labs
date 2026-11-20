#!/usr/bin/env bash
set -euo pipefail
cd /root/bash08/work
expected=$'USER=Anna\nUSER=Boris\nUSER=Carol'
[[ -f users.txt ]] || { echo "✗ Нет users.txt."; exit 1; }
[[ "$(cat users.txt)" == "$expected" ]] || { echo "✗ users.txt должен содержать три обработанные строки из names.txt."; exit 1; }
echo "✓ while read обработал файл построчно."
