#!/usr/bin/env bash
set -euo pipefail
cd /root/bash04/work
[[ -f system_report.txt ]] || { echo "✗ Нет system_report.txt."; exit 1; }
expected="$(mktemp)"
{
  echo "USER"
  whoami
  echo "HOSTNAME"
  hostname
  echo "KERNEL"
  uname -r
  echo "ARCH"
  uname -m
  echo "OS"
  grep '^PRETTY_NAME=' /etc/os-release
} > "$expected"
if ! cmp -s "$expected" system_report.txt; then
  rm -f "$expected"
  echo "✗ system_report.txt заполнен неверно или строки расположены не в том порядке."
  echo "Проверьте USER, HOSTNAME, KERNEL, ARCH и OS."
  exit 1
fi
rm -f "$expected"
[[ -f .done ]] || { echo "✗ Скрытый файл .done не создан."; exit 1; }
echo "✓ Системный отчёт составлен правильно. ОС04 завершена!"
