# 4. Подстановка команд: `$(...)`

Иногда значение переменной удобно получить не вручную, а из другой команды.

Например:

```bash
CURRENT_USER=$(whoami)
```

Теперь:

```bash
echo "$CURRENT_USER"
```

покажет имя пользователя.

Создайте ещё:

```bash
CURRENT_HOST=$(hostname)
CURRENT_KERNEL=$(uname -r)
```

Посмотрите:

```bash
echo "$CURRENT_HOST"
echo "$CURRENT_KERNEL"
```

Соберите файл:

```bash
echo "USER=$CURRENT_USER" > command_substitution.txt
echo "HOST=$CURRENT_HOST" >> command_substitution.txt
echo "KERNEL=$CURRENT_KERNEL" >> command_substitution.txt
```

Проверьте:

```bash
cat command_substitution.txt
```

То есть конструкция:

```text
$(команда)
```

сначала выполняет команду, а затем подставляет её вывод.

Нажмите **CHECK**.
