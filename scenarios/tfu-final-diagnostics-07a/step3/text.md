# 3. Найти скрытый дефект L12

Здесь Link есть, поэтому простой обрыв маловероятен.

Выполните:

```bash
cable-test L12
pair-test L12
```

Создайте:

```bash
nano /root/tfu07a/l12.txt
```

Шаблон:

```text
WIREMAP=
FAULT=
AFFECTED_PAIRS=
```

Для `AFFECTED_PAIRS` запишите пары через запятую в виде:

```text
1-2,3-6
```

После заполнения нажмите **CHECK**.
