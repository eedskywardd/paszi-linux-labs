#!/usr/bin/env bash
set -euo pipefail
[ -f /root/PASZI17_READY ] || { echo '✗ SQL Server ещё не готов'; exit 1; }
source /root/paszi17_check.sh
if ! is_zero "SELECT CASE WHEN EXISTS (SELECT 1 FROM sys.database_permissions WHERE grantee_principal_id=DATABASE_PRINCIPAL_ID(N'ticket_reader') AND major_id=OBJECT_ID(N'dbo.Tickets') AND minor_id=0 AND permission_name=N'SELECT' AND state=N'G') THEN 1 ELSE 0 END"; then
 echo '✗ У ticket_reader осталось общее право SELECT на всю таблицу'; exit 1
fi
if ! is_one "SELECT CASE WHEN (SELECT COUNT(DISTINCT minor_id) FROM sys.database_permissions WHERE grantee_principal_id=DATABASE_PRINCIPAL_ID(N'ticket_reader') AND major_id=OBJECT_ID(N'dbo.Tickets') AND minor_id IN (COLUMNPROPERTY(OBJECT_ID(N'dbo.Tickets'),N'ticket_id','ColumnId'), COLUMNPROPERTY(OBJECT_ID(N'dbo.Tickets'),N'status','ColumnId'), COLUMNPROPERTY(OBJECT_ID(N'dbo.Tickets'),N'summary','ColumnId')) AND permission_name=N'SELECT' AND state=N'G')=3 THEN 1 ELSE 0 END"; then
 echo '✗ Выдайте SELECT роли ticket_reader на три разрешённых столбца'; exit 1
fi
if ! sqlq "EXECUTE AS USER = 'support_user'; SELECT TOP (1) ticket_id,status,summary FROM dbo.Tickets;" >/dev/null 2>&1; then
 echo '✗ Поддержка не может читать все разрешённые столбцы'; exit 1
fi
if sqlq "EXECUTE AS USER = 'support_user'; SELECT TOP (1) internal_note FROM dbo.Tickets;" >/dev/null 2>&1; then
 echo '✗ Закрытый столбец internal_note доступен'; exit 1
fi
if sqlq "EXECUTE AS USER = 'support_user'; SELECT TOP (1) * FROM dbo.Tickets;" >/dev/null 2>&1; then
 echo '✗ Поддержка всё ещё может читать всю таблицу'; exit 1
fi
for op in INSERT UPDATE DELETE; do
 if ! is_zero "EXECUTE AS USER = 'support_user'; SELECT ISNULL(HAS_PERMS_BY_NAME(N'dbo.Tickets',N'OBJECT',N'$op'),0)"; then
  echo "✗ Лишнее право $op на Tickets"; exit 1
 fi
done
is_one "SELECT CASE WHEN (SELECT COUNT(*) FROM dbo.Tickets)=2 THEN 1 ELSE 0 END" || { echo '✗ Исходные заявки изменены'; exit 1; }
echo '✓ Все три технических этапа выполнены; сделайте скриншот финального экрана'
