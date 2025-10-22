# Caddy Configuration - GainTempsIA

Configuration Caddy pour servir le site et proxifier l'API.

## 📝 Installation de Caddy

```bash
# Installation sur macOS
brew install caddy

# Installation sur Linux
curl -fsSL https://get.caddy.sh -o get-caddy.sh
sudo sh get-caddy.sh

# Vérification
caddy version
```

## ⚙️ Configuration

Le fichier `Caddyfile` configure :

1. **Site statique** sur `gaintemps-ia.fr`
2. **Reverse proxy** pour l'API sur `/api/*`
3. **Redirection** www vers non-www
4. **HTTPS automatique** avec Let's Encrypt
5. **Headers de sécurité**

## 🚀 Utilisation

```bash
# Copier la configuration
sudo cp Caddyfile /etc/caddy/Caddyfile

# Vérifier la configuration
caddy validate --config /etc/caddy/Caddyfile

# Redémarrer Caddy
sudo systemctl restart caddy

# Voir les logs
sudo journalctl -u caddy -f

# Statut
sudo systemctl status caddy
```

## 🔒 HTTPS

Caddy génère automatiquement les certificats SSL via Let's Encrypt.

**Prérequis :**
- Votre domaine doit pointer vers votre serveur
- Les ports 80 et 443 doivent être ouverts
