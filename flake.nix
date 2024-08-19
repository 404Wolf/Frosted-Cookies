{
  description = "Cookiecutter project template collection";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in rec {
      packages.default = pkgs.writeShellApplication {
        name = "cookiecutter";
        runtimeInputs = with pkgs; [cookiecutter];
        text = ''
          COOKIECUTTER_DIR=${./templates}
          ${builtins.readFile ./cookiecutter.sh}
        '';
      };
      apps.default = flake-utils.lib.mkApp {
        name = "cookiecutter";
        drv = packages.default;
      };
      devShells = pkgs.mkShell {
        inputsFrom = packages.default;
      };
    });
}
