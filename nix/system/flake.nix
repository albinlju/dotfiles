{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgsveryold.url = "github:nixos/nixpkgs/ab7b6889ae9d484eed2876868209e33eb262511d";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, nixpkgsveryold }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pkgsold = nixpkgsveryold.legacyPackages.${system};
      in
      {
        defaultPackage = pkgs.buildEnv {
          name = "system-packages";
          paths = [ 
            pkgsold.neovim
            #pkgs.neovim 
            pkgs.starship
            pkgs.tmux 
            pkgs.git
            pkgs.ripgrep
            pkgs.fzf
            pkgs.lazygit
            pkgs.dwt1-shell-color-scripts
            pkgs.asciiquarium
          ];
        };
      });
}
