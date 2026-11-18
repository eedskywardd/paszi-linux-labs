#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu10/step3.ok ]] || { echo "✗ Сначала этап 3."; exit 1; }
f=/root/tfu10/fiber-test.txt
[[ -f "$f" ]] || { echo "✗ Нет fiber-test.txt"; exit 1; }
grep -Eq '^F01_TYPE=OM3$' "$f" || { echo "✗ F01_TYPE неверен."; exit 1; }
grep -Eq '^F01_SFP=MM$' "$f" || { echo "✗ F01_SFP неверен."; exit 1; }
grep -Eq '^F01_LOSS=2\.2$' "$f" || { echo "✗ F01_LOSS неверен."; exit 1; }
grep -Eq '^F01_RESULT=PASS$' "$f" || { echo "✗ F01_RESULT неверен."; exit 1; }
grep -Eq '^F02_TYPE=OS2$' "$f" || { echo "✗ F02_TYPE неверен."; exit 1; }
grep -Eq '^F02_SFP=SM$' "$f" || { echo "✗ F02_SFP неверен."; exit 1; }
grep -Eq '^F02_LOSS=2\.5$' "$f" || { echo "✗ F02_LOSS неверен."; exit 1; }
grep -Eq '^F02_RESULT=PASS$' "$f" || { echo "✗ F02_RESULT неверен."; exit 1; }
touch /root/tfu10/step4.ok
echo "✓ Оптические магистрали прошли сертификацию."
