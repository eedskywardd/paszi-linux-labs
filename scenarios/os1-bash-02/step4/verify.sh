#!/usr/bin/env bash
set -euo pipefail
cd /root/bash02
[[ -f users_unique.txt ]] || { echo "✗ Нет users_unique.txt."; exit 1; }
[[ -f users_counted.txt ]] || { echo "✗ Нет users_counted.txt."; exit 1; }
diff -q <(sort users.txt | uniq) users_unique.txt >/dev/null || { echo "✗ users_unique.txt должен содержать уникальные отсортированные имена."; exit 1; }
diff -q <(sort users.txt | uniq -c) users_counted.txt >/dev/null || { echo "✗ users_counted.txt должен быть результатом sort users.txt | uniq -c."; exit 1; }
[[ "$(wc -l < users_unique.txt)" -eq 4 ]] || { echo "✗ Уникальных имён должно быть 4."; exit 1; }
echo "✓ sort и uniq соединены конвейером."
