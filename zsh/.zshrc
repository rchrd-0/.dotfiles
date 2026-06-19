
# p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source local secrets
[ -f "$HOME/.zsh.secrets" ] && source "$HOME/.zsh.secrets"

# source functions
for zsh_function_file in "$HOME/.zsh/functions"/*.zsh(.N); do
  source "$zsh_function_file"
done

# env variables
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=nvim
export ANDROID_HOME=$HOME/Library/Android/sdk
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export BUN_INSTALL="$HOME/.bun"
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/.ripgreprc

# PATH
path=(
    $HOME/qmk_toolchains_macosARM64/bin
    /opt/homebrew/bin
    $HOME/.composer/vendor/bin
    $HOME/.local/bin
    $HOME/.rvm/bin
    $ANDROID_HOME/emulator
    $ANDROID_HOME/platform-tools
    $BUN_INSTALL/bin
    $HOME/.config/herd-lite/bin
    $HOME/.config/emacs/bin
    $path
)
export PATH


# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# zinit setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# brew completions
if type brew &>/dev/null; then
    fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

# Load FZF theme
[ -f "$HOME/.config/fzf/theme.sh" ] && source "$HOME/.config/fzf/theme.sh"

# completions -> fpath
fpath=(
    $HOME/.zsh/completions
    $fpath
)

# load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# zinit plugins, snippets
# zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light z-shell/F-Sy-H
zinit snippet OMZP::git/git.plugin.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::theme-and-appearance.zsh

# zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

zle_highlight+=(paste:none)

# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zinit completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z-a-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*' complete-options false
zstyle ':fzf-tab:*' fzf-flags $=FZF_THEME_OPTS
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# history settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
# setopt hist_ignore_dups
setopt extendedglob globdots

# aliases
[ -f "$HOME/.zsh/aliases.zsh" ] && source "$HOME/.zsh/aliases.zsh"

# keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

bindkey '^[[1;3D' backward-word  # Alt+Left
bindkey '^[[1;3C' forward-word   # Alt+Right
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word

bindkey '^[k' kill-line
bindkey '^[u' backward-kill-line
# bindkey '\e' autosuggest-clear
bindkey '^g' autosuggest-clear

# tools and integrations 
eval "$(fzf --zsh)"
eval "$(thefuck --alias)"
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
eval "$(oh-my-posh init zsh --config "$HOME/.config/ohmyposh/rchrd.jsonc")"
eval "$(codex completion zsh)"

[ -f "$HOME/.deno/env" ] && source "$HOME/.deno/env"

export SERVICES="$HOME/services"

# Added by Antigravity CLI installer
export PATH="/Users/rchrd/.local/bin:$PATH"
