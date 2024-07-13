{
  description = "{{ cookiecutter.description }}";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
        python = pkgs.python3.withPackages (python-pkgs: [ python-pkgs.requests ]);
      in
      {
        packages = {
          default = pkgs.stdenv.mkDerivation {
            src = self;
            buildInputs = [
              pkgs.mkShellScriptBin "main" "${python}/bin/python3 main.py"
            ];
            installPhase = ''
              mkdir -p $out/bin
              cp main $out/bin
            '';
          };
        };

        devShells = {
          default = pkgs.mkShell {
            packages = [
              python
              pkgs.pyright
              pkgs.black
            ];
          };
        };
      }
    );
}
