#!/usr/bin/env bash
# Run on the VPS from the repo: bash scripts/install-nginx.sh
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"

sudo apt-get update
sudo apt-get install -y nginx

sudo cp "$REPO_DIR/nginx/vedrion.conf" /etc/nginx/sites-available/vedrion
sudo ln -sf /etc/nginx/sites-available/vedrion /etc/nginx/sites-enabled/vedrion
sudo rm -f /etc/nginx/sites-enabled/default

sudo nginx -t
sudo systemctl enable --now nginx
sudo systemctl reload nginx
echo "nginx config installed and reloaded."
