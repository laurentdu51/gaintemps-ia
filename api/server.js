require('dotenv').config();
const express = require('express');
const { Resend } = require('resend');
const cors = require('cors');

const app = express();
const resend = new Resend(process.env.RESEND_API_KEY);

// Configuration CORS
app.use(cors({
  origin: process.env.ALLOWED_ORIGIN || '*',
  methods: ['POST', 'GET'],
  credentials: true
}));

app.use(express.json());

// Route de santé
app.get('/health', (req, res) => {
  res.json({ 
    status: 'ok', 
    message: 'GainTempsIA API is running',
    timestamp: new Date().toISOString()
  });
});

// Route pour envoyer l'email
app.post('/api/contact', async (req, res) => {
  try {
    const { name, email, phone, company, message } = req.body;

    // Validation des champs requis
    if (!name || !email || !message) {
      return res.status(400).json({ 
        error: 'Les champs nom, email et message sont requis' 
      });
    }

    // Validation basique de l'email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      return res.status(400).json({ 
        error: 'Format d\'email invalide' 
      });
    }

    // Envoi de l'email via Resend
    // NOTE: L'adresse 'from' doit être un domaine vérifié sur Resend
    // Pour tester, vous pouvez utiliser: onboarding@resend.dev
    const { data, error } = await resend.emails.send({
      from: 'GainTempsIA <onboarding@resend.dev>',  // Email de test Resend
      to: 'contact@duhaz.fr',
      replyTo: email,
      subject: `Nouveau contact depuis GainTempsIA - ${name}`,
      html: `
        <h2>Nouveau message de contact</h2>
        <p><strong>Nom :</strong> ${name}</p>
        <p><strong>Email :</strong> ${email}</p>
        <p><strong>Téléphone :</strong> ${phone || 'Non renseigné'}</p>
        <p><strong>Entreprise :</strong> ${company || 'Non renseignée'}</p>
        <hr>
        <h3>Message :</h3>
        <p>${message.replace(/\n/g, '<br>')}</p>
      `,
    });

    if (error) {
      console.error('Erreur Resend:', error);
      return res.status(400).json({ 
        error: 'Erreur lors de l\'envoi de l\'email',
        details: error 
      });
    }

    console.log('Email envoyé avec succès:', data);
    res.json({ 
      success: true, 
      message: 'Message envoyé avec succès !',
      id: data.id 
    });

  } catch (error) {
    console.error('Erreur serveur:', error);
    res.status(500).json({ 
      error: 'Erreur serveur',
      message: error.message 
    });
  }
});

// Gestion des erreurs 404
app.use((req, res) => {
  res.status(404).json({ error: 'Route non trouvée' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 API GainTempsIA lancée sur le port ${PORT}`);
  console.log(`📧 Resend API configurée`);
  console.log(`🌍 CORS autorisé pour: ${process.env.ALLOWED_ORIGIN}`);
});
