# 1. Пользователь и имя компьютера

Сначала убедитесь, что вы в рабочем каталоге:

```bash
cd /root/bash04/work
pwd
```

## Кто я?

Команда:

```bash
whoami
```

показывает имя текущего пользователя.

В учебной среде Killercoda это обычно:

```text
root
```

Сохраните результат:

```bash
whoami > user.txt
```

## Более подробная информация о пользователе

```bash
id
```

Команда показывает UID, GID и группы пользователя.

Сохраните результат:

```bash
id > identity.txt
```

## Имя компьютера

```bash
hostname
```

Сохраните:

```bash
hostname > hostname.txt
```

Проверьте:

```bash
cat user.txt
cat identity.txt
cat hostname.txt
```

Нажмите **CHECK**.
