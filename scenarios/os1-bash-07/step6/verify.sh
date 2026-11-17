#!/usr/bin/env bash
set -euo pipefail
cd /root/bash07/work
[[ -f check_lines.sh ]] || { echo "✗ Нет check_lines.sh."; exit 1; }
[[ -x check_lines.sh ]] || { echo "✗ check_lines.sh должен быть исполняемым."; exit 1; }
grep -q 'wc -l' check_lines.sh || { echo "✗ В check_lines.sh должна использоваться команда wc -l."; exit 1; }
expected_found=$'STATUS=FOUND\nLINES=3'
[[ "$(cat found_output.txt 2>/dev/null || true)" == "$expected_found" ]] || { echo "✗ found_output.txt должен содержать STATUS=FOUND и LINES=3."; exit 1; }
[[ "$(cat missing_output.txt 2>/dev/null || true)" == "STATUS=NOT_FOUND" ]] || { echo "✗ missing_output.txt должен содержать STATUS=NOT_FOUND."; exit 1; }
echo "✓ Скрипт проверяет файл и считает строки."
