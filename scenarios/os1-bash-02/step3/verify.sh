#!/usr/bin/env bash
set -euo pipefail
cd /root/bash02
[[ -f users_sorted.txt ]] || { echo "✗ Нет users_sorted.txt."; exit 1; }
[[ -f users_reverse.txt ]] || { echo "✗ Нет users_reverse.txt."; exit 1; }
diff -q <(sort users.txt) users_sorted.txt >/dev/null || { echo "✗ users_sorted.txt отсортирован неправильно."; exit 1; }
diff -q <(sort -r users.txt) users_reverse.txt >/dev/null || { echo "✗ users_reverse.txt должен быть обратной сортировкой."; exit 1; }
echo "✓ Обычная и обратная сортировка выполнены."
