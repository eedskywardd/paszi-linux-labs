# 2. Диагностировать обрыв L11

Выполните:

```bash
cable-test L11
tdr L11
```

Создайте файл:

```bash
nano /root/tfu07a/l11.txt
```

Шаблон:

```text
FAULT=
CONDUCTOR=
DISTANCE=
```

Подсказка:

- `FAULT` — тип неисправности;
- `CONDUCTOR` — **номер жилы**;
- `DISTANCE` — расстояние до дефекта, только число.

После заполнения нажмите **CHECK**.
