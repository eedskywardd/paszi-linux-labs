#!/usr/bin/env bash
set -euo pipefail
if [ ! -f /root/PASZI_DB_READY ]; then echo 'База ещё готовится'; exit 1; fi
try_role() { runuser -u postgres -- psql -X -qAt -d paszi_lab -v ON_ERROR_STOP=1 -c "SET ROLE $1; $2" >/dev/null 2>&1; }
if ! try_role support_agent 'SELECT ticket_id, client_id, status, description FROM corp.tickets LIMIT 1;'; then
 echo '✗ Не все четыре разрешённых столбца доступны оператору.'; exit 1
fi
if try_role support_agent 'SELECT internal_note FROM corp.tickets LIMIT 1;'; then
 echo '✗ Оператор всё ещё читает internal_note.'; exit 1
fi
if try_role support_agent 'SELECT * FROM corp.tickets LIMIT 1;'; then
 echo '✗ У оператора осталось право SELECT на всю таблицу.'; exit 1
fi
p=$(runuser -u postgres -- psql -X -qAt -d paszi_lab -v ON_ERROR_STOP=1 -c "SELECT has_table_privilege('support_agent','corp.tickets','INSERT'),has_table_privilege('support_agent','corp.tickets','UPDATE'),has_table_privilege('support_agent','corp.tickets','DELETE')")
if [ "$p" != 'f|f|f' ]; then
 echo '✗ Оператор снова получил одно из запрещённых прав записи.'; exit 1
fi
echo '✓ Разрешённые столбцы доступны; internal_note скрыт; запись запрещена.'
