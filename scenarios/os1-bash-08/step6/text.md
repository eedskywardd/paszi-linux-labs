# 6. Первый скрипт массовой обработки

Теперь оформим цикл как отдельную утилиту.

Создайте:

```bash
cd /root/bash08/work
nano count_txt.sh
```

Введите:

```bash
#!/usr/bin/env bash

DIR="$1"
COUNT=0

for FILE in "$DIR"/*.txt; do
    if [ -f "$FILE" ]; then
        COUNT=$((COUNT + 1))
    fi
done

echo "TXT_COUNT=$COUNT"
```

## Как работает скрипт

### `DIR="$1"`

Первый аргумент — каталог, который нужно проверить.

### `COUNT=0`

До начала цикла найдено 0 файлов.

### `for FILE in "$DIR"/*.txt`

Bash перебирает объекты с расширением `.txt`.

### `if [ -f "$FILE" ]`

Проверяем, что это действительно обычный файл.

### `COUNT=$((COUNT + 1))`

За каждый найденный файл увеличиваем счётчик на 1.

Сделайте скрипт исполняемым:

```bash
chmod +x count_txt.sh
```

Запустите:

```bash
./count_txt.sh /root/bash08/data
```

Должно быть:

```text
TXT_COUNT=4
```

Сохраните:

```bash
./count_txt.sh /root/bash08/data > count_result.txt
```

Нажмите **CHECK**.
