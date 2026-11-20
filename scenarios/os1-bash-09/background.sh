#!/usr/bin/env bash
set -Eeuo pipefail

rm -rf /root/bash09
mkdir -p /root/bash09/work
mkdir -p /root/bash09/data/subdir

printf 'one\ntwo\nthree\n' > /root/bash09/data/a.txt
printf 'alpha\nbeta\n' > /root/bash09/data/b.txt
printf 'INFO demo\n' > /root/bash09/data/app.log
printf 'mode=test\n' > /root/bash09/data/app.conf
printf 'inside\n' > /root/bash09/data/subdir/c.txt

echo READY > /root/BASH09_READY
