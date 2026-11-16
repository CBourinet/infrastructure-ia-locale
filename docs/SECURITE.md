# Sécurité — AnythingLLM sur VPS

## Mesures prévues dans le déploiement
- HTTPS obligatoire (Caddy + Let's Encrypt), HSTS, en-têtes de sécurité.
- Port 3001 lié à 127.0.0.1 : jamais exposé directement.
- Pare-feu UFW (22, 80, 443 seulement) + fail2ban.
- Mode multi-utilisateurs : aucun accès sans compte ; secrets JWT/SIG aléatoires ; télémétrie désactivée.
- Mots de passe uniques, dans `secrets/MOTS_DE_PASSE.md` (ignoré par git).
- Container `no-new-privileges`.

## À faire par l'administrateur (Charles)
1. Activer le mode multi-utilisateurs dès le premier accès (sinon l'instance est ouverte à tous !).
2. Faire changer les mots de passe à la première connexion ; supprimer ensuite le fichier de mots de passe.
3. Durcir SSH : clé uniquement, `PermitRootLogin no`, `PasswordAuthentication no`.
4. Paramètres > Confidentialité : vérifier que les données ne vont qu'au fournisseur choisi (Mistral).
5. Mises à jour mensuelles : `docker compose pull && docker compose up -d` ; `apt upgrade`.
6. Sauvegardes : copier régulièrement `deploy/storage/` (hors VPS).
7. Révoquer la clé API développeur après création des comptes.

## Limites à connaître
- Rôle « manager » : peut créer des espaces et gérer des documents, pas les réglages système.
- Les textes envoyés au modèle transitent par l'API Mistral : pas de données hautement sensibles sans accord DPA.
- Sous-domaine à faire pointer (enregistrement A) vers l'IP du VPS avant le démarrage.
