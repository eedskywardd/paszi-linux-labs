# 4. Исправить линии и выполнить контроль

Сформируйте итоговый отчёт:

```text
L02=
L03=
L04=
```

Откройте:

```bash
nano /root/tfu02/report.txt
```

Используйте названия:

```text
MISWIRE
REVERSED_PAIR
SPLIT_PAIR
```

После заполнения выполните:

```bash
repair-all
```

Теперь проведите контроль:

```bash
link-status
cable-test L02
cable-test L03
cable-test L04
pair-test L04
```

После ремонта все линии должны быть `UP`, работать на `1000 Mbps` без ошибок, а тесты должны показывать `PASS`.

После этого нажмите **CHECK**.
