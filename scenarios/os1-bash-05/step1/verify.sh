#!/usr/bin/env bash
set -euo pipefail
cd /root/bash05/work
[[ -s process_list.txt ]] || { echo "✗ process_list.txt не создан или пуст."; exit 1; }
head -n 1 process_list.txt | grep -Eq 'PID[[:space:]]+PPID[[:space:]]+COMMAND' || {
  echo "✗ process_list.txt должен быть создан командой ps -eo pid,ppid,comm."
  exit 1
}
[[ "$(wc -l < process_list.txt)" -ge 2 ]] || { echo "✗ В списке процессов слишком мало строк."; exit 1; }
echo "✓ Список процессов получен."
