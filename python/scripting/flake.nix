rec {
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
        name = "{{ cookiecutter.project_slug }}";
        pkgs = import nixpkgs { inherit system; };

        pyPkgs = [ pkgs.python312Packages.requests ];
      in
      {
        packages = {
          default = pkgs.stdenv.mkDerivation {
            inherit name;
            src = ./.;
            buildInputs = [
              pkgs.python312
              pkgs.pyright
              pkgs.black
            ] ++ pyPkgs;
            installPhase = ''
              mkdir -p $out/bin
              cp -r * $out
              cp $out/main.py $out/bin/${name}
              echo '#!${pkgs.python312}/bin/python' | cat - $out/main.py > $out/bin/${name}
              chmod +x $out/bin/${name}
            '';
          };
        };

        devShells = {
          default = pkgs.mkShell {
            packages = [
              pkgs.python312
              pkgs.pyright
              pkgs.black
            ] ++ pyPkgs;
          };
        };
      }
    );
}
