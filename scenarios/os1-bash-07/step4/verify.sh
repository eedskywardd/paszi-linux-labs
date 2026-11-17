#!/usr/bin/env bash
set -euo pipefail
cd /root/bash07/work
[[ "$(cat file_test.txt 2>/dev/null || true)" == "0" ]] || { echo "✗ Проверка существующего файла должна вернуть 0."; exit 1; }
[[ "$(cat dir_test.txt 2>/dev/null || true)" == "0" ]] || { echo "✗ Проверка существующего каталога должна вернуть 0."; exit 1; }
m="$(cat missing_test.txt 2>/dev/null || true)"
[[ "$m" =~ ^[0-9]+$ ]] || { echo "✗ missing_test.txt должен содержать код возврата."; exit 1; }
[[ "$m" -ne 0 ]] || { echo "✗ Несуществующий файл не должен возвращать 0."; exit 1; }
echo "✓ Проверки -f и -d выполнены правильно."
