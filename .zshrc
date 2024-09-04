# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
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

# PATH
path=(
    /opt/homebrew/bin
    $HOME/.composer/vendor/bin
    $ANDROID_HOME/emulator
    $ANDROID_HOME/platform-tools
    $HOME/.local/bin
    $GOPATH/bin
    $HOME/.rvm/bin
    $path
)
export PATH

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

# brew completions
if type brew &>/dev/null; then
    fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

# source asdf
if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
    . "$HOME/.asdf/asdf.sh"
    # asdf completions
    fpath=(${ASDF_DIR}/completions $fpath)
fi

# load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# zinit plugins, snippets
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light z-shell/F-Sy-H
zinit snippet OMZP::git/git.plugin.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::theme-and-appearance.zsh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zinit completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z-a-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
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

# aliases
alias cat=bat
alias a-s="php artisan serve"
alias a-t="php artisan tinker"
alias d-b="bash docker/build.sh"
alias np-w="npm run watch"
alias np-d="npm run dev"
alias np-s="npm run start"
alias air="~/.air"
alias lg="lazygit"
alias services="~/services"

# keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[1;3D' backward-word  # Alt+Left
bindkey '^[[1;3C' forward-word   # Alt+Right
bindkey -e
bindkey '\e' autosuggest-clear

# tools and integrations integrations
eval "$(fzf --zsh)"
eval "$(thefuck --alias)"
eval "$(fnm env --use-on-cd)"
eval "$(zoxide init zsh)"
