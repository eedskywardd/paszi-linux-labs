# 5. Меняем права буквами: `chmod`

Оставайтесь в каталоге:

```text
/root/bash03/lab/permissions
```

Если вы не уверены:

```bash
cd /root/bash03/lab/permissions
pwd
```

Команда `chmod` изменяет права доступа.

Обозначения пользователей:

- `u` — user, владелец;
- `g` — group, группа;
- `o` — others, остальные.

Действия:

- `+` — добавить право;
- `-` — убрать право.

## Добавляем владельцу право выполнения

```bash
chmod u+x run.sh
```

## Убираем чтение у остальных

```bash
chmod o-r readme.txt
```

## Добавляем группе право записи

```bash
chmod g+w private.txt
```

Посмотрите результат:

```bash
ls -l
```

А теперь выведите права числами:

```bash
stat -c "%a %n" run.sh readme.txt private.txt
```

После этих команд должно быть:

```text
744 run.sh
640 readme.txt
660 private.txt
```

Нажмите **CHECK**.
