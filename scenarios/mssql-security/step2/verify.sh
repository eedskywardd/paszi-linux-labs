#!/usr/bin/env bash
set -euo pipefail
[ -f /root/PASZI17_READY ] || { echo '✗ SQL Server ещё не готов'; exit 1; }
source /root/paszi17_check.sh
if ! is_one "SELECT CASE WHEN EXISTS (SELECT 1 FROM sys.database_permissions WHERE grantee_principal_id=DATABASE_PRINCIPAL_ID(N'hr_reader') AND major_id=OBJECT_ID(N'dbo.Employees') AND minor_id=0 AND permission_name=N'SELECT' AND state=N'G') THEN 1 ELSE 0 END"; then
 echo '✗ Кадровые данные должна читать роль hr_reader'; exit 1
fi
if ! sqlq "EXECUTE AS USER = 'hr_user'; SELECT TOP (1) employee_id FROM dbo.Employees;" >/dev/null 2>&1; then
 echo '✗ Кадровик не может читать Employees'; exit 1
fi
if sqlq "EXECUTE AS USER = 'intern_user'; SELECT TOP (1) employee_id FROM dbo.Employees;" >/dev/null 2>&1; then
 echo '✗ Стажёр всё ещё имеет доступ к Employees'; exit 1
fi
if ! is_zero "SELECT CASE WHEN EXISTS (SELECT 1 FROM sys.database_permissions WHERE grantee_principal_id=DATABASE_PRINCIPAL_ID(N'intern_user') AND major_id=OBJECT_ID(N'dbo.Employees') AND permission_name=N'SELECT' AND state=N'G') THEN 1 ELSE 0 END"; then
 echo '✗ Отзовите ранее выданный SELECT у стажёра'; exit 1
fi
if ! sqlq "EXECUTE AS USER = 'intern_user'; SELECT TOP (1) bulletin_id FROM dbo.PolicyBulletin;" >/dev/null 2>&1; then
 echo '✗ Стажёр должен видеть общую политику'; exit 1
fi
for usr in hr_user intern_user; do
 for op in INSERT UPDATE DELETE; do
  if ! is_zero "EXECUTE AS USER = '$usr'; SELECT ISNULL(HAS_PERMS_BY_NAME(N'dbo.Employees',N'OBJECT',N'$op'),0)"; then
   echo "✗ Лишние права $op у $usr"; exit 1
  fi
 done
done
is_one "SELECT CASE WHEN (SELECT COUNT(*) FROM dbo.Employees)=2 THEN 1 ELSE 0 END" || { echo '✗ Кадровые строки изменены'; exit 1; }
echo '✓ Доступ кадровика восстановлен, лишнее право стажёра отозвано'
