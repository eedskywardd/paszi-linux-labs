# 5. `while read`: читаем файл построчно

`for` удобен для списка объектов.

А если нужно читать текстовый файл **строка за строкой**, часто используют:

```bash
while read -r NAME; do
    echo "USER=$NAME"
done < /root/bash08/data/names.txt
```

Разберём:

- `while` — повторять, пока можно прочитать очередную строку;
- `read` — прочитать строку;
- `-r` — не обрабатывать обратные слэши как специальные символы;
- `NAME` — переменная, куда попадёт строка;
- `done < файл` — брать входные строки из указанного файла.

Посмотрите исходный файл:

```bash
cat /root/bash08/data/names.txt
```

В нём:

```text
Anna
Boris
Carol
```

Теперь сохраните обработанный результат:

```bash
cd /root/bash08/work

while read -r NAME; do
    echo "USER=$NAME"
done < /root/bash08/data/names.txt > users.txt
```

Проверьте:

```bash
cat users.txt
```

Должно быть:

```text
USER=Anna
USER=Boris
USER=Carol
```

Нажмите **CHECK**.
