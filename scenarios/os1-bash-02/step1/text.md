# 1. Первые и последние строки: `head`, `tail`, `wc`

Перейдите в каталог работы:

```bash
cd /root/bash02
```

Посмотрите журнал целиком:

```bash
cat app.log
```

В нём 10 событий. На настоящем сервере журнал может содержать тысячи строк, поэтому `cat` не всегда удобен.

## `head` — начало файла

```bash
head -n 3 app.log
```

- `head` — показать начало;
- `-n 3` — показать 3 строки;
- `app.log` — файл.

Сохраните эти три строки:

```bash
head -n 3 app.log > head3.txt
```

## `tail` — конец файла

```bash
tail -n 2 app.log
```

Сохраните две последние строки:

```bash
tail -n 2 app.log > tail2.txt
```

## `wc -l` — количество строк

```bash
wc -l app.log
```

Должно быть **10** строк.

Сохраните результат:

```bash
wc -l app.log > linecount.txt
```

Проверьте созданные файлы:

```bash
cat head3.txt
cat tail2.txt
cat linecount.txt
```

Нажмите **CHECK**.
