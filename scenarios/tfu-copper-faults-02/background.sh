#!/usr/bin/env bash
set -euo pipefail

mkdir -p /root/tfu02
printf 'BROKEN\n' > /root/tfu02/state
rm -f /root/tfu02/step1.ok /root/tfu02/step2.ok /root/tfu02/step3.ok
rm -f /root/tfu02/suspects.txt /root/tfu02/faults.txt /root/tfu02/split.txt /root/tfu02/report.txt

cat > /usr/local/bin/link-status <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
state="$(cat /root/tfu02/state 2>/dev/null || echo BROKEN)"
echo "LINE   ENDPOINT   LINK    SPEED       ERRORS"
if [[ "$state" == "OK" ]]; then
  echo "L01    PC-01      UP      1000 Mbps    0"
  echo "L02    PC-02      UP      1000 Mbps    0"
  echo "L03    PC-03      UP      1000 Mbps    0"
  echo "L04    PC-04      UP      1000 Mbps    0"
else
  echo "L01    PC-01      UP      1000 Mbps    0"
  echo "L02    PC-02      DOWN    -            -"
  echo "L03    PC-03      DOWN    -            -"
  echo "L04    PC-04      UP      100 Mbps     287"
fi
EOF

cat > /usr/local/bin/cable-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
state="$(cat /root/tfu02/state 2>/dev/null || echo BROKEN)"

if [[ -z "$line" ]]; then
  echo "Использование: cable-test L01|L02|L03|L04"
  exit 2
fi

if [[ "$state" == "OK" ]]; then
  cat <<OUT
CABLE TESTER · $line
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

case "$line" in
  L01)
    cat <<'OUT'
CABLE TESTER · L01
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
    ;;
  L02)
    cat <<'OUT'
CABLE TESTER · L02
1 ----> 1
2 ----> 2
3 ----> 6
4 ----> 4
5 ----> 5
6 ----> 3
7 ----> 7
8 ----> 8

RESULT: FAIL
FAULT: MISWIRE
OUT
    ;;
  L03)
    cat <<'OUT'
CABLE TESTER · L03
1 ----> 2
2 ----> 1
3 ----> 3
4 ----> 4
5 ----> 5
6 ----> 6
7 ----> 7
8 ----> 8

RESULT: FAIL
FAULT: REVERSED PAIR
OUT
    ;;
  L04)
    cat <<'OUT'
CABLE TESTER · L04
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
  *)
    echo "Неизвестная линия: $line"
    exit 2
    ;;
esac
EOF

cat > /usr/local/bin/pair-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
state="$(cat /root/tfu02/state 2>/dev/null || echo BROKEN)"

if [[ "$line" != "L04" ]]; then
  echo "PAIR TEST · ${line:-?}"
  echo "PAIRS: NORMAL"
  exit 0
fi

if [[ "$state" == "OK" ]]; then
  cat <<'OUT'
PAIR TEST · L04
PAIR 1-2: OK
PAIR 3-6: OK
PAIR 4-5: OK
PAIR 7-8: OK
RESULT: PASS
OUT
else
  cat <<'OUT'
PAIR TEST · L04
CONTINUITY: PASS
PAIR 1-2: SPLIT
PAIR 3-6: SPLIT
PAIR 4-5: OK
PAIR 7-8: OK

RESULT: FAIL
FAULT: SPLIT PAIR
OUT
fi
EOF

cat > /usr/local/bin/repair-all <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
report=/root/tfu02/report.txt

[[ -f "$report" ]] || { echo "Сначала создайте /root/tfu02/report.txt"; exit 1; }
grep -Eq '^L02=MISWIRE$' "$report" || { echo "Неверный диагноз для L02."; exit 1; }
grep -Eq '^L03=REVERSED_PAIR$' "$report" || { echo "Неверный диагноз для L03."; exit 1; }
grep -Eq '^L04=SPLIT_PAIR$' "$report" || { echo "Неверный диагноз для L04."; exit 1; }

printf 'OK\n' > /root/tfu02/state
echo "✓ Все три линии исправлены."
echo "Выполните link-status и повторите тесты."
EOF

chmod +x /usr/local/bin/link-status /usr/local/bin/cable-test /usr/local/bin/pair-test /usr/local/bin/repair-all
