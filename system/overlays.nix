{ config, pkgs, lib, ... }:


{
  nixpkgs.overlays = [
    (
      self: super: {
        dwm = super.dwm.overrideAttrs (old: { src = ./dwm; });
        dmenu = super.dmenu.overrideAttrs (old: { src = ./dmenu; });
      }
    )
  ];
}


