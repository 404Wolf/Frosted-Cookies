{
  description = "{{ cookiecutter.description }}";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "{{ cookiecutter.name }}";
          src = ./.;
          buildInputs = [ pkgs.bun ];
          buildPhase = ''
            bun install
            bun run build
          '';
          installPhase = ''
            mkdir -p $out/bin
            cp -r ./dist/* $out/bin
          '';
          outputHashAlgo = "sha256";
          outputHashMode = "recursive";
          outputHash = "sha256-G2oYzUhhE4U27lWcdFGhAGg3b6izixIGsdhDzqcgu5E=";
        };
        devShells = {
          default = pkgs.mkShell {
            packages = [
              pkgs.bun
              pkgs.typescript
            ];
          };
        };
      }
    );
}
