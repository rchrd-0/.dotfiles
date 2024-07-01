# source private
source $HOME/.dot-private/.zshrc


# PATH
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$PATH:$HOME/.composer/vendor/bin"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$HOME/.local/bin:$PATH
export PATH="$HOME/scripts:$PATH"
export PATH=$HOME/console-ninja/.bin:$PATH
# expo > 50
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
# expo < 49
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home
# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# pnpm end

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Set zinit directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit if it does not exist
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# p10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# autoload
# autoload -U compinit && compinit
autoload -Uz compinit && compinit

zinit cdreplay -q

# zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light z-shell/F-Sy-H
zinit light Aloxaf/fzf-tab
zinit load agkozak/zsh-z

# omz
zinit snippet OMZP::git/git.plugin.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::theme-and-appearance.zsh

# aliases
alias cat=bat
alias a-s="php artisan serve"
alias a-t="php artisan tinker"
alias np-w="npm run watch"
alias np-b="bash docker/build.sh"
alias np-d="npm run dev"
alias air="~/.air"
alias lg="lazygit"
alias python=python3

# functions
tunnel() {
    if [ "$1" ]; then
        cloudflared tunnel --url "127.0.0.1:$1"
    else
        echo "Please provide a port number. Usage: tunnel <port>"
    fi
}

# keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[1;3D' backward-word  # Alt+Left
bindkey '^[[1;3C' forward-word   # Alt+Right
bindkey -e

# history
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

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z-a-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# variables
export EDITOR=nvim
export VISUAL=nvim
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

# shell integrations
eval "$(fzf --zsh)"
eval "$(thefuck --alias)"
eval "$(fnm env --use-on-cd)"
