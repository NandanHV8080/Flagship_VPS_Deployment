cat > docs/troubleshooting.md <<'DOC_END'
# Troubleshooting Log

## Useful commands
- `systemctl status vedrion` - is the service running?
- `journalctl -u vedrion -n 50 --no-pager` - last 50 log lines
- `sudo ufw status` - firewall rules
- `sudo ss -tlnp` - which programs listen on which ports
- `sudo sshd -T | grep -E "passwordauthentication|permitrootlogin"` - effective SSH settings


### 1. New user could not log in after hardening
- Symptom: `Permission denied (publickey)` when logging in as the new user.
- Cause: on AWS Ubuntu, root's authorized_keys starts with a `command="..."` prefix that blocks logins. The script copied that file, so the new user inherited the block.
- Fix: copy the key from the ubuntu user's authorized_keys instead.

### 2. Hardening script stopped early
- Symptom: `Missing privilege separation directory: /run/sshd`.
- Cause: on Ubuntu 24.04 that directory does not exist until SSH starts, so `sshd -t` failed and `set -e` stopped the script before SSH was restarted.
- Fix: run `mkdir -p /run/sshd` before `sshd -t`. Also made user creation safe to re-run.

### 3. Could not connect from my laptop
- Symptom: `No route to host` and later `Permission denied (publickey)`.
- Network part: Port 22 was open again when `nc -vz <ip> 22` succeeded.
- Key part: my WSL had no private key (`~/.ssh` held only known_hosts). I generated a new ed25519 key in WSL and added its public key to the server's authorized_keys.
- Lesson: check which machine each command runs on (the prompt shows it).


## Status
- [x] VPS created and hardened
- [x] DNS pointing to the VPS
- [x] Service running under systemd
- [ ] nginx reverse proxy
- [ ] HTTPS with Let's Encrypt
- [ ] Portfolio site live at vedrion.com
