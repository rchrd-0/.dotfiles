tunnel() {
    local port="${1:-}"

    if [ "$1" ]; then
        port="$1"
    else
        port=$(gum input --prompt "Enter port number: " --placeholder "8080")
        if [ -z "$port" ]; then
            gum style --foreground 196 "Error: Port number is required."
            return 1
        fi
    fi

    if ! [[ "$port" =~ ^[1-9][0-9]*$ ]]; then
        gum style --foreground 196 "Error: Invalid port number. Please enter a positive integer."
        return 1
    fi

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

vc() {
  git add -A
  git status --short
  echo
  read "reply?Commit these changes? [y/N] "
  [[ "$reply" == "y" ]] || return 1
  git commit -m "update: $(date +%Y%m%d)"
  git push
}

opencode() {
  OPENCODE_ENABLE_EXA=1 command opencode "$@"
}

_herdr_session_select() {
  local prompt="$1"
  local session_table

  setopt local_options pipe_fail

  command -v jq >/dev/null || {
    print -u2 "hs: jq is required"
    return 1
  }

  command -v fzf >/dev/null || {
    print -u2 "hs: fzf is required"
    return 1
  }

  session_table="$(
    command herdr session list --json |
      command jq -r '
        def pad($text; $width):
          $text + (" " * ($width - ($text | length)));

        .sessions as $sessions
        | (["name"] + [$sessions[].name] | map(length) | max) as $name_width
        | (["status", "running", "stopped"] | map(length) | max) as $status_width
        | (pad("name"; $name_width) + "  " + pad("status"; $status_width) + "  directory" + "\t"),
          ($sessions[]
            | (if .running then "running" else "stopped" end) as $status
            | pad(.name; $name_width) + "  " + pad($status; $status_width) + "  " + .session_dir + "\t" + .name)
      '
  )" || return

  [[ "$session_table" == *$'\n'* ]] || {
    print -u2 "hs: no Herdr sessions found"
    return 1
  }

  print -r -- "$session_table" |
    command fzf \
      --delimiter=$'\t' \
      --nth=1 \
      --with-nth=1 \
      --accept-nth=2 \
      --header-lines=1 \
      --height='~50%' \
      --layout=reverse \
      --border \
      --prompt="$prompt"
}

hs() {
  _herdr_session_select "Herdr session: "
}

ha() {
  (( $# <= 1 )) || {
    print -u2 "usage: ha [session-name]"
    return 2
  }

  local session_name="${1:-}"
  if [[ -z "$session_name" ]]; then
    session_name="$(_herdr_session_select "Attach session: ")" || return
  fi

  command herdr session attach "$session_name"
}

hx() {
  (( $# <= 1 )) || {
    print -u2 "usage: hx [session-name]"
    return 2
  }

  local session_name="${1:-}"
  if [[ -z "$session_name" ]]; then
    session_name="$(_herdr_session_select "Stop session: ")" || return
  fi

  command herdr session stop "$session_name"
}

h() {
  local session_name
  session_name="$(tsn)" || return

  ha "$session_name"
}
