#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu07a/step3.ok ]] || { echo "✗ Сначала завершите этап 3."; exit 1; }
f=/root/tfu07a/p18.txt
[[ -f "$f" ]] || { echo "✗ Не найден p18.txt"; exit 1; }
norm(){ tr -d '\r' < "$1" | sed 's/[[:space:]]*=[[:space:]]*/=/g;s/[[:space:]]*$//' | tr '[:lower:]' '[:upper:]'; }
v="$(norm "$f")"
grep -q '^PD_CLASS=4$' <<<"$v" || { echo "✗ PD_CLASS неверен."; exit 1; }
grep -q '^VOLTAGE_IDLE=49.1$' <<<"$v" || { echo "✗ VOLTAGE_IDLE неверно."; exit 1; }
grep -q '^VOLTAGE_LOAD=41.0$' <<<"$v" || { echo "✗ VOLTAGE_LOAD неверно."; exit 1; }
grep -q '^DROP=8.1$' <<<"$v" || { echo "✗ DROP неверен."; exit 1; }
grep -q '^FAULT=EXCESSIVE_VOLTAGE_DROP$' <<<"$v" || { echo "✗ FAULT неверен."; exit 1; }
grep -q '^CAUSE=HIGH_RESISTANCE_OR_CCA_LINE$' <<<"$v" || { echo "✗ CAUSE неверна."; exit 1; }
touch /root/tfu07a/step4.ok
echo "✓ P18 диагностирован правильно."
