#!/usr/bin/env bash
set -euo pipefail
cd /root/bash02
[[ -f error_count.txt ]] || { echo "✗ Нет error_count.txt."; exit 1; }
[[ -f last_info.txt ]] || { echo "✗ Нет last_info.txt."; exit 1; }
[[ -f unique_count.txt ]] || { echo "✗ Нет unique_count.txt."; exit 1; }
[[ "$(tr -d '[:space:]' < error_count.txt)" == "3" ]] || { echo "✗ В error_count.txt должно быть число 3."; exit 1; }
diff -q <(grep "INFO" app.log | tail -n 2) last_info.txt >/dev/null || { echo "✗ last_info.txt должен содержать две последние INFO-строки."; exit 1; }
[[ "$(tr -d '[:space:]' < unique_count.txt)" == "4" ]] || { echo "✗ Разных пользователей должно быть 4."; exit 1; }
echo "✓ Вы собрали конвейеры из двух и трёх команд."
