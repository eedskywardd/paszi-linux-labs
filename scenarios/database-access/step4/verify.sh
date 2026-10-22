#!/usr/bin/env bash
set -euo pipefail
if [ ! -f /root/otchet.md ]; then echo '✗ Создайте файл /root/otchet.md'; exit 1; fi
python3 - <<'PY'
from pathlib import Path
import sys
t = Path('/root/otchet.md').read_text(encoding='utf-8', errors='replace')
students = {}
body_lines = []
for line in t.splitlines():
    if '=' in line and line.split('=', 1)[0].strip() in ('STUDENT_1', 'STUDENT_2', 'STUDENT_3'):
        key, value = line.split('=', 1)
        students[key.strip()] = value.strip()
    else:
        body_lines.append(line)
first = students.get('STUDENT_1', '')
if len(first.split()) < 2 or first.lower() == 'фамилия имя':
    sys.exit('✗ Укажите фамилию и имя в STUDENT_1')
for key in ('STUDENT_2', 'STUDENT_3'):
    value = students.get(key, '')
    if value and len(value.split()) < 2:
        sys.exit('✗ ' + key + ': укажите ФИО полностью либо оставьте пустым')
names = [value for value in students.values() if value]
if len(set(names)) != len(names):
    sys.exit('✗ Не дублируйте ФИО участников')
body = '\n'.join(body_lines).strip()
if len(body) < 180:
    sys.exit('✗ Добавьте содержательное объяснение: текст отчёта пока слишком короткий')
print('✓ Отчёт принят по форме. Участников: ' + str(len(names)))
print('Качество объяснения преподаватель оценивает отдельно.')
PY
