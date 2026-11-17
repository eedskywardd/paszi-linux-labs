#!/usr/bin/env bash
set -euo pipefail
cd /root/bash06/work
[[ -f hello.sh ]] || { echo "✗ Нет hello.sh."; exit 1; }
[[ -x hello.sh ]] || { echo "✗ hello.sh не является исполняемым. Используйте chmod +x."; exit 1; }
head -n 1 hello.sh | grep -qx '#!/usr/bin/env bash' || { echo "✗ Первая строка hello.sh должна быть #!/usr/bin/env bash."; exit 1; }
[[ -f hello_output.txt ]] || { echo "✗ Нет hello_output.txt."; exit 1; }
expected="$(mktemp)"
{
  echo "Hello, Student!"
  echo "User: $(whoami)"
  echo "Host: $(hostname)"
} > "$expected"
cmp -s "$expected" hello_output.txt || { rm -f "$expected"; echo "✗ hello_output.txt не совпадает с ожидаемым выводом скрипта."; exit 1; }
rm -f "$expected"
echo "✓ Первый Bash-скрипт создан и выполнен."
