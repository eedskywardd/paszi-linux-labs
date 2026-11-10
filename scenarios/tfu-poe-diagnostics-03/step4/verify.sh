#!/usr/bin/env bash
set -euo pipefail

[[ -f /root/tfu03/step3.ok ]] || { echo "✗ Сначала завершите этап 3."; exit 1; }

f=/root/tfu03/report.txt
[[ -f "$f" ]] || { echo "✗ Не найден /root/tfu03/report.txt"; exit 1; }

grep -Eq '^PORT=P02$' "$f" || { echo "✗ PORT заполнен неверно."; exit 1; }
grep -Eq '^PD_CLASS=3$' "$f" || { echo "✗ PD_CLASS заполнен неверно."; exit 1; }
grep -Eq '^FAULT=EXCESSIVE_VOLTAGE_DROP$' "$f" || { echo "✗ FAULT заполнен неверно."; exit 1; }
grep -Eq '^CAUSE=HIGH_RESISTANCE_LINE$' "$f" || { echo "✗ CAUSE заполнена неверно."; exit 1; }

if [[ "$(cat /root/tfu03/state 2>/dev/null)" != "OK" ]]; then
  echo "✗ Диагноз правильный, но линия ещё не восстановлена."
  echo "Выполните repair-poe P02."
  exit 1
fi

echo "✓ PoE-линия диагностирована и восстановлена."
