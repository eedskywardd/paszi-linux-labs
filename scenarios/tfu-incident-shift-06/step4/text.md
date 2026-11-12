# 4. Диагностировать оптический uplink F03

Uplink F03 поднят, но имеет большие потери и много ошибок.

Начните с VFL:

```bash
vfl F03
```

Если VFL не даёт точного ответа, измерьте общие потери:

```bash
power-meter F03
```

Затем локализуйте событие:

```bash
otdr F03
```

Создайте:

```bash
nano /root/tfu06/fiber.txt
```

Шаблон:

```text
LOSS_DB=
EVENT_DISTANCE=
CAUSE=
```

После заполнения нажмите **CHECK**.
