# 4. Читаем права доступа

Перейдите в каталог:

```bash
cd /root/bash03/lab/permissions
pwd
```

Должно быть:

```text
/root/bash03/lab/permissions
```

Посмотрите подробный список:

```bash
ls -l
```

Вы увидите строки примерно такого вида:

```text
-rw-r--r-- ... readme.txt
-rw-r--r-- ... run.sh
-rw-r----- ... private.txt
```

Первые десять символов описывают тип объекта и права.

Например:

```text
-rw-r--r--
```

Разбирается так:

```text
-   rw-   r--   r--
│    │     │     └─ остальные пользователи
│    │     └─────── группа
│    └───────────── владелец
└────────────────── обычный файл
```

Буквы:

- `r` — read — чтение;
- `w` — write — запись;
- `x` — execute — выполнение;
- `-` — права нет.

Сохраним текущие права в учебный отчёт:

```bash
stat -c "%A %n" readme.txt run.sh private.txt > /root/bash03/permissions_before.txt
```

Проверьте:

```bash
cat /root/bash03/permissions_before.txt
```

Нажмите **CHECK**.
