# 3. Проверить PoE-линии

Проверьте все три PoE-подключения:

```bash
certify-poe A-AP-01
certify-poe A-CAM-01
certify-poe A-CAM-02
```

Обратите внимание не только на наличие питания, но и на:

- успешное PoE-согласование;
- напряжение;
- потребляемую мощность;
- наличие экранирования у CAM-02.

Создайте:

```bash
nano /root/tfu10/poe-test.txt
```

Шаблон:

```text
AP01=
CAM01=
CAM02=
CAM02_SHIELDING=
NEGOTIATION=
RESULT=
```

Используйте `PASS` и `PRESENT`.

После заполнения нажмите **CHECK**.
