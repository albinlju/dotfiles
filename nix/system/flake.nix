{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, ... }:
  let
    pkgs = nixpkgs.legacyPackages.aarch64-linux;
  in
  {
    packages.aarch64-linux.default = [
      pkgs.neovim
      pkgs.starship
      pkgs.tmux
      pkgs.fd
      pkgs.ripgrep
      pkgs.fzf
      pkgs.lazygit
      pkgs."dwt1-shell-color-scripts"
      pkgs.asciiquarium
    ];
  };
}
