# Production-Style VPS Deployment

A small service deployed on a real VPS with a custom domain (vedrion.com),
HTTPS via Let's Encrypt and nginx, and a systemd-managed Python service.

## Goals
- Deploy a service on a real VPS and keep it running
- Serve it on my own domain over HTTPS
- Document every step and every problem

## Status
- [x] VPS created and hardened
- [x] DNS pointing to the VPS
- [x] Service running under systemd
- [x] nginx reverse proxy
- [x] HTTPS with Let's Encrypt
- [x] Portfolio site live at vedrion.com

## Live
- Site: https://vedrion.com
- Health endpoint: https://vedrion.com/api/health

## Architecture
Visitor → DNS (A records) → AWS EC2 (Ubuntu 24.04) → nginx (80/443) → static site in /var/www/vedrion, and /api/ proxied to a Python service on 127.0.0.1:8000, run by systemd.

## Documentation
- [VPS notes](docs/vps-notes.md)
- [DNS](docs/dns.md)
- [nginx and TLS](docs/nginx-and-tls.md)
- [Troubleshooting log](docs/troubleshooting.md)
