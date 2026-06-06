{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        defaultPackage = pkgs.buildEnv {
          name = "system-packages";
          paths = [
            pkgs.colima
            pkgs.docker
            pkgs.rustup
            pkgs.git
            pkgs.lazygit
            pkgs.ripgrep
            pkgs.dwt1-shell-color-scripts
            pkgs.devpod
            pkgs.neovim 
            pkgs.starship
            pkgs.asciiquarium
          ];
        };
      });
}
