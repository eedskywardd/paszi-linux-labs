#!/usr/bin/env bash
set -euo pipefail
cd /root/bash09/work

[[ -f toolkit.sh ]] || { echo "✗ Нет toolkit.sh."; exit 1; }
[[ -x toolkit.sh ]] || { echo "✗ toolkit.sh должен быть исполняемым."; exit 1; }
grep -q 'show_user()' toolkit.sh || { echo "✗ Нужна функция show_user()."; exit 1; }
grep -q 'show_kernel()' toolkit.sh || { echo "✗ Нужна функция show_kernel()."; exit 1; }
grep -q 'count_txt()' toolkit.sh || { echo "✗ Нужна функция count_txt()."; exit 1; }
grep -q 'case ' toolkit.sh || { echo "✗ В toolkit.sh должен использоваться case."; exit 1; }

[[ "$(./toolkit.sh user)" == "USER=$(whoami)" ]] || { echo "✗ Действие user работает неверно."; exit 1; }
[[ "$(./toolkit.sh kernel)" == "KERNEL=$(uname -r)" ]] || { echo "✗ Действие kernel работает неверно."; exit 1; }
[[ "$(./toolkit.sh txt)" == "TXT_COUNT=2" ]] || { echo "✗ Действие txt должно вернуть TXT_COUNT=2."; exit 1; }
[[ "$(./toolkit.sh wrong)" == "ERROR=UNKNOWN_ACTION" ]] || { echo "✗ Неизвестное действие должно вернуть ERROR=UNKNOWN_ACTION."; exit 1; }

[[ "$(cat toolkit_user.txt 2>/dev/null || true)" == "USER=$(whoami)" ]] || { echo "✗ toolkit_user.txt заполнен неверно."; exit 1; }
[[ "$(cat toolkit_txt.txt 2>/dev/null || true)" == "TXT_COUNT=2" ]] || { echo "✗ toolkit_txt.txt заполнен неверно."; exit 1; }

echo "✓ Функции и case объединены в одну программу."
