#!/usr/bin/env bash
set -euo pipefail
cd /root/bash08/work
expected_numbers=$'NUMBER=1\nNUMBER=2\nNUMBER=3\nNUMBER=4\nNUMBER=5'
[[ "$(cat numbers.txt 2>/dev/null || true)" == "$expected_numbers" ]] || { echo "✗ numbers.txt заполнен неверно."; exit 1; }
[[ "$(cat sum.txt 2>/dev/null || true)" == "SUM=15" ]] || { echo "✗ sum.txt должен содержать SUM=15."; exit 1; }
echo "✓ Цикл по числам и счётчик работают."
