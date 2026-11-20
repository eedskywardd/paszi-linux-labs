# 3. `local` и `return`

Функция может создавать свои переменные.

Лучше делать их локальными:

```bash
local FILE="$1"
```

Такая переменная предназначена только для текущей функции.

## Код возврата функции

Функция может вернуть код:

```bash
return 0
```

или:

```bash
return 1
```

Как и раньше:

- `0` — успех;
- ненулевое значение — неуспех.

Создайте:

```bash
cd /root/bash09/work
nano check_function.sh
```

Введите:

```bash
#!/usr/bin/env bash

check_file() {
    local FILE="$1"

    if [ -f "$FILE" ]; then
        return 0
    else
        return 1
    fi
}

check_file /root/bash09/data/a.txt
echo "FIRST=$?"

check_file /root/bash09/data/missing.txt
echo "SECOND=$?"
```

Сделайте исполняемым и запустите:

```bash
chmod +x check_function.sh
./check_function.sh
```

Должно быть:

```text
FIRST=0
SECOND=1
```

Сохраните:

```bash
./check_function.sh > return_codes.txt
```

Нажмите **CHECK**.
