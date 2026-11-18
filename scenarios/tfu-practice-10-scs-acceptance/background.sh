#!/usr/bin/env bash
set -euo pipefail

mkdir -p /root/tfu10
rm -f /root/tfu10/*.txt /root/tfu10/*.ok

cat > /usr/local/bin/inspect-project <<'EOF'
#!/usr/bin/env bash
cat <<'OUT'
PROJECT: ENTERPRISE_SCS
WORKPLACES: 18
COPPER: CAT6 UTP
POE DEVICES: 3
PATCH PANEL: 48 PORT
SWITCH: 48 PORT
OPTICAL BACKBONES: 2
F01: OM3 / LC / MM SFP / 180 m
F02: OS2 / LC / SM SFP / 620 m
LABELING: A-SCHEME
DOCUMENTATION: COMPLETE
OUT
EOF

cat > /usr/local/bin/certify-copper <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
case "$line" in
  A-PC-01|A-PC-10|A-PC-11|A-PC-18)
    case "$line" in
      A-PC-01) len="41.8";;
      A-PC-10) len="43.1";;
      A-PC-11) len="54.6";;
      A-PC-18) len="55.4";;
    esac
    cat <<OUT
CERTIFICATION · $line
STANDARD: CAT6
WIREMAP: PASS
PAIR INTEGRITY: PASS
LENGTH: $len m
LIMIT: 100 m
RESULT: PASS
OUT
    ;;
  *)
    echo "Unknown test point: ${line:-none}"
    echo "Use one of: A-PC-01 A-PC-10 A-PC-11 A-PC-18"
    exit 2
    ;;
esac
EOF

cat > /usr/local/bin/certify-poe <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
case "$line" in
  A-AP-01)
    printf 'POE CERTIFICATION · A-AP-01\nLINK: PASS\nSTANDARD: IEEE 802.3af\nNEGOTIATION: PASS\nVOLTAGE: 48.2 V\nPOWER: 10.8 W\nRESULT: PASS\n'
    ;;
  A-CAM-01)
    printf 'POE CERTIFICATION · A-CAM-01\nLINK: PASS\nSTANDARD: IEEE 802.3af\nNEGOTIATION: PASS\nVOLTAGE: 48.4 V\nPOWER: 7.1 W\nRESULT: PASS\n'
    ;;
  A-CAM-02)
    printf 'POE CERTIFICATION · A-CAM-02\nLINK: PASS\nSTANDARD: IEEE 802.3af\nNEGOTIATION: PASS\nSHIELDING: PRESENT\nVOLTAGE: 48.1 V\nPOWER: 7.4 W\nRESULT: PASS\n'
    ;;
  *)
    echo "Unknown PoE test point: ${line:-none}"
    exit 2
    ;;
esac
EOF

cat > /usr/local/bin/certify-fiber <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fiber="${1:-}"
case "$fiber" in
  A-F01)
    cat <<'OUT'
FIBER CERTIFICATION · A-F01
TYPE: OM3
CONNECTORS: LC
SFP: MM
LENGTH: 180 m
TOTAL LOSS: 2.2 dB
CONTINUITY: PASS
RESULT: PASS
OUT
    ;;
  A-F02)
    cat <<'OUT'
FIBER CERTIFICATION · A-F02
TYPE: OS2
CONNECTORS: LC
SFP: SM
LENGTH: 620 m
TOTAL LOSS: 2.5 dB
CONTINUITY: PASS
RESULT: PASS
OUT
    ;;
  *)
    echo "Unknown fiber: ${fiber:-none}"
    exit 2
    ;;
esac
EOF

cat > /usr/local/bin/check-labels <<'EOF'
#!/usr/bin/env bash
cat <<'OUT'
LABEL AUDIT
A-PC-01 ... A-PC-18: PASS
A-AP-01: PASS
A-CAM-01: PASS
A-CAM-02: PASS
A-F01: PASS
A-F02: PASS
PATCH PANEL LABELS: PASS
OUTLET LABELS: PASS
RESULT: PASS
OUT
EOF

cat > /usr/local/bin/check-capacity <<'EOF'
#!/usr/bin/env bash
cat <<'OUT'
CAPACITY AUDIT
ACTIVE COPPER PORTS: 21
INSTALLED SWITCH PORTS: 48
INSTALLED PATCH PANEL PORTS: 48
REQUIRED RESERVE: 20%
MINIMUM WITH RESERVE: 26
FREE SWITCH PORTS: 27
RESULT: PASS
OUT
EOF

cat > /usr/local/bin/check-docs <<'EOF'
#!/usr/bin/env bash
cat <<'OUT'
DOCUMENTATION AUDIT
CABLE DESIGN: PRESENT
PORT PLAN: PRESENT
LABELING PLAN: PRESENT
BOM: PRESENT
SCS PASSPORT: PRESENT
RESULT: PASS
OUT
EOF

cat > /usr/local/bin/accept-scs <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
f=/root/tfu10/protocol.txt
[[ -f "$f" ]] || { echo "FAIL: protocol.txt missing"; exit 1; }

for line in   '^PROJECT_COMPLIANCE=PASS$'   '^COPPER_LINES=PASS$'   '^POE_LINES=PASS$'   '^FIBER_F01=PASS$'   '^FIBER_F02=PASS$'   '^LABELING=PASS$'   '^PORT_CAPACITY=PASS$'   '^DOCUMENTATION=PASS$'   '^FINAL_ACCEPTANCE=PASS$'
do
  grep -Eq "$line" "$f" || { echo "FAIL: protocol incomplete"; exit 1; }
done

cat <<'OUT'
SCS ACCEPTANCE TEST

Project compliance: PASS
Copper cabling: PASS
PoE infrastructure: PASS
Fiber backbone F01: PASS
Fiber backbone F02: PASS
Port capacity: PASS
Labeling: PASS
Documentation: PASS

FINAL RESULT: ACCEPTED
OUT
EOF

chmod +x /usr/local/bin/inspect-project /usr/local/bin/certify-copper /usr/local/bin/certify-poe
chmod +x /usr/local/bin/certify-fiber /usr/local/bin/check-labels /usr/local/bin/check-capacity
chmod +x /usr/local/bin/check-docs /usr/local/bin/accept-scs
