#!/usr/bin/env zsh
#
# FZF theme manager
#
# Usage:
#   source ~/.config/fzf/theme.sh [theme_name]
#
# If no theme is provided:
#   1. Use the last saved theme
#   2. Fallback to DEFAULT_THEME
#

# ---------- Paths ----------
FZF_CONFIG_DIR="$HOME/.config/fzf"
THEME_DIR="$FZF_CONFIG_DIR/themes"
CURRENT_THEME_FILE="$FZF_CONFIG_DIR/current_theme"

# ---------- Defaults ----------
DEFAULT_THEME="rose"

# ---------- Resolve theme ----------
if [ -n "$1" ]; then
  THEME="$1"
elif [ -f "$CURRENT_THEME_FILE" ]; then
  THEME="$(<"$CURRENT_THEME_FILE")"
else
  THEME="$DEFAULT_THEME"
fi

THEME_FILE="$THEME_DIR/$THEME.sh"

if [ ! -f "$THEME_FILE" ]; then
  echo "FZF theme '$THEME' not found — falling back to '$DEFAULT_THEME'"
  THEME="$DEFAULT_THEME"
  THEME_FILE="$THEME_DIR/$THEME.sh"
fi

# ---------- Reset previous theme ----------
unset FZF_THEME_OPTS

# ---------- Load theme ----------
# Theme file must export FZF_THEME_OPTS only
source "$THEME_FILE"

# ---------- Base (non-color) defaults ----------
# export FZF_BASE_OPTS="
#   --height=~40%
#   --layout=reverse
#   --border=none
#   --preview-window=right:60%:wrap
#   --preview '
#     if [[ -d {} ]]; then
#       ls --color=always {}
#     elif [[ -f {} ]]; then
#       bat --style=numbers --color=always {}
#     else
#       echo {}
#     fi
#   '
#   --bind 'ctrl-/:toggle-preview'
# "

export FZF_BASE_OPTS="
  --layout=reverse
"

# ---------- Apply theme ----------
export FZF_DEFAULT_OPTS="$FZF_BASE_OPTS $FZF_THEME_OPTS"

# ---------- Persist theme ----------
mkdir -p "$FZF_CONFIG_DIR"
echo "$THEME" >|"$CURRENT_THEME_FILE"
