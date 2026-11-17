#!/usr/bin/env bash
set -euo pipefail
cd /root/bash07/work
[[ -f typecheck.sh ]] || { echo "✗ Нет typecheck.sh."; exit 1; }
[[ -x typecheck.sh ]] || { echo "✗ typecheck.sh должен быть исполняемым."; exit 1; }
grep -q 'if ' typecheck.sh || { echo "✗ В typecheck.sh должен использоваться if."; exit 1; }
grep -q '\-f' typecheck.sh || { echo "✗ В условии должна использоваться проверка -f."; exit 1; }
grep -q 'else' typecheck.sh || { echo "✗ В скрипте должен быть else."; exit 1; }
grep -q 'fi' typecheck.sh || { echo "✗ Конструкция if должна завершаться fi."; exit 1; }
[[ "$(cat type_file.txt 2>/dev/null || true)" == "TYPE=FILE" ]] || { echo "✗ Для sample.txt скрипт должен вывести TYPE=FILE."; exit 1; }
[[ "$(cat type_dir.txt 2>/dev/null || true)" == "TYPE=NOT_FILE" ]] || { echo "✗ Для каталога скрипт должен вывести TYPE=NOT_FILE."; exit 1; }
echo "✓ Первое условие if / else работает."
