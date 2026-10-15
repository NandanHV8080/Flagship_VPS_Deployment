#!/usr/bin/env bash
# Usage (as root): bash harden.sh <new-username>
set -euo pipefail

NEW_USER="${1:?usage: bash harden.sh <new-username>}"

if [ "$(id -u)" -ne 0 ]; then
  echo "Run this as root." >&2
  exit 1
fi

apt-get update
apt-get -y upgrade

# 1. Create a normal admin user
adduser --disabled-password --gecos "" "$NEW_USER"
usermod -aG sudo "$NEW_USER"
echo "$NEW_USER ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/90-$NEW_USER"
chmod 440 "/etc/sudoers.d/90-$NEW_USER"

# 2. Give the new user your SSH key
mkdir -p "/home/$NEW_USER/.ssh"
cp /root/.ssh/authorized_keys "/home/$NEW_USER/.ssh/authorized_keys"
chown -R "$NEW_USER:$NEW_USER" "/home/$NEW_USER/.ssh"
chmod 700 "/home/$NEW_USER/.ssh"
chmod 600 "/home/$NEW_USER/.ssh/authorized_keys"

# 3. Firewall: allow SSH, HTTP, HTTPS only
ufw default deny incoming
ufw default allow outgoing
ufw allow OpenSSH
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable

# 4. SSH: key login only, no root login
# The "00-" name makes this file win over other config files.
cat > /etc/ssh/sshd_config.d/00-hardening.conf <<'EOF'
PasswordAuthentication no
PermitRootLogin no
EOF
sshd -t
systemctl restart ssh

echo "Done. Test login as $NEW_USER from a NEW terminal before closing this one."
