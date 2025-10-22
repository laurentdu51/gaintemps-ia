#!/bin/bash

echo "🔍 Vérification du projet GainTempsIA"
echo "======================================"
echo ""

PROJECT_DIR="/Users/duhaz/projets/gaintemps-ia"
cd "$PROJECT_DIR"

# Couleurs
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Compteurs
OK=0
WARNING=0
ERROR=0

# Fonction de vérification
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✅${NC} $1"
        ((OK++))
    else
        echo -e "${RED}❌${NC} $1 (manquant)"
        ((ERROR++))
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✅${NC} $1/"
        ((OK++))
    else
        echo -e "${RED}❌${NC} $1/ (manquant)"
        ((ERROR++))
    fi
}

echo "📁 Structure des dossiers"
echo "-------------------------"
check_dir "api"
check_dir "frontend"
check_dir "caddy"
echo ""

echo "📄 Fichiers racine"
echo "------------------"
check_file "README.md"
check_file "LICENSE"
check_file ".gitignore"
check_file "DEPLOIEMENT.md"
check_file "ETAPES-FINALES.md"
echo ""

echo "🔧 API"
echo "------"
check_file "api/server.js"
check_file "api/package.json"
check_file "api/Dockerfile"
check_file "api/docker-compose.yml"
check_file "api/.dockerignore"
check_file "api/.env.example"
check_file "api/README.md"
echo ""

echo "🌐 Frontend"
echo "-----------"
check_file "frontend/README.md"
HTML_FILE="frontend/index.html"
if [ -f "$HTML_FILE" ]; then
    FILE_SIZE=$(wc -c < "$HTML_FILE")
    if [ "$FILE_SIZE" -gt 10000 ]; then
        echo -e "${GREEN}✅${NC} $HTML_FILE (${FILE_SIZE} octets - complet)"
        ((OK++))
    else
        echo -e "${YELLOW}⚠️${NC} $HTML_FILE (${FILE_SIZE} octets - incomplet)"
        ((WARNING++))
    fi
else
    echo -e "${RED}❌${NC} $HTML_FILE (manquant)"
    ((ERROR++))
fi
echo ""

echo "🔀 Caddy"
echo "--------"
check_file "caddy/Caddyfile"
check_file "caddy/README.md"
echo ""

echo "📊 Résumé"
echo "========="
echo -e "${GREEN}✅ OK: $OK${NC}"
if [ $WARNING -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Avertissements: $WARNING${NC}"
fi
if [ $ERROR -gt 0 ]; then
    echo -e "${RED}❌ Erreurs: $ERROR${NC}"
fi
echo ""

if [ $ERROR -gt 0 ] || [ $WARNING -gt 0 ]; then
    echo "❗ Actions requises :"
    echo ""
    if [ $ERROR -gt 0 ]; then
        echo "  - Fichiers manquants détectés"
    fi
    if [ $WARNING -gt 0 ]; then
        echo "  - Le fichier HTML frontend/index.html doit être récupéré depuis Claude"
        echo "    Consultez ETAPES-FINALES.md pour les instructions"
    fi
    echo ""
    echo "📖 Lisez le fichier ETAPES-FINALES.md pour plus d'informations"
else
    echo "🎉 Tout est prêt !"
    echo ""
    echo "Prochaines étapes :"
    echo "1. Récupérez le HTML complet depuis Claude (si pas déjà fait)"
    echo "2. Initialisez Git : git init"
    echo "3. Ajoutez les fichiers : git add ."
    echo "4. Commitez : git commit -m 'Initial commit'"
    echo "5. Créez le repo sur GitHub"
    echo "6. Poussez : git push -u origin main"
    echo ""
    echo "📖 Voir DEPLOIEMENT.md pour les instructions complètes"
fi
