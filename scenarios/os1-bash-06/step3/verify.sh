#!/usr/bin/env bash
set -euo pipefail
cd /root/bash06/work
[[ "$(cat exported.txt 2>/dev/null || true)" == "OS06" ]] || { echo "✗ exported.txt должен содержать OS06."; exit 1; }
[[ "$(cat level.txt 2>/dev/null || true)" == "beginner" ]] || { echo "✗ level.txt должен содержать beginner."; exit 1; }
echo "✓ export использован правильно."
