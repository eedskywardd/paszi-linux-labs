# 3. Finder — файловый менеджер macOS

Откройте **Finder** в ThanasOS.

Finder выполняет ту же базовую роль, что Проводник в Windows или файловый менеджер в Linux.

Посмотрите на окно Finder.

В нём есть:

- боковая панель навигации;
- основная область содержимого;
- элементы файловой структуры.

Обратите внимание: браузерный симулятор показывает интерфейс Finder, но не является полноценной файловой системой настоящего Mac.

## Задание

Ответьте, за что отвечает Finder и для чего нужна боковая панель.

В терминале:

```bash
cd /root/os05/work
echo "FINDER=files_and_folders" > finder.txt
echo "SIDEBAR=navigation" >> finder.txt
echo "MAIN_AREA=contents" >> finder.txt
```

Проверьте:

```bash
cat finder.txt
```

Нажмите **CHECK**.
