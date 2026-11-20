# 1. Первый цикл `for`

Цикл `for` повторяет набор команд для нескольких значений.

Пример:

```bash
for COLOR in red green blue; do
    echo "COLOR=$COLOR"
done
```

Разберём по частям:

- `for` — начало цикла;
- `COLOR` — переменная цикла;
- `in red green blue` — значения, которые она получит по очереди;
- `do` — начало повторяемых команд;
- `$COLOR` — текущее значение;
- `done` — конец цикла.

То есть Bash выполнит `echo` три раза.

Попробуйте:

```bash
cd /root/bash08/work

for COLOR in red green blue; do
    echo "COLOR=$COLOR"
done
```

Должно получиться:

```text
COLOR=red
COLOR=green
COLOR=blue
```

Теперь сохраните вывод:

```bash
for COLOR in red green blue; do
    echo "COLOR=$COLOR"
done > colors.txt
```

Проверьте:

```bash
cat colors.txt
```

Нажмите **CHECK**.
