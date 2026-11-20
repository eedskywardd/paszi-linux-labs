#!/usr/bin/env bash
set -euo pipefail
cd /root/bash09/work

[[ -f actions.sh ]] || { echo "✗ Нет actions.sh."; exit 1; }
[[ -x actions.sh ]] || { echo "✗ actions.sh должен быть исполняемым."; exit 1; }
grep -q 'case ' actions.sh || { echo "✗ В actions.sh должен использоваться case."; exit 1; }
grep -q 'esac' actions.sh || { echo "✗ Конструкция case должна завершаться esac."; exit 1; }

[[ "$(cat action_start.txt 2>/dev/null || true)" == "ACTION=START" ]] || { echo "✗ Неверный результат для start."; exit 1; }
[[ "$(cat action_stop.txt 2>/dev/null || true)" == "ACTION=STOP" ]] || { echo "✗ Неверный результат для stop."; exit 1; }
[[ "$(cat action_status.txt 2>/dev/null || true)" == "ACTION=STATUS" ]] || { echo "✗ Неверный результат для status."; exit 1; }
[[ "$(cat action_unknown.txt 2>/dev/null || true)" == "ACTION=UNKNOWN" ]] || { echo "✗ Неверная обработка неизвестного действия."; exit 1; }

echo "✓ case выбирает нужную ветку."
