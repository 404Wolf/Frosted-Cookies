{
  description = "Python devshell";

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
        devShells = {
          default = pkgs.mkShell {
            shellHook = ''
              conda install;
            '';
            packages = with pkgs; [
              python
              conda
              pyright
              black
            ];
          };
        };
      }
    );
}
