# 4. Spotlight, Launchpad и Control Center

Теперь найдите в ThanasOS три системных инструмента.

## Spotlight

Spotlight используется для быстрого поиска приложений, настроек и другой информации.

Откройте Spotlight через интерфейс симулятора и попробуйте найти:

```text
Settings
```

## Launchpad

Launchpad показывает приложения в виде сетки значков.

Откройте Launchpad и найдите там Calculator или Settings.

## Control Center

Control Center — панель быстрых настроек.

В ней можно увидеть быстрый доступ к таким функциям, как:

- Wi-Fi;
- Bluetooth;
- звук;
- яркость;
- другие системные переключатели.

После исследования запишите:

```bash
cd /root/os05/work
echo "SPOTLIGHT=search" > system_tools.txt
echo "LAUNCHPAD=applications" >> system_tools.txt
echo "CONTROL_CENTER=quick_settings" >> system_tools.txt
```

Проверьте файл:

```bash
cat system_tools.txt
```

Нажмите **CHECK**.
