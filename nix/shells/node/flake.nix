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
        pkgs.nodejs
      ];
    };
  };
}
