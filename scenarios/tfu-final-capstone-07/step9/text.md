# 9. Выполнить ремонт и итоговую приёмку

Теперь восстановите все три аварийных сегмента:

```bash
repair L18
repair P07
repair F02
```

После ремонта выполните **контрольные измерения**:

```bash
fault-status
cable-test L18
tdr L18
poe-test P07
load-test P07
vfl F02
power-meter F02
otdr F02
```

Затем запустите итоговую приёмку:

```bash
final-acceptance
```

Если всё исправно, вы должны увидеть:

```text
ACCEPTANCE: PASS
Copper: PASS
PoE: PASS
Fiber: PASS
```

Теперь создайте итоговый акт:

```bash
nano /root/tfu07/final-report.txt
```

Шаблон:

```text
PROJECT=PASS
OPTICAL_BUDGET=PASS
COPPER=RESTORED
POE=RESTORED
FIBER=RESTORED
ACCEPTANCE=PASS
```

После этого нажмите **CHECK**.
