#!/usr/bin/env bash
set -euo pipefail
cd /root/bash05/work
pid="$(cat background_pid.txt 2>/dev/null || true)"
[[ "$pid" =~ ^[0-9]+$ ]] || { echo "✗ Не найден корректный PID учебного процесса."; exit 1; }
if kill -0 "$pid" 2>/dev/null; then
  echo "✗ Процесс sleep ещё работает. Завершите его командой kill."
  exit 1
fi
[[ "$(cat process_terminated.txt 2>/dev/null || true)" == "terminated" ]] || { echo "✗ Создайте process_terminated.txt по инструкции."; exit 1; }
echo "✓ Учебный процесс завершён корректно."
