{
  description =
    "A flake giving access to fonts that I use, outside of nixpkgs.";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        defaultPackage = pkgs.symlinkJoin {
          name = "myfonts-0.1.4";
          paths = builtins.attrValues
            self.packages.${system}; # Add font derivation names here
        };

        packages.sf = pkgs.stdenvNoCC.mkDerivation {
          name = "sf-mono";
          dontConfigue = true;
          src = pkgs.fetchzip {
            url =
              "https://github.com/epk/SF-Mono-Nerd-Font/archive/refs/tags/v18.0d1e1.0.zip";
            sha256 = "sha256-7Z1i4/XdDhXc3xPqRpnzZoCB75HzyVqRDh4qh4jJdKI=";
            stripRoot = false;
          };
          installPhase = ''
            mkdir -p $out/share/fonts
            cp -R $src $out/share/fonts/apple
          '';
          meta = { description = "The San Francisco Font Family derivation."; };
        };

      });
}
