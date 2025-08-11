# completions -> fpath
if [[ ":$FPATH:" != *":/Users/rchrd/.zsh/completions:"* ]]; then export FPATH="/Users/rchrd/.zsh/completions:$FPATH"; fi

# p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source private
[ -f $HOME/.dot-private/.zshrc ] && source $HOME/.dot-private/.zshrc

# source functions
[ -f $HOME/.zsh_functions ] && source $HOME/.zsh_functions

# env variables
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=nvim
export ANDROID_HOME=$HOME/Library/Android/sdk
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export GOPATH=$HOME/go
export BUN_INSTALL="$HOME/.bun"
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/.ripgreprc

# PATH
path=(
    /opt/homebrew/bin
    $HOME/.composer/vendor/bin
    $HOME/.local/bin
    $GOPATH/bin
    $HOME/.rvm/bin
    $ANDROID_HOME/emulator
    $ANDROID_HOME/platform-tools
    $BUN_INSTALL/bin
    $HOME/.codeium/windsurf/bin
    $HOME/.config/herd-lite/bin
    $path
)
export PATH

# export PATH="/Users/rchrd/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/Users/rchrd/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"


# pnpm
export PNPM_HOME="/Users/rchrd/Library/pnpm"
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

# completions
fpath=(~/.zsh.d $fpath)

# # brew completions
if type brew &>/dev/null; then
    fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

# load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# zinit plugins, snippets
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light Aloxaf/fzf-tab
# zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light z-shell/F-Sy-H
zinit snippet OMZP::git/git.plugin.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::theme-and-appearance.zsh
# zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

zle_highlight=(paste:special)

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zinit completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z-a-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*' complete-options false
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
setopt hist_ignore_dups
setopt extendedglob globdots

# aliases
alias vim="nvim"
alias cat=bat
alias a-s="php artisan serve"
alias a-t="php artisan tinker"
alias d-b="bash docker/build.sh"
alias np-w="npm run watch"
alias np-d="npm run dev"
alias np-b="npm run build"
alias np-s="npm run start"
alias np-l="npm run lint"
alias np-f="npm run format"
alias air="~/.air"
alias lg="lazygit"
alias services="cd ~/services"
alias tmux="tmux_smart"
alias gbsc="git branch --show-current"
alias lazyvim='NVIM_APPNAME="lazyvim" nvim'
alias theme='~/.local/bin/theme-switcher'
alias themeC='~/.local/bin/theme-switcher-charm'

# keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[1;3D' backward-word  # Alt+Left
bindkey '^[[1;3C' forward-word   # Alt+Right
bindkey '^[k' kill-line
bindkey '^[u' backward-kill-line
bindkey '\e' autosuggest-clear

# Load FZF theme
[ -f "$HOME/.config/fzf/theme.sh" ] && source "$HOME/.config/fzf/theme.sh"

# tools and integrations 
eval "$(fzf --zsh)"
eval "$(thefuck --alias)"
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
# eval "$(starship init zsh)"
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/rchrd.json)"

[ -f "$HOME/.deno/env" ] && source "$HOME/.deno/env"
