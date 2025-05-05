{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, ... }@ inputs:
  let
    pkgs = nixpkgs.legacyPackages.aarch64-darwin;
  in
  {
    devShells.aarch64-darwin.default = pkgs.mkShell {
      buildInputs = [
        pkgs.nodejs
      ];
    };
  };
}
