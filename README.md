# Infrastructure IA locale — AnythingLLM (VPS Hostinger)

1. DNS : enregistrement A `ia.votredomaine` → IP du VPS.
2. Sur le VPS : copier `deploy/`, `cp .env.example .env`, remplir (clé Mistral, `openssl rand -hex 32` ×3), `sudo ./setup-vps.sh`.
3. Ouvrir https://domaine, **activer le mode multi-utilisateurs** et créer le compte admin Charles.
4. Générer une clé API, lancer `create-users.sh`, créer 1 espace par personne.
5. Lire `docs/SECURITE.md`, distribuer `docs/FICHE-DEBUTANT.md`.

Mots de passe : `secrets/MOTS_DE_PASSE.md` (non versionné).
