#!/usr/bin/env bash
# Run on the VPS from the repo: bash scripts/deploy.sh
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Locked-down system user for the service
id -u vedrion >/dev/null 2>&1 || sudo useradd --system --no-create-home --shell /usr/sbin/nologin vedrion

# Copy the app
sudo mkdir -p /opt/vedrion
sudo cp "$REPO_DIR/app/app.py" /opt/vedrion/app.py
sudo chown -R vedrion:vedrion /opt/vedrion

# Publish the static site
sudo mkdir -p /var/www/vedrion
sudo cp -r "$REPO_DIR/site/." /var/www/vedrion/
sudo chown -R root:root /var/www/vedrion
sudo find /var/www/vedrion -type d -exec chmod 755 {} \;
sudo find /var/www/vedrion -type f -exec chmod 644 {} \;

# Install and start the service
sudo cp "$REPO_DIR/systemd/vedrion.service" /etc/systemd/system/vedrion.service
sudo systemctl daemon-reload
sudo systemctl enable vedrion
sudo systemctl restart vedrion
sudo systemctl --no-pager status vedrion

