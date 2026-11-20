# 4. `if` внутри `for`: файл или каталог

Цикл может перебирать объекты, а `if` — принимать решение для каждого из них.

Посмотрите содержимое:

```bash
ls /root/bash08/data
```

Там есть и обычные файлы, и каталог `archive`.

Создадим цикл:

```bash
for ITEM in /root/bash08/data/*; do
    if [ -f "$ITEM" ]; then
        echo "FILE=$(basename "$ITEM")"
    elif [ -d "$ITEM" ]; then
        echo "DIR=$(basename "$ITEM")"
    fi
done
```

Здесь появляется `elif`.

Он означает:

> иначе, если выполняется другое условие.

Логика такая:

1. если объект обычный файл — вывести `FILE=`;
2. иначе, если объект каталог — вывести `DIR=`.

Сохраните результат:

```bash
cd /root/bash08/work

for ITEM in /root/bash08/data/*; do
    if [ -f "$ITEM" ]; then
        echo "FILE=$(basename "$ITEM")"
    elif [ -d "$ITEM" ]; then
        echo "DIR=$(basename "$ITEM")"
    fi
done > classified.txt
```

Проверьте:

```bash
cat classified.txt
```

В выводе должна быть строка:

```text
DIR=archive
```

а остальные объекты должны быть отмечены как `FILE=`.

Нажмите **CHECK**.
