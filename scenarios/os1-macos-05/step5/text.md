# 5. System Settings: найдите нужные разделы

Теперь откройте второй симулятор:

https://osimulator.com/

Выберите **macOS** и откройте System Settings.

Ваша задача — не просто прочитать ответы, а **самостоятельно найти разделы в дереве настроек**.

Найдите:

1. настройки внешнего вида;
2. настройки Dock и рабочего стола;
3. пользователей и группы;
4. настройки конфиденциальности и безопасности;
5. Firewall.

Зафиксируйте найденные пути:

```bash
cd /root/os05/work
echo "APPEARANCE=Appearance" > settings_paths.txt
echo "DESKTOP_DOCK=Desktop & Dock" >> settings_paths.txt
echo "USERS=Users & Groups" >> settings_paths.txt
echo "PRIVACY=Privacy & Security" >> settings_paths.txt
echo "FIREWALL=Network > Firewall" >> settings_paths.txt
```

Проверьте:

```bash
cat settings_paths.txt
```

Нажмите **CHECK**.
