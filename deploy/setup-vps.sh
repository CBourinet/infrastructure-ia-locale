#!/usr/bin/env bash
# À lancer sur le VPS (Ubuntu/Debian) en root, dans le dossier deploy/ avec .env rempli.
set -euo pipefail
[ -f .env ] || { echo ".env manquant (cp .env.example .env)"; exit 1; }
chmod 600 .env
command -v docker >/dev/null || curl -fsSL https://get.docker.com | sh
# Pare-feu : SSH + web uniquement
apt-get install -y ufw fail2ban >/dev/null
ufw default deny incoming; ufw default allow outgoing
ufw allow 22/tcp; ufw allow 80/tcp; ufw allow 443/tcp
ufw --force enable
systemctl enable --now fail2ban
mkdir -p storage && touch storage/.env
docker compose pull
docker compose up -d
echo "OK -> https://$(grep ^DOMAIN= .env | cut -d= -f2)"
