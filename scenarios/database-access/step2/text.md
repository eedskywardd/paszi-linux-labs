# Этап 2. Разделение полномочий

**Инцидент:** аудитор auditor имеет доступ к контактам клиентов, но не видит журнал событий. Стажёр trainee видит персональные данные, которые ему не нужны.

### Критерии успеха
- auditor может SELECT из corp.security_events;
- auditor **не может** читать corp.clients или corp.tickets;
- trainee **не может** читать corp.clients или corp.security_events;
- auditor не должен иметь возможность добавлять записи в журнал.

Сравните назначения таблиц, затем посмотрите **\dp corp.*** и результат has_table_privilege для этих ролей.

<details><summary>Подсказка 1 — логика доступа</summary>
Аудитор занимается событиями безопасности. Контакты клиентов и служебные заявки не относятся к его задаче.
</details>

<details><summary>Подсказка 2 — диагностика</summary>
Проверьте обе роли и три таблицы, прежде чем менять права. Особенно важны SELECT у auditor и trainee.
</details>

<details><summary>Подсказка 3 — пример запроса</summary>

~~~sql
SELECT has_table_privilege('auditor','corp.security_events','SELECT');
~~~

После исправления он должен возвращать true. Для corp.clients результат должен быть обратным.
</details>

Затем нажмите **ПРОВЕРИТЬ**.
