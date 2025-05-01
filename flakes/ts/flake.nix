{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, ... }@ inputs:
  let
    pkgs = nixpkgs.legacyPackages.aarch64-linux;
  in
  {
    devShells.aarch64-linux.default = pkgs.mkShell {
      buildInputs = [
        pkgs.neovim
        pkgs.starship
        pkgs.tmux
        pkgs.fd
        pkgs.ripgrep
        pkgs.fzf
        pkgs.lazygit
        pkgs.nodejs
        pkgs.dwt1-shell-color-scripts
      ];
    };
  };
}
