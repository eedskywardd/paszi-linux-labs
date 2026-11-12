# 2. Диагностировать медную линию L07

Для PC-07 отсутствует Link.

Проверьте линию:

```bash
cable-test L07
tdr L07
```

Создайте:

```bash
nano /root/tfu06/copper.txt
```

Шаблон:

```text
FAULT=
CONDUCTOR=
DISTANCE=
```

После заполнения нажмите **CHECK**.
