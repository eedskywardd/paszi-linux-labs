# 4. Записываем и читаем текст: `echo`, `cat`, `>`, `>>`

Сейчас `notes.txt` пустой.

Запишем первую строку:

```bash
echo "Operating Systems" > /root/bash01/work/docs/notes.txt
```

Проверьте:

```bash
cat /root/bash01/work/docs/notes.txt
```

Теперь добавим вторую строку:

```bash
echo "Bash practice" >> /root/bash01/work/docs/notes.txt
```

И снова:

```bash
cat /root/bash01/work/docs/notes.txt
```

Должно быть:

```text
Operating Systems
Bash practice
```

### Главное отличие

`>` — записать заново. Старое содержимое файла будет заменено.

`>>` — добавить текст **в конец**, сохранив то, что было раньше.

Проверьте количество строк:

```bash
wc -l /root/bash01/work/docs/notes.txt
```

`wc -l` считает строки. Здесь должно быть **2**.

Нажмите **CHECK**.
