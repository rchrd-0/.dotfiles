#!/bin/bash

# FZF theme manager script
# Usage: source ~/.config/fzf/theme.sh [theme_name]
# If no theme name is provided, it will use the current theme or default to carbonfox

# Directory where themes are stored
THEME_DIR="$HOME/.config/fzf/themes"

# Current theme file
CURRENT_THEME_FILE="$HOME/.config/fzf/current_theme"

# Default theme
DEFAULT_THEME="kanagawa"

# Get the theme name from argument or current theme file
if [ -n "$1" ]; then
  THEME="$1"
elif [ -f "$CURRENT_THEME_FILE" ]; then
  THEME=$(cat "$CURRENT_THEME_FILE")
else
  THEME="$DEFAULT_THEME"
fi

# Check if theme file exists
THEME_FILE="$THEME_DIR/$THEME.sh"
if [ ! -f "$THEME_FILE" ]; then
  echo "Theme '$THEME' not found. Using default theme '$DEFAULT_THEME'."
  THEME="$DEFAULT_THEME"
  THEME_FILE="$THEME_DIR/$THEME.sh"
fi

# Reset FZF_DEFAULT_OPTS to remove any previous theme settings
# This is a basic reset - you might need to adjust based on your base settings
export FZF_DEFAULT_OPTS=""

# Source the theme file
source "$THEME_FILE"

# Save the current theme
echo "$THEME" > "$CURRENT_THEME_FILE"

# echo "FZF theme set to: $THEME" 
