# 6. Что такое `/proc`

В Linux часть системной информации доступна через специальную виртуальную файловую систему:

```text
/proc
```

Это не обычная папка с файлами на диске. Ядро Linux формирует многие данные там прямо во время работы системы.

## Информация о процессоре

Посмотрите начало файла:

```bash
head -n 10 /proc/cpuinfo
```

Сохраните первые 10 строк:

```bash
head -n 10 /proc/cpuinfo > /root/bash04/work/cpuinfo_head.txt
```

## Информация о памяти

```bash
head -n 10 /proc/meminfo
```

Сохраните:

```bash
head -n 10 /proc/meminfo > /root/bash04/work/meminfo_head.txt
```

## Версия ядра через `/proc`

```bash
cat /proc/version
```

Сохраните:

```bash
cat /proc/version > /root/bash04/work/proc_version.txt
```

Проверьте созданные файлы:

```bash
wc -l /root/bash04/work/cpuinfo_head.txt
wc -l /root/bash04/work/meminfo_head.txt
cat /root/bash04/work/proc_version.txt
```

В первых двух случаях должно быть по **10 строк**.

Нажмите **CHECK**.
