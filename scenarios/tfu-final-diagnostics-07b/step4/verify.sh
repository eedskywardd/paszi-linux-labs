#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu07b/step3.ok ]] || { echo "✗ Сначала этап 3."; exit 1; }
[[ "$(cat /root/tfu07b/p18.state 2>/dev/null)" == "OK" ]] || { echo "✗ P18 ещё не восстановлен."; exit 1; }
[[ "$(cat /root/tfu07b/f07.state 2>/dev/null)" == "OK" ]] || { echo "✗ F07 ещё не восстановлена."; exit 1; }
touch /root/tfu07b/step4.ok
echo "✓ PoE и оптическая линия восстановлены."
