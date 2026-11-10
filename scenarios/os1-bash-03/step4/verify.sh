#!/usr/bin/env bash
set -euo pipefail
f=/root/bash03/permissions_before.txt
[[ -f "$f" ]] || { echo "✗ Нет permissions_before.txt."; exit 1; }
expected=$'-rw-r--r-- readme.txt\n-rw-r--r-- run.sh\n-rw-r----- private.txt'
[[ "$(cat "$f")" == "$expected" ]] || { echo "✗ permissions_before.txt должен содержать исходные права трёх файлов."; exit 1; }
echo "✓ Вы правильно прочитали исходные права."
