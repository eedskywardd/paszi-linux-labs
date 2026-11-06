#!/usr/bin/env bash
set -euo pipefail
cd /root/bash02
[[ -s history_last10.txt ]] || { echo "✗ history_last10.txt отсутствует или пуст."; echo "Выполните: history | tail -n 10 > history_last10.txt"; exit 1; }
echo "✓ История сохранена. Стрелки ↑/↓ помогают повторно использовать команды."
