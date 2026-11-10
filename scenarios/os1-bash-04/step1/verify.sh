#!/usr/bin/env bash
set -euo pipefail
cd /root/bash04/work
[[ -f user.txt ]] || { echo "✗ Нет user.txt."; exit 1; }
[[ -f identity.txt ]] || { echo "✗ Нет identity.txt."; exit 1; }
[[ -f hostname.txt ]] || { echo "✗ Нет hostname.txt."; exit 1; }
[[ "$(cat user.txt)" == "$(whoami)" ]] || { echo "✗ user.txt должен содержать результат whoami."; exit 1; }
[[ "$(cat identity.txt)" == "$(id)" ]] || { echo "✗ identity.txt должен содержать результат id."; exit 1; }
[[ "$(cat hostname.txt)" == "$(hostname)" ]] || { echo "✗ hostname.txt должен содержать результат hostname."; exit 1; }
echo "✓ Пользователь и hostname определены правильно."
