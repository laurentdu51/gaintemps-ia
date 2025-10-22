# 🚀 Instructions de déploiement sur GitHub

## Étape 1 : Copier le fichier HTML

Le fichier HTML est trop long pour être créé automatiquement. Deux options :

### Option A : Copier depuis l'artifact Claude
1. Faites défiler vers le haut de cette conversation
2. Trouvez l'artifact "GainTempsIA - Site Web de Consulting IA"
3. Cliquez sur les trois points en haut à droite de l'artifact
4. Sélectionnez "Copier le code"
5. Collez dans le fichier : `/Users/duhaz/projets/gaintemps-ia/frontend/index.html`

### Option B : Si vous avez déjà le fichier
```bash
cp /chemin/vers/votre/index.html /Users/duhaz/projets/gaintemps-ia/frontend/
```

## Étape 2 : Initialiser Git

```bash
cd /Users/duhaz/projets/gaintemps-ia

# Initialiser le repository
git init

# Ajouter tous les fichiers
git add .

# Premier commit
git commit -m "Initial commit - GainTempsIA website and API"
```

## Étape 3 : Créer le repository sur GitHub

1. Allez sur [github.com](https://github.com)
2. Cliquez sur "New repository"
3. Nom : `gaintemps-ia`
4. Description : "Site web et API pour GainTempsIA - Consulting IA pour TPE/PME"
5. Choisissez "Public" ou "Private"
6. Ne cochez PAS "Initialize with README"
7. Cliquez "Create repository"

## Étape 4 : Lier et pousser vers GitHub

GitHub vous donnera des commandes. Utilisez celles-ci :

```bash
# Lier avec GitHub (remplacez votre-username par votre vrai username)
git remote add origin https://github.com/votre-username/gaintemps-ia.git

# Renommer la branche en main
git branch -M main

# Pousser vers GitHub
git push -u origin main
```

## Étape 5 : Configurer l'API en production

Sur votre serveur de production :

```bash
# Cloner le repository
git clone https://github.com/votre-username/gaintemps-ia.git
cd gaintemps-ia/api

# Créer le fichier .env avec vos vraies valeurs
cp .env.example .env
nano .env
# Ajoutez votre vraie clé API Resend

# Lancer avec Docker
docker compose up -d

# Vérifier que ça marche
docker compose logs -f
```

## ⚠️ IMPORTANT - Sécurité

Avant de pousser, vérifiez :
- ✅ `.env` est dans `.gitignore`
- ✅ `.env.example` ne contient PAS de vraies clés
- ✅ Aucun secret n'est committé

## 📝 Commandes Git utiles

```bash
# Voir le statut
git status

# Ajouter des modifications
git add .

# Commit
git commit -m "Description des changements"

# Pousser vers GitHub
git push

# Voir l'historique
git log --oneline
```

## 🎉 C'est fait !

Votre projet est maintenant sur GitHub : `https://github.com/votre-username/gaintemps-ia`
