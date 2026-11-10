#!/usr/bin/env bash
set -euo pipefail
f=/root/bash03/step1_pwd.txt
[[ -f "$f" ]] || { echo "✗ Файл step1_pwd.txt не найден."; exit 1; }
[[ "$(cat "$f")" == "/root/bash03/lab/projects/site" ]] || { echo "✗ В step1_pwd.txt должен быть путь /root/bash03/lab/projects/site."; exit 1; }
echo "✓ Абсолютный путь определён правильно."
