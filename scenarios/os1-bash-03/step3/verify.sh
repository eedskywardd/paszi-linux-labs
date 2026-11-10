#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/bash03/server_path.txt ]] || { echo "✗ Нет server_path.txt."; exit 1; }
[[ "$(cat /root/bash03/server_path.txt)" == "/root/bash03/lab/projects/api/server.py" ]] || { echo "✗ server_path.txt содержит неверный путь."; exit 1; }
[[ -f /root/bash03/txt_files.txt ]] || { echo "✗ Нет txt_files.txt."; exit 1; }
tmp="$(mktemp)"
find /root/bash03/lab -type f -name "*.txt" | sort > "$tmp"
cmp -s "$tmp" /root/bash03/txt_files.txt || { rm -f "$tmp"; echo "✗ txt_files.txt должен содержать полный отсортированный список .txt-файлов."; exit 1; }
rm -f "$tmp"
echo "✓ find использован правильно."
