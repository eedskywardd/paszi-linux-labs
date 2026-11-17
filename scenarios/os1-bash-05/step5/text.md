# 5. Завершаем свой процесс: `kill`

Команда:

```bash
kill PID
```

по умолчанию отправляет **SIGTERM (15)** — запрос на корректное завершение.

Завершайте только тот `sleep`, который создали сами.

Посмотрите PID:

```bash
cat /root/bash05/work/background_pid.txt
```

Завершите:

```bash
kill $(cat /root/bash05/work/background_pid.txt)
```

Проверьте:

```bash
ps -p $(cat /root/bash05/work/background_pid.txt)
```

Если процесс завершён, строки процесса уже не будет.

Создайте отметку:

```bash
echo "terminated" > /root/bash05/work/process_terminated.txt
```

Нажмите **CHECK**.
