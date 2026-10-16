# nginx and TLS setup

## Layout
- nginx config lives in `nginx/vedrion.conf` and is installed with `scripts/install-nginx.sh`
- Site files live in `site/` and are published to `/var/www/vedrion` by `scripts/deploy.sh`
- The Python service listens on 127.0.0.1:8000; nginx proxies `/api/` to it

## Certificate
Issued with certbot's nginx authenticator (`certonly`), so certbot never edits the nginx config:

    sudo certbot certonly --nginx -d vedrion.com -d www.vedrion.com \
      --deploy-hook "systemctl reload nginx"

Certificates are in `/etc/letsencrypt/live/vedrion.com/`.

## Redirects
- http://vedrion.com and http://www.vedrion.com redirect to https://vedrion.com
- https://www.vedrion.com redirects to https://vedrion.com

## Applying a config change
    cd ~/Flagship_VPS_Deployment && git pull && bash scripts/install-nginx.sh

