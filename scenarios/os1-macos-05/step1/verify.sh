#!/usr/bin/env bash
set -euo pipefail
cd /root/os05/work
expected=$'MENU_BAR=top\nDOCK=bottom\nFINDER=file_browser'
[[ -f interface.txt ]] || { echo "✗ Нет interface.txt."; exit 1; }
[[ "$(cat interface.txt)" == "$expected" ]] || { echo "✗ Проверьте расположение Menu Bar, Dock и назначение Finder."; exit 1; }
echo "✓ Основные элементы рабочего стола определены."
