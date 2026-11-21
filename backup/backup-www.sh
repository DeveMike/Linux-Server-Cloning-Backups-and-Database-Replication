#!/usr/bin/env bash
set -euo pipefail

LAHDE="ubuntu@192.168.1.170:/var/www/html/"
AVAIN="/root/.ssh/sync_ed25519"
KOHDE="/var/backups/www-from-a"
LOKI="/var/log/www-backup.log"

AIKA="$(date +%F_%H%M)"
mkdir -p "$KOHDE"
chmod 700 "$KOHDE"

TILA=0
rsync -a -e "ssh -i $AVAIN -o BatchMode=yes" "$LAHDE" "$KOHDE/$AIKA/" || TILA=$?

# virhe 24 - > tiedosto katosi kesken
if [ "$TILA" -eq 0 ] || [ "$TILA" -eq 24 ]; then
    echo "$(date '+%F %T') OK   $AIKA" >> "$LOKI"
else
    echo "$(date '+%F %T') FAIL $AIKA (rsync $TILA)" >> "$LOKI"
    rm -rf "$KOHDE/$AIKA"
    exit 1
fi
