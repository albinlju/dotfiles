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
            pkgs.neovim 
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
