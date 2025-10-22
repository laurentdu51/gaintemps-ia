# API - GainTempsIA

API Node.js containerisée pour gérer l'envoi d'emails via Resend.

## 🛠️ Technologies

- Node.js 20
- Express
- Resend
- Docker

## 📦 Installation

### Avec Docker (recommandé)

```bash
# Copier le fichier d'environnement
cp .env.example .env

# Éditer et ajouter votre clé API Resend
nano .env

# Construire et lancer
docker compose up -d

# Voir les logs
docker compose logs -f
```

### Sans Docker

```bash
# Installer les dépendances
npm install

# Lancer l'API
npm start
```

## 🔌 Endpoints

### GET /health
Vérification de l'état de l'API

**Response:**
```json
{
  "status": "ok",
  "message": "GainTempsIA API is running",
  "timestamp": "2025-10-22T10:00:00.000Z"
}
```

### POST /api/contact
Envoi d'un email de contact

**Request Body:**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "phone": "0612345678",
  "company": "Ma Société",
  "message": "Bonjour, je souhaite..."
}
```

**Response Success:**
```json
{
  "success": true,
  "message": "Message envoyé avec succès !",
  "id": "email_id_from_resend"
}
```

## 🐳 Commandes Docker

```bash
# Construire l'image
docker compose build

# Lancer le conteneur
docker compose up -d

# Arrêter le conteneur
docker compose down

# Voir les logs
docker compose logs -f

# Redémarrer
docker compose restart

# Reconstruire après modifications
docker compose up -d --build
```

## 🔒 Variables d'environnement

- `RESEND_API_KEY` : Clé API Resend (obligatoire)
- `PORT` : Port d'écoute (défaut: 3000)
- `ALLOWED_ORIGIN` : Origine autorisée pour CORS
- `NODE_ENV` : Environnement (production/development)

## 📝 Configuration Resend

1. Créez un compte sur [resend.com](https://resend.com)
2. Vérifiez votre domaine
3. Créez une clé API
4. Ajoutez la clé dans `.env`
