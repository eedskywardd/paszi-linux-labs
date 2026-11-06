#!/usr/bin/env bash
set -euo pipefail
base=/root/bash01/work
[[ -f "$base/docs/notes.txt" ]] || { echo "✗ Исходный notes.txt пропал."; exit 1; }
[[ -f "$base/backup/notes_copy.txt" ]] || { echo "✗ Нет backup/notes_copy.txt."; exit 1; }
cmp -s "$base/docs/notes.txt" "$base/backup/notes_copy.txt" || { echo "✗ Копия не совпадает с исходным файлом."; exit 1; }
[[ -f "$base/temp/ready.txt" ]] || { echo "✗ draft.txt ещё не переименован в ready.txt."; exit 1; }
[[ ! -e "$base/temp/draft.txt" ]] || { echo "✗ Старое имя draft.txt всё ещё существует."; exit 1; }
[[ ! -e "$base/temp/delete_me.txt" ]] || { echo "✗ delete_me.txt ещё не удалён."; exit 1; }
echo "✓ cp, mv и rm выполнены правильно."
