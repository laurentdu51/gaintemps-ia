# GainTempsIA 🚀

Site web et API pour l'activité de consulting en IA GainTempsIA.

## 🎯 Description

GainTempsIA aide les TPE et PME à automatiser leurs tâches répétitives et chronophages grâce à l'Intelligence Artificielle.

## 🏗️ Architecture

- **Frontend** : Site web statique HTML/CSS/JS
- **API** : Node.js + Express + Resend (containerisé avec Docker)
- **Reverse Proxy** : Caddy Server

## 🚀 Installation rapide

### Prérequis
- Docker & Docker Compose
- Caddy Server
- Compte Resend avec domaine vérifié

### Étapes

1. **Clonez le repository**
```bash
git clone https://github.com/laurentdu51/gaintemps-ia.git
cd gaintemps-ia
```

2. **Configurez l'API**
```bash
cd api
cp .env.example .env
# Éditez .env et ajoutez votre clé API Resend
nano .env
```

3. **Lancez l'API avec Docker**
```bash
docker compose up -d
```

4. **Déployez le frontend**
```bash
cd ../frontend
sudo cp -r * /var/www/gaintemps-ia/
```

5. **Configurez Caddy**
```bash
cd ../caddy
sudo cp Caddyfile /etc/caddy/Caddyfile
sudo systemctl restart caddy
```

## 📚 Documentation

- [Frontend README](frontend/README.md)
- [API README](api/README.md)
- [Caddy README](caddy/README.md)

## 🔒 Sécurité

- Ne jamais commiter le fichier `.env`
- Utilisez `.env.example` comme template
- La clé API Resend doit rester secrète

## 📧 Contact

- Email: contact@duhaz.fr
- LinkedIn: [Laurent Hazart](https://www.linkedin.com/in/laurent-hazart-4b9a95329/)

## 📝 Licence

MIT License - voir [LICENSE](LICENSE)
