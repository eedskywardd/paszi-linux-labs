#!/usr/bin/env bash
set -euo pipefail
if [ ! -f /root/PASZI_MINI_READY ]; then echo 'Подготовка не завершена'; exit 1; fi
try_sql() { runuser -u postgres -- psql -X -qAt -v ON_ERROR_STOP=1 -d paszi_mini -c "$1" >/dev/null 2>&1; }
read_sql() { runuser -u postgres -- psql -X -qAt -v ON_ERROR_STOP=1 -d paszi_mini -c "$1"; }
if ! try_sql 'SET ROLE checker; SELECT id FROM training.orders LIMIT 1;'; then echo '✗ Проверяющий не может читать заказы.'; exit 1; fi
if try_sql 'SET ROLE seller; SELECT id FROM training.orders LIMIT 1;'; then echo '✗ Продавец всё ещё может читать заказы.'; exit 1; fi
if ! try_sql 'SET ROLE seller; SELECT id FROM training.products LIMIT 1;'; then echo '✗ Продавец потерял доступ к каталогу.'; exit 1; fi
for role in seller checker; do
 for priv in INSERT UPDATE DELETE; do
  got=$(read_sql "SELECT has_table_privilege('$role','training.orders','$priv')")
  if [ "$got" != "f" ]; then echo "✗ У роли $role лишнее право $priv на orders"; exit 1; fi
 done
done
echo '✓ Все технические требования выполнены: доступ к каталогу и заказам разграничен.'
