#!/usr/bin/env bash
set -euo pipefail
cd /root/bash04/work
[[ -s disk_free.txt ]] || { echo "✗ disk_free.txt не создан или пуст."; exit 1; }
[[ -s root_disk.txt ]] || { echo "✗ root_disk.txt не создан или пуст."; exit 1; }
[[ -s block_devices.txt ]] || { echo "✗ block_devices.txt не создан или пуст."; exit 1; }
grep -q 'Filesystem' disk_free.txt || { echo "✗ disk_free.txt должен содержать вывод df -h."; exit 1; }
grep -q 'Filesystem' root_disk.txt || { echo "✗ root_disk.txt должен содержать вывод df -h /."; exit 1; }
grep -Eq 'NAME|loop|sd|vd|nvme' block_devices.txt || { echo "✗ block_devices.txt не похож на вывод lsblk."; exit 1; }
echo "✓ Информация о дисках получена."
