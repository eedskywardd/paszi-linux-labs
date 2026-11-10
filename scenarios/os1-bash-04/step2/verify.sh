#!/usr/bin/env bash
set -euo pipefail
cd /root/bash04/work
[[ "$(cat kernel.txt 2>/dev/null || true)" == "$(uname -r)" ]] || { echo "✗ kernel.txt должен содержать uname -r."; exit 1; }
[[ "$(cat architecture.txt 2>/dev/null || true)" == "$(uname -m)" ]] || { echo "✗ architecture.txt должен содержать uname -m."; exit 1; }
[[ "$(cat uname_all.txt 2>/dev/null || true)" == "$(uname -a)" ]] || { echo "✗ uname_all.txt должен содержать uname -a."; exit 1; }
echo "✓ Сведения о ядре и архитектуре сохранены."
