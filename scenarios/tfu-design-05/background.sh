#!/usr/bin/env bash
set -euo pipefail

mkdir -p /root/tfu05
rm -f /root/tfu05/*.txt /root/tfu05/*.ok

cat > /usr/local/bin/object-info <<'EOF'
#!/usr/bin/env bash
cat <<'OUT'
SEGMENT   DESTINATION       DISTANCE   CONDITIONS
L01       Office PCs        35-70 m    office
L02       AP-01             82 m       PoE
L03       CAM-01            62 m       PoE + power cable nearby
F01       SW1-SW2           180 m      inter-floor backbone
F02       SW1-SW3           650 m      remote building
OUT
EOF

cat > /usr/local/bin/design-check <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
f=/root/tfu05/final.txt
[[ -f "$f" ]] || { echo "Нет /root/tfu05/final.txt"; exit 1; }

grep -Eq '^L01=CAT6_UTP$' "$f" || { echo "Ошибка в L01"; exit 1; }
grep -Eq '^L02=CAT6_UTP_POE$' "$f" || { echo "Ошибка в L02"; exit 1; }
grep -Eq '^L03=CAT6A_FTP_POE$' "$f" || { echo "Ошибка в L03"; exit 1; }
grep -Eq '^F01=OM3_LC_SFP$' "$f" || { echo "Ошибка в F01"; exit 1; }
grep -Eq '^F02=OS2_LC_SFP$' "$f" || { echo "Ошибка в F02"; exit 1; }
grep -Eq '^PATCH_PANEL=24_PORT$' "$f" || { echo "Ошибка в PATCH_PANEL"; exit 1; }
grep -Eq '^RACK=YES$' "$f" || { echo "Ошибка в RACK"; exit 1; }

echo "✓ Проект физического уровня прошёл проверку."
EOF

chmod +x /usr/local/bin/object-info /usr/local/bin/design-check
