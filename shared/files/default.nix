{ config, pkgs, ... }:

let
  configFilesToLink = {
    # TODO: custom
    "khal" = ./khal; # TODO: create custom service
    "dunst" = ./dunst; # TODO: create custom service
    "khard" = ./khard; # TODO: create custom service
    "touchegg/touchegg.conf" = ./touchegg/touchegg.conf; # create custom service

    # Leave it
    "mutt" = ./mutt; # TODO: declarable in home-manager
    "mpv" = ./mpv; # TODO: declarable in home-manager
  };

  homeFilesToLink = {
    # TODO: custom
    ".local/share/fonts" = ./fonts; # TODO: write nix package for sf font or find alternative font
    ".xinitrc" = ./xorg/.xinitrc; # TODO: is there a nix way?

  };

  # Function to help map attrs for symlinking home.file, xdg.configFile
  toSource = configDirName: dotfilesPath: { source = dotfilesPath; };


in
{

  # Symlink files under ~, e.g. ~/.xprofile
  home.file = pkgs.lib.attrsets.mapAttrs toSource homeFilesToLink // {
    # Add custom .xprofile
    ".xprofile".source = pkgs.writeShellScript "xprofile" ''
      ${pkgs.hsetroot}/bin/hsetroot -solid "#252A34" &
      ${pkgs.xbindkeys}/bin/xbindkeys &
      ${pkgs.clipmenu}/bin/clipmenud &
      ${pkgs.spice-vdagent}/bin/spice-vdagent &
    '';

  };

  # Symlink files under ~/.config, e.g. ~/.config/alacritty/alacritty.yml
  xdg.configFile = pkgs.lib.attrsets.mapAttrs toSource configFilesToLink;

}
