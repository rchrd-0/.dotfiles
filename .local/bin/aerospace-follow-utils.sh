#!/usr/bin/env bash

# Usage:
#   aerospace-follow-utils.sh Spotify Bitwarden
#   aerospace-follow-utils.sh Spotify --minimize WhatsApp Slack

CURRENT_WS="$(aerospace list-workspaces --focused)"

[ "$#" -eq 0 ] && exit 0

MINIMIZE_MODE=0

for ARG in "$@"; do
  if [ "$ARG" = "--minimize" ]; then
    MINIMIZE_MODE=1
    continue
  fi

  aerospace list-windows --app-bundle-id "$ARG" --monitor all |
    awk '{print $1}' |
    while read -r WIN_ID; do
      [ -z "$WIN_ID" ] && continue

      aerospace move-node-to-workspace --window-id "$WIN_ID" "$CURRENT_WS"

      if [ "$MINIMIZE_MODE" -eq 1 ]; then
        aerospace macos-native-minimize --window-id "$WIN_ID"
      fi
    done
done
