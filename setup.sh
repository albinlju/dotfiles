#!/bin/bash

# Set up XDG_CONFIG_HOME
export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CONFIG_HOME"/alacritty

# Create symlinks for existing configurations
ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME"/nvim
ln -sf "$PWD/flakes" "$XDG_CONFIG_HOME"/nix/flakes
ln -sf "$PWD/starship.toml" "$XDG_CONFIG_HOME"/starship.toml
ln -sf "$PWD/.inputrc" "$HOME"/.inputrc
ln -sf "$PWD/.bashrc" "$HOME"/.bashrc
ln -sf "$PWD/.tmux.conf" "$HOME"/.tmux.conf
ln -sf "$PWD/alacritty.toml" "$XDG_CONFIG_HOME"/alacritty/alacritty.toml

touch "$HOME/.privaterc"

# Set up completions
echo "Setup complete."
