# 3. Какой установлен Linux?

Название дистрибутива обычно хранится в файле:

```text
/etc/os-release
```

Посмотрите его:

```bash
cat /etc/os-release
```

Там есть строки вроде:

```text
NAME="Ubuntu"
VERSION="..."
PRETTY_NAME="Ubuntu ..."
```

Нас интересует строка `PRETTY_NAME`.

Вы уже знаете `grep`, поэтому найдите её:

```bash
grep "^PRETTY_NAME=" /etc/os-release
```

Символ `^` означает: строка должна **начинаться** с `PRETTY_NAME=`.

Сохраните результат:

```bash
grep "^PRETTY_NAME=" /etc/os-release > /root/bash04/work/os_name.txt
```

Сохраните весь файл тоже:

```bash
cat /etc/os-release > /root/bash04/work/os_release.txt
```

Проверьте:

```bash
cat /root/bash04/work/os_name.txt
```

Нажмите **CHECK**.
