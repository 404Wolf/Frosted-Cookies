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
        name = "{{ cookiecutter.document_name }}";
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = rec {
          default = buildLatexDocument {
            inherit pkgs name;
            src = self;
            lastModified = self.lastModified;
          };
          buildLatexDocument = (pkgs.callPackage ./package.nix);
        };
        devShells = { };
      }
    );
}
