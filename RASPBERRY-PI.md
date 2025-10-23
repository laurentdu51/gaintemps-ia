# 🍓 GainTempsIA sur Raspberry Pi

Guide complet pour déployer l'API GainTempsIA sur Raspberry Pi.

## ✅ Compatibilité

- ✅ Raspberry Pi 4 ou 5 (recommandé - 4GB RAM minimum)
- ✅ Raspberry Pi 3 (fonctionne mais plus lent)
- ✅ Architecture ARM64/ARM32 supportée
- ✅ L'image `node:20-alpine` est multi-architecture

## 📋 Prérequis

- Raspberry Pi avec Raspberry Pi OS (ou Ubuntu)
- Connexion Internet
- Accès SSH ou écran/clavier

## 🚀 Installation sur Raspberry Pi

### Étape 1 : Mettre à jour le système

```bash
sudo apt update
sudo apt upgrade -y
```

### Étape 2 : Installer Docker

```bash
# Installation de Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Ajouter votre utilisateur au groupe docker (pour ne pas utiliser sudo)
sudo usermod -aG docker $USER

# Redémarrer la session (ou redémarrer le RPi)
# Puis vérifier :
docker --version
docker compose version
```

### Étape 3 : Installer Git (si pas déjà installé)

```bash
sudo apt install git -y
```

### Étape 4 : Cloner le projet depuis GitHub

```bash
cd ~
git clone https://github.com/VOTRE-USERNAME/gaintemps-ia.git
cd gaintemps-ia/api
```

### Étape 5 : Configurer l'environnement

```bash
# Copier le fichier d'exemple
cp .env.example .env

# Éditer avec votre clé API Resend
nano .env
```

Ajoutez vos vraies valeurs :
```env
RESEND_API_KEY=re_votre_vraie_cle_api_ici
PORT=3000
ALLOWED_ORIGIN=http://votre-ip-rpi:8080
NODE_ENV=production
```

### Étape 6 : Construire et lancer

```bash
# Construire l'image (peut prendre 5-10 minutes sur RPi)
docker compose build

# Lancer le conteneur
docker compose up -d

# Vérifier les logs
docker compose logs -f
```

### Étape 7 : Tester l'API

```bash
# Test local sur le RPi
curl http://localhost:3000/health

# Test depuis un autre ordinateur sur le réseau
curl http://IP-DU-RPI:3000/health
```

Vous devriez voir :
```json
{
  "status": "ok",
  "message": "GainTempsIA API is running",
  "timestamp": "..."
}
```

## 🔧 Commandes utiles

```bash
# Voir les logs
docker compose logs -f

# Arrêter l'API
docker compose down

# Redémarrer l'API
docker compose restart

# Reconstruire après modifications
git pull
docker compose up -d --build

# Voir l'utilisation des ressources
docker stats
```

## 🌐 Configurer Caddy sur Raspberry Pi

### Installation de Caddy

```bash
# Ajouter le dépôt Caddy
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list

# Installer Caddy
sudo apt update
sudo apt install caddy

# Vérifier
caddy version
```

### Configuration

```bash
# Copier le Caddyfile
sudo mkdir -p /var/www/gaintemps-ia
sudo cp ~/gaintemps-ia/frontend/index.html /var/www/gaintemps-ia/
sudo cp ~/gaintemps-ia/caddy/Caddyfile /etc/caddy/Caddyfile

# Adapter le Caddyfile pour l'IP locale si besoin
sudo nano /etc/caddy/Caddyfile
```

Pour un test local, remplacez `gaintemps-ia.fr` par `:8080` dans le Caddyfile :

```caddy
:8080 {
    root * /var/www/gaintemps-ia
    file_server
    encode gzip
    
    handle /api/* {
        reverse_proxy localhost:3000
    }
}
```

```bash
# Redémarrer Caddy
sudo systemctl restart caddy
sudo systemctl status caddy

# Tester
curl http://localhost:8080
```

## 💾 Utilisation de la mémoire

L'API Node.js en Docker utilisera environ :
- **50-100 MB** de RAM en idle
- **150-200 MB** de RAM sous charge

Le Raspberry Pi 4 avec 4GB est largement suffisant.

## 🔐 Sécurité

```bash
# Configurer le pare-feu (optionnel)
sudo apt install ufw
sudo ufw allow 22/tcp    # SSH
sudo ufw allow 80/tcp    # HTTP
sudo ufw allow 443/tcp   # HTTPS
sudo ufw allow 3000/tcp  # API (si exposition directe)
sudo ufw enable
```

## 📝 Démarrage automatique

Docker est configuré pour redémarrer automatiquement (`restart: unless-stopped` dans docker-compose.yml).

Pour Caddy :
```bash
sudo systemctl enable caddy
```

## 🐛 Dépannage

### L'API ne démarre pas
```bash
# Vérifier les logs
docker compose logs

# Vérifier que le port 3000 est libre
sudo netstat -tlnp | grep 3000
```

### Manque de mémoire
```bash
# Voir l'utilisation
free -h
docker stats
```

Si problème, ajoutez un swap :
```bash
sudo dphys-swapfile swapoff
sudo nano /etc/dphys-swapfile
# Modifier CONF_SWAPSIZE=1024
sudo dphys-swapfile setup
sudo dphys-swapfile swapon
```

## 🎯 Accès depuis Internet

Pour rendre votre API accessible depuis Internet :

1. **Configurez le port forwarding sur votre routeur**
   - Port 80 → Raspberry Pi:80
   - Port 443 → Raspberry Pi:443

2. **Utilisez un service DDNS** (ex: DuckDNS, No-IP)

3. **Caddy générera automatiquement les certificats SSL**

## 📊 Performances attendues

- **Temps de build** : 5-10 minutes
- **Temps de démarrage** : 5-10 secondes
- **Mémoire utilisée** : 100-200 MB
- **CPU** : <5% en idle, 20-40% sous charge

## ✅ Checklist de déploiement

- [ ] Docker installé
- [ ] Git installé  
- [ ] Projet cloné depuis GitHub
- [ ] Fichier .env configuré avec clé Resend
- [ ] Image Docker construite
- [ ] Conteneur lancé et fonctionnel
- [ ] API accessible (test curl)
- [ ] Caddy installé (optionnel)
- [ ] Frontend déployé (optionnel)
- [ ] Test complet du formulaire

Bon déploiement ! 🚀
