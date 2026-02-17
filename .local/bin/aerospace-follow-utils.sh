#!/usr/bin/env bash

# Usage:
#   aerospace-follow-utils.sh "Spotify" "Bitwarden" "WhatsApp"

CURRENT_WS="$(aerospace list-workspaces --focused)"

# If no apps passed, nothing to do
[ "$#" -eq 0 ] && exit 0

for APP in "$@"; do
  aerospace list-windows --app-bundle-id "$APP" --monitor all |
    awk '{print $1}' |
    while read -r WIN_ID; do
      [ -z "$WIN_ID" ] && continue
      aerospace move-node-to-workspace --window-id "$WIN_ID" "$CURRENT_WS"
    done
done
