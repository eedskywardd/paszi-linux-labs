#!/usr/bin/env bash
set -euo pipefail
if [ ! -f /root/otchet.md ]; then echo '✗ Создайте файл /root/otchet.md'; exit 1; fi
python3 - <<'PY'
from pathlib import Path
import re,sys
t=Path('/root/otchet.md').read_text(encoding='utf-8',errors='replace')
students=dict(re.findall(r'^STUDENT_([123])\s*=\s*(.*)$',t,flags=re.M))
first=students.get('1','').strip()
if len(first.split())<2 or first.lower()=='фамилия имя':
 sys.exit('✗ Укажите фамилию и имя в STUDENT_1')
for k in ('2','3'):
 n=students.get(k,'').strip()
 if n and len(n.split())<2:
  sys.exit('✗ Поле STUDENT_'+k+' либо оставьте пустым, либо укажите два слова')
names=[v.strip() for v in students.values() if v.strip()]
if len(set(names))!=len(names): sys.exit('✗ Не дублируйте ФИО')
body=re.sub(r'^STUDENT_[123]\s*=.*$','',t,flags=re.M).strip()
if len(body)<180: sys.exit('✗ Добавьте содержательное объяснение (пока текст слишком короткий)')
print('✓ Отчёт принят по форме; участников: '+str(len(names)))
print('Качество объяснения оценивает преподаватель отдельно.')
PY
