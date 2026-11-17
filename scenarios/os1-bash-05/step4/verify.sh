#!/usr/bin/env bash
set -euo pipefail
cd /root/bash05/work
[[ -f jobs.txt ]] || { echo "✗ Нет jobs.txt."; exit 1; }
[[ -f background_status.txt ]] || { echo "✗ Нет background_status.txt."; exit 1; }
pid="$(cat background_pid.txt)"
grep -Eq "(^|[^0-9])${pid}([^0-9]|$)" background_status.txt || { echo "✗ background_status.txt должен содержать PID фонового процесса."; exit 1; }
grep -q 'sleep' background_status.txt || { echo "✗ background_status.txt должен содержать имя sleep."; exit 1; }
kill -0 "$pid" 2>/dev/null || { echo "✗ Фоновый процесс завершился раньше времени."; exit 1; }
echo "✓ Фоновая задача найдена через jobs и ps."
