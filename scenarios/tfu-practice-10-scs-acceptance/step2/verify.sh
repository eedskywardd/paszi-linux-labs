#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu10/step1.ok ]] || { echo "✗ Сначала этап 1."; exit 1; }
f=/root/tfu10/copper-test.txt
[[ -f "$f" ]] || { echo "✗ Нет copper-test.txt"; exit 1; }
for x in A-PC-01 A-PC-10 A-PC-11 A-PC-18; do
  grep -Eq "^$x=PASS$" "$f" || { echo "✗ $x не подтверждена."; exit 1; }
done
grep -Eq '^CATEGORY=CAT6$' "$f" || { echo "✗ CATEGORY неверна."; exit 1; }
grep -Eq '^MAX_LENGTH_OK=YES$' "$f" || { echo "✗ Проверьте ограничение длины."; exit 1; }
grep -Eq '^RESULT=PASS$' "$f" || { echo "✗ RESULT неверен."; exit 1; }
touch /root/tfu10/step2.ok
echo "✓ Медные линии прошли сертификацию."
