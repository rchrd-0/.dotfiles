#!/usr/bin/env bash

# Usage:
#   export BW_SESSION="$(bw unlock --raw)"
#   ~/.dotfiles/scripts/sync-secrets.sh
#   bw lock
#   unset BW_SESSION

set -euo pipefail

out_file="$HOME/.zsh.secrets"
config_file="$HOME/.config/dotfiles/config.env"

: "${BW_SESSION:?BW_SESSION is not set. Run: export BW_SESSION=\$(bw unlock --raw)}"

[ -f "$config_file" ] || {
  echo "Missing $config_file" >&2
  exit 1
}

# shellcheck disable=SC1090
source "$config_file"

openrouter_dev_key="$(bw get password "$BW_OPENROUTER_ITEM_ID" --session "$BW_SESSION")"
codexlb_key="$(bw get password "$BW_CODEX_LB_ID" --session "$BW_SESSION")"
inception_key="$(bw get password "$BW_INCEPTION_LABS_ID" --session "$BW_SESSION")"

c7_key="$(bw get password "$BW_C7_ITEM_ID" --session "$BW_SESSION")"
exa_key="$(bw get password "$BW_EXA_ITEM_ID" --session "$BW_SESSION")"

umask 177

cat >"$out_file" <<EOF
export OPENROUTER_API_KEY=$(printf '%q' "$openrouter_dev_key")
export CODEX_LB_API_KEY=$(printf '%q' "$codexlb_key")
export INCEPTION_LABS_API_KEY=$(printf '%q' "$inception_key")

export C7_API_KEY=$(printf '%q' "$c7_key")
export EXA_API_KEY=$(printf '%q' "$exa_key")
EOF

echo "Wrote $out_file"
echo "Reminder: bw lock && unset BW_SESSION"
