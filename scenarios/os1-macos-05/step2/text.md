# 2. Окна macOS и три кнопки управления

В ThanasOS откройте Finder, Settings или Calculator.

В левом верхнем углу окна вы увидите три цветные кнопки.

## Красная

Закрывает окно.

## Жёлтая

Сворачивает окно.

## Зелёная

Разворачивает окно.

Попробуйте:

1. свернуть одно окно жёлтой кнопкой;
2. снова открыть его через Dock;
3. развернуть зелёной кнопкой;
4. вернуть окно обратно;
5. закрыть красной кнопкой.

После этого зафиксируйте назначение кнопок:

```bash
cd /root/os05/work
echo "RED=close" > window_controls.txt
echo "YELLOW=minimize" >> window_controls.txt
echo "GREEN=maximize" >> window_controls.txt
```

Проверьте:

```bash
cat window_controls.txt
```

Нажмите **CHECK**.
