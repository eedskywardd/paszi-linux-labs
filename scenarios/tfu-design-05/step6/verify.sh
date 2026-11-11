#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu05/step5.ok ]] || { echo "✗ Сначала этап 5."; exit 1; }

f=/root/tfu05/final.txt
[[ -f "$f" ]] || { echo "✗ Нет final.txt"; exit 1; }

grep -Eq '^L01=CAT6_UTP$' "$f" || { echo "✗ Ошибка L01."; exit 1; }
grep -Eq '^L02=CAT6_UTP_POE$' "$f" || { echo "✗ Ошибка L02."; exit 1; }
grep -Eq '^L03=CAT6A_FTP_POE$' "$f" || { echo "✗ Ошибка L03."; exit 1; }
grep -Eq '^F01=OM3_LC_SFP$' "$f" || { echo "✗ Ошибка F01."; exit 1; }
grep -Eq '^F02=OS2_LC_SFP$' "$f" || { echo "✗ Ошибка F02."; exit 1; }
grep -Eq '^PATCH_PANEL=24_PORT$' "$f" || { echo "✗ Ошибка PATCH_PANEL."; exit 1; }
grep -Eq '^RACK=YES$' "$f" || { echo "✗ Ошибка RACK."; exit 1; }

echo "✓ Финальная инженерная проверка пройдена."
