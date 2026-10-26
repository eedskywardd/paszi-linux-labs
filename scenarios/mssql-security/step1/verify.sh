#!/usr/bin/env bash
set -euo pipefail
[ -f /root/PASZI17_READY ] || { echo '✗ SQL Server ещё не готов; см. /root/paszi17_setup.log'; exit 1; }
source /root/paszi17_check.sh
if ! is_one "SELECT CASE WHEN IS_ROLEMEMBER(N'incident_reader',N'analyst_user')=1 THEN 1 ELSE 0 END"; then
 echo '✗ Аналитик должен оставаться участником incident_reader'; exit 1
fi
if ! is_one "SELECT CASE WHEN EXISTS (SELECT 1 FROM sys.database_permissions WHERE grantee_principal_id=DATABASE_PRINCIPAL_ID(N'incident_reader') AND major_id=OBJECT_ID(N'dbo.Incidents') AND minor_id=0 AND permission_name=N'SELECT' AND state=N'G') THEN 1 ELSE 0 END"; then
 echo '✗ Разрешите SELECT на журнал именно роли incident_reader'; exit 1
fi
if ! sqlq "EXECUTE AS USER = 'analyst_user'; SELECT TOP (1) incident_id FROM dbo.Incidents;" >/dev/null 2>&1; then
 echo '✗ Аналитик не может читать Incidents'; exit 1
fi
for op in INSERT UPDATE DELETE; do
 if ! is_zero "EXECUTE AS USER = 'analyst_user'; SELECT ISNULL(HAS_PERMS_BY_NAME(N'dbo.Incidents',N'OBJECT',N'$op'),0)"; then
  echo "✗ Аналитику нельзя разрешать $op"; exit 1
 fi
done
is_one "SELECT CASE WHEN (SELECT COUNT(*) FROM dbo.Incidents)=2 THEN 1 ELSE 0 END" || { echo '✗ Данные журнала изменены'; exit 1; }
is_zero "SELECT CASE WHEN IS_ROLEMEMBER(N'db_owner',N'analyst_user')=1 THEN 1 ELSE 0 END" || { echo '✗ Запрещено назначать db_owner'; exit 1; }
echo '✓ Аналитик читает журнал через роль, изменение данных запрещено'
