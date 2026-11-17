#!/usr/bin/env bash
set -euo pipefail
cd /root/bash05/work
[[ -f shell_pid.txt ]] || { echo "✗ Нет shell_pid.txt."; exit 1; }
[[ -f shell_process.txt ]] || { echo "✗ Нет shell_process.txt."; exit 1; }
pid="$(cat shell_pid.txt)"
[[ "$pid" =~ ^[0-9]+$ ]] || { echo "✗ shell_pid.txt должен содержать только PID."; exit 1; }
line_pid="$(awk '{print $1}' shell_process.txt)"
[[ "$line_pid" == "$pid" ]] || { echo "✗ PID в shell_process.txt не совпадает с shell_pid.txt."; exit 1; }
grep -Eq 'bash|sh' shell_process.txt || { echo "✗ shell_process.txt должен содержать процесс оболочки."; exit 1; }
echo "✓ PID текущей оболочки найден правильно."
