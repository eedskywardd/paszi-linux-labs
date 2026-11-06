#!/usr/bin/env bash
set -euo pipefail
cd /root/bash02
[[ -f errors.txt ]] || { echo "✗ Нет errors.txt."; exit 1; }
[[ -f login_hits.txt ]] || { echo "✗ Нет login_hits.txt."; exit 1; }
diff -q <(grep "ERROR" app.log) errors.txt >/dev/null || { echo "✗ errors.txt должен содержать все строки с ERROR."; exit 1; }
diff -q <(grep -in "login" app.log) login_hits.txt >/dev/null || { echo "✗ login_hits.txt должен быть результатом grep -in \"login\" app.log."; exit 1; }
[[ "$(wc -l < errors.txt)" -eq 3 ]] || { echo "✗ В errors.txt должно быть 3 строки."; exit 1; }
[[ "$(wc -l < login_hits.txt)" -eq 2 ]] || { echo "✗ С ключом -i должны находиться 2 записи login/LOGIN."; exit 1; }
echo "✓ grep, -i и -n освоены."
