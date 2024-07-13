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
        python = pkgs.python3.withPackages (python-pkgs: [ python-pkgs.selenium ]);
      in
      {
        packages = rec {
          default = pkgs.stdenv.mkDerivation {
            name = "main";
            src = self;
            dontUnpack = true;
            buildInputs = [ pkgs.makeWrapper ];
            installPhase = ''
              mkdir -p $out/bin
              cp ${script}/bin/* $out/bin
            '';
            postFixup = ''
              wrapProgram $out/bin/main \
                --set PATH $PATH:${
                  pkgs.lib.makeBinPath [
                    pkgs.chromedriver
                    pkgs.ungoogled-chromium
                  ]
                }
            '';
          };
          script = pkgs.writeShellScriptBin "main" "${python}/bin/python3 main.py";
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
