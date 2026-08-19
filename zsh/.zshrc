# environment
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=nvim
export ANDROID_HOME=$HOME/Library/Android/sdk
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/.ripgreprc
export SERVICES="$HOME/services"

# keep PATH entries unique
typeset -U path PATH

path=(
    $HOME/qmk_toolchains_macosARM64/bin
    /opt/homebrew/bin
    $HOME/.composer/vendor/bin
    $HOME/.local/bin
    $ANDROID_HOME/emulator
    $ANDROID_HOME/platform-tools
    $HOME/.config/herd-lite/bin
    $HOME/.config/emacs/bin
    $HOME/.bun/bin
    $path
)

export PATH

# local secrets, functions
[ -f "$HOME/.zsh.secrets" ] && source "$HOME/.zsh.secrets"

for zsh_function_file in "$HOME/.zsh/functions"/*.zsh(.N); do
  source "$zsh_function_file"
done

# shell opts, history
setopt extendedglob globdots
setopt globdots

HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTFILE="$HOME/.zsh_history"

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups

HISTDUP=erase

# zinit setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# fzf
[ -f "$HOME/.config/fzf/theme.sh" ] && source "$HOME/.config/fzf/theme.sh"

eval "$(fzf --zsh)"

# completion sources must be on fpath before compinit
fpath=(
  "$HOME/.zsh/completions"
  "/opt/homebrew/share/zsh/site-functions"
  $fpath
)

zinit light zsh-users/zsh-completions

autoload -Uz compinit
compinit

autoload bashcompinit
bashcompinit
if (( $+commands[aws_completer] )); then
  complete -C "${commands[aws_completer]}" aws
fi

# fzf-tab must load after compinit
zinit light Aloxaf/fzf-tab

# zinit plugins, snippets
zinit light zsh-users/zsh-autosuggestions
zinit light z-shell/F-Sy-H

zinit snippet OMZP::git/git.plugin.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::theme-and-appearance.zsh

zinit cdreplay -q

zle_highlight+=(paste:none)

# zinit completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z-a-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*' complete-options false

zstyle ':fzf-tab:*' fzf-flags $=FZF_THEME_OPTS
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# aliases
[ -f "$HOME/.zsh/aliases.zsh" ] && source "$HOME/.zsh/aliases.zsh"

# keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word

bindkey '^[k' kill-line
bindkey '^[u' backward-kill-line

bindkey '^g' autosuggest-clear

# tools and integrations
eval "$(thefuck --alias)"
eval "$(zoxide init zsh)"

eval "$("$HOME/.local/bin/mise" activate zsh)"

eval "$(oh-my-posh init zsh --config "$HOME/.config/ohmyposh/rchrd.jsonc")"

for _f in ${HOME}/.config/herdr/plugins/github/herdr-automatic-rename-*/shell/hook.zsh(N); do
  source $_f; break
done

eval "$(codex completion zsh)"
