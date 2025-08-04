# EtherEdge / PrivChain RPC (nom à finaliser)

Service de nœuds Ethereum privés optimisés pour MEV, arbitrage et bots à faible latence.

## 🚀 Features principales
- Endpoint RPC/WebSocket dédié (pas de noisy neighbor).  
- Provisioning en <30 minutes.  
- Monitoring & healthcheck automatique.  
- Rotation de clés API.  
- Comparatif de latence vs Infura/QuickNode fourni.  
- Support direct (Slack/Telegram) avec SLA.

## 📦 Déploiement rapide (exemple)
```bash
git clone https://github.com/tonCompte/ethereedge-node-service.git
cd provisioning
./install_geth.sh
./setup_rpc.sh --key YOUR_API_KEY
