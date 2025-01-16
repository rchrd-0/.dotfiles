export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts/"

# kanagawa fzf
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#2A2A37 \
  --color=bg:#1F1F28 \
  --color=border:#7E9CD8 \
  --color=fg:#DCD7BA \
  --color=gutter:#1F1F28 \
  --color=header:#FF9E3B \
  --color=hl+:#7AA89F \
  --color=hl:#7AA89F \
  --color=info:#727169 \
  --color=marker:#E46876 \
  --color=pointer:#E46876 \
  --color=prompt:#7AA89F \
  --color=query:#DCD7BA:regular \
  --color=scrollbar:#7E9CD8 \
  --color=separator:#FF9E3B \
  --color=spinner:#E46876"

# rose-pine fzf
# export FZF_DEFAULT_OPTS="
# 	--color=fg:#908caa,bg:#191724,hl:#ebbcba
# 	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
# 	--color=border:#403d52,header:#31748f,gutter:#191724
# 	--color=spinner:#f6c177,info:#9ccfd8
# 	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
# 	--layout=reverse"

# tokyonight fzf
# export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
#   --highlight-line \
#   --info=inline-right \
#   --ansi \
#   --layout=reverse \
#   --border=none
#   --color=bg+:#283457 \
#   --color=bg:#16161e \
#   --color=border:#27a1b9 \
#   --color=fg:#c0caf5 \
#   --color=gutter:#16161e \
#   --color=header:#ff9e64 \
#   --color=hl+:#2ac3de \
#   --color=hl:#2ac3de \
#   --color=info:#545c7e \
#   --color=marker:#ff007c \
#   --color=pointer:#ff007c \
#   --color=prompt:#2ac3de \
#   --color=query:#c0caf5:regular \
#   --color=scrollbar:#27a1b9 \
#   --color=separator:#ff9e64 \
#   --color=spinner:#ff007c \
# "

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
