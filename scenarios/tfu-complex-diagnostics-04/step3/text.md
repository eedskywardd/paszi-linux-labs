# 3. Проверить оптическую линию с помощью VFL

Перейдите к оптическому сегменту F01.

Запустите:

```bash
vfl F01
```

Ответьте себе на два вопроса:

1. Есть ли оптическая непрерывность?
2. Видна ли утечка красного света?

Запишите результат в файл:

```text
CONTINUITY=
VISIBLE_LEAK=
LOCATION=
```

Создайте его:

```bash
nano /root/tfu04/vfl.txt
```

Для `CONTINUITY` и `VISIBLE_LEAK` используйте значения из вывода прибора.

Для `LOCATION` можно записать место **как в выводе VFL**:

```text
LOCATION=rack B / patch-cord bend
```

Также CHECK примет вариант без пробелов:

```text
LOCATION=rack_B_patch-cord_bend
```

После этого нажмите **CHECK**.
