#!/usr/bin/env bash
set -euo pipefail
d=/root/bash05/work/final
[[ -d "$d" ]] || { echo "✗ Каталог final не найден."; exit 1; }
[[ -f "$d/worker.pid" ]] || { echo "✗ Нет worker.pid."; exit 1; }
pid="$(cat "$d/worker.pid")"
[[ "$pid" =~ ^[0-9]+$ ]] || { echo "✗ worker.pid должен содержать PID."; exit 1; }
[[ -f "$d/worker_status.txt" ]] || { echo "✗ Нет worker_status.txt."; exit 1; }
grep -Eq "(^|[^0-9])${pid}([^0-9]|$)" "$d/worker_status.txt" || { echo "✗ worker_status.txt должен содержать PID учебного процесса."; exit 1; }
grep -q 'sleep' "$d/worker_status.txt" || { echo "✗ worker_status.txt должен содержать имя sleep."; exit 1; }
if kill -0 "$pid" 2>/dev/null; then
  echo "✗ Учебный sleep 400 ещё работает. Его нужно завершить через kill."
  exit 1
fi
[[ "$(cat "$d/terminated.txt" 2>/dev/null || true)" == "DONE" ]] || { echo "✗ terminated.txt должен содержать DONE."; exit 1; }
[[ -f "$d/.done" ]] || { echo "✗ Скрытый файл .done не создан."; exit 1; }
echo "✓ ОС05 завершена. Вы умеете запускать, находить и завершать собственный процесс!"
