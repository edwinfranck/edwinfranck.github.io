#!/usr/bin/env bash
# Prévisualisation locale du portfolio, accessible depuis le téléphone.
#
#   ./serve.sh          port 8080 par défaut
#   ./serve.sh 9000     autre port
#
# Le téléphone doit être sur le même réseau Wi-Fi que cette machine.
# Rien n'est publié : tout reste sur ta machine tant que tu n'as pas dit
# de pousser.

set -e
PORT="${1:-8080}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IP="$(hostname -I 2>/dev/null | awk '{print $1}')"

cd "$DIR"

echo
echo "  Portfolio servi depuis : $DIR"
echo
echo "  Sur cette machine   ->  http://localhost:$PORT"
if [ -n "$IP" ]; then
  echo "  Sur ton téléphone   ->  http://$IP:$PORT"
  echo
  echo "  Démo des ouvertures ->  http://$IP:$PORT/splash-demo.html"
fi
echo
echo "  Ctrl+C pour arrêter."
echo
echo "  Note : le service worker met en cache. Si tu ne vois pas tes"
echo "  changements, recharge en vidant le cache, ou ouvre l'adresse"
echo "  avec ?nocache=1 puis recharge."
echo

exec python3 -m http.server "$PORT" --bind 0.0.0.0
