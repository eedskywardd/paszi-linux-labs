#!/usr/bin/env bash
set -euo pipefail

mkdir -p /root/tfu06
printf 'BROKEN\n' > /root/tfu06/copper_state
printf 'BROKEN\n' > /root/tfu06/poe_state
printf 'BROKEN\n' > /root/tfu06/fiber_state
rm -f /root/tfu06/*.txt /root/tfu06/*.ok

cat > /usr/local/bin/shift-status <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
c="$(cat /root/tfu06/copper_state)"
p="$(cat /root/tfu06/poe_state)"
f="$(cat /root/tfu06/fiber_state)"

echo "OBJECT   SEGMENT   LINK    POWER/LOSS      ERRORS"
if [[ "$c" == "OK" ]]; then
  echo "PC-07    L07       UP      -               0"
else
  echo "PC-07    L07       DOWN    -               -"
fi

if [[ "$p" == "OK" ]]; then
  echo "CAM-02   P12       UP      PoE 8.0 W       0"
else
  echo "CAM-02   P12       FLAP    PoE FAULT       36"
fi

if [[ "$f" == "OK" ]]; then
  echo "SW2      F03       UP      loss 2.1 dB     0"
else
  echo "SW2      F03       UP      loss 8.4 dB     629"
fi
EOF

cat > /usr/local/bin/cable-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
state="$(cat /root/tfu06/copper_state)"
if [[ "$line" != "L07" ]]; then
  echo "CABLE TESTER · ${line:-?}"
  echo "RESULT: PASS"
  exit 0
fi
if [[ "$state" == "OK" ]]; then
  cat <<'OUT'
CABLE TESTER · L07
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
CABLE TESTER · L07
1 ----> 1
2 ----> 2
3 ----> 3
4 ----> 4
5 ----> 5
6 ----> 6
7 ----> OPEN
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
state="$(cat /root/tfu06/copper_state)"
if [[ "$line" != "L07" ]]; then
  echo "TDR · ${line:-?}"
  echo "FAULTS: NONE"
  exit 0
fi
if [[ "$state" == "OK" ]]; then
  printf 'TDR · L07\nLINE LENGTH: 54.2 m\nFAULTS: NONE\nRESULT: PASS\n'
else
  printf 'TDR · L07\nLINE LENGTH: 54.2 m\nFAULT TYPE: OPEN\nFAULT DISTANCE: 18.9 m\nESTIMATED ZONE: floor box FB-07\n'
fi
EOF

cat > /usr/local/bin/poe-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
port="${1:-}"
state="$(cat /root/tfu06/poe_state)"
if [[ "$port" != "P12" ]]; then
  echo "POE TEST · ${port:-?}"
  echo "RESULT: PASS"
  exit 0
fi
if [[ "$state" == "OK" ]]; then
  printf 'POE TEST · P12\nSTANDARD: IEEE 802.3af\nPD CLASS: 3\nNEGOTIATION: OK\nVOLTAGE IDLE: 48.5 V\nRESULT: PASS\n'
else
  printf 'POE TEST · P12\nSTANDARD: IEEE 802.3af\nPD CLASS: 3\nNEGOTIATION: OK\nVOLTAGE IDLE: 48.5 V\nPOWER REQUEST: 11.5 W\nRESULT: WARNING\n'
fi
EOF

cat > /usr/local/bin/load-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
port="${1:-}"
state="$(cat /root/tfu06/poe_state)"
if [[ "$port" != "P12" ]]; then
  echo "LOAD TEST · ${port:-?}"
  echo "RESULT: PASS"
  exit 0
fi
if [[ "$state" == "OK" ]]; then
  printf 'LOAD TEST · P12\nVOLTAGE UNDER LOAD: 47.8 V\nDROP: 0.7 V\nRESULT: PASS\n'
else
  printf 'LOAD TEST · P12\nVOLTAGE IDLE: 48.5 V\nVOLTAGE UNDER LOAD: 40.1 V\nDROP: 8.4 V\nRESULT: FAIL\nFAULT: EXCESSIVE_VOLTAGE_DROP\nCAUSE: HIGH_RESISTANCE_CONTACT\n'
fi
EOF

cat > /usr/local/bin/vfl <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fiber="${1:-}"
state="$(cat /root/tfu06/fiber_state)"
if [[ "$fiber" != "F03" ]]; then
  echo "VFL · ${fiber:-?}"
  echo "CONTINUITY: OK"
  exit 0
fi
if [[ "$state" == "OK" ]]; then
  printf 'VFL · F03\nCONTINUITY: OK\nVISIBLE LEAK: NO\n'
else
  printf 'VFL · F03\nCONTINUITY: PRESENT\nVISIBLE LEAK: NO\nRESULT: INCONCLUSIVE\n'
fi
EOF

cat > /usr/local/bin/power-meter <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fiber="${1:-}"
state="$(cat /root/tfu06/fiber_state)"
if [[ "$fiber" != "F03" ]]; then
  echo "OPTICAL POWER METER · ${fiber:-?}"
  echo "RESULT: PASS"
  exit 0
fi
if [[ "$state" == "OK" ]]; then
  printf 'OPTICAL POWER METER · F03\nWAVELENGTH: 1310 nm\nTX REFERENCE: -1.8 dBm\nRX POWER: -3.9 dBm\nTOTAL LOSS: 2.1 dB\nRESULT: PASS\n'
else
  printf 'OPTICAL POWER METER · F03\nWAVELENGTH: 1310 nm\nTX REFERENCE: -1.8 dBm\nRX POWER: -10.2 dBm\nTOTAL LOSS: 8.4 dB\nRESULT: FAIL\n'
fi
EOF

cat > /usr/local/bin/otdr <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fiber="${1:-}"
state="$(cat /root/tfu06/fiber_state)"
if [[ "$fiber" != "F03" ]]; then
  echo "OTDR · ${fiber:-?}"
  echo "RESULT: PASS"
  exit 0
fi
if [[ "$state" == "OK" ]]; then
  cat <<'OUT'
OTDR · F03 · 1310 nm
0.0 m     launch
92.0 m    connector    loss 0.3 dB
244.0 m   splice       loss 0.2 dB
410.0 m   end
TOTAL LOSS: 2.1 dB
RESULT: PASS
OUT
else
  cat <<'OUT'
OTDR · F03 · 1310 nm
0.0 m     launch
92.0 m    connector    loss 0.3 dB
244.0 m   event        loss 5.9 dB    reflectance HIGH
410.0 m   end

EVENT TYPE: REFLECTIVE_HIGH_LOSS
SUSPECT: DIRTY_OR_BAD_CONNECTOR
TOTAL LOSS: 8.4 dB
RESULT: FAIL
OUT
fi
EOF

cat > /usr/local/bin/repair <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
target="${1:-}"
case "$target" in
  L07)
    f=/root/tfu06/copper.txt
    [[ -f "$f" ]] || { echo "Сначала оформите copper.txt"; exit 1; }
    grep -Eq '^FAULT=OPEN$' "$f" || { echo "Неверный диагноз L07."; exit 1; }
    grep -Eq '^CONDUCTOR=7$' "$f" || { echo "Неверная жила."; exit 1; }
    grep -Eq '^DISTANCE=18\.9$' "$f" || { echo "Неверное расстояние."; exit 1; }
    printf 'OK\n' > /root/tfu06/copper_state
    echo "✓ L07 восстановлена."
    ;;
  P12)
    f=/root/tfu06/poe.txt
    [[ -f "$f" ]] || { echo "Сначала оформите poe.txt"; exit 1; }
    grep -Eq '^FAULT=EXCESSIVE_VOLTAGE_DROP$' "$f" || { echo "Неверный диагноз P12."; exit 1; }
    grep -Eq '^CAUSE=HIGH_RESISTANCE_CONTACT$' "$f" || { echo "Неверная причина P12."; exit 1; }
    printf 'OK\n' > /root/tfu06/poe_state
    echo "✓ P12 восстановлен."
    ;;
  F03)
    f=/root/tfu06/fiber.txt
    [[ -f "$f" ]] || { echo "Сначала оформите fiber.txt"; exit 1; }
    grep -Eq '^LOSS_DB=8\.4$' "$f" || { echo "Неверные потери F03."; exit 1; }
    grep -Eq '^EVENT_DISTANCE=244\.0$' "$f" || { echo "Неверное расстояние события."; exit 1; }
    grep -Eq '^CAUSE=DIRTY_OR_BAD_CONNECTOR$' "$f" || { echo "Неверная причина F03."; exit 1; }
    printf 'OK\n' > /root/tfu06/fiber_state
    echo "✓ F03 восстановлена."
    ;;
  *)
    echo "Использование: repair L07|P12|F03"
    exit 2
    ;;
esac
EOF

chmod +x /usr/local/bin/shift-status /usr/local/bin/cable-test /usr/local/bin/tdr
chmod +x /usr/local/bin/poe-test /usr/local/bin/load-test
chmod +x /usr/local/bin/vfl /usr/local/bin/power-meter /usr/local/bin/otdr /usr/local/bin/repair
