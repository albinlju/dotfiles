{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.mkFlake {
      inherit self nixpkgs;
      systems = [ "aarch64-linux" ];

      packages.aarch64-linux.default = let pkgs = nixpkgs.legacyPackages.aarch64-linux; in [
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
