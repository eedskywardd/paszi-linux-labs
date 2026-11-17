# 4. Проверяем фоновые задачи: `jobs` и `ps -p`

Фоновые процессы текущей оболочки:

```bash
jobs
```

С PID:

```bash
jobs -l
```

Сохраните список:

```bash
jobs -l > /root/bash05/work/jobs.txt
```

Теперь посмотрите процесс по сохранённому PID:

```bash
ps -p $(cat /root/bash05/work/background_pid.txt) -o pid=,stat=,comm=
```

Сохраните:

```bash
ps -p $(cat /root/bash05/work/background_pid.txt) -o pid=,stat=,comm= > /root/bash05/work/background_status.txt
```

Проверьте:

```bash
cat /root/bash05/work/jobs.txt
cat /root/bash05/work/background_status.txt
```

В `background_status.txt` должно быть имя `sleep`.

Нажмите **CHECK**.
