#!/usr/bin/env bash
set -euo pipefail
cd /root/bash04/work
[[ -f os_name.txt ]] || { echo "✗ Нет os_name.txt."; exit 1; }
[[ -f os_release.txt ]] || { echo "✗ Нет os_release.txt."; exit 1; }
[[ "$(cat os_name.txt)" == "$(grep '^PRETTY_NAME=' /etc/os-release)" ]] || { echo "✗ os_name.txt должен содержать строку PRETTY_NAME из /etc/os-release."; exit 1; }
cmp -s /etc/os-release os_release.txt || { echo "✗ os_release.txt должен быть копией содержимого /etc/os-release."; exit 1; }
echo "✓ Дистрибутив Linux определён правильно."
