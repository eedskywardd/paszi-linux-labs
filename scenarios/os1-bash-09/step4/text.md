# 4. Выбор действия через `case`

Если вариантов много, длинная цепочка `if / elif / elif` становится неудобной.

Для выбора по одному значению существует `case`.

Пример:

```bash
ACTION="$1"

case "$ACTION" in
    start)
        echo "ACTION=START"
        ;;
    stop)
        echo "ACTION=STOP"
        ;;
    *)
        echo "ACTION=UNKNOWN"
        ;;
esac
```

Разберём:

- `case "$ACTION" in` — начинаем проверять значение;
- `start)` — ветка для слова start;
- `;;` — конец этой ветки;
- `*)` — любой другой вариант;
- `esac` — конец конструкции case.

Создайте:

```bash
cd /root/bash09/work
nano actions.sh
```

Введите:

```bash
#!/usr/bin/env bash

ACTION="$1"

case "$ACTION" in
    start)
        echo "ACTION=START"
        ;;
    stop)
        echo "ACTION=STOP"
        ;;
    status)
        echo "ACTION=STATUS"
        ;;
    *)
        echo "ACTION=UNKNOWN"
        ;;
esac
```

Сделайте исполняемым:

```bash
chmod +x actions.sh
```

Проверьте:

```bash
./actions.sh start
./actions.sh stop
./actions.sh status
./actions.sh hello
```

Сохраните четыре результата:

```bash
./actions.sh start > action_start.txt
./actions.sh stop > action_stop.txt
./actions.sh status > action_status.txt
./actions.sh hello > action_unknown.txt
```

Нажмите **CHECK**.
