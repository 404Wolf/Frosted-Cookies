{
  description = "{{ cookiecutter.description }}";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
        python = pkgs.python3.withPackages (pyPkgs: [
          pyPkgs.selenium
        ]);
      in {
        packages = {
          default = pkgs.writeShellApplicaation {
            name = "{{ cookiecutter.slug }}";
            runtimeInputs = [
              python
              pkgs.chromedriver
              pkgs.ungoogled-chromium
            ];
            text = ''
              python -O ${./main.py} $@
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
