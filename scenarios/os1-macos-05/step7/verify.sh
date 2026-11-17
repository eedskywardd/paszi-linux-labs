#!/usr/bin/env bash
set -euo pipefail
cd /root/os05/work
[[ -f macos_report.txt ]] || { echo "✗ Нет macos_report.txt."; exit 1; }
expected=$'DESKTOP\nMenu Bar\nDock\nFinder\nSEARCH\nSpotlight\nSETTINGS\nSystem Settings'
[[ "$(cat macos_report.txt)" == "$expected" ]] || {
  echo "✗ macos_report.txt заполнен неверно."
  echo "Проверьте порядок и написание всех 8 строк."
  exit 1
}
[[ "$(wc -l < macos_report.txt)" -eq 8 ]] || { echo "✗ В macos_report.txt должно быть ровно 8 строк."; exit 1; }
[[ -f .done ]] || { echo "✗ Скрытый файл .done не создан."; exit 1; }
echo "✓ ОС05 завершена. Основы интерфейса macOS изучены!"
