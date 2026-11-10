#!/usr/bin/env bash
set -euo pipefail
cd /root/bash04/work

[[ -f cpuinfo_head.txt ]] || { echo "✗ Нет cpuinfo_head.txt."; exit 1; }
[[ -f meminfo_head.txt ]] || { echo "✗ Нет meminfo_head.txt."; exit 1; }
[[ -f proc_version.txt ]] || { echo "✗ Нет proc_version.txt."; exit 1; }

[[ "$(wc -l < cpuinfo_head.txt)" -eq 10 ]] || { echo "✗ cpuinfo_head.txt должен содержать первые 10 строк /proc/cpuinfo."; exit 1; }
[[ "$(wc -l < meminfo_head.txt)" -eq 10 ]] || { echo "✗ meminfo_head.txt должен содержать первые 10 строк /proc/meminfo."; exit 1; }

cmp -s <(head -n 10 /proc/cpuinfo) cpuinfo_head.txt || { echo "✗ cpuinfo_head.txt содержит неверные данные."; exit 1; }
cmp -s <(head -n 10 /proc/meminfo) meminfo_head.txt || { echo "✗ meminfo_head.txt содержит неверные данные."; exit 1; }
cmp -s /proc/version proc_version.txt || { echo "✗ proc_version.txt должен содержать /proc/version."; exit 1; }

echo "✓ Системные сведения из /proc получены."
