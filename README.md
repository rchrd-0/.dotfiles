# Dotfiles

Stow-managed packages in this repo:

- `config` -> `~/.config`
- `local` -> `~/.local`
- `stow` -> `~/.stow-global-ignore` (shared ignore rules, including `.DS_Store`)
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
stow -t ~ stow
stow -t ~ config local vim zsh
```

## Project picker

`pick-project` shares the zoxide directory filters, fzf theme, and keyboard
settings used by `tmux-sessionizer`, `herdr-sessionizer`, and `rex-sessionizer`.
It prints an absolute path on selection, or nothing on cancellation. Errors
return a nonzero exit status. `pick-project --list` shows the home-relative
candidates in zoxide order without opening fzf.

Each sessionizer also accepts a directory argument to bypass the picker. Rex's
wrapper requires the locally configured `sessionizer_go` action.
