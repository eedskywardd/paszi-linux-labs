#!/usr/bin/env bash
set -euo pipefail
if [ ! -f /root/PASZI_DB_READY ]; then echo 'База ещё готовится'; exit 1; fi
try_role() { runuser -u postgres -- psql -X -qAt -d paszi_lab -v ON_ERROR_STOP=1 -c "SET ROLE $1; $2" >/dev/null 2>&1; }
if ! try_role auditor 'SELECT * FROM corp.security_events LIMIT 1;'; then
 echo '✗ Аудитор не читает журнал corp.security_events.'; exit 1
fi
if try_role auditor 'SELECT * FROM corp.clients LIMIT 1;'; then
 echo '✗ Аудитор всё ещё читает контакты клиентов.'; exit 1
fi
if try_role auditor 'SELECT * FROM corp.tickets LIMIT 1;'; then
 echo '✗ Аудитор не должен читать заявки.'; exit 1
fi
if try_role trainee 'SELECT * FROM corp.clients LIMIT 1;'; then
 echo '✗ Стажёр всё ещё читает контакты клиентов.'; exit 1
fi
if try_role trainee 'SELECT * FROM corp.security_events LIMIT 1;'; then
 echo '✗ Стажёр не должен читать журнал.'; exit 1
fi
p=$(runuser -u postgres -- psql -X -qAt -d paszi_lab -v ON_ERROR_STOP=1 -c "SELECT has_table_privilege('auditor','corp.security_events','INSERT')")
if [ "$p" != 'f' ]; then echo '✗ У аудитора есть право добавлять события.'; exit 1; fi
echo '✓ Аудитор читает только журнал, стажёр не видит чувствительные данные.'
