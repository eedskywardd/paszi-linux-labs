#!/usr/bin/env bash
set -euo pipefail
d=/root/bash01/work/final
[[ -d "$d" ]] || { echo "✗ Каталог final не найден."; exit 1; }
[[ -f "$d/answer.txt" ]] || { echo "✗ answer.txt не найден."; exit 1; }
expected=$'I know pwd\nI know ls'
actual="$(cat "$d/answer.txt")"
[[ "$actual" == "$expected" ]] || { echo "✗ answer.txt должен содержать ровно две требуемые строки."; exit 1; }
[[ -f "$d/answer_copy.txt" ]] || { echo "✗ answer_copy.txt не найден."; exit 1; }
cmp -s "$d/answer.txt" "$d/answer_copy.txt" || { echo "✗ answer_copy.txt не совпадает с answer.txt."; exit 1; }
[[ -f "$d/.done" ]] || { echo "✗ Скрытый файл .done не создан."; exit 1; }
echo "✓ Всё выполнено. Первая практика Bash завершена!"
