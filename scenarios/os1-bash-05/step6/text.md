# 6. Мониторинг: `uptime`, `free` и `top`

## Нагрузка и время работы

```bash
uptime
uptime > /root/bash05/work/uptime.txt
```

## Оперативная память

```bash
free -h
free -h > /root/bash05/work/memory.txt
```

## Однократный снимок top

Обычный `top` открывает интерактивный экран. Чтобы не застрять в нём:

```bash
top -b -n 1 | head -n 15
```

- `-b` — пакетный режим;
- `-n 1` — один снимок;
- `head -n 15` — первые 15 строк.

Сохраните:

```bash
top -b -n 1 | head -n 15 > /root/bash05/work/top_snapshot.txt
```

Проверьте:

```bash
cat /root/bash05/work/top_snapshot.txt
```

Нажмите **CHECK**.
