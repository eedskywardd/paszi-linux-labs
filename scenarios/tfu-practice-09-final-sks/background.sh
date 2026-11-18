#!/usr/bin/env bash
set -euo pipefail

mkdir -p /root/tfu09
rm -f /root/tfu09/*.txt /root/tfu09/*.ok

cat > /usr/local/bin/object-info <<'EOF'
#!/usr/bin/env bash
cat <<'OUT'
OBJECT / LINE          COUNT / LENGTH        CONDITIONS
Room 101               10 x 42 m avg         office
Room 102               8 x 55 m avg          office
AP-01                  76 m                  PoE
CAM-01                 61 m                  PoE
CAM-02                 67 m                  PoE + power cable nearby
F01                     180 m                 inter-floor backbone
F02                     620 m                 separate building

REQUIREMENTS
- reserve for copper cable: 10%
- reserve for ports: 20%
- use structured labeling
- provide patch panel, cable manager and optical cross
OUT
EOF

cat > /usr/local/bin/route-calc <<'EOF'
#!/usr/bin/env bash
python3 - <<'PY'
office = 10*42 + 8*55
poe = 76+61+67
base = office + poe
reserve = base*0.10
total = base+reserve
print(f"OFFICE_CABLE={office}")
print(f"POE_CABLE={poe}")
print(f"BASE_COPPER={base}")
print(f"RESERVE_10_PERCENT={reserve:.1f}")
print(f"TOTAL_COPPER={total:.1f}")
PY
EOF

cat > /usr/local/bin/project-summary <<'EOF'
#!/usr/bin/env bash
for f in design cable ports labels bom passport; do
  if [[ -f "/root/tfu09/$f.txt" ]]; then
    echo "===== $f.txt ====="
    cat "/root/tfu09/$f.txt"
    echo
  else
    echo "===== $f.txt MISSING ====="
  fi
done
EOF

cat > /usr/local/bin/final-project-check <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

need=(design cable ports labels bom passport)
for x in "${need[@]}"; do
  [[ -f "/root/tfu09/$x.txt" ]] || { echo "FAIL: missing $x.txt"; exit 1; }
done

grep -Eq '^ROOMS=CAT6_UTP$' /root/tfu09/design.txt || exit 1
grep -Eq '^AP01=CAT6_UTP_POE$' /root/tfu09/design.txt || exit 1
grep -Eq '^CAM01=CAT6_UTP_POE$' /root/tfu09/design.txt || exit 1
grep -Eq '^CAM02=CAT6A_FTP_POE$' /root/tfu09/design.txt || exit 1
grep -Eq '^F01=OM3_LC_MM_SFP$' /root/tfu09/design.txt || exit 1
grep -Eq '^F02=OS2_LC_SM_SFP$' /root/tfu09/design.txt || exit 1

grep -Eq '^TOTAL_COPPER=1126\.4$' /root/tfu09/cable.txt || exit 1
grep -Eq '^SWITCH_PORTS=48$' /root/tfu09/ports.txt || exit 1
grep -Eq '^PATCH_PANEL=48_PORT$' /root/tfu09/ports.txt || exit 1

grep -Eq '^PROJECT_STATUS=READY$' /root/tfu09/passport.txt || exit 1
echo "PROJECT CHECK: PASS"
echo "СКС спроектирована и паспортизирована."
EOF

chmod +x /usr/local/bin/object-info /usr/local/bin/route-calc /usr/local/bin/project-summary /usr/local/bin/final-project-check
