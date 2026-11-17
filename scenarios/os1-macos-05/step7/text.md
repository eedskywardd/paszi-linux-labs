# 7. Самостоятельная мини-задача: отчёт о macOS

Теперь соберите итоговый файл без готовой последовательности команд.

Перейдите в рабочий каталог:

```bash
cd /root/os05/work
pwd
```

Должно быть:

```text
/root/os05/work
```

Создайте файл:

```text
macos_report.txt
```

Он должен содержать **ровно 8 строк**:

```text
DESKTOP
Menu Bar
Dock
Finder
SEARCH
Spotlight
SETTINGS
System Settings
```

После этого создайте скрытый файл:

```text
.done
```

## Подсказка 1

Вы уже умеете создавать строки через:

```bash
echo "..." > файл
echo "..." >> файл
```

## Подсказка 2

Первая строка:

```bash
echo "DESKTOP" > macos_report.txt
```

Остальные семь добавьте самостоятельно.

## Проверка перед CHECK

```bash
cat macos_report.txt
wc -l < macos_report.txt
ls -la
```

Количество строк должно быть:

```text
8
```

Когда всё готово — нажмите **CHECK**.
