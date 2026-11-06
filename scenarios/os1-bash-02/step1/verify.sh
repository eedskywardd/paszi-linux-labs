#!/usr/bin/env bash
set -euo pipefail
cd /root/bash02
[[ -f head3.txt ]] || { echo "✗ Нет head3.txt."; exit 1; }
[[ -f tail2.txt ]] || { echo "✗ Нет tail2.txt."; exit 1; }
[[ -f linecount.txt ]] || { echo "✗ Нет linecount.txt."; exit 1; }
diff -q <(head -n 3 app.log) head3.txt >/dev/null || { echo "✗ head3.txt должен содержать первые 3 строки app.log."; exit 1; }
diff -q <(tail -n 2 app.log) tail2.txt >/dev/null || { echo "✗ tail2.txt должен содержать последние 2 строки app.log."; exit 1; }
grep -Eq '^10[[:space:]]+app\.log$' linecount.txt || { echo "✗ linecount.txt должен содержать результат wc -l app.log."; exit 1; }
echo "✓ head, tail и wc выполнены правильно."
