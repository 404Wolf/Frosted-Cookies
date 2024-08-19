{
  description = "{{ cookiecutter.description }}";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, poetry2nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        name = "{{ cookiecutter.project_slug }}";
        pkgs = import nixpkgs { inherit system; };
        inherit (poetry2nix.lib.mkPoetry2Nix { inherit pkgs; })
          mkPoetryApplication;
      in {
        packages = {
          default = self.packages.${system}.${name};
          ${name} = mkPoetryApplication { projectDir = self; };
        };

        devShells = {
          default = pkgs.mkShell { 
            inputsFrom = [ self.packages.${system}.${name} ]; 
          };
          poetry = pkgs.mkShell { 
            packages = [ pkgs.python313 pkgs.poetry ]; 
            shellHook = '' poetry install '';
          };
        };
      });
}
