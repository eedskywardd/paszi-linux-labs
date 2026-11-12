#!/usr/bin/env bash
set -euo pipefail
mkdir -p /root/tfu07b
printf 'BROKEN\n' > /root/tfu07b/l11.state
printf 'BROKEN\n' > /root/tfu07b/l12.state
printf 'BROKEN\n' > /root/tfu07b/p18.state
printf 'BROKEN\n' > /root/tfu07b/f07.state
rm -f /root/tfu07b/*.txt /root/tfu07b/*.ok

cat > /usr/local/bin/repair-guide <<'EOF'
#!/usr/bin/env bash
cat <<'OUT'
REPAIR GUIDE
OPEN conductor            -> RETERMINATE_OR_REPLACE_SECTION
SPLIT PAIR                -> RECRIMP_CORRECT_PAIRS
HIGH RESISTANCE / CCA     -> REPLACE_WITH_SOLID_COPPER
DIRTY CONNECTOR           -> CLEAN_AND_RESEAT_CONNECTOR
OUT
EOF

cat > /usr/local/bin/repair <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
target="${1:-}"
action="${2:-}"
case "$target:$action" in
L11:RETERMINATE_OR_REPLACE_SECTION)
  printf 'OK\n' > /root/tfu07b/l11.state
  echo "✓ L11 restored"
  ;;
L12:RECRIMP_CORRECT_PAIRS)
  printf 'OK\n' > /root/tfu07b/l12.state
  echo "✓ L12 restored"
  ;;
P18:REPLACE_WITH_SOLID_COPPER)
  printf 'OK\n' > /root/tfu07b/p18.state
  echo "✓ P18 restored"
  ;;
F07:CLEAN_AND_RESEAT_CONNECTOR)
  printf 'OK\n' > /root/tfu07b/f07.state
  echo "✓ F07 restored"
  ;;
*)
  echo "Неверная комбинация."
  echo "Использование: repair SEGMENT ACTION"
  exit 1
  ;;
esac
EOF

cat > /usr/local/bin/acceptance-status <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
l11="$(cat /root/tfu07b/l11.state)"
l12="$(cat /root/tfu07b/l12.state)"
p18="$(cat /root/tfu07b/p18.state)"
f07="$(cat /root/tfu07b/f07.state)"

echo "SEGMENT   STATUS   RESULT"
[[ "$l11" == "OK" ]] && echo "L11       UP       PASS" || echo "L11       DOWN     FAIL"
[[ "$l12" == "OK" ]] && echo "L12       UP       PASS" || echo "L12       DEGRADED FAIL"
[[ "$p18" == "OK" ]] && echo "P18       PoE OK   PASS" || echo "P18       PoE BAD  FAIL"
[[ "$f07" == "OK" ]] && echo "F07       LOSS OK  PASS" || echo "F07       LOSS BAD FAIL"
EOF

cat > /usr/local/bin/cable-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
case "$line" in
L11)
 if [[ "$(cat /root/tfu07b/l11.state)" == "OK" ]]; then
   printf 'CABLE TESTER · L11\n1->1 2->2 3->3 4->4 5->5 6->6 7->7 8->8\nRESULT: PASS\n'
 else
   printf 'CABLE TESTER · L11\n4 -> OPEN\nRESULT: FAIL\n'
 fi
 ;;
L12)
 if [[ "$(cat /root/tfu07b/l12.state)" == "OK" ]]; then
   printf 'CABLE TESTER · L12\nWIREMAP: PASS\nPAIR INTEGRITY: PASS\nRESULT: PASS\n'
 else
   printf 'CABLE TESTER · L12\nWIREMAP: PASS\nPAIR INTEGRITY: WARNING\nRESULT: FAIL\n'
 fi
 ;;
*) echo "RESULT: PASS";;
esac
EOF

cat > /usr/local/bin/pair-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
if [[ "$line" == "L12" && "$(cat /root/tfu07b/l12.state)" == "OK" ]]; then
  printf 'PAIR TEST · L12\nPAIR 1-2: OK\nPAIR 3-6: OK\nPAIR 4-5: OK\nPAIR 7-8: OK\nRESULT: PASS\n'
else
  printf 'PAIR TEST · %s\nRESULT: FAIL\n' "$line"
fi
EOF

cat > /usr/local/bin/load-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
port="${1:-}"
if [[ "$port" == "P18" && "$(cat /root/tfu07b/p18.state)" == "OK" ]]; then
  printf 'LOAD TEST · P18\nVOLTAGE IDLE: 49.1 V\nVOLTAGE UNDER LOAD: 47.9 V\nDROP: 1.2 V\nRESULT: PASS\n'
else
  printf 'LOAD TEST · %s\nRESULT: FAIL\n' "$port"
fi
EOF

cat > /usr/local/bin/power-meter <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fiber="${1:-}"
if [[ "$fiber" == "F07" && "$(cat /root/tfu07b/f07.state)" == "OK" ]]; then
  printf 'OPTICAL POWER METER · F07\nTX REFERENCE: -2.2 dBm\nRX POWER: -4.5 dBm\nTOTAL LOSS: 2.3 dB\nRESULT: PASS\n'
else
  printf 'OPTICAL POWER METER · %s\nRESULT: FAIL\n' "$fiber"
fi
EOF

cat > /usr/local/bin/otdr <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fiber="${1:-}"
if [[ "$fiber" == "F07" && "$(cat /root/tfu07b/f07.state)" == "OK" ]]; then
cat <<'OUT'
OTDR · F07
0.0 m      launch
48.0 m     connector loss 0.2 dB
172.0 m    connector loss 0.3 dB
318.0 m    end
TOTAL LOSS: 2.3 dB
RESULT: PASS
OUT
else
  printf 'OTDR · %s\nRESULT: FAIL\n' "$fiber"
fi
EOF

chmod +x /usr/local/bin/repair-guide /usr/local/bin/repair /usr/local/bin/acceptance-status
chmod +x /usr/local/bin/cable-test /usr/local/bin/pair-test /usr/local/bin/load-test
chmod +x /usr/local/bin/power-meter /usr/local/bin/otdr
