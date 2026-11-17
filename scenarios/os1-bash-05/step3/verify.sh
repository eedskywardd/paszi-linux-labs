#!/usr/bin/env bash
set -euo pipefail
cd /root/bash05/work
[[ -f background_pid.txt ]] || { echo "✗ Нет background_pid.txt."; exit 1; }
pid="$(cat background_pid.txt)"
[[ "$pid" =~ ^[0-9]+$ ]] || { echo "✗ background_pid.txt должен содержать PID."; exit 1; }
kill -0 "$pid" 2>/dev/null || { echo "✗ Учебный процесс уже не работает. Запустите sleep 300 & заново."; exit 1; }
ps -p "$pid" -o comm= | grep -qx 'sleep' || { echo "✗ PID должен принадлежать учебному процессу sleep."; exit 1; }
echo "✓ Фоновый процесс запущен, PID сохранён."
