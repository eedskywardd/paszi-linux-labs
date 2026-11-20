# 3. Цикл по файлам: `*.txt`

Одна из самых полезных возможностей Bash — обработка сразу группы файлов.

Посмотрите:

```bash
ls /root/bash08/data/*.txt
```

Маска:

```text
*.txt
```

означает:

> все имена, заканчивающиеся на .txt.

Теперь обработаем каждый такой файл циклом:

```bash
for FILE in /root/bash08/data/*.txt; do
    echo "$FILE"
done
```

Переменная `FILE` по очереди получает полный путь каждого найденного файла.

Но иногда нужен только его короткий файл без пути. Для этого есть:

```bash
basename /root/bash08/data/alpha.txt
```

Результат:

```text
alpha.txt
```

Соберите список:

```bash
cd /root/bash08/work

for FILE in /root/bash08/data/*.txt; do
    basename "$FILE"
done > txt_files.txt
```

Проверьте:

```bash
cat txt_files.txt
```

Вы должны увидеть четыре файла:

```text
alpha.txt
beta.txt
names.txt
notes.txt
```

Нажмите **CHECK**.
