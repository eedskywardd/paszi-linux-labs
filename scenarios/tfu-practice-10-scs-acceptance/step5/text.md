# 5. Проверить маркировку и коммутацию

Проверьте маркировку:

```bash
check-labels
```

Убедитесь, что подписи есть:

- на рабочих линиях;
- на PoE-линиях;
- на оптических магистралях;
- на патч-панели;
- на розетках.

Создайте:

```bash
nano /root/tfu10/labels-check.txt
```

Шаблон:

```text
WORKPLACE_LABELS=
POE_LABELS=
FIBER_LABELS=
PATCH_PANEL_LABELS=
OUTLET_LABELS=
RESULT=
```

Во всех строках используйте `PASS`.

После заполнения нажмите **CHECK**.
