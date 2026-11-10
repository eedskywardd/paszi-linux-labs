# 6. Оформить общий диагноз и восстановить линии

Сначала восстановите медную линию:

```bash
repair-copper L03
```

Теперь оформите итоговый отчёт по оптике:

```bash
nano /root/tfu04/report.txt
```

Шаблон:

```text
FIBER=
LOSS_DB=
EVENT_DISTANCE=
FAULT=
```

После заполнения выполните:

```bash
repair-fiber F01
```

Теперь проведите **полную контрольную проверку**:

```bash
link-status
cable-test L03
tdr L03
vfl F01
power-meter F01
otdr F01
```

В исправном состоянии:

- L03 должна быть `UP / 1000 Mbps`;
- cable-test должен показать `PASS`;
- TDR — без дефектов;
- VFL — без видимой утечки;
- Power Meter — потери 2.3 dB;
- OTDR — `PASS`.

После этого нажмите **CHECK**.
