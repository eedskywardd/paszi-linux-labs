# 2. Переменные окружения

Bash уже получает часть переменных от системы.

Посмотрите:

```bash
echo "$HOME"
echo "$USER"
echo "$SHELL"
echo "$PATH"
```

## Что они означают

- `HOME` — домашний каталог пользователя;
- `USER` — имя пользователя;
- `SHELL` — оболочка;
- `PATH` — каталоги, где система ищет команды.

Все переменные окружения можно увидеть через:

```bash
printenv
```

Найдём несколько конкретных:

```bash
printenv HOME
printenv USER
printenv PATH
```

Сохраните значения:

```bash
echo "HOME=$HOME" > environment.txt
echo "USER=$USER" >> environment.txt
echo "SHELL=$SHELL" >> environment.txt
```

Проверьте:

```bash
cat environment.txt
```

Нажмите **CHECK**.
