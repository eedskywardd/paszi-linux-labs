#!/usr/bin/env bash
set -Eeuo pipefail
mkdir -p /root/bash02

cat > /root/bash02/app.log <<'EOF'
2026-11-06 09:00 INFO service started
2026-11-06 09:01 INFO user alice login
2026-11-06 09:02 WARN disk usage 75%
2026-11-06 09:03 ERROR database timeout
2026-11-06 09:04 INFO user bob LOGIN
2026-11-06 09:05 ERROR permission denied
2026-11-06 09:06 INFO user ALICE logout
2026-11-06 09:07 WARN retry scheduled
2026-11-06 09:08 ERROR network unreachable
2026-11-06 09:09 INFO service stopped
EOF

cat > /root/bash02/users.txt <<'EOF'
alice
bob
alice
carol
bob
dave
carol
alice
EOF

cat > /root/bash02/README.txt <<'EOF'
Bash 02 training data
app.log   - учебный журнал событий
users.txt - список имён с повторами
EOF

echo READY > /root/BASH02_READY
