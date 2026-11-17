#!/usr/bin/env bash
set -euo pipefail
cd /root/bash05/work
[[ -s uptime.txt ]] || { echo "✗ Нет uptime.txt."; exit 1; }
[[ -s memory.txt ]] || { echo "✗ Нет memory.txt."; exit 1; }
[[ -s top_snapshot.txt ]] || { echo "✗ Нет top_snapshot.txt."; exit 1; }
grep -q 'load average' uptime.txt || { echo "✗ uptime.txt не похож на вывод uptime."; exit 1; }
grep -q '^Mem:' memory.txt || { echo "✗ memory.txt должен содержать вывод free -h."; exit 1; }
head -n 1 top_snapshot.txt | grep -qi '^top' || { echo "✗ top_snapshot.txt должен быть создан через top -b -n 1."; exit 1; }
echo "✓ Снимок состояния системы получен."
