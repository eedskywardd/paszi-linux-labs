# 6. Проверить запас портов и соответствие спецификации

Проверьте фактическую ёмкость:

```bash
check-capacity
```

Затем проверьте наличие проектной документации:

```bash
check-docs
```

Создайте:

```bash
nano /root/tfu10/capacity-docs.txt
```

Шаблон:

```text
ACTIVE_PORTS=
INSTALLED_PORTS=
MIN_WITH_RESERVE=
FREE_PORTS=
RESERVE_OK=
BOM=
PASSPORT=
DOCUMENTATION_RESULT=
```

Для логических полей используйте `YES` или `PASS`.

После заполнения нажмите **CHECK**.
