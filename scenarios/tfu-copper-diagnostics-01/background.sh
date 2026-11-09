#!/usr/bin/env bash
set -euo pipefail

mkdir -p /root/tfu01
printf 'BROKEN\n' > /root/tfu01/state
rm -f /root/tfu01/step1.ok /root/tfu01/step2.ok /root/tfu01/step3.ok /root/tfu01/report.txt /root/tfu01/problem-line.txt /root/tfu01/conductor.txt /root/tfu01/distance.txt

cat > /usr/local/bin/link-status <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
state="$(cat /root/tfu01/state 2>/dev/null || echo BROKEN)"
echo "LINE   ENDPOINT   LINK    SPEED"
echo "L01    PC-01      UP      1000 Mbps"
if [[ "$state" == "OK" ]]; then
  echo "L02    PC-02      UP      1000 Mbps"
else
  echo "L02    PC-02      DOWN    -"
fi
echo "L03    PC-03      UP      1000 Mbps"
echo "L04    AP-01      UP      1000 Mbps"
EOF

cat > /usr/local/bin/cable-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
if [[ -z "$line" ]]; then
  echo "Использование: cable-test L01|L02|L03|L04"
  exit 2
fi
case "$line" in
  L02)
    if [[ "$(cat /root/tfu01/state)" == "OK" ]]; then
      cat <<'OUT'
CABLE TESTER · L02
MAIN      REMOTE
1   ----> 1
2   ----> 2
3   ----> 3
4   ----> 4
5   ----> 5
6   ----> 6
7   ----> 7
8   ----> 8

RESULT: PASS
OUT
    else
      cat <<'OUT'
CABLE TESTER · L02
MAIN      REMOTE
1   ----> 1
2   ----> 2
3   ----> 3
4   ----> OPEN
5   ----> 5
6   ----> 6
7   ----> 7
8   ----> 8

RESULT: FAIL
FAULT: OPEN
OUT
    fi
    ;;
  L01|L03|L04)
    cat <<OUT
CABLE TESTER · $line
MAIN      REMOTE
1   ----> 1
2   ----> 2
3   ----> 3
4   ----> 4
5   ----> 5
6   ----> 6
7   ----> 7
8   ----> 8

RESULT: PASS
OUT
    ;;
  *)
    echo "Неизвестная линия: $line"
    exit 2
    ;;
esac
EOF

cat > /usr/local/bin/tdr <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
if [[ "$line" != "L02" ]]; then
  echo "TDR: на линии ${line:-?} существенных дефектов не обнаружено."
  exit 0
fi
if [[ "$(cat /root/tfu01/state)" == "OK" ]]; then
  cat <<'OUT'
TDR · L02
LINE LENGTH: 47.8 m
FAULTS: NONE
RESULT: PASS
OUT
else
  cat <<'OUT'
TDR · L02
LINE LENGTH: 47.8 m
FAULT TYPE: OPEN
FAULT DISTANCE: 31.4 m
ESTIMATED ZONE: wall passage / outlet 201-02
OUT
fi
EOF

cat > /usr/local/bin/repair-line <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
line="${1:-}"
if [[ "$line" != "L02" ]]; then
  echo "Ремонт не выполнен: выбран неверный сегмент."
  exit 1
fi
report=/root/tfu01/report.txt
if [[ ! -f "$report" ]]; then
  echo "Сначала оформите /root/tfu01/report.txt"
  exit 1
fi
grep -Eq '^LINE=L02$' "$report" || { echo "В отчёте неверно указана LINE."; exit 1; }
grep -Eq '^FAULT=OPEN$' "$report" || { echo "В отчёте неверно указан FAULT."; exit 1; }
grep -Eq '^CONDUCTOR=4$' "$report" || { echo "В отчёте неверно указан CONDUCTOR."; exit 1; }
grep -Eq '^DISTANCE=31\.4$' "$report" || { echo "В отчёте неверно указана DISTANCE."; exit 1; }

printf 'OK\n' > /root/tfu01/state
echo "✓ Линия L02 восстановлена. Выполните link-status и cable-test L02 для контрольной проверки."
EOF

chmod +x /usr/local/bin/link-status /usr/local/bin/cable-test /usr/local/bin/tdr /usr/local/bin/repair-line
