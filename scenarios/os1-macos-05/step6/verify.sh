#!/usr/bin/env bash
set -euo pipefail
cd /root/os05/work
expected=$'FILES=Finder\nSEARCH=Spotlight\nAPPEARANCE=System Settings > Appearance\nUSERS=System Settings > Users & Groups\nQUICK_SETTINGS=Control Center'
[[ -f routes.txt ]] || { echo "✗ Нет routes.txt."; exit 1; }
[[ "$(cat routes.txt)" == "$expected" ]] || { echo "✗ Проверьте, какой системный элемент используется в каждой ситуации."; exit 1; }
echo "✓ Навигация по основным функциям macOS закреплена."
