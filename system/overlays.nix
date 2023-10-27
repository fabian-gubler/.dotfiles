{ config, pkgs, lib, ... }:


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
      }
    )
  ];
}


