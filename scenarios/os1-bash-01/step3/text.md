# 3. Каталоги и файлы: `mkdir`, `touch`

Перейдите в рабочий каталог:

```bash
cd /root/bash01/work
```

Создадим три каталога:

```bash
mkdir docs
mkdir backup
mkdir temp
```

Проверьте:

```bash
ls
```

Должны появиться:

```text
backup  docs  temp
```

Порядок может отличаться — это нормально.

Теперь создадим пустые файлы:

```bash
touch docs/notes.txt
touch temp/draft.txt
touch temp/delete_me.txt
```

`touch` создаёт пустой файл, если такого файла ещё нет.

Посмотрите структуру:

```bash
ls docs
ls temp
```

И подробный список:

```bash
ls -l docs
```

В начале строки обычного файла будет символ `-`, а у каталога в `ls -l` обычно стоит `d`.

Нажмите **CHECK**.
