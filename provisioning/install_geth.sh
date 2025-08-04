#!/usr/bin/env bash
set -e

# Simple bootstrap script pour installer Geth et lancer la sync
# À exécuter sur une machine Linux (Ubuntu/Debian recommandé)

# Variables configurables
GETH_DATADIR="${HOME}/.ethereum"
GETH_BINARY="/usr/bin/geth"

echo "[*] Mise à jour du système"
sudo apt update && sudo apt install -y wget curl software-properties-common

echo "[*] Installation de Geth"
if ! command -v geth >/dev/null 2>&1; then
  # Télécharge et installe la version stable
  sudo add-apt-repository -y ppa:ethereum/ethereum
  sudo apt update
  sudo apt install -y ethereum
else
  echo "[+] Geth déjà installé"
fi

echo "[*] Lancement du nœud en mode full (sync rapide)"
# Exemple : lancer en background, ajuster flags selon besoin (archive, pruning, etc.)
nohup geth --http --http.addr 0.0.0.0 --http.api eth,net,web3 --http.vhosts="*" --syncmode fast --datadir "$GETH_DATADIR" > geth.log 2>&1 &

echo "[+] Geth lancé. Logs : geth.log"
echo "Tu peux vérifier los status avec :"
echo "  curl -X POST http://localhost:8545 -H 'Content-Type: application/json' -d '{\"jsonrpc\":\"2.0\",\"method\":\"eth_blockNumber\",\"params\":[],\"id\":1}'"

