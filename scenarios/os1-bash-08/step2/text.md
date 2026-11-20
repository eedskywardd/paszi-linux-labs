# 2. Повторение и счётчик

Цикл может работать не только со словами, но и с числами.

Выполните:

```bash
for N in 1 2 3 4 5; do
    echo "NUMBER=$N"
done
```

Теперь добавим счётчик суммы.

Создайте переменную:

```bash
SUM=0
```

А внутри цикла будем прибавлять текущее число:

```bash
SUM=0

for N in 1 2 3 4 5; do
    SUM=$((SUM + N))
done

echo "SUM=$SUM"
```

Конструкция:

```text
$(( ... ))
```

используется для арифметики в Bash.

В нашем случае:

```text
SUM=$((SUM + N))
```

означает:

> взять старое значение SUM, прибавить N и сохранить результат обратно в SUM.

Сохраните два результата:

```bash
for N in 1 2 3 4 5; do
    echo "NUMBER=$N"
done > numbers.txt
```

Затем:

```bash
SUM=0
for N in 1 2 3 4 5; do
    SUM=$((SUM + N))
done
echo "SUM=$SUM" > sum.txt
```

Проверьте:

```bash
cat numbers.txt
cat sum.txt
```

В `sum.txt` должно быть:

```text
SUM=15
```

Нажмите **CHECK**.
