#!/usr/bin/env bash
set -euo pipefail
for d in docs backup temp; do
  [[ -d "/root/bash01/work/$d" ]] || { echo "✗ Нет каталога $d."; exit 1; }
done
for f in docs/notes.txt temp/draft.txt temp/delete_me.txt; do
  [[ -f "/root/bash01/work/$f" ]] || { echo "✗ Нет файла $f."; exit 1; }
done
echo "✓ Каталоги и пустые файлы созданы правильно."
