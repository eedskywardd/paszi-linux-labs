# 3. Восстановить медные линии

Выполните ремонт L11 и L12:

```bash
repair L11 RETERMINATE_OR_REPLACE_SECTION
repair L12 RECRIMP_CORRECT_PAIRS
```

После этого сразу выполните контроль:

```bash
cable-test L11
cable-test L12
pair-test L12
```

Если все три проверки показывают `PASS`, нажмите **CHECK**.
