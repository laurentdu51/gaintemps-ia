# Utilise l'image officielle Node.js LTS (Alpine pour être plus léger)
FROM node:20-alpine

# Définit le répertoire de travail dans le conteneur
WORKDIR /app

# Copie les fichiers de dépendances
COPY package*.json ./

# Installe les dépendances
RUN npm install --omit=dev

# Copie le reste des fichiers de l'application
COPY . .

# Expose le port 3000
EXPOSE 3000

# Définit l'utilisateur non-root pour la sécurité
USER node

# Commande pour lancer l'application
CMD ["node", "server.js"]
