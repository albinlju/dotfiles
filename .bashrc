#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set to superior editing mode
set -o vi

# keybinds
bind -x '"\C-l":clear'
# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

export VISUAL=nvim
export EDITOR=nvim
export TERM=screen-256color

# config
export BROWSER="chrome"

# directories
export REPOS="$HOME/Repos"
export GITUSER="albinlju"
export GHREPOS="$REPOS/github.com/$GITUSER"
export NIXSHELL="$HOME/dotfiles/nix/shells"
export NIXPROFILES="$HOME/dotfiles/nix/profiles"

# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~

PATH="${PATH:+${PATH}:}$HOME/.local/bin:$HOME/dotnet" # appending

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

# This function is stolen from rwxrob

clone() {
  local repo="$1" user
  local repo="${repo#https://github.com/}"
  local repo="${repo#git@github.com:}"
  if [[ $repo =~ / ]]; then
    user="${repo%%/*}"
  else
    user="$GITUSER"
    [[ -z "$user" ]] && user="$USER"
  fi
  local name="${repo##*/}"
  local userd="$REPOS/github.com/$user"
  local path="$userd/$name"
  [[ -d "$path" ]] && cd "$path" && return
  mkdir -p "$userd"
  cd "$userd"
  echo gh repo clone "$user/$name" -- --recurse-submodule
  gh repo clone "$user/$name" -- --recurse-submodule
  cd "$name"
} && export -f clone

# Function to choose/switch nix shell file
nixshell() {
  if [ -z "$1" ]; then
    echo "Usage: nixshell <shell-name>"
    ls "$NIXSHELL"
    return 1
  fi
  nix develop "$NIXSHELL/$1"
}
nixprofile() {
  if [ -z "$1" ]; then
    echo "Usage: nixprofile <profile-name>"
    ls "$NIXPROFILES"
    retirn 1
  fi
  nix profile install "$NIXPROFILES/$1"
}
alias nxs=nixshell
alias nxp=nixprofile

NODE_PROXY_SCRIPT="$HOME/dotfiles/proxy.js"
export NODE_PROXY_PID=""
start_proxy() {
  if [ ! -f "$NODE_PROXY_SCRIPT" ]; then
    echo "Error: Proxy script not found at $NODE_PROXY_SCRIPT"
    echo "Please ensure the path is correct and the file exists."
    return 1
  fi

  if [ -n "$NODE_PROXY_PID" ] && ps -p "$NODE_PROXY_PID" >/dev/null; then
    echo "Node.js proxy already running with PID: $NODE_PROXY_PID"
    echo "To restart, first use: stop_proxy"
    return 1
  fi

  echo "Starting Node.js proxy..."
  # Pass all arguments directly to the Node.js script
  node "$NODE_PROXY_SCRIPT" "$@" &
  NODE_PROXY_PID=$! # Store the PID of the background process

  # Give the proxy a moment to start and print its initial messages
  sleep 2

  if ps -p "$NODE_PROXY_PID" >/dev/null; then
    echo "Node.js proxy started successfully (PID: $NODE_PROXY_PID)."
    echo "For detailed output, check the terminal where it was launched, or redirect output."
    echo "Use 'stop_proxy' to stop it."
  else
    echo "Failed to start Node.js proxy. Check for errors above."
    NODE_PROXY_PID="" # Clear PID if start failed
    return 1
  fi
}

stop_proxy() {
  local target_pid=""

  if [ -n "$1" ]; then
    target_pid="$1"
    echo "Attempting to stop Node.js proxy with provided PID: $target_pid"
  elif [ -z "$NODE_PROXY_PID" ]; then
    target_pid="$_NODE_PROXY_PID"
    echo "Attempting to stop Node.js proxy with stored PID: $target_pid"
    echo "Node.js proxy is not currently running (no PID stored)."
  else
    echo "Node.js proxy is not currently running (no PID stored and no PID provided)."
    return 0
  fi

  if ps -p "$target_pid" >/dev/null; then
    echo "Stopping Node.js proxy (PID: $NODE_PROXY_PID)..."
    kill "$target_pid" 2>/dev/null
    wait "$target_pid" 2>/dev/null # Wait for it to terminate
    echo "Node.js proxy stopped."
  else
    echo "Node.js proxy (PID: $target_pid) was not found or already stopped."
  fi

  if [ "$target_pid" = "$NODE_PROXY_PID" ]; then
    NODE_PROXY_PID=""
  fi
}

devpod-up() {
  local type="$1"
  local id="$2"
  local path=""

  if [[ -z "$type" || -z "$id" ]]; then
    echo "Usage: devpod-up <type: ubuntu|mssql> <id>"
    return 1
  fi

  case "$type" in
    ubuntu)
      path="$HOME/dotfiles/devcontainers/ubuntu/.devcontainer.json"
      ;;
    mssql)
      path="$HOME/dotfiles/devcontainers/mssql/.devcontainer.json"
      ;;
    *)
      echo "Error: Unknown type '$type'. Available types: ubuntu, mssql"
      return 1
      ;;
  esac

  # devpod requires relative path to cwd
  local rel_path
  if command -v python3 &>/dev/null; then
      rel_path=$(python3 -c "import os.path; print(os.path.relpath('$path', '.'))")
  else
      echo "Error: python3 is required for relative path calculation"
      return 1
  fi

  devpod up . --devcontainer-path "$rel_path" --dotfiles https://github.com/albinlju/dotfiles.git --id "$id" --ide none --debug
}


trap 'stop_proxy' EXIT
alias stp=start_proxy
alias sp=stop_proxy

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

eval "$(starship init bash)"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v=nvim
# alias vim=nvim

# cd
alias rp='cd $REPOS/'

alias c="clear"

# ls
alias ls='ls --color=auto'
alias ll='ls -la'
# alias la='exa -laghm@ --all --icons --git --color=always'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias lastmod='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias t='tmux'
alias e='exit'

# dotnet
alias dr='dotnet run'

#nix
alias nd='nix develop'

# git
alias gp='git pull'
alias gs='git status'
alias lg='lazygit'

# fun
alias fishies=asciiquarium

# completions
source <(devpod completion bash)

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(fp)'
