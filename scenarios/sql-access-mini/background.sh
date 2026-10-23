#!/usr/bin/env bash
set -Eeuo pipefail
exec > >(tee -a /root/paszi_mini_setup.log) 2>&1
trap 'echo "FAILED: см. /root/paszi_mini_setup.log" > /root/PASZI_MINI_ERROR' ERR
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y -qq postgresql postgresql-client >/dev/null
service postgresql start >/dev/null
for i in $(seq 1 30); do pg_isready -q && break; sleep 1; done
pg_isready -q
runuser -u postgres -- psql -X -v ON_ERROR_STOP=1 <<'SQL'
CREATE ROLE seller NOLOGIN;
CREATE ROLE checker NOLOGIN;
CREATE DATABASE paszi_mini;
SQL
runuser -u postgres -- psql -X -v ON_ERROR_STOP=1 -d paszi_mini <<'SQL'
CREATE SCHEMA training;
CREATE TABLE training.products (id int PRIMARY KEY, title text NOT NULL, price int NOT NULL);
CREATE TABLE training.orders (id int PRIMARY KEY, product_id int NOT NULL, quantity int NOT NULL);
INSERT INTO training.products VALUES (1,'Тестовый роутер',2000),(2,'Учебный коммутатор',3500),(3,'Тестовый кабель',100);
INSERT INTO training.orders VALUES (101,1,2),(102,3,5);
GRANT USAGE ON SCHEMA training TO seller,checker;
GRANT SELECT ON training.orders TO seller;
SQL
cat > /root/PASZI_MINI_START.txt <<'EOF'
МИНИ-ПРАКТИКУМ ПО ПАСЗИ
Статус: cat /root/PASZI_MINI_READY
Подключение: runuser -u postgres -- psql -d paszi_mini
Внутри psql:
  \du               список ролей
  \dt training.*    таблицы
  \d training.products структура
  \dp training.*    права
  \q                выход
Задания выполняются SQL-командами внутри psql.
НЕ удаляйте таблицы/роли. НЕ выдавайте SUPERUSER.
EOF
echo READY > /root/PASZI_MINI_READY
