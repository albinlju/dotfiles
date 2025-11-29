{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, neovim-nightly }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        nightlyPkgs = neovim-nightly.packages.${system};
      in
      {
        defaultPackage = pkgs.buildEnv {
          name = "system-packages";
          paths = [
            nightlyPkgs.default 
            pkgs.go
            pkgs.colima
            pkgs.docker
            pkgs.devpod
            pkgs.neovim 
            pkgs.starship
            pkgs.tmux 
            pkgs.git
            pkgs.nodejs
            pkgs.ripgrep
            pkgs.fzf
            pkgs.lazygit
            pkgs.dwt1-shell-color-scripts
            pkgs.asciiquarium
          ];
        };
      });
}
