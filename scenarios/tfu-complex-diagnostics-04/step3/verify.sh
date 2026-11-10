#!/usr/bin/env bash
set -euo pipefail
[[ -f /root/tfu04/step2.ok ]] || { echo "✗ Сначала завершите этап 2."; exit 1; }

f=/root/tfu04/vfl.txt
[[ -f "$f" ]] || { echo "✗ Не найден /root/tfu04/vfl.txt"; exit 1; }

grep -Eq '^CONTINUITY=PRESENT$' "$f" || { echo "✗ Неверно указана CONTINUITY."; exit 1; }
grep -Eq '^VISIBLE_LEAK=YES$' "$f" || { echo "✗ Неверно указана VISIBLE_LEAK."; exit 1; }

if ! grep -Eq '^LOCATION=(rack B / patch-cord bend|rack_B_patch-cord_bend)$' "$f"; then
  echo "✗ Неверно указана LOCATION."
  echo "Используйте: LOCATION=rack B / patch-cord bend"
  exit 1
fi

touch /root/tfu04/step3.ok
echo "✓ VFL показывает непрерывность и видимую утечку в зоне изгиба."
