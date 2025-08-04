#!/usr/bin/env bash
set -e

# Configuration d'un endpoint RPC minimal avec API key enforcement via nginx (simplifié)
# Nécessite : nginx installé (sudo apt install nginx), openssl pour TLS si souhaité.

usage() {
  echo "Usage: $0 --key <API_KEY> [--domain example.com]"
  exit 1
}

API_KEY=""
DOMAIN="localhost"

while [[ $# -gt 0 ]]; do
  case $1 in
    --key) API_KEY="$2"; shift 2 ;;
    --domain) DOMAIN="$2"; shift 2 ;;
    *) usage ;;
  esac
done

if [[ -z "$API_KEY" ]]; then
  echo "Il faut fournir une clé API avec --key"; usage
fi

echo "[*] Création d'un fichier de validation de clé API"
API_KEY_FILE="/etc/eth_rpc_api_key"
echo "$API_KEY" | sudo tee "$API_KEY_FILE" >/dev/null
sudo chmod 600 "$API_KEY_FILE"

echo "[*] Installation de nginx si nécessaire"
if ! command -v nginx >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y nginx
fi

# Configuration nginx simple avec vérification d'en-tête
NGINX_CONF="/etc/nginx/sites-available/eth_rpc"
sudo tee "$NGINX_CONF" >/dev/null <<EOF
server {
    listen 80;
    server_name $DOMAIN;

    location / {
        proxy_pass http://localhost:8545;
        proxy_http_version 1.1;
        proxy_set_header Connection "";
        proxy_set_header Host \$host;

        # Vérification clé API
        if (\$http_x_api_key != "$API_KEY") {
            return 401;
        }

        # Timeout / buffering custom si besoin
        proxy_read_timeout 300;
    }
}
EOF

sudo ln -sf "$NGINX_CONF" /etc/nginx/sites-enabled/eth_rpc
sudo nginx -t
sudo systemctl reload nginx

echo "[+] Endpoint configuré sur http://$DOMAIN avec vérification de x-api-key"
echo "Test rapide :"
echo "curl -X POST http://$DOMAIN -H 'Content-Type: application/json' -H 'x-api-key: $API_KEY' -d '{\"jsonrpc\":\"2.0\",\"method\":\"eth_blockNumber\",\"params\":[],\"id\":1}'"

