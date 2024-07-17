{
  pkgs,
  src,
  name,
  texlive ? pkgs.texlive,
  texpkgs ? { },
  builder ? "lualatex",
  lastModified ? 0,
  ...
}:
let
  tex = texlive.combine { inherit (pkgs.texlive) scheme-minimal latex-bin latexmk; } // texpkgs;
in
pkgs.stdenvNoCC.mkDerivation {
  inherit src name;
  buildPhase = ''
    mkdir -p .cache/texmf-var
    export TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var
    export SOURCE_DATE_EPOCH=${toString lastModified} # Ensure date is pure
    ${tex}/bin/latexmk \
      -interaction=nonstopmode \
      -pdf \
      -${builder} \
      -pretex='\pdfvariable suppressoptionalinfo 512\relax' \
      -jobname=document \
      ${./src/document.tex}
  '';
  installPhase = ''
    mkdir -p $out
    cp document.pdf $out/${name}.pdf
  '';
}
