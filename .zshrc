#
# ~/.zshrc

export XDG_CONFIG_HOME="$HOME"/.config

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set to superior editing mode
set -o vi

# set symlinks
ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME"/nvim
ln -sf "$PWD/starship.toml" "$XDG_CONFIG_HOME"/starship.toml
ln -sf "$PWD/.inputrc" "$XDG_CONFIG_HOME"/.inputrc
ln -sf "$PWD/.bashrc" "$XDG_CONFIG_HOME"/.bashrc
ln -sf "$PWD/.zshrc" "$XDG_CONFIG_HOME"/.zshrc
ln -sf "$PWD/.tmux.conf" "$XDG_CONFIG_HOME"/.tmux.conf
ln -sf "$PWD/alacritty.toml" "$XDG_CONFIG_HOME"/alacritty/alacritty.toml

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

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

# Function to choose/switch nix flake file
nswitch() {
  if [ -z "$1" ]; then
    echo "Usage: nswitch <shell-name>"
    ls "$NIXSHELL"
    return 1
  fi
  nix develop "$NIXSHELL/$1"
}
alias ns=nswitch

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

# Moved to starship 20-03-2024 for all my prompt needs.

eval "$(starship init zsh)"

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

