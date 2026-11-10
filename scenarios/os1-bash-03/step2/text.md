# 2. `.`, `..` и `~`

Сначала вернитесь в каталог сайта:

```bash
cd /root/bash03/lab/projects/site
pwd
```

Сейчас вы должны находиться здесь:

```text
/root/bash03/lab/projects/site
```

## `..` — каталог уровнем выше

Выполните:

```bash
cd ..
pwd
```

Теперь вы в:

```text
/root/bash03/lab/projects
```

Сохраните этот путь:

```bash
pwd > /root/bash03/parent_path.txt
```

## `.` — текущий каталог

Команда:

```bash
cd ./site
```

означает: «из текущего каталога перейти в его подкаталог `site`».

## Переходим на несколько уровней

Сейчас вы снова в `site`.

Выполните:

```bash
cd ../../notes
pwd
```

Почему два раза `..`?

- первый `..` поднимает из `site` в `projects`;
- второй `..` — из `projects` в `lab`;
- затем `notes` переводит в нужный каталог.

Сохраните путь:

```bash
pwd > /root/bash03/notes_path.txt
```

## `~` — домашний каталог

Выполните:

```bash
cd ~
pwd
```

Для пользователя root домашний каталог:

```text
/root
```

Сохраните его:

```bash
pwd > /root/bash03/home_path.txt
```

Нажмите **CHECK**.
