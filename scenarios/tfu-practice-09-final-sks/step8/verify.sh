#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu09/step7.ok ]] || { echo "✗ Сначала этап 7."; exit 1; }

for x in design cable ports labels bom passport; do
  [[ -f "/root/tfu09/$x.txt" ]] || { echo "✗ Отсутствует $x.txt"; exit 1; }
done

grep -Eq '^TOTAL_COPPER=1170\.4$' /root/tfu09/cable.txt || { echo "✗ Ошибка в расчёте кабеля."; exit 1; }
grep -Eq '^SWITCH_PORTS=48$' /root/tfu09/ports.txt || { echo "✗ Ошибка в коммутации."; exit 1; }
grep -Eq '^PROJECT_STATUS=READY$' /root/tfu09/passport.txt || { echo "✗ Паспорт не готов."; exit 1; }

echo "✓ ПРАКТИЧЕСКАЯ РАБОТА №9 ЗАВЕРШЕНА."
echo "✓ Проект СКС прошёл итоговую проверку."
