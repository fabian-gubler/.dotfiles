{ config, pkgs, lib, ... }:
{
  nixpkgs.overlays = [
    (self: super: {
      dwm = super.dwm.overrideAttrs (old: { src = ./dwm; });
      dmenu = super.dmenu.overrideAttrs (old: { src = ./dmenu; });

      # stable -> 4.4.6
      bitwig-studio = super.bitwig-studio.overrideAttrs (old: rec {
        version = "4.4.8";
        pname = "bitwig-studio";
        src = super.fetchurl {
          url = "https://downloads.bitwig.com/stable/${version}/${pname}-${version}.deb";
          sha256 = "sha256-qdqRvCmp6Q7lcTdOIEHeQKAAOLtJxs867gapopyeHuc=";
        };
      });
    })
  ];
}
