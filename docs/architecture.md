Visitor -> vedrion.com (DNS A record) -> VPS
VPS:
  nginx (ports 80/443, planned)
    -> /var/www/vedrion (static portfolio, planned)
    -> /api/ -> Python service on 127.0.0.1:8000 (systemd)
