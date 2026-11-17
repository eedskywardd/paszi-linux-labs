# 1. Рабочий стол, Menu Bar и Dock

Откройте **ThanasOS**:

https://thanasos.thanas.dev

После загрузки найдите три основных элемента интерфейса.

## Menu Bar

**Menu Bar** — строка меню в верхней части экрана.

В ней находятся:

- меню текущего приложения;
- системные значки;
- часы;
- быстрый доступ к системным функциям.

## Dock

**Dock** располагается в нижней части рабочего стола.

Он используется для:

- запуска приложений;
- переключения между ними;
- отображения запущенных программ.

## Finder

Найдите значок **Finder** в Dock и откройте его.

Finder — основной файловый менеджер macOS.

Теперь вернитесь в терминал Killercoda и запишите ответы:

```bash
cd /root/os05/work
echo "MENU_BAR=top" > interface.txt
echo "DOCK=bottom" >> interface.txt
echo "FINDER=file_browser" >> interface.txt
```

Проверьте:

```bash
cat interface.txt
```

Должно быть:

```text
MENU_BAR=top
DOCK=bottom
FINDER=file_browser
```

Нажмите **CHECK**.
