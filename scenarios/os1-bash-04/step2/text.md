# 2. Ядро и архитектура: `uname`

Оставайтесь в:

```text
/root/bash04/work
```

Если потерялись:

```bash
cd /root/bash04/work
```

Команда `uname` показывает сведения о системе.

## Версия ядра

```bash
uname -r
```

Ключ `-r` означает **release** — версия выпуска ядра.

Сохраните:

```bash
uname -r > kernel.txt
```

## Архитектура

```bash
uname -m
```

Например, можно увидеть:

```text
x86_64
```

Сохраните:

```bash
uname -m > architecture.txt
```

## Все основные сведения сразу

```bash
uname -a
```

Ключ `-a` означает **all** — показать все основные сведения.

Сохраните:

```bash
uname -a > uname_all.txt
```

Проверьте:

```bash
cat kernel.txt
cat architecture.txt
cat uname_all.txt
```

Нажмите **CHECK**.
