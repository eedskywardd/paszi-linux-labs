# 3. Ищем файлы командой `find`

Команда `find` ищет объекты в файловой системе.

Перейдите в учебный каталог:

```bash
cd /root/bash03/lab
```

Проверьте:

```bash
pwd
```

## Найти файл по имени

Найдём `server.py`:

```bash
find /root/bash03/lab -type f -name "server.py"
```

Разбор:

- `/root/bash03/lab` — где начинать поиск;
- `-type f` — искать только обычные файлы;
- `-name "server.py"` — искать указанное имя.

Сохраните найденный путь:

```bash
find /root/bash03/lab -type f -name "server.py" > /root/bash03/server_path.txt
```

## Найти все файлы по расширению

Найдём все файлы `.txt`:

```bash
find /root/bash03/lab -type f -name "*.txt"
```

Кавычки вокруг `*.txt` важны: маску должен обработать именно `find`.

Сохраним список в алфавитном порядке:

```bash
find /root/bash03/lab -type f -name "*.txt" | sort > /root/bash03/txt_files.txt
```

Проверьте:

```bash
cat /root/bash03/server_path.txt
cat /root/bash03/txt_files.txt
```

Нажмите **CHECK**.
