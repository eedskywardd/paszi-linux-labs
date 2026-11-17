#!/usr/bin/env bash
set -euo pipefail
cd /root/bash07/work
[[ "$(cat success_code.txt 2>/dev/null || true)" == "0" ]] || { echo "✗ success_code.txt должен содержать 0."; exit 1; }
failure="$(cat failure_code.txt 2>/dev/null || true)"
[[ "$failure" =~ ^[0-9]+$ ]] || { echo "✗ failure_code.txt должен содержать число."; exit 1; }
[[ "$failure" -ne 0 ]] || { echo "✗ Код неуспешной команды не должен быть 0."; exit 1; }
echo '✓ Код возврата $? прочитан правильно.'
