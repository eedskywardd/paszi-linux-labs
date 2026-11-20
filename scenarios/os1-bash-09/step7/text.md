# 7. Самостоятельная мини-задача: `sysmenu.sh`

Теперь создайте небольшую консольную программу.

## Подготовка

Перейдите:

```bash
cd /root/bash09/work
```

Создайте каталог `final` и войдите в него.

Проверьте:

```bash
pwd
```

Должно быть:

```text
/root/bash09/work/final
```

Создайте файл **именно с таким именем**:

```bash
nano sysmenu.sh
```

Имя должно быть ровно:

```text
sysmenu.sh
```

> Не `systemenu.sh`, не `systemmenu.sh` и не `sys_menu.sh`. Все команды ниже и CHECK работают с файлом `sysmenu.sh`.

После сохранения сделайте его исполняемым:

```bash
chmod +x sysmenu.sh
```

## Требования

В скрипте должны быть **минимум три функции**:

```text
show_system
count_files
show_user
```

### Функция `show_system`

Должна вывести:

```text
HOST=<имя компьютера>
KERNEL=<версия ядра>
```

Используйте `hostname` и `uname -r`.

### Функция `count_files`

Должна посчитать обычные файлы верхнего уровня:

```text
/root/bash09/data
```

и вывести:

```text
FILES=4
```

В каталоге верхнего уровня находятся четыре обычных файла:

- a.txt
- b.txt
- app.log
- app.conf

Каталог `subdir` считать как файл нельзя.

Используйте цикл `for` и проверку `-f`.

### Функция `show_user`

Должна вывести:

```text
USER=<текущий пользователь>
```

## Меню

При запуске скрипт должен сначала вывести:

```text
1 - System
2 - Files
3 - User
```

Затем прочитать выбор через `read`.

После этого `case` должен вызвать нужную функцию.

### Выбор 1

```bash
printf '1\n' | ./sysmenu.sh
```

Последние строки:

```text
HOST=<имя компьютера>
KERNEL=<версия ядра>
```

### Выбор 2

Последняя строка:

```text
FILES=4
```

### Выбор 3

Последняя строка:

```text
USER=<текущий пользователь>
```

### Любое другое значение

Например 9:

```text
ERROR=UNKNOWN_CHOICE
```

## Обязательно

В `sysmenu.sh` должны использоваться:

- функции;
- `local` хотя бы в функции подсчёта файлов;
- цикл `for`;
- `if`;
- `read`;
- `case`;
- `hostname`;
- `uname -r`;
- `whoami`.

## Сохраните четыре теста

```bash
printf '1\n' | ./sysmenu.sh > system.txt
printf '2\n' | ./sysmenu.sh > files.txt
printf '3\n' | ./sysmenu.sh > user.txt
printf '9\n' | ./sysmenu.sh > unknown.txt
```

Создайте:

```bash
touch .done
```

Проверьте:

```bash
cat system.txt
cat files.txt
cat user.txt
cat unknown.txt
ls -la
```

Нажмите **CHECK**.
