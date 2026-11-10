#!/usr/bin/env bash
set -euo pipefail

mkdir -p /root/tfu03
printf 'BROKEN\n' > /root/tfu03/state
rm -f /root/tfu03/step1.ok /root/tfu03/step2.ok /root/tfu03/step3.ok
rm -f /root/tfu03/problem-port.txt /root/tfu03/poe-class.txt /root/tfu03/voltage.txt /root/tfu03/report.txt

cat > /usr/local/bin/poe-status <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
state="$(cat /root/tfu03/state 2>/dev/null || echo BROKEN)"
echo "PORT   DEVICE       LINK   POE      POWER"
echo "P01    IP-CAM-01    UP     ON       6.2 W"
if [[ "$state" == "OK" ]]; then
  echo "P02    IP-CAM-02    UP     ON       8.1 W"
else
  echo "P02    IP-CAM-02    DOWN   FAULT    0.0 W"
fi
echo "P03    AP-01        UP     ON       11.8 W"
echo "P04    PC-01        UP     OFF      -"
EOF

cat > /usr/local/bin/poe-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
port="${1:-}"
state="$(cat /root/tfu03/state 2>/dev/null || echo BROKEN)"
if [[ -z "$port" ]]; then
  echo "Использование: poe-test P01|P02|P03|P04"
  exit 2
fi
case "$port" in
  P01)
    printf 'POE TEST · P01\nSTANDARD: IEEE 802.3af\nPD CLASS: 2\nNEGOTIATION: OK\nVOLTAGE IDLE: 48.6 V\nRESULT: PASS\n'
    ;;
  P02)
    if [[ "$state" == "OK" ]]; then
      printf 'POE TEST · P02\nSTANDARD: IEEE 802.3af\nPD CLASS: 3\nNEGOTIATION: OK\nVOLTAGE IDLE: 48.4 V\nRESULT: PASS\n'
    else
      printf 'POE TEST · P02\nSTANDARD: IEEE 802.3af\nPD CLASS: 3\nNEGOTIATION: OK\nVOLTAGE IDLE: 48.4 V\nPOWER REQUEST: 12.0 W\nRESULT: WARNING\n'
    fi
    ;;
  P03)
    printf 'POE TEST · P03\nSTANDARD: IEEE 802.3at\nPD CLASS: 4\nNEGOTIATION: OK\nVOLTAGE IDLE: 49.0 V\nRESULT: PASS\n'
    ;;
  P04)
    echo "P04: устройство не запрашивает PoE."
    ;;
  *)
    echo "Неизвестный порт: $port"
    exit 2
    ;;
esac
EOF

cat > /usr/local/bin/load-test <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
port="${1:-}"
state="$(cat /root/tfu03/state 2>/dev/null || echo BROKEN)"

if [[ "$port" != "P02" ]]; then
  echo "LOAD TEST · ${port:-?}"
  echo "VOLTAGE UNDER LOAD: 48.1 V"
  echo "RESULT: PASS"
  exit 0
fi

if [[ "$state" == "OK" ]]; then
  printf 'LOAD TEST · P02\nVOLTAGE IDLE: 48.4 V\nVOLTAGE UNDER LOAD: 47.6 V\nCURRENT: 0.17 A\nRESULT: PASS\n'
else
  printf 'LOAD TEST · P02\nVOLTAGE IDLE: 48.4 V\nVOLTAGE UNDER LOAD: 39.2 V\nCURRENT: 0.21 A\nDROP: 9.2 V\nRESULT: FAIL\nFAULT: EXCESSIVE_VOLTAGE_DROP\nSUSPECT: HIGH_RESISTANCE_LINE\n'
fi
EOF

cat > /usr/local/bin/repair-poe <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
port="${1:-}"
report=/root/tfu03/report.txt

[[ "$port" == "P02" ]] || { echo "Выбран неверный порт."; exit 1; }
[[ -f "$report" ]] || { echo "Сначала создайте /root/tfu03/report.txt"; exit 1; }

grep -Eq '^PORT=P02$' "$report" || { echo "Неверно указан PORT."; exit 1; }
grep -Eq '^PD_CLASS=3$' "$report" || { echo "Неверно указан PD_CLASS."; exit 1; }
grep -Eq '^FAULT=EXCESSIVE_VOLTAGE_DROP$' "$report" || { echo "Неверно указан FAULT."; exit 1; }
grep -Eq '^CAUSE=HIGH_RESISTANCE_LINE$' "$report" || { echo "Неверно указана CAUSE."; exit 1; }

printf 'OK\n' > /root/tfu03/state
echo "✓ Линия P02 восстановлена."
echo "Проведите повторные измерения."
EOF

chmod +x /usr/local/bin/poe-status /usr/local/bin/poe-test /usr/local/bin/load-test /usr/local/bin/repair-poe
