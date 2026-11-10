#!/usr/bin/env bash
set -euo pipefail
d=/root/bash03/final
[[ -d "$d" ]] || { echo "✗ Каталог /root/bash03/final не найден."; exit 1; }
[[ -f "$d/conf_files.txt" ]] || { echo "✗ В final нет conf_files.txt."; exit 1; }
tmp="$(mktemp)"
find /root/bash03/lab -type f -name "*.conf" | sort > "$tmp"
cmp -s "$tmp" "$d/conf_files.txt" || { rm -f "$tmp"; echo "✗ conf_files.txt должен содержать полный отсортированный список .conf-файлов."; exit 1; }
rm -f "$tmp"
[[ -f "$d/run_copy.sh" ]] || { echo "✗ В final нет run_copy.sh."; exit 1; }
cmp -s /root/bash03/lab/permissions/run.sh "$d/run_copy.sh" || { echo "✗ run_copy.sh не совпадает с исходным run.sh."; exit 1; }
[[ "$(stat -c '%a' "$d/run_copy.sh")" == "700" ]] || { echo "✗ Для run_copy.sh нужны права 700."; exit 1; }
[[ -f "$d/.done" ]] || { echo "✗ Скрытый файл .done не создан."; exit 1; }
echo "✓ Всё выполнено. Bash 03 завершён!"
