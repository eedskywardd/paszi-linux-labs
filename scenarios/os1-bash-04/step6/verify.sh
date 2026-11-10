#!/usr/bin/env bash
set -euo pipefail
cd /root/bash04/work
[[ "$(wc -l < cpuinfo_head.txt 2>/dev/null || echo 0)" -eq 10 ]] || { echo "✗ cpuinfo_head.txt должен содержать первые 10 строк /proc/cpuinfo."; exit 1; }
[[ "$(wc -l < meminfo_head.txt 2>/dev/null || echo 0)" -eq 10 ]] || { echo "✗ meminfo_head.txt должен содержать первые 10 строк /proc/meminfo."; exit 1; }
cmp -s <(head -n 10 /proc/cpuinfo) cpuinfo_head.txt || { echo "✗ cpuinfo_head.txt содержит неверные данные."; exit 1; }
cmp -s <(head -n 10 /proc/meminfo) meminfo_head.txt || { echo "✗ meminfo_head.txt содержит неверные данные."; exit 1; }
cmp -s /proc/version proc_version.txt || { echo "✗ proc_version.txt должен содержать /proc/version."; exit 1; }
echo "✓ Системные сведения из /proc получены."
