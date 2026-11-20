#!/usr/bin/env bash
set -euo pipefail
cd /root/bash08/work
[[ -f classified.txt ]] || { echo "✗ Нет classified.txt."; exit 1; }
grep -qx 'DIR=archive' classified.txt || { echo "✗ Каталог archive должен быть отмечен как DIR=archive."; exit 1; }
for name in alpha.txt beta.txt names.txt notes.txt app.log system.log app.conf readme.md; do
  grep -qx "FILE=$name" classified.txt || { echo "✗ Не найдено FILE=$name."; exit 1; }
done
[[ "$(wc -l < classified.txt)" -eq 9 ]] || { echo "✗ В classified.txt должно быть ровно 9 объектов."; exit 1; }
echo "✓ Файлы и каталог классифицированы правильно."
