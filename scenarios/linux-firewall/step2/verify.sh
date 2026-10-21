#!/usr/bin/env bash
set -euo pipefail
r=$(ip netns exec fw nft -j list chain inet labfilter forward)
python3 - "$r" <<'PYCODE'
import json,sys
j=json.loads(sys.argv[1])
chains=[x['chain'] for x in j['nftables'] if 'chain' in x]
if not chains or chains[0].get('policy')!='drop':
 print('✗ Политика forward должна быть drop');sys.exit(1)
PYCODE
if ! ip netns exec pc curl --noproxy '*' -m 4 -fsS http://10.10.20.2:8000/ | grep -qx 'PASZI_LAB_OK'; then echo '✗ TCP/8000 не работает'; exit 1; fi
if ip netns exec pc curl --noproxy '*' -m 2 -fsS http://10.10.20.2:9000/ >/dev/null 2>&1; then echo '✗ TCP/9000 открывается'; exit 1; fi
if ! ip netns exec fw nft list chain inet labfilter forward | grep -q 'ct state established,related'; then echo '✗ Отсутствует правило established,related'; exit 1; fi
echo '✓ Разрешённый сервис работает, политика drop сохранена'
