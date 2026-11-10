#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/bash03/parent_path.txt ]] || { echo "✗ Нет parent_path.txt."; exit 1; }
[[ -f /root/bash03/notes_path.txt ]] || { echo "✗ Нет notes_path.txt."; exit 1; }
[[ -f /root/bash03/home_path.txt ]] || { echo "✗ Нет home_path.txt."; exit 1; }
[[ "$(cat /root/bash03/parent_path.txt)" == "/root/bash03/lab/projects" ]] || { echo "✗ Неверный путь в parent_path.txt."; exit 1; }
[[ "$(cat /root/bash03/notes_path.txt)" == "/root/bash03/lab/notes" ]] || { echo "✗ Неверный путь в notes_path.txt."; exit 1; }
[[ "$(cat /root/bash03/home_path.txt)" == "/root" ]] || { echo "✗ Неверный домашний каталог."; exit 1; }
echo "✓ Вы правильно использовали .., . и ~."
