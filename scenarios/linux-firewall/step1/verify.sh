#!/usr/bin/env bash
set -euo pipefail
ip -n pc route get 10.10.20.2 | grep -q 'via 10.10.10.1' && echo '✓ Маршрут исправлен'
