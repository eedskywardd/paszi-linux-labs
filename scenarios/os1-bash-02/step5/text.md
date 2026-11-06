# 5. Конвейер `|`: соединяем команды

Конвейер нужен, когда результат одной команды должен стать входными данными другой.

## Сколько ошибок в журнале?

Можно сначала создать файл, а потом считать его строки:

```bash
grep "ERROR" app.log > temp_errors.txt
wc -l temp_errors.txt
```

Но промежуточный файл не обязателен:

```bash
grep "ERROR" app.log | wc -l
```

Результат должен быть:

```text
3
```

Сохраните только число:

```bash
grep "ERROR" app.log | wc -l > error_count.txt
```

## Две последние информационные записи

```bash
grep "INFO" app.log | tail -n 2
```

Сохраните:

```bash
grep "INFO" app.log | tail -n 2 > last_info.txt
```

## Сколько разных пользователей?

```bash
sort users.txt | uniq | wc -l
```

Сохраните:

```bash
sort users.txt | uniq | wc -l > unique_count.txt
```

Здесь уже **три команды** соединены двумя конвейерами.

Проверьте:

```bash
cat error_count.txt
cat last_info.txt
cat unique_count.txt
```

Нажмите **CHECK**.
