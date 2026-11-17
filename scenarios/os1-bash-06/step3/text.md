# 3. `export`: передаём переменную дочернему процессу

Обычная переменная существует в текущем Bash.

Создайте:

```bash
LAB_NAME="OS06"
```

Проверьте:

```bash
echo "$LAB_NAME"
```

Теперь запустим новый Bash и попросим его показать переменную:

```bash
bash -c 'echo "$LAB_NAME"'
```

Скорее всего строка будет пустой: новый процесс не получил обычную переменную.

Теперь экспортируйте её:

```bash
export LAB_NAME
```

И повторите:

```bash
bash -c 'echo "$LAB_NAME"'
```

Теперь должно появиться:

```text
OS06
```

Сохраните результат дочернего Bash:

```bash
bash -c 'echo "$LAB_NAME"' > exported.txt
```

Также можно создать и экспортировать переменную одной командой:

```bash
export STUDENT_LEVEL="beginner"
```

Сохраните:

```bash
bash -c 'echo "$STUDENT_LEVEL"' > level.txt
```

Нажмите **CHECK**.
