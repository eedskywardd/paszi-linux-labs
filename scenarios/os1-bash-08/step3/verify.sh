#!/usr/bin/env bash
set -euo pipefail
cd /root/bash08/work
expected=$'alpha.txt\nbeta.txt\nnames.txt\nnotes.txt'
[[ -f txt_files.txt ]] || { echo "✗ Нет txt_files.txt."; exit 1; }
[[ "$(cat txt_files.txt)" == "$expected" ]] || { echo "✗ txt_files.txt должен содержать все .txt-файлы верхнего уровня каталога data."; exit 1; }
echo "✓ Маска *.txt обработана циклом правильно."
