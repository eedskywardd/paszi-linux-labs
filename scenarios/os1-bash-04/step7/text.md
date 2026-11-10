# 7. Самостоятельная мини-задача: системный отчёт

Теперь соберите небольшой отчёт о системе.

Сначала перейдите в рабочий каталог:

```bash
cd /root/bash04/work
pwd
```

Должно быть:

```text
/root/bash04/work
```

Создайте файл:

```text
system_report.txt
```

Он должен содержать **ровно 10 строк** в таком порядке:

```text
USER
<результат whoami>
HOSTNAME
<результат hostname>
KERNEL
<результат uname -r>
ARCH
<результат uname -m>
OS
<строка PRETTY_NAME из /etc/os-release>
```

Например, первая часть строится так:

```bash
echo "USER" > system_report.txt
whoami >> system_report.txt
```

Дальше продолжите самостоятельно по тому же принципу.

### Подсказка

Для последней строки понадобится уже знакомая команда:

```bash
grep "^PRETTY_NAME=" /etc/os-release
```

Когда закончите, проверьте:

```bash
cat system_report.txt
wc -l < system_report.txt
```

Последняя команда должна показать:

```text
10
```

Создайте скрытый файл завершения:

```bash
touch .done
```

После этого нажмите **CHECK**.
