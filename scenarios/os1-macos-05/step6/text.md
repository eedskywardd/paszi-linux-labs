# 6. Системные пути и назначение элементов

Теперь закрепим логику интерфейса.

Ниже перечислены ситуации. Определите, куда пользователь macOS должен обратиться.

### Ситуация 1

Нужно открыть файлы и каталоги.

Ответ: **Finder**.

### Ситуация 2

Нужно быстро найти приложение.

Ответ: **Spotlight**.

### Ситуация 3

Нужно изменить внешний вид системы.

Ответ: **System Settings → Appearance**.

### Ситуация 4

Нужно управлять пользователями компьютера.

Ответ: **System Settings → Users & Groups**.

### Ситуация 5

Нужно получить быстрый доступ к Wi-Fi, Bluetooth и звуку.

Ответ: **Control Center**.

Запишите ответы в файл:

```bash
cd /root/os05/work
echo "FILES=Finder" > routes.txt
echo "SEARCH=Spotlight" >> routes.txt
echo "APPEARANCE=System Settings > Appearance" >> routes.txt
echo "USERS=System Settings > Users & Groups" >> routes.txt
echo "QUICK_SETTINGS=Control Center" >> routes.txt
```

Проверьте:

```bash
cat routes.txt
```

Нажмите **CHECK**.
