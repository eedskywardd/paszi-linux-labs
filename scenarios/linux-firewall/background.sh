#!/usr/bin/env bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y -qq nftables iproute2 curl python3 netcat-openbsd >/dev/null
cat > /root/START_HERE.txt <<'EOF'
ПАСЗИ №15: проверка стенда
ip netns list
ip netns exec pc ip route
ip netns exec srv ss -ltn
ip netns exec fw nft list ruleset
Для проверки HTTP: ip netns exec pc curl -m 3 -sS http://10.10.20.2:8000/
Внимание: правила исправлять ВНУТРИ namespace fw.
EOF
for ns in pc fw srv; do ip netns add "$ns"; ip -n "$ns" link set lo up; done
ip link add pcp type veth peer name fwp
ip link add fws type veth peer name srvp
ip link set pcp netns pc; ip link set fwp netns fw
ip link set fws netns fw; ip link set srvp netns srv
ip -n pc addr add 10.10.10.2/24 dev pcp
ip -n fw addr add 10.10.10.1/24 dev fwp
ip -n fw addr add 10.10.20.1/24 dev fws
ip -n srv addr add 10.10.20.2/24 dev srvp
for pair in 'pc pcp' 'fw fwp' 'fw fws' 'srv srvp'; do set -- $pair; ip -n "$1" link set "$2" up; done
ip -n pc route add 10.10.20.0/24 via 10.10.10.254 || true
ip -n srv route add 10.10.10.0/24 via 10.10.20.1
ip netns exec fw sysctl -qw net.ipv4.ip_forward=1
mkdir -p /root/web; echo 'PASZI_LAB_OK' > /root/web/index.html
ip netns exec srv bash -c 'cd /root/web; nohup python3 -m http.server 8000 --bind 10.10.20.2 </dev/null >/tmp/paszi-http.log 2>&1 &'
ip netns exec fw nft -f - <<'EOF'
table inet labfilter {
  chain forward {
    type filter hook forward priority 0; policy drop;
    ct state established,related accept
    ip saddr 10.10.20.0/24 ip daddr 10.10.20.2 tcp dport 8080 accept
    counter log prefix "PASZI_DROP: " drop
  }
}
EOF
printf '\nSTAND READY\n' > /root/LAB_READY
