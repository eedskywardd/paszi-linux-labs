#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu07b/step2.ok ]] || { echo "✗ Сначала этап 2."; exit 1; }
[[ "$(cat /root/tfu07b/l11.state 2>/dev/null)" == "OK" ]] || { echo "✗ L11 ещё не восстановлена."; exit 1; }
[[ "$(cat /root/tfu07b/l12.state 2>/dev/null)" == "OK" ]] || { echo "✗ L12 ещё не восстановлена."; exit 1; }
touch /root/tfu07b/step3.ok
echo "✓ Обе медные линии восстановлены."
