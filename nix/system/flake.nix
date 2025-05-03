{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, ... }:
  let
    pkgs = nixpkgs.legacyPackages.aarch64-linux;
  in
  {
    packages.neovim = pkgs.neovim;
    packages.starship = pkgs.starship;
    packages.tmux = pkgs.tmux;
    packages.fd = pkgs.fd;
    packages.ripgrep = pkgs.ripgrep;
    packages.fzf = pkgs.fzf;
    packages.lazygit = pkgs.lazygit;
    packages.dwt1-shell-color-scripts = pkgs.dwt1-shell-color-scripts;
    packages.asciiquarium = pkgs.asciiquarium;
  };
}
