#!/bin/bash
set -e

SERVICE_NAME="debug-server"
DIR="$(cd "$(dirname "$0")" && pwd)"

# Ensure bun is installed
if ! command -v bun &>/dev/null; then
  echo "Installing bun..."
  curl -fsSL https://bun.sh/install | bash
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi

BUN_PATH="$(command -v bun)"
echo "Using bun: $BUN_PATH"

# Install dependencies
cd "$DIR"
bun install

# Create/recreate systemd service
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"
cat > "$SERVICE_FILE" <<EOF
[Unit]
Description=Debug Server
After=network.target

[Service]
Type=simple
User=$USER
WorkingDirectory=$DIR
ExecStart=$BUN_PATH run index.js
Restart=always
RestartSec=5
Environment=PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.bun/bin

[Install]
WantedBy=multi-user.target
EOF

echo "Created $SERVICE_FILE"

systemctl daemon-reload
systemctl enable "$SERVICE_NAME"
systemctl restart "$SERVICE_NAME"
systemctl status "$SERVICE_NAME" --no-pager
