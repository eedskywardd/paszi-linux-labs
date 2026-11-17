# 6. Скрипт проверяет файл и считает строки

Теперь объединим несколько уже знакомых вещей:

- аргумент `$1`;
- проверку `-f`;
- `if`;
- `wc -l`;
- подстановку команд `$(...)`.

Создайте:

```bash
cd /root/bash07/work
nano check_lines.sh
```

Введите:

```bash
#!/usr/bin/env bash

FILE="$1"

if [ -f "$FILE" ]; then
    LINES=$(wc -l < "$FILE")
    echo "STATUS=FOUND"
    echo "LINES=$LINES"
else
    echo "STATUS=NOT_FOUND"
fi
```

Разберём новые строки.

### `FILE="$1"`

Мы копируем первый аргумент в переменную с понятным именем `FILE`.

### `LINES=$(wc -l < "$FILE")`

1. `wc -l` считает строки;
2. `< "$FILE"` передаёт содержимое файла команде;
3. `$(...)` берёт результат;
4. результат сохраняется в `LINES`.

Сделайте исполняемым:

```bash
chmod +x check_lines.sh
```

Запустите:

```bash
./check_lines.sh /root/bash07/data/sample.txt
```

Должно быть:

```text
STATUS=FOUND
LINES=3
```

Проверьте отсутствующий файл:

```bash
./check_lines.sh /root/bash07/data/missing.txt
```

Должно быть:

```text
STATUS=NOT_FOUND
```

Сохраните оба запуска:

```bash
./check_lines.sh /root/bash07/data/sample.txt > found_output.txt
./check_lines.sh /root/bash07/data/missing.txt > missing_output.txt
```

Нажмите **CHECK**.
