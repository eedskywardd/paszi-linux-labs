# 7. Самостоятельная мини-задача: `filecheck.sh`

Теперь создайте первую небольшую утилиту Bash.

## Подготовка

Перейдите в:

```bash
cd /root/bash07/work
```

Создайте каталог:

```text
final
```

и **зайдите внутрь него**.

Проверьте:

```bash
pwd
```

Правильный путь:

```text
/root/bash07/work/final
```

## Создайте `filecheck.sh`

Скрипт должен принимать **один аргумент — путь к файлу**.

Он обязан обработать три ситуации.

---

## Ситуация 1. Аргумент не передан

Запуск:

```bash
./filecheck.sh
```

Вывод:

```text
ERROR=NO_ARGUMENT
```

После этого скрипт должен завершиться командой:

```bash
exit 1
```

Для проверки количества аргументов используйте `$#`.

---

## Ситуация 2. Файл существует

Запуск:

```bash
./filecheck.sh /root/bash07/data/sample.txt
```

Вывод должен быть **ровно таким**:

```text
FILE=/root/bash07/data/sample.txt
STATUS=FOUND
LINES=3
```

Используйте:

- `$1`;
- проверку `-f`;
- `wc -l`.

---

## Ситуация 3. Файл не существует

Запуск:

```bash
./filecheck.sh /root/bash07/data/missing.txt
```

Вывод:

```text
FILE=/root/bash07/data/missing.txt
STATUS=NOT_FOUND
```

---

## Что обязательно должно быть в скрипте

- первая строка `#!/usr/bin/env bash`;
- проверка количества аргументов через `$#`;
- использование первого аргумента `$1`;
- хотя бы одна конструкция `if`;
- проверка файла через `-f`;
- подсчёт строк через `wc -l`;
- `exit 1` при отсутствии аргумента.

После создания:

```bash
chmod +x filecheck.sh
```

## Сохраните результаты трёх тестов

### Без аргумента

```bash
./filecheck.sh > no_argument.txt
```

Так как скрипт должен вернуть код 1, после команды можно проверить:

```bash
echo $?
```

### С существующим файлом

```bash
./filecheck.sh /root/bash07/data/sample.txt > found.txt
```

### С несуществующим файлом

```bash
./filecheck.sh /root/bash07/data/missing.txt > not_found.txt
```

Создайте:

```bash
touch .done
```

## Подсказка 1

Начало проверки аргументов:

```bash
if [ "$#" -eq 0 ]; then
    ...
fi
```

`-eq` означает «равно» для чисел.

## Подсказка 2

После проверки аргументов удобно сохранить:

```bash
FILE="$1"
```

## Подсказка 3

Проверка файла:

```bash
if [ -f "$FILE" ]; then
    ...
else
    ...
fi
```

## Проверка перед CHECK

```bash
pwd
ls -la
cat filecheck.sh
cat no_argument.txt
cat found.txt
cat not_found.txt
```

Когда всё готово — нажмите **CHECK**.
