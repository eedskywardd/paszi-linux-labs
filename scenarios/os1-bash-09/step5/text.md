# 5. Первое интерактивное меню

До этого выбор передавался аргументом:

```bash
./actions.sh start
```

Теперь программа сама покажет меню и прочитает ответ пользователя.

Команда:

```bash
read -r CHOICE
```

ждёт ввод строки и сохраняет её в переменную `CHOICE`.

Создайте:

```bash
cd /root/bash09/work
nano menu.sh
```

Введите:

```bash
#!/usr/bin/env bash

echo "1 - Hello"
echo "2 - User"
echo "3 - Exit"
read -r CHOICE

case "$CHOICE" in
    1)
        echo "RESULT=HELLO"
        ;;
    2)
        echo "RESULT=$(whoami)"
        ;;
    3)
        echo "RESULT=EXIT"
        ;;
    *)
        echo "RESULT=UNKNOWN"
        ;;
esac
```

Сделайте исполняемым:

```bash
chmod +x menu.sh
```

Запустите:

```bash
./menu.sh
```

После появления меню введите, например:

```text
1
```

## Как проверить меню без ручного ввода

Можно заранее передать строку через конвейер:

```bash
printf '2\n' | ./menu.sh
```

Это удобно для автоматической проверки.

Сохраните запуск варианта 2:

```bash
printf '2\n' | ./menu.sh > menu_output.txt
```

Проверьте:

```bash
cat menu_output.txt
```

Последняя строка должна быть:

```text
RESULT=root
```

Нажмите **CHECK**.
