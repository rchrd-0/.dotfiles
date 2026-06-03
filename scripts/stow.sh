#!/usr/bin/env bash
set -euo pipefail

repo="$HOME/.dotfiles"
target="$HOME"

cd "$repo"
stow -t "$target" config local vim zsh
