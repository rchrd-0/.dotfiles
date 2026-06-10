tunnel() {
    local port

    if [ "$1" ]; then
        port="$1"
    else
        port=$(gum input --prompt "Enter port number: " --placeholder "8080")
        if [ -z "$port" ]; then
            gum style --foreground 196 "Error: Port number is required."
            return 1
        fi
    fi

      # Verify port is a positive integer
    if ! [[ "$port" =~ ^[1-9][0-9]*$ ]]; then
        gum style --foreground 196 "Error: Invalid port number. Please enter a positive integer."
        return 1
    fi

    # Verify port is within valid range (1-65535)
    if [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
        gum style --foreground 196 "Error: Port number must be between 1 and 65535."
        return 1
    fi

    gum style \
        --border double \
        --align center \
        --width 50 \
        --margin "0 0" \
        --padding "0 0" \
        "Cloudflare tunnel" \
        "Port: $(gum style --foreground 39 "$port")"

    gum spin --spinner dot --title "Starting tunnel on port $port..." -- sleep 1

    cloudflared tunnel --url "localhost:$port"

}

tmux_smart() {
    if [[ $# -eq 0 ]]; then
        tmux attach || tmux new
    else
        command tmux "$@"
    fi
}

vaultcommit() {
  git add -A
  git status --short
  echo
  read "reply?Commit these changes? [y/N] "
  [[ "$reply" == "y" ]] || return 1
  git commit -m "update: $(date +%Y%m%d)"
  git push
}
