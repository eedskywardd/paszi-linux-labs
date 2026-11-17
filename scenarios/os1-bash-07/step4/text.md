# 4. Проверки `[ ]`: файл или каталог

Bash умеет проверять условия.

Одна из форм записи:

```bash
[ УСЛОВИЕ ]
```

Обратите внимание: **пробелы после `[` и перед `]` обязательны**.

## Проверяем файл

Команда:

```bash
[ -f /root/bash07/data/sample.txt ]
```

означает:

> существует ли обычный файл по этому пути?

Сразу после неё:

```bash
echo $?
```

должно быть `0`, потому что файл существует.

## Проверяем каталог

```bash
[ -d /root/bash07/data ]
echo $?
```

Ключ `-d` означает: существует ли **каталог**.

## Проверяем несуществующий объект

```bash
[ -f /root/bash07/data/missing.txt ]
echo $?
```

Теперь код будет не 0.

Сохраните три результата:

```bash
cd /root/bash07/work

[ -f /root/bash07/data/sample.txt ]
echo $? > file_test.txt

[ -d /root/bash07/data ]
echo $? > dir_test.txt

[ -f /root/bash07/data/missing.txt ]
echo $? > missing_test.txt
```

Проверьте:

```bash
cat file_test.txt
cat dir_test.txt
cat missing_test.txt
```

Должно быть:

```text
0
0
не 0
```

Нажмите **CHECK**.
