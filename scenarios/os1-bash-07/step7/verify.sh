#!/usr/bin/env bash
set -euo pipefail
d=/root/bash07/work/final

[[ -d "$d" ]] || { echo "✗ Каталог final не найден."; exit 1; }
[[ -f "$d/filecheck.sh" ]] || { echo "✗ Нет filecheck.sh."; exit 1; }
[[ -x "$d/filecheck.sh" ]] || { echo "✗ filecheck.sh должен быть исполняемым."; exit 1; }

head -n 1 "$d/filecheck.sh" | grep -qx '#!/usr/bin/env bash' || { echo "✗ Первая строка filecheck.sh должна быть #!/usr/bin/env bash."; exit 1; }
grep -q '\$#' "$d/filecheck.sh" || { echo "✗ Скрипт должен проверять количество аргументов через \$#."; exit 1; }
grep -q '\$1' "$d/filecheck.sh" || { echo "✗ Скрипт должен использовать первый аргумент \$1."; exit 1; }
grep -q 'if ' "$d/filecheck.sh" || { echo "✗ В filecheck.sh должен использоваться if."; exit 1; }
grep -q '\-f' "$d/filecheck.sh" || { echo "✗ В filecheck.sh должна использоваться проверка -f."; exit 1; }
grep -q 'wc -l' "$d/filecheck.sh" || { echo "✗ В filecheck.sh должна использоваться команда wc -l."; exit 1; }
grep -Eq 'exit[[:space:]]+1' "$d/filecheck.sh" || { echo "✗ При отсутствии аргумента должен использоваться exit 1."; exit 1; }

set +e
no_arg_output="$("$d/filecheck.sh" 2>&1)"
no_arg_code=$?
set -e
[[ "$no_arg_output" == "ERROR=NO_ARGUMENT" ]] || { echo "✗ Без аргумента скрипт должен вывести ERROR=NO_ARGUMENT."; exit 1; }
[[ "$no_arg_code" -eq 1 ]] || { echo "✗ Без аргумента filecheck.sh должен завершаться с кодом 1."; exit 1; }

found_output="$("$d/filecheck.sh" /root/bash07/data/sample.txt)"
expected_found=$'FILE=/root/bash07/data/sample.txt\nSTATUS=FOUND\nLINES=3'
[[ "$found_output" == "$expected_found" ]] || { echo "✗ Для sample.txt вывод filecheck.sh неверный."; exit 1; }

missing_output="$("$d/filecheck.sh" /root/bash07/data/missing.txt)"
expected_missing=$'FILE=/root/bash07/data/missing.txt\nSTATUS=NOT_FOUND'
[[ "$missing_output" == "$expected_missing" ]] || { echo "✗ Для отсутствующего файла вывод filecheck.sh неверный."; exit 1; }

[[ "$(cat "$d/no_argument.txt" 2>/dev/null || true)" == "ERROR=NO_ARGUMENT" ]] || { echo "✗ no_argument.txt должен содержать ERROR=NO_ARGUMENT."; exit 1; }
[[ "$(cat "$d/found.txt" 2>/dev/null || true)" == "$expected_found" ]] || { echo "✗ found.txt содержит неверный результат."; exit 1; }
[[ "$(cat "$d/not_found.txt" 2>/dev/null || true)" == "$expected_missing" ]] || { echo "✗ not_found.txt содержит неверный результат."; exit 1; }
[[ -f "$d/.done" ]] || { echo "✗ Скрытый файл .done не создан."; exit 1; }

echo "✓ ОС07 завершена. filecheck.sh правильно обрабатывает все три ситуации!"
