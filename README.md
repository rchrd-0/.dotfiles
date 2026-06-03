# Dotfiles

Stow-managed packages in this repo:

- `config` -> `~/.config`
- `local` -> `~/.local`
- `vim` -> `~/.vim`, `~/.vimrc`
- `zsh` -> `~/.zsh`, `~/.zprofile`, `~/.zshrc`

## Restow

Run:

```bash
./scripts/stow.sh
```

This applies all current packages to `$HOME`.

## Manual Stow

If needed:

```bash
stow -t ~ config local vim zsh
```
