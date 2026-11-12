# 5. Провести приёмочные измерения

Теперь проверьте объект целиком:

```bash
acceptance-status
```

Затем зафиксируйте контрольные значения:

```bash
load-test P18
power-meter F07
```

Создайте:

```bash
nano /root/tfu07b/acceptance.txt
```

Шаблон:

```text
L11=PASS
L12=PASS
P18_DROP=
F07_LOSS=
```

Числа записывайте без единиц измерения.

После заполнения нажмите **CHECK**.
