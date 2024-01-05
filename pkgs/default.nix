# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
# pkgs: {
#   # example = pkgs.callPackage ./example { };
#
#   apple-font-family = pkgs.callPackage ./apple-font-family { };
#
#
# }

{pkgs ? import <nixpkgs> {}}:
{
  apple-font = pkgs.callPackage ./apple-font { };
}
