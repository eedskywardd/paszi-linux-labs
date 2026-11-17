# 2. Находим собственный Bash-процесс

В Bash переменная:

```text
$$
```

содержит PID текущей оболочки.

Посмотрите PID:

```bash
echo $$
```

Сохраните:

```bash
echo $$ > shell_pid.txt
```

Теперь покажите именно этот процесс:

```bash
ps -p $$ -o pid=,ppid=,comm=
```

Сохраните результат:

```bash
ps -p $$ -o pid=,ppid=,comm= > shell_process.txt
```

Проверьте:

```bash
cat shell_pid.txt
cat shell_process.txt
```

Первое число в `shell_process.txt` должно совпадать с `shell_pid.txt`.

Нажмите **CHECK**.
