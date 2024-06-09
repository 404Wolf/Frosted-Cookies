{
  description = "Cookiecutter project template collection";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "cookiecutter";
          src = ./.;
          buildInputs = [ pkgs.python3Packages.cookiecutter ];
          buildPhase = ''
            mkdir -p $out/bin
            cp -r $src/* $out
            ln -s ${pkgs.cookiecutter}/bin/cookiecutter $out/bin/cookiecutter
          '';
        };
      });
}
