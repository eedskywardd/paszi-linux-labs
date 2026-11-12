# 5. Диагностировать оптику F07

Здесь Link поднят, но есть ошибки и повышенные потери.

Выполните последовательно:

```bash
vfl F07
power-meter F07
otdr F07
```

Создайте:

```bash
nano /root/tfu07a/f07.txt
```

Шаблон:

```text
VISIBLE_LEAK=
LOSS_DB=
EVENT_DISTANCE=
EVENT_LOSS=
CAUSE=
```

Если VFL не показывает видимую утечку, это **не означает**, что линия исправна.

После заполнения нажмите **CHECK**.
