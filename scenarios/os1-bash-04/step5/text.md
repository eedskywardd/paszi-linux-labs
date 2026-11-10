# 5. Диски и файловые системы

## Свободное место: `df -h`

Выполните:

```bash
df -h
```

`df` показывает файловые системы и использование дискового пространства.

Сохраните:

```bash
df -h > /root/bash04/work/disk_free.txt
```

Чтобы посмотреть только файловую систему, где находится корневой каталог `/`:

```bash
df -h /
```

Сохраните отдельно:

```bash
df -h / > /root/bash04/work/root_disk.txt
```

## Блочные устройства: `lsblk`

Выполните:

```bash
lsblk
```

Эта команда показывает диски и разделы как дерево.

Сохраните:

```bash
lsblk > /root/bash04/work/block_devices.txt
```

Проверьте:

```bash
cat /root/bash04/work/root_disk.txt
cat /root/bash04/work/block_devices.txt
```

Нажмите **CHECK**.
