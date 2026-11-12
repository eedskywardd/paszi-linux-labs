#!/usr/bin/env bash
set -euo pipefail
mkdir -p /root/tfu07a
rm -f /root/tfu07a/*.txt /root/tfu07a/*.ok

cat > /usr/local/bin/instrument-guide <<'EOF'
#!/usr/bin/env bash
cat <<'OUT'
INSTRUMENT GUIDE
cable-test   -> wiremap, OPEN, MISWIRE, continuity
tdr          -> distance to copper fault
pair-test    -> twisted-pair integrity, SPLIT PAIR
poe-test     -> PoE standard/class/idle voltage
load-test    -> voltage under load and voltage drop
vfl          -> visible optical leak / continuity
power-meter  -> total optical loss
otdr         -> distance and type of optical event
OUT
EOF

cat > /usr/local/bin/incident-list <<'EOF'
#!/usr/bin/env bash
cat <<'OUT'
ID    OBJECT   SEGMENT   SYMPTOM
1     PC-11    L11       LINK DOWN
2     PC-12    L12       LINK UP, 100 Mbps, ERRORS 214
3     AP-03    P18       PERIODIC REBOOT, PoE
4     SW2      F07       LINK UP, OPTICAL ERRORS 508
OUT
EOF

cat > /usr/local/bin/cable-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
case "$line" in
L11)
cat <<'OUT'
CABLE TESTER · L11
1 ----> 1
2 ----> 2
3 ----> 3
4 ----> OPEN
5 ----> 5
6 ----> 6
7 ----> 7
8 ----> 8
RESULT: FAIL
FAULT: OPEN
OUT
;;
L12)
cat <<'OUT'
CABLE TESTER · L12
1 ----> 1
2 ----> 2
3 ----> 3
4 ----> 4
5 ----> 5
6 ----> 6
7 ----> 7
8 ----> 8
WIREMAP: PASS
PAIR INTEGRITY: WARNING
OUT
;;
*) echo "CABLE TESTER · ${line:-?}"; echo "RESULT: PASS";;
esac
EOF

cat > /usr/local/bin/tdr <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
if [[ "$line" == "L11" ]]; then
cat <<'OUT'
TDR · L11
LINE LENGTH: 71.5 m
FAULT TYPE: OPEN
FAULT DISTANCE: 22.6 m
ESTIMATED ZONE: patch panel / cable tray
OUT
else
echo "TDR · ${line:-?}"
echo "FAULTS: NONE"
fi
EOF

cat > /usr/local/bin/pair-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
if [[ "$line" == "L12" ]]; then
cat <<'OUT'
PAIR TEST · L12
CONTINUITY: PASS
PAIR 1-2: SPLIT
PAIR 3-6: SPLIT
PAIR 4-5: OK
PAIR 7-8: OK
RESULT: FAIL
FAULT: SPLIT_PAIR
OUT
else
echo "PAIR TEST · ${line:-?}"
echo "PAIRS: NORMAL"
fi
EOF

cat > /usr/local/bin/poe-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
port="${1:-}"
if [[ "$port" == "P18" ]]; then
cat <<'OUT'
POE TEST · P18
STANDARD: IEEE 802.3at
PD CLASS: 4
NEGOTIATION: OK
VOLTAGE IDLE: 49.1 V
POWER REQUEST: 18.0 W
RESULT: WARNING
OUT
else
echo "POE TEST · ${port:-?}"
echo "RESULT: PASS"
fi
EOF

cat > /usr/local/bin/load-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
port="${1:-}"
if [[ "$port" == "P18" ]]; then
cat <<'OUT'
LOAD TEST · P18
VOLTAGE IDLE: 49.1 V
VOLTAGE UNDER LOAD: 41.0 V
DROP: 8.1 V
RESULT: FAIL
FAULT: EXCESSIVE_VOLTAGE_DROP
CAUSE: HIGH_RESISTANCE_OR_CCA_LINE
OUT
else
echo "LOAD TEST · ${port:-?}"
echo "RESULT: PASS"
fi
EOF

cat > /usr/local/bin/vfl <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fiber="${1:-}"
if [[ "$fiber" == "F07" ]]; then
cat <<'OUT'
VFL · F07
CONTINUITY: PRESENT
VISIBLE LEAK: NO
RESULT: INCONCLUSIVE
OUT
else
echo "VFL · ${fiber:-?}"
echo "RESULT: PASS"
fi
EOF

cat > /usr/local/bin/power-meter <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fiber="${1:-}"
if [[ "$fiber" == "F07" ]]; then
cat <<'OUT'
OPTICAL POWER METER · F07
WAVELENGTH: 1310 nm
TX REFERENCE: -2.2 dBm
RX POWER: -9.1 dBm
TOTAL LOSS: 6.9 dB
RESULT: FAIL
OUT
else
echo "OPTICAL POWER METER · ${fiber:-?}"
echo "RESULT: PASS"
fi
EOF

cat > /usr/local/bin/otdr <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fiber="${1:-}"
if [[ "$fiber" == "F07" ]]; then
cat <<'OUT'
OTDR · F07 · 1310 nm
0.0 m      launch
48.0 m     connector      loss 0.2 dB
172.0 m    event          loss 4.6 dB    reflectance HIGH
318.0 m    end
EVENT TYPE: REFLECTIVE_HIGH_LOSS
SUSPECT: DIRTY_CONNECTOR
TOTAL LOSS: 6.9 dB
RESULT: FAIL
OUT
else
echo "OTDR · ${fiber:-?}"
echo "RESULT: PASS"
fi
EOF

chmod +x /usr/local/bin/instrument-guide /usr/local/bin/incident-list
chmod +x /usr/local/bin/cable-test /usr/local/bin/tdr /usr/local/bin/pair-test
chmod +x /usr/local/bin/poe-test /usr/local/bin/load-test
chmod +x /usr/local/bin/vfl /usr/local/bin/power-meter /usr/local/bin/otdr
