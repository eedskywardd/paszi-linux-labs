# 4. Диагностировать PoE P18

Точка доступа AP-03 перезапускается.

Выполните:

```bash
poe-test P18
load-test P18
```

Создайте:

```bash
nano /root/tfu07a/p18.txt
```

Шаблон:

```text
PD_CLASS=
VOLTAGE_IDLE=
VOLTAGE_LOAD=
DROP=
FAULT=
CAUSE=
```

Числа записывайте без единиц измерения.

После заполнения нажмите **CHECK**.
