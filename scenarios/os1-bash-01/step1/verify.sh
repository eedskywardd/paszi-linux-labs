#!/usr/bin/env bash
set -euo pipefail
f=/root/bash01_hello.txt
if [[ ! -f "$f" ]]; then
  echo "✗ Файл /root/bash01_hello.txt не найден."
  echo "Подсказка: выполните echo "BASH_OK" > /root/bash01_hello.txt"
  exit 1
fi
if [[ "$(cat "$f")" != "BASH_OK" ]]; then
  echo "✗ Файл есть, но внутри должен быть ровно текст BASH_OK."
  exit 1
fi
echo "✓ Отлично. Вы выполнили команду, перенаправили её вывод в файл и прочитали файл через cat."
