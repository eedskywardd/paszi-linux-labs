#!/usr/bin/env bash
set -Eeuo pipefail
rm -rf /root/bash07
mkdir -p /root/bash07/work
mkdir -p /root/bash07/data

cat > /root/bash07/data/sample.txt <<'EOF'
alpha
beta
gamma
EOF

cat > /root/bash07/data/note.txt <<'EOF'
one line
EOF

echo READY > /root/BASH07_READY
