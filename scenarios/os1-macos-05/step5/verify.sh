#!/usr/bin/env bash
set -euo pipefail
cd /root/os05/work
expected=$'APPEARANCE=Appearance\nDESKTOP_DOCK=Desktop & Dock\nUSERS=Users & Groups\nPRIVACY=Privacy & Security\nFIREWALL=Network > Firewall'
[[ -f settings_paths.txt ]] || { echo "✗ Нет settings_paths.txt."; exit 1; }
[[ "$(cat settings_paths.txt)" == "$expected" ]] || { echo "✗ Один или несколько путей System Settings указаны неверно."; exit 1; }
echo "✓ Основные разделы System Settings найдены."
