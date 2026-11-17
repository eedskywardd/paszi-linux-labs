# 7. Самостоятельная мини-задача: контроль процесса

Самостоятельно пройдите полный цикл жизни учебного процесса.

Перейдите в:

```bash
cd /root/bash05/work
```

Создайте каталог `final` и **зайдите внутрь него**.

Правильный путь:

```text
/root/bash05/work/final
```

Дальше:

1. запустите в фоне `sleep 400`;
2. сохраните его PID в `worker.pid`;
3. через `ps -p` создайте `worker_status.txt`, где будут PID, состояние и имя команды;
4. завершите этот же процесс через `kill`;
5. создайте `terminated.txt` с единственной строкой `DONE`;
6. создайте скрытый файл `.done`.

## Подсказка 1

```bash
sleep 400 &
echo $! > worker.pid
```

## Подсказка 2

```bash
ps -p $(cat worker.pid) -o pid=,stat=,comm=
```

## Проверка перед CHECK

```bash
pwd
cat worker.pid
cat worker_status.txt
cat terminated.txt
ls -la
```

Нажмите **CHECK**.
