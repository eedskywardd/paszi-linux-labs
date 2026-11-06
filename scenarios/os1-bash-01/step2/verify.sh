#!/usr/bin/env bash
set -euo pipefail
if [[ ! -d /root/bash01/work ]]; then
  echo "✗ Каталог /root/bash01/work ещё не создан."
  exit 1
fi
echo "✓ Рабочий каталог создан. Запомните: pwd — где я, ls — что здесь, cd — перейти."
