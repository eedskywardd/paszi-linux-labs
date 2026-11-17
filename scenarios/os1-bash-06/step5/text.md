# 5. Создаём свои `alias`

Alias — короткое имя для другой команды.

Например:

```bash
alias ll='ls -la'
```

После этого в текущей оболочке можно написать:

```bash
ll
```

и Bash выполнит `ls -la`.

Создадим ещё один:

```bash
alias cwork='cd /root/bash06/work'
```

Посмотрите список:

```bash
alias
```

## Почему alias исчезает после нового терминала?

Команда `alias` меняет текущую оболочку. Чтобы сохранить описание, его обычно записывают в конфигурационный файл оболочки.

Для тренировки создайте свой файл:

```bash
cd /root/bash06/work
echo "alias ll='ls -la'" > aliases.sh
echo "alias cwork='cd /root/bash06/work'" >> aliases.sh
```

Загрузите его:

```bash
source aliases.sh
```

Проверьте:

```bash
alias ll
alias cwork
```

И сохраните список двух alias:

```bash
cat aliases.sh
```

Нажмите **CHECK**.
