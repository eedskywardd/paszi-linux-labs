# 6. Первый исполняемый Bash-скрипт

Скрипт — обычный текстовый файл с последовательностью команд.

Создадим:

```bash
cd /root/bash06/work
nano hello.sh
```

В редакторе напишите:

```bash
#!/usr/bin/env bash

NAME="Student"
echo "Hello, $NAME!"
echo "User: $(whoami)"
echo "Host: $(hostname)"
```

Сохранение в nano:

- **Ctrl+O** — записать файл;
- Enter — подтвердить имя;
- **Ctrl+X** — выйти.

Посмотрите файл:

```bash
cat hello.sh
```

Сначала попробуйте:

```bash
./hello.sh
```

Если Bash сообщает `Permission denied`, это нормально: файл ещё не исполняемый.

Добавьте право:

```bash
chmod +x hello.sh
```

Проверьте:

```bash
ls -l hello.sh
```

Запустите:

```bash
./hello.sh
```

Сохраните вывод:

```bash
./hello.sh > hello_output.txt
```

Нажмите **CHECK**.
