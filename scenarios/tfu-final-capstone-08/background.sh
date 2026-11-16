#!/usr/bin/env bash
set -euo pipefail

mkdir -p /root/tfu08
printf 'BROKEN\n' > /root/tfu08/copper_state
printf 'BROKEN\n' > /root/tfu08/poe_state
printf 'BROKEN\n' > /root/tfu08/fiber_state
rm -f /root/tfu08/*.txt /root/tfu08/*.ok

cat > /usr/local/bin/object-info <<'EOF'
#!/usr/bin/env bash
cat <<'OUT'
OBJECT / SEGMENT        DISTANCE       CONDITIONS
Office PCs              25-72 m        24 workplaces, office environment
AP-01 / AP-02           64 / 81 m      PoE
CAM-01 / CAM-02         48 / 57 m      PoE
CAM-03                  69 m            PoE, power cable nearby
F01 SW1-SW2             160 m           inter-floor backbone
F02 SW1-SW3             680 m           separate building

CURRENT FAULT TICKETS
L18 -> PC-18            LINK DOWN
P07 -> CAM-02           intermittent reboot
F02 -> SW3              LINK UP, high error counter
OUT
EOF

cat > /usr/local/bin/fiber-budget-data <<'EOF'
#!/usr/bin/env bash
cat <<'OUT'
F02 OPTICAL BUDGET INPUT
Fiber type candidate: OS2
Length: 0.680 km
Fiber attenuation: 0.35 dB/km
Connectors: 4
Loss per connector: 0.40 dB
Splices: 2
Loss per splice: 0.10 dB
Engineering reserve: 3.00 dB
Transmitter power: -2.00 dBm
Receiver sensitivity: -15.00 dBm

Calculate:
1. fiber loss
2. connector loss
3. splice loss
4. total loss including reserve
5. expected RX power
6. PASS or FAIL
OUT
EOF

cat > /usr/local/bin/fault-status <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
c="$(cat /root/tfu08/copper_state)"
p="$(cat /root/tfu08/poe_state)"
f="$(cat /root/tfu08/fiber_state)"
echo "SEGMENT   DEVICE    LINK    POWER/LOSS       ERRORS"
if [[ "$c" == "OK" ]]; then
  echo "L18       PC-18     UP      -                0"
else
  echo "L18       PC-18     DOWN    -                -"
fi
if [[ "$p" == "OK" ]]; then
  echo "P07       CAM-02    UP      PoE 7.8 W        0"
else
  echo "P07       CAM-02    FLAP    PoE FAULT        22"
fi
if [[ "$f" == "OK" ]]; then
  echo "F02       SW3       UP      loss 2.4 dB      0"
else
  echo "F02       SW3       UP      loss 7.1 dB      511"
fi
EOF

cat > /usr/local/bin/cable-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
state="$(cat /root/tfu08/copper_state)"
if [[ "$line" != "L18" ]]; then
  echo "CABLE TESTER · ${line:-?}"
  echo "RESULT: PASS"
  exit 0
fi
if [[ "$state" == "OK" ]]; then
  cat <<'OUT'
CABLE TESTER · L18
1 ----> 1
2 ----> 2
3 ----> 3
4 ----> 4
5 ----> 5
6 ----> 6
7 ----> 7
8 ----> 8
RESULT: PASS
OUT
else
  cat <<'OUT'
CABLE TESTER · L18
1 ----> 1
2 ----> 2
3 ----> 3
4 ----> 4
5 ----> OPEN
6 ----> 6
7 ----> 7
8 ----> 8

RESULT: FAIL
FAULT: OPEN
OUT
fi
EOF

cat > /usr/local/bin/tdr <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
state="$(cat /root/tfu08/copper_state)"
if [[ "$line" != "L18" ]]; then
  echo "TDR · ${line:-?}"
  echo "FAULTS: NONE"
  exit 0
fi
if [[ "$state" == "OK" ]]; then
  printf 'TDR · L18\nLINE LENGTH: 66.0 m\nFAULTS: NONE\nRESULT: PASS\n'
else
  printf 'TDR · L18\nLINE LENGTH: 66.0 m\nFAULT TYPE: OPEN\nFAULT DISTANCE: 36.8 m\nESTIMATED ZONE: ceiling tray near junction J-18\n'
fi
EOF

cat > /usr/local/bin/poe-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
port="${1:-}"
state="$(cat /root/tfu08/poe_state)"
if [[ "$port" != "P07" ]]; then
  echo "POE TEST · ${port:-?}"
  echo "RESULT: PASS"
  exit 0
fi
if [[ "$state" == "OK" ]]; then
  printf 'POE TEST · P07\nSTANDARD: IEEE 802.3af\nPD CLASS: 3\nNEGOTIATION: OK\nVOLTAGE IDLE: 48.7 V\nRESULT: PASS\n'
else
  printf 'POE TEST · P07\nSTANDARD: IEEE 802.3af\nPD CLASS: 3\nNEGOTIATION: OK\nVOLTAGE IDLE: 48.7 V\nRESULT: WARNING\n'
fi
EOF

cat > /usr/local/bin/load-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
port="${1:-}"
state="$(cat /root/tfu08/poe_state)"
if [[ "$port" != "P07" ]]; then
  echo "LOAD TEST · ${port:-?}"
  echo "RESULT: PASS"
  exit 0
fi
if [[ "$state" == "OK" ]]; then
  printf 'LOAD TEST · P07\nVOLTAGE UNDER LOAD: 47.9 V\nDROP: 0.8 V\nRESULT: PASS\n'
else
  printf 'LOAD TEST · P07\nVOLTAGE IDLE: 48.7 V\nVOLTAGE UNDER LOAD: 40.6 V\nDROP: 8.1 V\nRESULT: FAIL\nFAULT: EXCESSIVE_VOLTAGE_DROP\nCAUSE: HIGH_RESISTANCE_CONTACT\n'
fi
EOF

cat > /usr/local/bin/vfl <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fiber="${1:-}"
state="$(cat /root/tfu08/fiber_state)"
if [[ "$fiber" != "F02" ]]; then
  echo "VFL · ${fiber:-?}"
  echo "CONTINUITY: OK"
  exit 0
fi
if [[ "$state" == "OK" ]]; then
  printf 'VFL · F02\nCONTINUITY: OK\nVISIBLE LEAK: NO\n'
else
  printf 'VFL · F02\nCONTINUITY: PRESENT\nVISIBLE LEAK: YES\nLOCATION: entry bend near remote rack\nRESULT: WARNING\n'
fi
EOF

cat > /usr/local/bin/power-meter <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fiber="${1:-}"
state="$(cat /root/tfu08/fiber_state)"
if [[ "$fiber" != "F02" ]]; then
  echo "OPTICAL POWER METER · ${fiber:-?}"
  echo "RESULT: PASS"
  exit 0
fi
if [[ "$state" == "OK" ]]; then
  printf 'OPTICAL POWER METER · F02\nWAVELENGTH: 1310 nm\nTX REFERENCE: -2.0 dBm\nRX POWER: -4.4 dBm\nTOTAL LOSS: 2.4 dB\nRESULT: PASS\n'
else
  printf 'OPTICAL POWER METER · F02\nWAVELENGTH: 1310 nm\nTX REFERENCE: -2.0 dBm\nRX POWER: -9.1 dBm\nTOTAL LOSS: 7.1 dB\nRESULT: FAIL\n'
fi
EOF

cat > /usr/local/bin/otdr <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fiber="${1:-}"
state="$(cat /root/tfu08/fiber_state)"
if [[ "$fiber" != "F02" ]]; then
  echo "OTDR · ${fiber:-?}"
  echo "RESULT: PASS"
  exit 0
fi
if [[ "$state" == "OK" ]]; then
  cat <<'OUT'
OTDR · F02 · 1310 nm
0.0 m     launch
118.0 m   connector    loss 0.3 dB
462.0 m   splice       loss 0.2 dB
680.0 m   end
TOTAL LOSS: 2.4 dB
RESULT: PASS
OUT
else
  cat <<'OUT'
OTDR · F02 · 1310 nm
0.0 m     launch
118.0 m   connector    loss 0.3 dB
462.0 m   event        loss 4.6 dB    reflectance LOW
680.0 m   end

EVENT TYPE: NON_REFLECTIVE_HIGH_LOSS
SUSPECT: MACROBEND
TOTAL LOSS: 7.1 dB
RESULT: FAIL
OUT
fi
EOF

cat > /usr/local/bin/repair <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
target="${1:-}"
case "$target" in
  L18)
    f=/root/tfu08/copper-fault.txt
    [[ -f "$f" ]] || { echo "Нет copper-fault.txt"; exit 1; }
    grep -Eq '^FAULT=OPEN$' "$f" || { echo "Неверный FAULT."; exit 1; }
    grep -Eq '^CONDUCTOR=5$' "$f" || { echo "Неверная жила."; exit 1; }
    grep -Eq '^DISTANCE=36\.8$' "$f" || { echo "Неверное расстояние."; exit 1; }
    printf 'OK\n' > /root/tfu08/copper_state
    echo "✓ L18 восстановлена."
    ;;
  P07)
    f=/root/tfu08/poe-fault.txt
    [[ -f "$f" ]] || { echo "Нет poe-fault.txt"; exit 1; }
    grep -Eq '^FAULT=EXCESSIVE_VOLTAGE_DROP$' "$f" || { echo "Неверный FAULT."; exit 1; }
    grep -Eq '^CAUSE=HIGH_RESISTANCE_CONTACT$' "$f" || { echo "Неверная CAUSE."; exit 1; }
    printf 'OK\n' > /root/tfu08/poe_state
    echo "✓ P07 восстановлен."
    ;;
  F02)
    f=/root/tfu08/fiber-fault.txt
    [[ -f "$f" ]] || { echo "Нет fiber-fault.txt"; exit 1; }
    grep -Eq '^LOSS_DB=7\.1$' "$f" || { echo "Неверный LOSS_DB."; exit 1; }
    grep -Eq '^EVENT_DISTANCE=462\.0$' "$f" || { echo "Неверный EVENT_DISTANCE."; exit 1; }
    grep -Eq '^FAULT=MACROBEND$' "$f" || { echo "Неверный FAULT."; exit 1; }
    printf 'OK\n' > /root/tfu08/fiber_state
    echo "✓ F02 восстановлена."
    ;;
  *)
    echo "Использование: repair L18|P07|F02"
    exit 2
    ;;
esac
EOF

cat > /usr/local/bin/final-acceptance <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
[[ "$(cat /root/tfu08/copper_state)" == "OK" ]] || { echo "FAIL: L18"; exit 1; }
[[ "$(cat /root/tfu08/poe_state)" == "OK" ]] || { echo "FAIL: P07"; exit 1; }
[[ "$(cat /root/tfu08/fiber_state)" == "OK" ]] || { echo "FAIL: F02"; exit 1; }
echo "ACCEPTANCE: PASS"
echo "Copper: PASS"
echo "PoE: PASS"
echo "Fiber: PASS"
EOF

chmod +x /usr/local/bin/object-info /usr/local/bin/fiber-budget-data /usr/local/bin/fault-status
chmod +x /usr/local/bin/cable-test /usr/local/bin/tdr /usr/local/bin/poe-test /usr/local/bin/load-test
chmod +x /usr/local/bin/vfl /usr/local/bin/power-meter /usr/local/bin/otdr
chmod +x /usr/local/bin/repair /usr/local/bin/final-acceptance
