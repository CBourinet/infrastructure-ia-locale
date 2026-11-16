#!/usr/bin/env bash
# Crée les 5 utilisateurs (manager) + un espace de travail dédié par personne (Charles inclus).
# Prérequis : 1) multi-utilisateurs activé et compte admin Charles créé dans l'interface
#             2) clé API générée : Paramètres > Clés API développeur
# Usage : ANYTHINGLLM_URL=https://ia.exemple.fr API_KEY=xxx ./create-users.sh ../secrets/MOTS_DE_PASSE.md
# Vérifier les routes dans la doc Swagger : $ANYTHINGLLM_URL/api/docs
set -euo pipefail
: "${ANYTHINGLLM_URL:?}" "${API_KEY:?}"; F="${1:?fichier mots de passe}"
H=(-H "Authorization: Bearer $API_KEY" -H "Content-Type: application/json")
while IFS='|' read -r _ name user pass role _; do
  user=$(echo "$user" | xargs); pass=$(echo "$pass" | xargs); role=$(echo "$role" | xargs); name=$(echo "$name" | xargs)
  [[ "$role" == "manager" ]] || continue   # Charles (admin) déjà créé à la main
  curl -fsS "${H[@]}" -X POST "$ANYTHINGLLM_URL/api/v1/admin/users/new" \
    -d "{\"username\":\"$user\",\"password\":\"$pass\",\"role\":\"manager\"}" >/dev/null && echo "user $user créé"
done < <(grep -E '^\| [^|]+\| [a-z.]+ \|' "$F")
echo "Ensuite : créer un espace par personne dans l'interface (voir docs/FICHE-DEBUTANT.md) et l'assigner via Admin > Espaces de travail."
