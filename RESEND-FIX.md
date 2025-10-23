# 🔧 Correction Erreur 400 - Configuration Resend

## 🐛 Problème Identifié

**Erreur 400 lors de l'envoi d'email** : Le domaine `duhaz.fr` n'est pas vérifié sur Resend.

Resend nécessite que vous vérifiiez votre domaine avant d'envoyer des emails depuis celui-ci.

## ✅ Solution : Vérifier votre domaine sur Resend

### Étape 1 : Accéder aux domaines Resend

1. Allez sur https://resend.com/domains
2. Connectez-vous avec votre compte Resend

### Étape 2 : Ajouter votre domaine

1. Cliquez sur **"Add Domain"**
2. Entrez : `duhaz.fr`
3. Cliquez sur **"Add"**

### Étape 3 : Configurer les enregistrements DNS

Resend vous donnera **3 enregistrements DNS** à ajouter :

#### 1. SPF Record (TXT)
```
Type: TXT
Name: @ (ou vide)
Value: v=spf1 include:_spf.resend.com ~all
TTL: 3600
```

#### 2. DKIM Record (TXT)
```
Type: TXT
Name: resend._domainkey
Value: [Valeur fournie par Resend - longue chaîne]
TTL: 3600
```

#### 3. DMARC Record (TXT) - Optionnel mais recommandé
```
Type: TXT
Name: _dmarc
Value: v=DMARC1; p=none; rua=mailto:contact@duhaz.fr
TTL: 3600
```

### Étape 4 : Ajouter les DNS chez votre registrar

**Où ajouter les DNS ?**
Chez votre fournisseur de nom de domaine (OVH, Gandi, Cloudflare, etc.)

**Exemple avec Cloudflare :**
1. Allez sur https://dash.cloudflare.com
2. Sélectionnez `duhaz.fr`
3. Allez dans **DNS** → **Records**
4. Cliquez sur **Add record**
5. Ajoutez les 3 enregistrements ci-dessus

**Exemple avec OVH :**
1. Allez sur https://www.ovh.com/manager/
2. Sélectionnez votre domaine
3. Allez dans **Zone DNS**
4. Cliquez sur **Ajouter une entrée**
5. Ajoutez les 3 enregistrements

### Étape 5 : Vérifier la configuration

1. Retournez sur https://resend.com/domains
2. Cliquez sur **"Verify"** à côté de `duhaz.fr`
3. Attendez quelques minutes (propagation DNS peut prendre jusqu'à 48h)
4. Le statut devrait passer à **"Verified"** ✅

### Étape 6 : Mettre à jour le code

Une fois vérifié, modifiez `server.js` pour utiliser votre domaine :

```javascript
from: 'GainTempsIA <contact@duhaz.fr>',  // Votre domaine vérifié
```

## 🚀 Solution Temporaire (Pour tester immédiatement)

Si vous voulez tester MAINTENANT sans attendre la vérification DNS :

**Utilisez l'email de test Resend** (déjà fait dans le commit) :

```javascript
from: 'GainTempsIA <onboarding@resend.dev>',
```

Cet email fonctionne immédiatement mais affiche "onboarding@resend.dev" comme expéditeur.

## 📝 Commandes sur Raspberry Pi

Après avoir modifié le code :

```bash
# 1. Récupérer les dernières modifications
cd ~/gaintemps-ia
git pull

# 2. Reconstruire l'API
cd api
docker compose down
docker compose up -d --build

# 3. Vérifier les logs
docker compose logs -f
```

## 🧪 Tester l'envoi

1. Allez sur https://ia.duhaz.fr
2. Remplissez le formulaire de contact
3. Cliquez sur "Envoyer"
4. Vérifiez la console du navigateur (F12)

**Si ça marche** :
- Message de succès : "✓ Message envoyé avec succès !"
- Email reçu à contact@duhaz.fr

**Si erreur 400 persiste** :
- Vérifiez les logs : `docker compose logs -f`
- Vérifiez que le domaine est vérifié sur Resend

## 🔍 Debug

### Vérifier les logs API

```bash
docker compose logs -f
```

Vous devriez voir :
- `🚀 API GainTempsIA lancée sur le port 3000`
- `📧 Resend API configurée`

En cas d'erreur, vous verrez :
- `Erreur Resend: { message: '...', name: '...' }`

### Tester la configuration DNS

```bash
# Vérifier SPF
dig txt duhaz.fr +short | grep spf

# Vérifier DKIM
dig txt resend._domainkey.duhaz.fr +short

# Vérifier DMARC
dig txt _dmarc.duhaz.fr +short
```

## ✅ Checklist

- [ ] Domaine `duhaz.fr` ajouté sur Resend
- [ ] Enregistrements DNS (SPF, DKIM, DMARC) ajoutés
- [ ] Domaine vérifié sur Resend (statut "Verified")
- [ ] Code mis à jour avec le bon email `from`
- [ ] API redémarrée (`docker compose restart`)
- [ ] Formulaire testé
- [ ] Email reçu ✉️

## 💡 Notes Importantes

1. **Propagation DNS** : Peut prendre de quelques minutes à 48h
2. **Email de test** : `onboarding@resend.dev` fonctionne immédiatement
3. **Limite gratuite Resend** : 3000 emails/mois gratuits
4. **Reply-To** : Le champ `replyTo` fonctionne même si `from` est différent

## 📧 Configuration Finale Recommandée

Une fois tout vérifié :

```javascript
from: 'GainTempsIA <contact@duhaz.fr>',   // Domaine vérifié
to: 'contact@duhaz.fr',                   // Votre email
replyTo: email,                            // Email du client
```

Comme ça :
- L'email vient de `contact@duhaz.fr` (professionnel)
- Il arrive à `contact@duhaz.fr` (votre boîte)
- Quand vous cliquez "Répondre", ça répond au client

## 🆘 Besoin d'aide ?

Si le problème persiste :
1. Partagez les logs : `docker compose logs`
2. Vérifiez sur Resend : statut du domaine
3. Testez avec `onboarding@resend.dev` temporairement

Bon courage ! 🚀
