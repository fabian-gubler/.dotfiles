{
  description =
    "Ready-made templates for easily creating flake-driven environments";

  outputs = { self, flake-utils, nixpkgs }:
    {
      templates = {
        java = {
          path = ./java;
          description = "Java development environment for neovim";
        };

        scala = {
          path = ./scala;
          description = "Scala development environment for neovim";
        };

        notes = {
          path = ./latex/flake.nix;
          description = "Latex Writing and build environment";
        };

        latex = {
          path = ./latex;
          description = "Latex Writing and build environment";
        };

        data = {
          path = ./data;
          description = "Data Science development environment";
        };

        conda = {
          path = ./conda;
          description = "Isolated Conda File System";
        };

        notes = {
          path = ./notes;
          description = "Note taking utilities";
        };

      };
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShell writeScriptBin;
        exec = pkg: "${pkgs.${pkg}}/bin/${pkg}";

        format = writeScriptBin "format" ''
          ${exec "nixpkgs-fmt"} **/*.nix
        '';

        dvt = writeScriptBin "dvt" ''
          if [ -z $1 ]; then
            echo "no template specified"
            exit 1
          fi
          TEMPLATE=$1
          ${exec "nix"} \
            --experimental-features 'nix-command flakes' \
            flake init \
            --template \
            "github:the-nix-way/dev-templates#''${TEMPLATE}"
        '';

        update = writeScriptBin "update" ''
          for dir in `ls -d */`; do # Iterate through all the templates
            (
              cd $dir
              ${exec "nix"} flake update # Update flake.lock
              ${exec "direnv"} reload    # Make sure things work after the update
            )
          done
        '';
      in
      {
        devShells = {
          default = mkShell {
            packages = [ format update ];
          };
        };

        packages = rec {
          default = dvt;

          inherit dvt;
        };
      });
}
