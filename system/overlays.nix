{ config, pkgs, lib, ... }:


# pin docker to older nixpkgs: https://github.com/NixOS/nixpkgs/issues/244159
# nixpkgs.overlays = [
# (let
#   pinnedPkgs = import(pkgs.fetchFromGitHub {
# 	owner = "NixOS";
# 	repo = "nixpkgs";
# 	rev = "b6bbc53029a31f788ffed9ea2d459f0bb0f0fbfc";
# 	sha256 = "sha256-JVFoTY3rs1uDHbh0llRb1BcTNx26fGSLSiPmjojT+KY=";
#   }) {};
# in
# final: prev: {
#   docker = pinnedPkgs.docker;
# })
# ];

{
  nixpkgs.overlays = [
    (
      let
        pinnedPkgs = import
          (pkgs.fetchFromGitHub {
            owner = "NixOS";
            repo = "nixpkgs";
            rev = "b6bbc53029a31f788ffed9ea2d459f0bb0f0fbfc";
            sha256 = "sha256-JVFoTY3rs1uDHbh0llRb1BcTNx26fGSLSiPmjojT+KY=";
          })
          { };
      in
      self: super: {
        dwm = super.dwm.overrideAttrs (old: { src = ./dwm; });
        dmenu = super.dmenu.overrideAttrs (old: { src = ./dmenu; });

        docker = pinnedPkgs.docker;

        # stable -> 4.4.6
        # bitwig-studio = super.bitwig-studio.overrideAttrs (old: rec {
        #   version = "4.4.8";
        #   pname = "bitwig-studio";
        #   src = super.fetchurl {
        #     url = "https://downloads.bitwig.com/stable/${version}/${pname}-${version}.deb";
        #     sha256 = "sha256-qdqRvCmp6Q7lcTdOIEHeQKAAOLtJxs867gapopyeHuc=";
        #   };
        # });
        # overlays = [
        #   (self: super:
        #     let
        #       extraCerts = [ ./path/to/certificate.crt ];
        #     in
        #     {
        #       citrix_workspace = super.citrix_workspace.override {
        #         inherit extraCerts;
        #       };
        #     }
        #   )
        # ];

        # stable -> 0.3.11
        # leetcode-cli = super.leetcode-cli.overrideAttrs (drv: rec {
        #   version = "0.3.12";
        #   pname = "leetcode-cli";
        #   src = super.fetchCrate {
        #     inherit pname version;
        #     sha256 = "sha256-JxPcwbxEPMjJlUBXQw5RRC29sIxNDY+bIilCtflowBo=";
        #   };
        #
        #   # pkgname = "leetcode-cli";
        #   # newcargoSha256 = "$(nix-prefetch '{ sha256 }: ${pkgname}.cargoDeps.overrideAttrs (_: { cargoSha256 = sha256; })')";
        #
        #   cargoDeps = drv.cargoDeps.overrideAttrs (_: {
        #     inherit src; # You need to pass "src" here again,
        #     # otherwise the old "src" will be used.
        #     outputHash = "sha256-lbqQio0zkV0kvK3tKYBUFzn6NQjoCZmTXcs0+sxDj1U=";
        #   });
        # });

      }
    )
  ];
}


