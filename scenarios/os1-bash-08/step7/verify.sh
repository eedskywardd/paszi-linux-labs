#!/usr/bin/env bash
set -euo pipefail

d=/root/bash08/work/final
script="$d/folder_report.sh"

[[ -d "$d" ]] || { echo "✗ Каталог final не найден."; exit 1; }
[[ -f "$script" ]] || { echo "✗ Нет folder_report.sh."; exit 1; }
[[ -x "$script" ]] || { echo "✗ folder_report.sh должен быть исполняемым."; exit 1; }

head -n 1 "$script" | grep -qx '#!/usr/bin/env bash' || { echo "✗ Первая строка должна быть #!/usr/bin/env bash."; exit 1; }
grep -q '\$#' "$script" || { echo "✗ Нужно проверить количество аргументов через \$#."; exit 1; }
grep -q '\$1' "$script" || { echo "✗ Нужно использовать первый аргумент \$1."; exit 1; }
grep -q '\-d' "$script" || { echo "✗ Нужно проверить каталог через -d."; exit 1; }
grep -q 'for ' "$script" || { echo "✗ В скрипте должен быть цикл for."; exit 1; }
grep -q 'if ' "$script" || { echo "✗ В скрипте должен использоваться if."; exit 1; }
grep -q '\*.txt' "$script" || { echo "✗ Скрипт должен отдельно распознавать *.txt."; exit 1; }
grep -q '\*.log' "$script" || { echo "✗ Скрипт должен отдельно распознавать *.log."; exit 1; }
grep -Eq 'exit[[:space:]]+1' "$script" || { echo "✗ Ошибочные ситуации должны завершаться через exit 1."; exit 1; }

set +e
out_noarg="$("$script" 2>&1)"
code_noarg=$?
set -e
[[ "$out_noarg" == "ERROR=NO_ARGUMENT" ]] || { echo "✗ Без аргумента должен быть ERROR=NO_ARGUMENT."; exit 1; }
[[ "$code_noarg" -eq 1 ]] || { echo "✗ Без аргумента код возврата должен быть 1."; exit 1; }

set +e
out_file="$("$script" /root/bash08/data/alpha.txt 2>&1)"
code_file=$?
set -e
[[ "$out_file" == "ERROR=NOT_DIRECTORY" ]] || { echo "✗ Для пути к файлу должен быть ERROR=NOT_DIRECTORY."; exit 1; }
[[ "$code_file" -eq 1 ]] || { echo "✗ Для пути к файлу код возврата должен быть 1."; exit 1; }

expected=$'DIRECTORY=/root/bash08/data\nFILES=8\nDIRECTORIES=1\nTXT=4\nLOG=2'
actual="$("$script" /root/bash08/data)"
[[ "$actual" == "$expected" ]] || {
  echo "✗ Отчёт для /root/bash08/data неверный."
  echo "Ожидаются FILES=8, DIRECTORIES=1, TXT=4, LOG=2."
  exit 1
}

[[ -f "$d/report.txt" ]] || { echo "✗ Нет report.txt."; exit 1; }
[[ "$(cat "$d/report.txt")" == "$expected" ]] || { echo "✗ report.txt не совпадает с ожидаемым отчётом."; exit 1; }
[[ -f "$d/.done" ]] || { echo "✗ Скрытый файл .done не создан."; exit 1; }

echo "✓ ОС08 завершена. folder_report.sh корректно анализирует каталог!"
