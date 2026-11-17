# 1. Переменные Bash

Переменная позволяет сохранить значение под именем.

Создайте:

```bash
COURSE="Operating Systems"
LESSON=6
```

> В Bash вокруг знака `=` **не ставят пробелы**.

Посмотрите значения:

```bash
echo "$COURSE"
echo "$LESSON"
```

Символ `$` означает: взять значение переменной.

Теперь создайте ещё одну переменную:

```bash
TOPIC="Bash variables"
```

Сохраните отчёт:

```bash
echo "COURSE=$COURSE" > variables.txt
echo "LESSON=$LESSON" >> variables.txt
echo "TOPIC=$TOPIC" >> variables.txt
```

Проверьте:

```bash
cat variables.txt
```

Должно быть:

```text
COURSE=Operating Systems
LESSON=6
TOPIC=Bash variables
```

Нажмите **CHECK**.
