#!/usr/bin/env bash
set -euo pipefail
if [ ! -f /root/PASZI_MINI_READY ]; then echo 'Подготовка не завершена. См. /root/paszi_mini_setup.log'; exit 1; fi
check_sql() { runuser -u postgres -- psql -X -qAt -v ON_ERROR_STOP=1 -d paszi_mini -c "$1"; }
if ! check_sql 'SET ROLE seller; SELECT id, title FROM training.products LIMIT 1;' >/dev/null 2>&1; then
  echo '✗ Продавец по-прежнему не может читать каталог.'; exit 1
fi
perms=$(check_sql "SELECT has_table_privilege('seller','training.products','INSERT'),has_table_privilege('seller','training.products','UPDATE'),has_table_privilege('seller','training.products','DELETE')")
if [ "$perms" != 'f|f|f' ]; then echo '✗ Продавцу предоставлены ненужные права записи.'; exit 1; fi
echo '✓ Продавец читает каталог, но не может изменять товары.'
