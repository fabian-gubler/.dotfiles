{ config, pkgs, lib, ... }:
{
  nixpkgs.overlays = [
    (self: super: {
      dwm = super.dwm.overrideAttrs (old: { src = ./dwm; });
      dmenu = super.dmenu.overrideAttrs (old: { src = ./dmenu; });

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

    })
  ];
}

