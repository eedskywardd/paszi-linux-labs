#!/usr/bin/env bash
set -euo pipefail
base=/root/bash01/work
[[ -f "$base/docs/.secret.txt" ]] || { echo "✗ Скрытый файл .secret.txt не создан."; exit 1; }
for f in one.txt two.txt; do
  [[ -f "$base/docs/$f" ]] || { echo "✗ В docs нет $f."; exit 1; }
  [[ -f "$base/backup/$f" ]] || { echo "✗ $f не скопирован в backup."; exit 1; }
done
[[ -f "$base/docs/photo.jpg" ]] || { echo "✗ photo.jpg не создан."; exit 1; }
[[ ! -e "$base/backup/photo.jpg" ]] || { echo "✗ photo.jpg не должен был копироваться маской *.txt."; exit 1; }
echo "✓ Отлично. Вы использовали скрытый файл, ключ -a и маску *.txt."
