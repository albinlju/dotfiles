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
            pkgs.opencode
            pkgs.xdg-utils
            pkgs.wget
            pkgs.starship
            pkgs.dotnetCorePackages.sdk_10_0-bin
            pkgs.dotnet-ef
            pkgs.netcoredbg
            pkgs.tmux 
            pkgs.git
            pkgs.ripgrep
            pkgs.fzf
            pkgs.nodejs
            pkgs.lazygit
            pkgs.dwt1-shell-color-scripts
            pkgs.asciiquarium
          ];
        };
      });
}
