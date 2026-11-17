# 2. Сколько аргументов передано: `$#`

Специальная переменная:

```text
$#
```

содержит **количество аргументов**, переданных скрипту.

Создайте:

```bash
cd /root/bash07/work
nano count_args.sh
```

Введите:

```bash
#!/usr/bin/env bash

echo "COUNT=$#"
echo "FIRST=$1"
```

Сделайте исполняемым:

```bash
chmod +x count_args.sh
```

Запустите с одним аргументом:

```bash
./count_args.sh apple
```

Получится:

```text
COUNT=1
FIRST=apple
```

Теперь с тремя:

```bash
./count_args.sh red green blue
```

Первая строка станет:

```text
COUNT=3
```

То есть `$#` не содержит сами аргументы — только **их количество**.

Сохраните результат запуска с тремя аргументами:

```bash
./count_args.sh red green blue > count_output.txt
```

Проверьте:

```bash
cat count_output.txt
```

Нажмите **CHECK**.
