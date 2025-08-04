# EtherEdge / PrivChain RPC

Service de nœuds Ethereum privés optimisés pour MEV, arbitrage et bots à faible latence.  
Endpoint dédié RPC/WebSocket, onboarding rapide, monitoring, rotation de clés API et support direct.

## 🚀 Features principales
- Endpoint Ethereum dédié (RPC et WebSocket) : pas de noisy neighbor.  
- Provisioning automatisé en <30 minutes.  
- API key simple pour contrôle d’accès.  
- Monitoring & healthcheck de base.  
- Comparatif de latence (à fournir au client).  
- Support avec SLA (Slack/Telegram ou autre).  

## 📦 Installation rapide (exemple)

```bash
git clone https://github.com/tonCompte/ethereedge-node-service.git
cd provisioning
chmod +x install_geth.sh setup_rpc.sh
./install_geth.sh          # installe Geth et lance la sync
./setup_rpc.sh --key abc123  # configure le reverse proxy + API key
