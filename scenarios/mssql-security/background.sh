#!/usr/bin/env bash
set -Eeuo pipefail
exec > >(tee -a /root/paszi17_setup.log) 2>&1
trap 'echo "SETUP_FAILED: cat /root/paszi17_setup.log; docker logs paszi17-sqlserver" >/root/PASZI17_ERROR' ERR

# Static lab-only credential. This environment is ephemeral; never use production data.
PASSWORD='PasziLab17!2026aa'
CTR='paszi17-sqlserver'
IMAGE='mcr.microsoft.com/mssql/server:2022-latest'

docker info >/dev/null
ram=$(free -m | awk '/^Mem:/ {print $2}')
if [ "$ram" -lt 3300 ]; then echo 'SQL Server needs the ubuntu-4GB image'; exit 1; fi
docker image inspect "$IMAGE" >/dev/null 2>&1 || docker pull "$IMAGE"
docker rm -f "$CTR" >/dev/null 2>&1 || true
docker run -d --name "$CTR" --memory=3g -e ACCEPT_EULA=Y -e MSSQL_PID=Developer -e "MSSQL_SA_PASSWORD=$PASSWORD" -e MSSQL_MEMORY_LIMIT_MB=2304 "$IMAGE"

CMD='/opt/mssql-tools18/bin/sqlcmd'
if ! docker exec "$CTR" test -x "$CMD"; then CMD='/opt/mssql-tools/bin/sqlcmd'; fi
docker exec "$CTR" test -x "$CMD"

ready=0
for i in $(seq 1 150); do
  if docker exec -e "SQLCMDPASSWORD=$PASSWORD" "$CTR" "$CMD" -S localhost -U sa -C -l 3 -b -Q 'SELECT 1' >/dev/null 2>&1; then ready=1; break; fi
  if [ "$(docker inspect -f '{{.State.Running}}' "$CTR")" != 'true' ]; then
    docker logs --tail=60 "$CTR"; exit 1
  fi
  sleep 2
done
if [ "$ready" != 1 ]; then echo 'SQL Server start timeout'; docker logs --tail=60 "$CTR"; exit 1; fi

cat >/root/paszi17_seed.sql <<'SQL'
CREATE DATABASE [paszi17];
GO
USE [paszi17];
GO
CREATE TABLE dbo.Incidents (incident_id INT PRIMARY KEY, event_name NVARCHAR(100) NOT NULL, severity TINYINT NOT NULL, details NVARCHAR(200) NOT NULL);
CREATE TABLE dbo.Employees (employee_id INT PRIMARY KEY, person_name NVARCHAR(80) NOT NULL, salary INT NOT NULL, contact NVARCHAR(80) NOT NULL);
CREATE TABLE dbo.PolicyBulletin (bulletin_id INT PRIMARY KEY, text_public NVARCHAR(150) NOT NULL);
CREATE TABLE dbo.Tickets (ticket_id INT PRIMARY KEY, status NVARCHAR(40) NOT NULL, summary NVARCHAR(100) NOT NULL, internal_note NVARCHAR(200) NOT NULL);
INSERT INTO dbo.Incidents VALUES (1001,N'Login failure',3,N'Test security incident'), (1002,N'Access attempt',2,N'Test network event');
INSERT INTO dbo.Employees VALUES (1,N'Test Employee A',65000,N'a@example.invalid'), (2,N'Test Employee B',72000,N'b@example.invalid');
INSERT INTO dbo.PolicyBulletin VALUES (1,N'Information security policy bulletin');
INSERT INTO dbo.Tickets VALUES (101,N'open',N'Application failure',N'Private investigation note'), (102,N'closed',N'Move workstation',N'Internal staff note');
GO
CREATE ROLE incident_reader AUTHORIZATION dbo;
CREATE ROLE hr_reader AUTHORIZATION dbo;
CREATE ROLE ticket_reader AUTHORIZATION dbo;
CREATE USER analyst_user WITHOUT LOGIN;
CREATE USER hr_user WITHOUT LOGIN;
CREATE USER intern_user WITHOUT LOGIN;
CREATE USER support_user WITHOUT LOGIN;
ALTER ROLE incident_reader ADD MEMBER analyst_user;
ALTER ROLE hr_reader ADD MEMBER hr_user;
ALTER ROLE ticket_reader ADD MEMBER support_user;
GRANT SELECT ON dbo.Employees TO intern_user;
GRANT SELECT ON dbo.PolicyBulletin TO intern_user;
GRANT SELECT ON dbo.Tickets TO ticket_reader;
GO
SQL
docker cp /root/paszi17_seed.sql "$CTR:/tmp/paszi17_seed.sql"
docker exec -e "SQLCMDPASSWORD=$PASSWORD" "$CTR" "$CMD" -S localhost -U sa -C -b -l 15 -i /tmp/paszi17_seed.sql

cat >/usr/local/bin/sql17 <<'SCRIPT'
#!/usr/bin/env bash
set -euo pipefail
PW='PasziLab17!2026aa'
CTR='paszi17-sqlserver'
CMD='/opt/mssql-tools18/bin/sqlcmd'
if ! docker exec "$CTR" test -x "$CMD"; then CMD='/opt/mssql-tools/bin/sqlcmd'; fi
if [ "$#" -gt 0 ] && [ "$1" = '-Q' ]; then
  shift
  docker exec -i -e "SQLCMDPASSWORD=$PW" "$CTR" "$CMD" -S localhost -U sa -C -d paszi17 -b -l 8 -Q "$*"
else
  docker exec -it -e "SQLCMDPASSWORD=$PW" "$CTR" "$CMD" -S localhost -U sa -C -d paszi17 -l 8
fi
SCRIPT
chmod 755 /usr/local/bin/sql17

cat >/root/paszi17_check.sh <<'SCRIPT'
#!/usr/bin/env bash
set -euo pipefail
PASSWORD='PasziLab17!2026aa'
CTR='paszi17-sqlserver'
CMD='/opt/mssql-tools18/bin/sqlcmd'
if ! docker exec "$CTR" test -x "$CMD"; then CMD='/opt/mssql-tools/bin/sqlcmd'; fi
sqlq() {
  docker exec -e "SQLCMDPASSWORD=$PASSWORD" "$CTR" "$CMD" -S localhost -U sa -C -d paszi17 -b -l 8 -h -1 -W -Q "SET NOCOUNT ON; $1"
}
is_one() { test "$(sqlq "$1" | tr -d '[:space:]')" = '1'; }
is_zero() { test "$(sqlq "$1" | tr -d '[:space:]')" = '0'; }
SCRIPT
chmod 600 /root/paszi17_check.sh
echo READY >/root/PASZI17_READY
echo 'SQL Server ready; start with sql17'
