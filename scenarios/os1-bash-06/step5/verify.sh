#!/usr/bin/env bash
set -euo pipefail
cd /root/bash06/work
expected=$'alias ll=\x27ls -la\x27\nalias cwork=\x27cd /root/bash06/work\x27'
[[ -f aliases.sh ]] || { echo "✗ Нет aliases.sh."; exit 1; }
[[ "$(cat aliases.sh)" == "$expected" ]] || { echo "✗ aliases.sh должен содержать два alias из задания."; exit 1; }
echo "✓ Файл с alias создан правильно."
