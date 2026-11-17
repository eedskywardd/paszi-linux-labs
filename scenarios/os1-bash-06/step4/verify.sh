#!/usr/bin/env bash
set -euo pipefail
cd /root/bash06/work
[[ -f command_substitution.txt ]] || { echo "✗ Нет command_substitution.txt."; exit 1; }
expected="$(mktemp)"
{
  echo "USER=$(whoami)"
  echo "HOST=$(hostname)"
  echo "KERNEL=$(uname -r)"
} > "$expected"
cmp -s "$expected" command_substitution.txt || { rm -f "$expected"; echo "✗ command_substitution.txt содержит неверные значения."; exit 1; }
rm -f "$expected"
echo '✓ Подстановка команд $(...) использована правильно.'
