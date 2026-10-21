#!/usr/bin/env bash
set -euo pipefail
bash "$(dirname "$0")/../step2/verify.sh" >/dev/null
ip netns exec fw nft list chain inet labfilter forward | grep -q 'PASZI_DROP:' || { echo '✗ Нет префикса журнала'; exit 1; }
[ -s /root/paszi_report.txt ] || { echo '✗ Создайте /root/paszi_report.txt'; exit 1; }
for k in STUDENT FAULTS POLICY; do grep -Eq "^${k}=.{8,}" /root/paszi_report.txt || { echo "✗ Заполните $k="; exit 1; }; done
echo '✓ Аудит завершён. Покажите преподавателю результат.'
