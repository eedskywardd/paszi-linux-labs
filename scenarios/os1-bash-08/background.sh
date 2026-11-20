#!/usr/bin/env bash
set -Eeuo pipefail

rm -rf /root/bash08
mkdir -p /root/bash08/work
mkdir -p /root/bash08/data/archive

printf 'alpha\nbeta\n' > /root/bash08/data/alpha.txt
printf 'one\ntwo\nthree\n' > /root/bash08/data/beta.txt
printf 'remember loops\n' > /root/bash08/data/notes.txt
printf 'INFO start\nERROR test\n' > /root/bash08/data/app.log
printf 'WARN old\n' > /root/bash08/data/system.log
printf 'mode=student\n' > /root/bash08/data/app.conf
printf '# demo\n' > /root/bash08/data/readme.md
printf 'archived\n' > /root/bash08/data/archive/old.txt

cat > /root/bash08/data/names.txt <<'EOF'
Anna
Boris
Carol
EOF

echo READY > /root/BASH08_READY
