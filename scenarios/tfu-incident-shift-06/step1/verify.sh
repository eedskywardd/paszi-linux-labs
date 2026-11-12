#!/usr/bin/env bash
set -euo pipefail
f=/root/tfu06/incidents.txt
[[ -f "$f" ]] || { echo "✗ Не найден incidents.txt"; exit 1; }
v="$(tr -s '[:space:]' ' ' < "$f" | sed 's/^ //;s/ $//')"
if [[ "$v" != "L07 P12 F03" && "$v" != "L07 F03 P12" && "$v" != "P12 L07 F03" && "$v" != "P12 F03 L07" && "$v" != "F03 L07 P12" && "$v" != "F03 P12 L07" ]]; then
  echo "✗ Нужно указать три проблемных сегмента."
  exit 1
fi
touch /root/tfu06/step1.ok
echo "✓ Аварийные сегменты определены правильно."
