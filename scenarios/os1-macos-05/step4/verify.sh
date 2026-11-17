#!/usr/bin/env bash
set -euo pipefail
cd /root/os05/work
expected=$'SPOTLIGHT=search\nLAUNCHPAD=applications\nCONTROL_CENTER=quick_settings'
[[ -f system_tools.txt ]] || { echo "✗ Нет system_tools.txt."; exit 1; }
[[ "$(cat system_tools.txt)" == "$expected" ]] || { echo "✗ Проверьте назначение Spotlight, Launchpad и Control Center."; exit 1; }
echo "✓ Системные инструменты macOS определены."
