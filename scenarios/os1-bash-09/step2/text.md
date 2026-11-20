# 2. Аргументы функции

Функции тоже могут получать аргументы.

Создадим:

```bash
greet() {
    echo "Hello, $1"
}
```

Вызов:

```bash
greet Ivan
```

даст:

```text
Hello, Ivan
```

Важно: внутри функции `$1` означает **первый аргумент именно этой функции**.

Создайте:

```bash
cd /root/bash09/work
nano function_args.sh
```

Введите:

```bash
#!/usr/bin/env bash

describe() {
    echo "NAME=$1"
    echo "ROLE=$2"
}

describe Anna student
```

Сделайте исполняемым:

```bash
chmod +x function_args.sh
```

Запустите:

```bash
./function_args.sh
```

Сохраните:

```bash
./function_args.sh > function_args.txt
```

Должно быть:

```text
NAME=Anna
ROLE=student
```

Нажмите **CHECK**.
