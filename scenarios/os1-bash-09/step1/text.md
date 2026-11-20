# 1. Первая функция Bash

Создадим простую функцию:

```bash
hello() {
    echo "Hello from function"
}
```

Разберём:

- `hello` — имя функции;
- `()` — показывает, что это функция;
- `{` и `}` — границы блока команд;
- команды внутри выполняются только при вызове функции.

После объявления вызовите её:

```bash
hello
```

Полный пример:

```bash
hello() {
    echo "Hello from function"
}

hello
```

Теперь создайте скрипт:

```bash
cd /root/bash09/work
nano functions.sh
```

Введите:

```bash
#!/usr/bin/env bash

hello() {
    echo "Hello from function"
}

show_course() {
    echo "COURSE=Operating Systems"
}

hello
show_course
```

Сделайте исполняемым и запустите:

```bash
chmod +x functions.sh
./functions.sh
```

Сохраните вывод:

```bash
./functions.sh > functions_output.txt
```

Должно быть:

```text
Hello from function
COURSE=Operating Systems
```

Нажмите **CHECK**.
