{
  description = "{{ cookiecutter.description }}";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    latex-utils.url = "github:404Wolf/nixLatexDocument";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      latex-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        name = "{{ cookiecutter.project_name }}";
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = {
          default = latex-utils.lib.${system}.buildLatexDocument {
            inherit name;
            src = ./.;
            document = "{{ cookiecutter.document_name }}";
            lastModified = self.lastModified;
            texpkgs = {
              inherit (pkgs.texlive) amsmath;
            };
          };
        };
        devShells.default = latex-utils.devShells.${system}.default;
      }
    );
}
