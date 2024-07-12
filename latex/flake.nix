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
        documentName = "{{ cookiecutter.document_name }}";
        pkgs = import nixpkgs { inherit system; };

        # - latex-bin gives us lualatex
        # - latexmk is a tool to build latex documents (useful for when you need to run latex multiple times)
        # - scheme-minimal is a minimal texlive installation
        tex = pkgs.texlive.combine { inherit (pkgs.texlive) scheme-minimal latex-bin latexmk; };
      in
      {
        packages = rec {
          default = resume;
          # noCC discludes the C compiler since we don't need it for latex
          resume = pkgs.stdenvNoCC.mkDerivation {
            name = "resume";
            src = self;
            buildPhase = ''
              mkdir -p .cache/texmf-var
              env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
                SOURCE_DATE_EPOCH=${toString self.lastModified} \  # Ensure date is pure
                ${tex}/bin/latexmk -interaction=nonstopmode -pdf -lualatex \
                -pretex="\pdfvariable suppressoptionalinfo 512\relax" \  # Prevent random ID
                -usepretex src/document.tex
            '';
            installPhase = ''
              mkdir -p $out
              cp document.pdf $out/
            '';
          };
        };
        devShells = { };
      }
    );
}
