# 4. Восстановить PoE и оптику

Выполните:

```bash
repair P18 REPLACE_WITH_SOLID_COPPER
repair F07 CLEAN_AND_RESEAT_CONNECTOR
```

После ремонта проверьте:

```bash
load-test P18
power-meter F07
otdr F07
```

Ожидается:

- PoE: `RESULT: PASS`;
- оптические потери около 2–3 dB;
- OTDR: без аварийного события.

После этого нажмите **CHECK**.
