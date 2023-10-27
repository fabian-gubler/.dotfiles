{
  description = "Build LaTeX document with pandoc";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    {
      templates.document = {
        path = ./.;
        description = "Note taking utils";
      };

      defaultTemplate = self.templates.document;
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        latex-packages = with pkgs; [
          (texlive.combine {
            inherit (texlive)
              scheme-full
              framed
              titlesec
              cleveref
              multirow
              wrapfig
              tabu
              threeparttable
              threeparttablex
              makecell
              environ
              biblatex
              biber
              fvextra
              upquote
              catchfile
              xstring
              csquotes
              minted
              dejavu
              comment
              footmisc
              xltabular
              ltablex
              ;
          })
        ];

        dev-packages = with pkgs; [
		  pandoc
          texlab
          okular
        ];
      in
      rec {
        devShell = pkgs.mkShell {
			name = "notes";
          buildInputs = [ latex-packages dev-packages ];
        };

      }
    );
}
