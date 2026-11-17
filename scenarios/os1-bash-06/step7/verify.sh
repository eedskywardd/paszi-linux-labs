#!/usr/bin/env bash
set -euo pipefail
d=/root/bash06/work/final
[[ -d "$d" ]] || { echo "✗ Каталог final не найден."; exit 1; }
[[ -f "$d/info.sh" ]] || { echo "✗ Нет info.sh."; exit 1; }
[[ -x "$d/info.sh" ]] || { echo "✗ info.sh должен быть исполняемым."; exit 1; }
head -n 1 "$d/info.sh" | grep -qx '#!/usr/bin/env bash' || { echo "✗ Первая строка info.sh должна быть #!/usr/bin/env bash."; exit 1; }
grep -q 'whoami' "$d/info.sh" || { echo "✗ В info.sh должна использоваться команда whoami."; exit 1; }
grep -q 'hostname' "$d/info.sh" || { echo "✗ В info.sh должна использоваться команда hostname."; exit 1; }
grep -q 'uname -r' "$d/info.sh" || { echo "✗ В info.sh должна использоваться команда uname -r."; exit 1; }
grep -q '\$HOME' "$d/info.sh" || { echo "✗ В info.sh должна использоваться переменная \$HOME."; exit 1; }
[[ -f "$d/result.txt" ]] || { echo "✗ Нет result.txt."; exit 1; }
expected="$(mktemp)"
{
  echo "USER=$(whoami)"
  echo "HOST=$(hostname)"
  echo "KERNEL=$(uname -r)"
  echo "HOME=$HOME"
} > "$expected"
cmp -s "$expected" "$d/result.txt" || { rm -f "$expected"; echo "✗ result.txt содержит неверный вывод."; exit 1; }
rm -f "$expected"
[[ "$(wc -l < "$d/result.txt")" -eq 4 ]] || { echo "✗ В result.txt должно быть ровно 4 строки."; exit 1; }
[[ -f "$d/.done" ]] || { echo "✗ Скрытый файл .done не создан."; exit 1; }
echo "✓ ОС06 завершена. Первый самостоятельный Bash-скрипт готов!"
