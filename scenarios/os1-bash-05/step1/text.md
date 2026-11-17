# 1. Что такое процесс: `ps`, PID и PPID

Перейдите в рабочий каталог:

```bash
cd /root/bash05/work
```

Команда `ps` показывает процессы текущего терминала:

```bash
ps
```

Для более понятного вывода:

```bash
ps -eo pid,ppid,comm
```

- `pid` — номер процесса;
- `ppid` — номер родительского процесса;
- `comm` — имя команды.

Сохраните снимок:

```bash
ps -eo pid,ppid,comm > process_list.txt
```

Посмотрите начало:

```bash
head -n 10 process_list.txt
```

Первая строка должна содержать заголовки PID, PPID и COMMAND.

Нажмите **CHECK**.
