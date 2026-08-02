#!/usr/bin/env bash
# Prévisualisation locale du portfolio, accessible depuis le téléphone.
#
#   ./serve.sh          cherche un port libre à partir de 8080
#   ./serve.sh 9000     commence la recherche à 9000
#
# Le téléphone doit être sur le même réseau Wi-Fi que cette machine.
# Rien n'est publié : tout reste sur ta machine.

set -e
WANTED="${1:-8080}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IP="$(hostname -I 2>/dev/null | awk '{print $1}')"

# Cherche le premier port réellement libre à partir de celui demandé.
PORT="$(python3 - "$WANTED" <<'PY'
import socket, sys
start = int(sys.argv[1])
for p in range(start, start + 60):
    s = socket.socket()
    try:
        s.bind(("0.0.0.0", p))
        print(p)
        break
    except OSError:
        pass
    finally:
        s.close()
else:
    print(0)
PY
)"

if [ "$PORT" = "0" ]; then
  echo
  echo "  Aucun port libre entre $WANTED et $((WANTED + 59))."
  echo "  Essaie : ./serve.sh 9500"
  echo
  exit 1
fi

if [ "$PORT" != "$WANTED" ]; then
  BUSY="$(ss -ltnp 2>/dev/null | grep ":$WANTED " | grep -oP 'users:\(\("\K[^"]+' | head -1)"
  echo
  echo "  Le port $WANTED est déjà occupé${BUSY:+ par $BUSY}, je prends le $PORT."
fi

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
echo "  Si le téléphone montre une vieille version, c'est le service worker."
echo "  Ouvre l'adresse avec ?v=2 (n'importe quel numéro qui change), ou"
echo "  dans Chrome : menu ⋮ > Historique > Effacer les données de navigation."
echo

exec python3 -m http.server "$PORT" --bind 0.0.0.0
