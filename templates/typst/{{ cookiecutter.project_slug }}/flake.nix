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
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      packages.default = pkgs.stdenvNoCC.mkDerivation {
        name = "{{ cookiecutter.name }}";
        src = ./.;
        buildInputs = with pkgs; [
          typst
        ];
        buildPhase = ''
          typst compile ${./src/document.typ} document.pdf
        '';
        installPhase = ''
          cp document.pdf $out
        '';
      };
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          typst
          typst-lsp
        ];
      };
    });
}
