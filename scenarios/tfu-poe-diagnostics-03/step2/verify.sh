#!/usr/bin/env bash
set -euo pipefail

[[ -f /root/tfu03/step1.ok ]] || { echo "✗ Сначала завершите этап 1."; exit 1; }

f=/root/tfu03/poe-class.txt
[[ -f "$f" ]] || { echo "✗ Не найден /root/tfu03/poe-class.txt"; exit 1; }

if [[ "$(tr -d '[:space:]' < "$f")" != "3" ]]; then
  echo "✗ Неверно определён класс PoE-устройства."
  echo "Посмотрите строку PD CLASS."
  exit 1
fi

touch /root/tfu03/step2.ok
echo "✓ Верно: IP-CAM-02 определяется как PD Class 3."
