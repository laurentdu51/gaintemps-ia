#!/bin/bash

echo "🌐 GainTempsIA - Récupération du fichier HTML"
echo "=============================================="
echo ""
echo "Le fichier HTML complet avec l'API intégrée est disponible dans l'artifact Claude."
echo ""
echo "📋 Instructions pour récupérer le HTML :"
echo ""
echo "1. Dans la conversation Claude, trouvez l'artifact 'GainTempsIA - Site Web'"
echo "2. Cliquez sur l'icône de téléchargement ou copie en haut à droite"
echo "3. Le fichier sera sauvegardé automatiquement"
echo ""
echo "OU"
echo ""
echo "Ouvrez cette URL dans votre navigateur et sauvegardez la page :"
echo "→ Cliquez sur l'artifact dans Claude"
echo "→ Utilisez Cmd+S pour sauvegarder"
echo "→ Sauvegardez comme : /Users/duhaz/projets/gaintemps-ia/frontend/index.html"
echo ""
echo "✅ Une fois fait, vous pouvez continuer avec Git !"

# Vérifier si le fichier HTML existe et a du contenu
HTML_FILE="/Users/duhaz/projets/gaintemps-ia/frontend/index.html"
if [ -f "$HTML_FILE" ]; then
    FILE_SIZE=$(wc -c < "$HTML_FILE")
    if [ "$FILE_SIZE" -gt 10000 ]; then
        echo ""
        echo "✅ Le fichier HTML existe et semble complet ($FILE_SIZE octets)"
        echo "   Vous pouvez passer à l'étape Git !"
    else
        echo ""
        echo "⚠️  Le fichier HTML existe mais semble incomplet ($FILE_SIZE octets)"
        echo "   Veuillez le remplacer par le fichier complet"
    fi
else
    echo ""
    echo "❌ Le fichier HTML n'existe pas encore"
fi
