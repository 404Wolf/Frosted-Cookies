{
  description = "{{ cookiecutter.description }}";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages = {
          default = pkgs.maven.buildMavenPackage {
            pname = "{{ cookiecutter.project_slug }}";
            src = ./.;
            version = "{{ cookiecutter.version }}";
            mvnHash = "sha256-Bv5umnWGZtTPZJxcCI6nY5PVfZtSIk6HNtZEuBn7wNM=";
            nativeBuildInputs = [ pkgs.makeWrapper ];
            installPhase = ''
              mkdir -p $out/target
              cp -r target $out/target
              mkdir -p $out/bin
              cp target/java-maven-project-1.0.0.jar $out/bin/java-maven-project.jar
            '';
            meta = {
              description = "{{ cookiecutter.description }}";
              maintainers = [ "{{ cookiecutter.author_name }}" ];
            };
          };
        };
        devShells = {
          default = pkgs.mkShell { packages = [ pkgs.maven pkgs.zulu ]; };
        };
      });
}
