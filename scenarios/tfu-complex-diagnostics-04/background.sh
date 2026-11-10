#!/usr/bin/env bash
set -euo pipefail

mkdir -p /root/tfu04
printf 'BROKEN
' > /root/tfu04/copper_state
printf 'BROKEN
' > /root/tfu04/fiber_state

rm -f /root/tfu04/step1.ok /root/tfu04/step2.ok /root/tfu04/step3.ok /root/tfu04/step4.ok /root/tfu04/step5.ok
rm -f /root/tfu04/suspects.txt /root/tfu04/copper.txt /root/tfu04/vfl.txt /root/tfu04/power.txt /root/tfu04/otdr.txt /root/tfu04/report.txt

cat > /usr/local/bin/link-status <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
c="$(cat /root/tfu04/copper_state 2>/dev/null || echo BROKEN)"
f="$(cat /root/tfu04/fiber_state 2>/dev/null || echo BROKEN)"

echo "SEGMENT   TYPE     ENDPOINT        LINK    SPEED       ERRORS"
echo "L01       COPPER   PC-01           UP      1000 Mbps    0"
echo "L02       COPPER   PC-02           UP      1000 Mbps    0"

if [[ "$c" == "OK" ]]; then
  echo "L03       COPPER   PC-03           UP      1000 Mbps    0"
else
  echo "L03       COPPER   PC-03           DOWN    -            -"
fi

echo "L05       COPPER   AP-01           UP      1000 Mbps    0"

if [[ "$f" == "OK" ]]; then
  echo "F01       FIBER    SW1-SW2         UP      1000 Mbps    0"
else
  echo "F01       FIBER    SW1-SW2         UP      1000 Mbps    412"
fi

echo "L04       COPPER   PC-04           UP      1000 Mbps    0"
EOF

cat > /usr/local/bin/cable-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
state="$(cat /root/tfu04/copper_state 2>/dev/null || echo BROKEN)"

if [[ "$line" != "L03" ]]; then
  cat <<OUT
CABLE TESTER · ${line:-?}
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
  exit 0
fi

if [[ "$state" == "OK" ]]; then
  cat <<'OUT'
CABLE TESTER · L03
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
CABLE TESTER · L03
1 ----> 1
2 ----> 2
3 ----> 3
4 ----> 4
5 ----> 5
6 ----> OPEN
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
state="$(cat /root/tfu04/copper_state 2>/dev/null || echo BROKEN)"

if [[ "$line" != "L03" ]]; then
  echo "TDR · ${line:-?}"
  echo "FAULTS: NONE"
  exit 0
fi

if [[ "$state" == "OK" ]]; then
  cat <<'OUT'
TDR · L03
LINE LENGTH: 63.0 m
FAULTS: NONE
RESULT: PASS
OUT
else
  cat <<'OUT'
TDR · L03
LINE LENGTH: 63.0 m
FAULT TYPE: OPEN
FAULT DISTANCE: 42.7 m
ESTIMATED ZONE: cable tray near room 305
OUT
fi
EOF

cat > /usr/local/bin/vfl <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fiber="${1:-}"
state="$(cat /root/tfu04/fiber_state 2>/dev/null || echo BROKEN)"

if [[ "$fiber" != "F01" ]]; then
  echo "Неизвестный оптический сегмент: ${fiber:-?}"
  exit 2
fi

if [[ "$state" == "OK" ]]; then
  cat <<'OUT'
VFL · F01
VISIBLE LEAKS: NONE
CONTINUITY: OK
OUT
else
  cat <<'OUT'
VFL · F01
CONTINUITY: PRESENT
VISIBLE RED LEAK: YES
LOCATION: rack B / patch-cord bend
RESULT: WARNING
OUT
fi
EOF

cat > /usr/local/bin/power-meter <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fiber="${1:-}"
state="$(cat /root/tfu04/fiber_state 2>/dev/null || echo BROKEN)"

if [[ "$fiber" != "F01" ]]; then
  echo "Неизвестный оптический сегмент: ${fiber:-?}"
  exit 2
fi

if [[ "$state" == "OK" ]]; then
  cat <<'OUT'
OPTICAL POWER METER · F01
WAVELENGTH: 1310 nm
TX REFERENCE: -2.0 dBm
RX POWER: -4.3 dBm
TOTAL LOSS: 2.3 dB
RESULT: PASS
OUT
else
  cat <<'OUT'
OPTICAL POWER METER · F01
WAVELENGTH: 1310 nm
TX REFERENCE: -2.0 dBm
RX POWER: -9.6 dBm
TOTAL LOSS: 7.6 dB
RESULT: FAIL
OUT
fi
EOF

cat > /usr/local/bin/otdr <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fiber="${1:-}"
state="$(cat /root/tfu04/fiber_state 2>/dev/null || echo BROKEN)"

if [[ "$fiber" != "F01" ]]; then
  echo "Неизвестный оптический сегмент: ${fiber:-?}"
  exit 2
fi

if [[ "$state" == "OK" ]]; then
  cat <<'OUT'
OTDR · F01 · 1310 nm
0.0 m      launch
37.0 m     connector      loss 0.3 dB
181.0 m    splice         loss 0.2 dB
296.0 m    end
TOTAL LOSS: 2.3 dB
RESULT: PASS
OUT
else
  cat <<'OUT'
OTDR · F01 · 1310 nm
0.0 m      launch
37.0 m     connector      loss 0.3 dB
181.0 m    event          loss 4.8 dB    reflectance LOW
296.0 m    end

EVENT TYPE: NON_REFLECTIVE_HIGH_LOSS
SUSPECT: MACROBEND
TOTAL LOSS: 7.6 dB
RESULT: FAIL
OUT
fi
EOF

cat > /usr/local/bin/repair-copper <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
[[ "$line" == "L03" ]] || { echo "Выбран неверный медный сегмент."; exit 1; }

f=/root/tfu04/copper.txt
[[ -f "$f" ]] || { echo "Сначала оформите /root/tfu04/copper.txt"; exit 1; }
grep -Eq '^LINE=L03$' "$f" || { echo "Неверный LINE."; exit 1; }
grep -Eq '^FAULT=OPEN$' "$f" || { echo "Неверный FAULT."; exit 1; }
grep -Eq '^CONDUCTOR=6$' "$f" || { echo "Неверный CONDUCTOR."; exit 1; }
grep -Eq '^DISTANCE=42\.7$' "$f" || { echo "Неверная DISTANCE."; exit 1; }

printf 'OK
' > /root/tfu04/copper_state
echo "✓ Медная линия L03 восстановлена."
EOF

cat > /usr/local/bin/repair-fiber <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fiber="${1:-}"
[[ "$fiber" == "F01" ]] || { echo "Выбран неверный оптический сегмент."; exit 1; }

f=/root/tfu04/report.txt
[[ -f "$f" ]] || { echo "Сначала оформите /root/tfu04/report.txt"; exit 1; }
grep -Eq '^FIBER=F01$' "$f" || { echo "Неверный FIBER."; exit 1; }
grep -Eq '^LOSS_DB=7\.6$' "$f" || { echo "Неверный LOSS_DB."; exit 1; }
grep -Eq '^EVENT_DISTANCE=181\.0$' "$f" || { echo "Неверный EVENT_DISTANCE."; exit 1; }
grep -Eq '^FAULT=MACROBEND$' "$f" || { echo "Неверный FAULT."; exit 1; }

printf 'OK
' > /root/tfu04/fiber_state
echo "✓ Оптическая линия F01 восстановлена."
EOF

chmod +x /usr/local/bin/link-status /usr/local/bin/cable-test /usr/local/bin/tdr
chmod +x /usr/local/bin/vfl /usr/local/bin/power-meter /usr/local/bin/otdr
chmod +x /usr/local/bin/repair-copper /usr/local/bin/repair-fiber
