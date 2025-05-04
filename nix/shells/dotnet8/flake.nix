{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/ab7b6889ae9d484eed2876868209e33eb262511d";

  };

  outputs = { nixpkgs, ... }@ inputs:
  let
    pkgs = nixpkgs.legacyPackages.aarch64-linux;
  in
  {
    devShells.aarch64-linux.default = pkgs.mkShell {
      buildInputs = [
        pkgs.nodejs
        pkgs.dotnet-sdk
      ];
    };
  };
}
