#!/usr/bin/env bash
set -euo pipefail
if [ ! -f /root/PASZI_DB_READY ]; then echo 'База ещё готовится; проверьте /root/paszi_db_setup.log'; exit 1; fi
pg() { runuser -u postgres -- psql -X -qAt -d paszi_lab -v ON_ERROR_STOP=1 -c "$1"; }
if ! pg 'SET ROLE support_agent; SELECT * FROM corp.tickets LIMIT 1;' >/dev/null 2>&1; then
 echo '✗ Оператор пока не может читать таблицу corp.tickets.'; exit 1
fi
rights=$(pg "SELECT has_table_privilege('support_agent','corp.tickets','INSERT'),has_table_privilege('support_agent','corp.tickets','UPDATE'),has_table_privilege('support_agent','corp.tickets','DELETE')")
if [ "$rights" != 'f|f|f' ]; then
 echo '✗ У оператора остались лишние права INSERT, UPDATE или DELETE.'; exit 1
fi
echo '✓ Оператор может читать обращения, но не может менять данные.'
