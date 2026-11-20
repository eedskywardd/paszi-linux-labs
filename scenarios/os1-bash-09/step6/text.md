# 6. Несколько функций в одной программе

Теперь объединим функции и `case`.

Создайте:

```bash
cd /root/bash09/work
nano toolkit.sh
```

Введите:

```bash
#!/usr/bin/env bash

show_user() {
    echo "USER=$(whoami)"
}

show_kernel() {
    echo "KERNEL=$(uname -r)"
}

count_txt() {
    local DIR="$1"
    local COUNT=0

    for FILE in "$DIR"/*.txt; do
        if [ -f "$FILE" ]; then
            COUNT=$((COUNT + 1))
        fi
    done

    echo "TXT_COUNT=$COUNT"
}

ACTION="$1"

case "$ACTION" in
    user)
        show_user
        ;;
    kernel)
        show_kernel
        ;;
    txt)
        count_txt /root/bash09/data
        ;;
    *)
        echo "ERROR=UNKNOWN_ACTION"
        ;;
esac
```

Здесь `case` не выполняет всю работу сам. Он только решает, **какую функцию вызвать**.

Сделайте исполняемым:

```bash
chmod +x toolkit.sh
```

Проверьте:

```bash
./toolkit.sh user
./toolkit.sh kernel
./toolkit.sh txt
./toolkit.sh wrong
```

Для `txt` должно быть:

```text
TXT_COUNT=2
```

Почему 2? Потому что в верхнем уровне `/root/bash09/data` находятся `a.txt` и `b.txt`. Файл `subdir/c.txt` лежит глубже и маска `"$DIR"/*.txt` его не захватывает.

Сохраните:

```bash
./toolkit.sh user > toolkit_user.txt
./toolkit.sh txt > toolkit_txt.txt
```

Нажмите **CHECK**.
