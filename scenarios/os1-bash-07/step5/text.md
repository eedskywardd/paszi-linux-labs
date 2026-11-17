# 5. Первое условие `if / else / fi`

До этого мы проверяли условие вручную:

```bash
[ -f файл ]
echo $?
```

Теперь Bash будет сам выбирать, что делать.

Общая форма:

```bash
if [ условие ]; then
    команда_если_да
else
    команда_если_нет
fi
```

Читается так:

- `if` — если;
- `then` — тогда;
- `else` — иначе;
- `fi` — конец конструкции `if`.

Создайте:

```bash
cd /root/bash07/work
nano typecheck.sh
```

Введите:

```bash
#!/usr/bin/env bash

if [ -f "$1" ]; then
    echo "TYPE=FILE"
else
    echo "TYPE=NOT_FILE"
fi
```

Почему `"$1"` в кавычках?

Потому что путь может содержать пробелы. Кавычки помогают Bash воспринимать его как одно значение.

Сделайте скрипт исполняемым:

```bash
chmod +x typecheck.sh
```

Проверьте существующий файл:

```bash
./typecheck.sh /root/bash07/data/sample.txt
```

Должно быть:

```text
TYPE=FILE
```

Теперь каталог:

```bash
./typecheck.sh /root/bash07/data
```

Получится:

```text
TYPE=NOT_FILE
```

Сохраните оба результата:

```bash
./typecheck.sh /root/bash07/data/sample.txt > type_file.txt
./typecheck.sh /root/bash07/data > type_dir.txt
```

Нажмите **CHECK**.
