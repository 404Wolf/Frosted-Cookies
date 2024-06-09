{
  description = "{{ cookiecutter.description }}";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        nodejs = pkgs.nodejs_22;
      in rec {
        packages = {
          default = pkgs.buildNpmPackage {
            name = "{{ cookiecutter.project_slug }}";
            src = ./.;
            npmDepsHash = "<hash>";
            dontNpmInstall = true;
            postInstall = '' mv $out/bin/index.js $out/bin/{{ cookiecutter.project_slug }}.js '';
            meta = {
              description = "{{ cookiecutter.description }}";
              license = "MIT";
            };
          };
        };
        devShells = {
          default = pkgs.mkShell { 
            out=".";
            packages = [ nodejs pkgs.prefetch-npm-deps pkgs.nodePackages.pnpm ];
            shellHook = ''pnpm install; prefetch-npm-deps package-lock.json'';
          };
        };
      });
}
