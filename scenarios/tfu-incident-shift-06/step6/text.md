# 6. Восстановить объект и оформить акт

Теперь выполните ремонт трёх сегментов:

```bash
repair L07
repair P12
repair F03
```

После ремонта проведите контроль:

```bash
shift-status
cable-test L07
tdr L07
poe-test P12
load-test P12
power-meter F03
otdr F03
```

Затем создайте итоговый акт:

```bash
nano /root/tfu06/final-report.txt
```

Шаблон:

```text
COPPER=RESTORED
POE=RESTORED
FIBER=RESTORED
FINAL_STATUS=OK
```

Когда всё заполнено, нажмите **CHECK**.
