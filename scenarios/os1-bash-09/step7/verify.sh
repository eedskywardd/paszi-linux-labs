#!/usr/bin/env bash
set -euo pipefail

d=/root/bash09/work/final
script="$d/sysmenu.sh"

[[ -d "$d" ]] || { echo "✗ Каталог final не найден."; exit 1; }
if [[ ! -f "$script" ]]; then
  if [[ -f "$d/systemenu.sh" ]]; then
    echo "✗ Найден systemenu.sh, но нужен файл sysmenu.sh. Переименуйте: mv systemenu.sh sysmenu.sh"
  elif [[ -f "$d/systemmenu.sh" ]]; then
    echo "✗ Найден systemmenu.sh, но нужен файл sysmenu.sh. Переименуйте: mv systemmenu.sh sysmenu.sh"
  else
    echo "✗ Нет файла /root/bash09/work/final/sysmenu.sh."
  fi
  exit 1
fi
[[ -x "$script" ]] || { echo "✗ sysmenu.sh должен быть исполняемым."; exit 1; }

first_line="$(head -n 1 "$script" | tr -d '\r')"
[[ "$first_line" == '#!/usr/bin/env bash' || "$first_line" == '#!/bin/bash' ]] || {
  echo "✗ Первая строка должна быть #!/usr/bin/env bash или #!/bin/bash."
  exit 1
}
grep -q 'show_system()' "$script" || { echo "✗ Нужна функция show_system()."; exit 1; }
grep -q 'count_files()' "$script" || { echo "✗ Нужна функция count_files()."; exit 1; }
grep -q 'show_user()' "$script" || { echo "✗ Нужна функция show_user()."; exit 1; }
grep -q 'local ' "$script" || { echo "✗ Используйте local хотя бы в одной функции."; exit 1; }
grep -q 'for ' "$script" || { echo "✗ Нужен цикл for."; exit 1; }
grep -q 'if ' "$script" || { echo "✗ Нужна проверка if."; exit 1; }
grep -q 'read ' "$script" || { echo "✗ Меню должно читать выбор через read."; exit 1; }
grep -q 'case ' "$script" || { echo "✗ Меню должно использовать case."; exit 1; }
grep -q 'hostname' "$script" || { echo "✗ show_system должна использовать hostname."; exit 1; }
grep -q 'uname -r' "$script" || { echo "✗ show_system должна использовать uname -r."; exit 1; }
grep -q 'whoami' "$script" || { echo "✗ show_user должна использовать whoami."; exit 1; }

menu=$'1 - System\n2 - Files\n3 - User'

out1="$(printf '1\n' | "$script")"
expected1="$menu"$'\nHOST='"$(hostname)"$'\nKERNEL='"$(uname -r)"
[[ "$out1" == "$expected1" ]] || { echo "✗ Вариант 1 должен показать HOST и KERNEL."; exit 1; }

out2="$(printf '2\n' | "$script")"
expected2="$menu"$'\nFILES=4'
[[ "$out2" == "$expected2" ]] || { echo "✗ Вариант 2 должен вывести FILES=4."; exit 1; }

out3="$(printf '3\n' | "$script")"
expected3="$menu"$'\nUSER='"$(whoami)"
[[ "$out3" == "$expected3" ]] || { echo "✗ Вариант 3 должен вывести текущего пользователя."; exit 1; }

out9="$(printf '9\n' | "$script")"
expected9="$menu"$'\nERROR=UNKNOWN_CHOICE'
[[ "$out9" == "$expected9" ]] || { echo "✗ Неизвестный выбор должен дать ERROR=UNKNOWN_CHOICE."; exit 1; }

[[ "$(cat "$d/system.txt" 2>/dev/null || true)" == "$expected1" ]] || { echo "✗ system.txt заполнен неверно."; exit 1; }
[[ "$(cat "$d/files.txt" 2>/dev/null || true)" == "$expected2" ]] || { echo "✗ files.txt заполнен неверно."; exit 1; }
[[ "$(cat "$d/user.txt" 2>/dev/null || true)" == "$expected3" ]] || { echo "✗ user.txt заполнен неверно."; exit 1; }
[[ "$(cat "$d/unknown.txt" 2>/dev/null || true)" == "$expected9" ]] || { echo "✗ unknown.txt заполнен неверно."; exit 1; }
[[ -f "$d/.done" ]] || { echo "✗ Скрытый файл .done не создан."; exit 1; }

echo "✓ ОС09 завершена. sysmenu.sh корректно работает во всех режимах!"
