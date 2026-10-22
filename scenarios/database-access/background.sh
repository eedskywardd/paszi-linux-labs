#!/usr/bin/env bash
set -Eeuo pipefail
exec > >(tee -a /root/paszi_db_setup.log) 2>&1
trap 'echo "Ошибка подготовки базы. См. /root/paszi_db_setup.log" > /root/PASZI_SETUP_ERROR' ERR
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y -qq postgresql postgresql-client >/dev/null
service postgresql start >/dev/null
for i in $(seq 1 30); do pg_isready -q && break; sleep 1; done
pg_isready -q
runuser -u postgres -- psql -X -v ON_ERROR_STOP=1 <<'SQL'
CREATE ROLE support_agent NOLOGIN;
CREATE ROLE auditor NOLOGIN;
CREATE ROLE trainee NOLOGIN;
CREATE DATABASE paszi_lab;
SQL
runuser -u postgres -- psql -X -v ON_ERROR_STOP=1 -d paszi_lab <<'SQL'
CREATE SCHEMA corp;
CREATE TABLE corp.tickets (ticket_id int PRIMARY KEY,client_id int NOT NULL,status text NOT NULL,description text NOT NULL,internal_note text NOT NULL);
CREATE TABLE corp.clients (client_id int PRIMARY KEY,full_name text NOT NULL,phone text NOT NULL,email text NOT NULL);
CREATE TABLE corp.security_events (event_id int PRIMARY KEY,occurred_at timestamp NOT NULL,event_type text NOT NULL,object_name text NOT NULL);
INSERT INTO corp.tickets VALUES (101,1,'open','Замена оборудования','Внутреннее разбирательство'),(102,2,'in_progress','Проверка связи','Внутренняя записка'),(103,3,'closed','Переустановка ОС','Обсуждение условий');
INSERT INTO corp.clients VALUES (1,'Тестовый клиент А','+7-000-000-01-01','a@example.invalid'),(2,'Тестовый клиент Б','+7-000-000-02-02','b@example.invalid'),(3,'Тестовый клиент В','+7-000-000-03-03','c@example.invalid');
INSERT INTO corp.security_events VALUES (1,'2026-10-20 10:12:00','failed_login','corp.clients'),(2,'2026-10-20 10:13:00','permission_denied','corp.security_events'),(3,'2026-10-20 10:15:00','role_change','support_agent');
GRANT USAGE ON SCHEMA corp TO support_agent,auditor,trainee;
GRANT UPDATE ON corp.tickets TO support_agent;
GRANT SELECT ON corp.clients TO auditor,trainee;
SQL
cat > /root/START_HERE.txt <<'EOF'
ПАСЗИ №16. Вход в PostgreSQL: runuser -u postgres -- psql -d paszi_lab
Внутри psql: \du — роли; \dp corp.* — права; \d corp.tickets — структура; \q — выход.
Запрещено удалять таблицы, подменять данные и выдавать SUPERUSER.
EOF
echo READY > /root/PASZI_DB_READY
