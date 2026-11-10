#!/usr/bin/env bash
set -Eeuo pipefail

rm -rf /root/bash03
mkdir -p /root/bash03/lab/projects/site
mkdir -p /root/bash03/lab/projects/api
mkdir -p /root/bash03/lab/notes
mkdir -p /root/bash03/lab/archive
mkdir -p /root/bash03/lab/config
mkdir -p /root/bash03/lab/permissions

cat > /root/bash03/lab/projects/site/index.html <<'EOF'
<h1>Bash 03</h1>
EOF

cat > /root/bash03/lab/projects/site/style.css <<'EOF'
body { font-family: sans-serif; }
EOF

cat > /root/bash03/lab/projects/site/app.js <<'EOF'
console.log("bash03");
EOF

cat > /root/bash03/lab/projects/api/server.py <<'EOF'
print("server")
EOF

cat > /root/bash03/lab/projects/api/config.txt <<'EOF'
PORT=8080
EOF

cat > /root/bash03/lab/notes/todo.txt <<'EOF'
learn paths
learn find
learn chmod
EOF

cat > /root/bash03/lab/notes/ideas.txt <<'EOF'
practice every command
EOF

cat > /root/bash03/lab/archive/old.log <<'EOF'
old log
EOF

cat > /root/bash03/lab/archive/old.txt <<'EOF'
old text
EOF

cat > /root/bash03/lab/config/web.conf <<'EOF'
listen=80
EOF

cat > /root/bash03/lab/projects/api/api.conf <<'EOF'
port=8080
EOF

cat > /root/bash03/lab/projects/site/site.conf <<'EOF'
root=/var/www
EOF

cat > /root/bash03/lab/permissions/readme.txt <<'EOF'
This file is for reading.
EOF

cat > /root/bash03/lab/permissions/run.sh <<'EOF'
#!/usr/bin/env bash
echo "Bash 03 script works"
EOF

cat > /root/bash03/lab/permissions/private.txt <<'EOF'
private training data
EOF

chmod 644 /root/bash03/lab/permissions/readme.txt
chmod 644 /root/bash03/lab/permissions/run.sh
chmod 640 /root/bash03/lab/permissions/private.txt

echo READY > /root/BASH03_READY
