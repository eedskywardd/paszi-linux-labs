#!/usr/bin/env bash
set -euo pipefail
d=/root/bash03/lab/permissions
[[ "$(stat -c '%a' "$d/run.sh")" == "744" ]] || { echo "✗ У run.sh должны быть права 744 после chmod u+x."; exit 1; }
[[ "$(stat -c '%a' "$d/readme.txt")" == "640" ]] || { echo "✗ У readme.txt должны быть права 640 после chmod o-r."; exit 1; }
[[ "$(stat -c '%a' "$d/private.txt")" == "660" ]] || { echo "✗ У private.txt должны быть права 660 после chmod g+w."; exit 1; }
echo "✓ Символьная запись chmod выполнена правильно."
