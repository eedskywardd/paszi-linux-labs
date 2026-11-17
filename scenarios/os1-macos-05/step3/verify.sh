#!/usr/bin/env bash
set -euo pipefail
cd /root/os05/work
expected=$'FINDER=files_and_folders\nSIDEBAR=navigation\nMAIN_AREA=contents'
[[ -f finder.txt ]] || { echo "✗ Нет finder.txt."; exit 1; }
[[ "$(cat finder.txt)" == "$expected" ]] || { echo "✗ Проверьте назначение Finder, боковой панели и основной области."; exit 1; }
echo "✓ Основные элементы Finder определены."
