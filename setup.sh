#!/bin/bash

# Set up XDG_CONFIG_HOME
export XDG_CONFIG_HOME="$HOME"/.config

# Conditionall create folders
if [ ! -d "$XDG_CONFIG_HOME" ]; then
  mkdir -p "$XDG_CONFIG_HOME"
else
  echo "$XDG_CONFIG_HOME alerady exist"
fi

if [ ! -d "$XDG_CONFIG_HOME"/alacritty ]; then
  mkdir -p "$XDG_CONFIG_HOME"/alacritty
else
  echo "$XDG_CONFIG_HOME/alacritty alerady exist"
fi

if [ ! -d "$XDG_CONFIG_HOME"/nix ]; then
  mkdir -p "$XDG_CONFIG_HOME"/nix
else
  echo "$XDG_CONFIG_HOME/nix alerady exist"
fi

if [ ! -f "$XDG_CONFIG_HOME"/nix/nix.conf ]; then
  echo "experimental-features = nix-command flakes" >>"$XDG_CONFIG_HOME"/nix/nix.conf
  echo "Created default ~/.config/nix/nix.conf with experimental features enabled."
else
  echo "$XDG_CONFIG_HOME/nix/nix.conf nix conf alerady exist"
fi

# Create symlinks for existing configurations
ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME"/nvim
ln -sf "$PWD/starship.toml" "$XDG_CONFIG_HOME"/starship.toml
ln -sf "$PWD/.bashrc" "$HOME"/.bashrc
ln -sf "$PWD/.bash_profile" "$HOME"/.bash_profile
ln -sf "$PWD/.tmux.conf" "$HOME"/.tmux.conf
ln -sf "$PWD/alacritty.toml" "$XDG_CONFIG_HOME"/alacritty/alacritty.toml

# Install system packages to devcontainer with nix profile
if [[ "$OSTYPE" == "linux"* ]]; then
  nix profile install "$PWD/nix/profiles/base"
fi

# Set up completions
echo "Setup complete."
