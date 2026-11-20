# 7. Самостоятельная мини-задача: `folder_report.sh`

Теперь создайте скрипт, который самостоятельно анализирует содержимое каталога.

## Подготовка

Перейдите в:

```bash
cd /root/bash08/work
```

Создайте каталог `final` и **обязательно войдите в него**:

```bash
mkdir -p final
cd final
pwd
```

Правильный путь:

```text
/root/bash08/work/final
```

## Задача

Создайте скрипт именно **в этом каталоге**:

```bash
nano folder_report.sh
```

Первая строка может быть любой из двух корректных форм:

```bash
#!/usr/bin/env bash
```

или:

```bash
#!/bin/bash
```

После сохранения:

```bash
chmod +x folder_report.sh
```

Запускать файл нужно через:

```bash
./folder_report.sh
```

> Если Bash пишет `command not found` или `No such file or directory`, сначала выполните `pwd`. Для этого этапа вы должны находиться в `/root/bash08/work/final`.

Он должен принимать **один аргумент — путь к каталогу**.

### Если аргумент не передан

```bash
./folder_report.sh
```

должен вывести:

```text
ERROR=NO_ARGUMENT
```

и завершиться через:

```bash
exit 1
```

### Если переданный путь не является каталогом

Например:

```bash
./folder_report.sh /root/bash08/data/alpha.txt
```

должен вывести:

```text
ERROR=NOT_DIRECTORY
```

и завершиться через `exit 1`.

### Если каталог существует

Для:

```bash
./folder_report.sh /root/bash08/data
```

нужно получить **ровно 5 строк**:

```text
DIRECTORY=/root/bash08/data
FILES=8
DIRECTORIES=1
TXT=4
LOG=2
```

## Что должен делать скрипт

1. проверить `$#`;
2. сохранить `$1` в понятную переменную;
3. проверить каталог через `-d`;
4. создать счётчики со значением 0;
5. использовать цикл `for` по `"$DIR"/*`;
6. через `if` определять файл или каталог;
7. для обычных файлов считать общее количество;
8. отдельно считать файлы `*.txt` и `*.log`.

## Подсказка: как проверить окончание имени

Внутри цикла после проверки `-f` можно использовать:

```bash
if [[ "$ITEM" == *.txt ]]; then
    TXT=$((TXT + 1))
fi
```

А для логов:

```bash
if [[ "$ITEM" == *.log ]]; then
    LOG=$((LOG + 1))
fi
```

Конструкция `[[ ... ]]` — расширенная проверка Bash. Здесь она позволяет удобно сравнить имя с маской.

## Сохраните результаты

После создания и `chmod +x folder_report.sh` выполните:

```bash
./folder_report.sh /root/bash08/data > report.txt
```

Также создайте:

```bash
touch .done
```

Проверьте:

```bash
pwd
cat folder_report.sh
cat report.txt
ls -la
```

Первая строка `pwd` должна быть:

```text
/root/bash08/work/final
```

Если вы случайно вернулись в `/root/bash08/work`, вернитесь:

```bash
cd /root/bash08/work/final
```

Только после этого нажмите **CHECK**.
