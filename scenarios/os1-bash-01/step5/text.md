# 5. Копирование, перемещение и удаление

## Копирование — `cp`

Скопируйте файл:

```bash
cp /root/bash01/work/docs/notes.txt /root/bash01/work/backup/notes_copy.txt
```

Проверьте:

```bash
cat /root/bash01/work/backup/notes_copy.txt
```

`cp` создаёт копию. Исходный файл остаётся на месте.

## Переименование и перемещение — `mv`

Переименуем `draft.txt`:

```bash
mv /root/bash01/work/temp/draft.txt /root/bash01/work/temp/ready.txt
```

Проверьте:

```bash
ls /root/bash01/work/temp
```

`mv` используется и для перемещения, и для переименования.

## Удаление — `rm`

Удалим специально созданный временный файл, но попросим Linux сначала спросить подтверждение:

```bash
rm -i /root/bash01/work/temp/delete_me.txt
```

Появится вопрос. Введите:

```text
y
```

и нажмите Enter.

Ключ `-i` означает **interactive** — спросить подтверждение перед удалением.

Проверьте:

```bash
ls /root/bash01/work/temp
```

`delete_me.txt` больше быть не должно.

Нажмите **CHECK**.
