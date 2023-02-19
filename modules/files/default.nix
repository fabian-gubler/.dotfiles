{ config, pkgs, ... }:

let
  configFilesToLink = {
    # TODO: custom
    "khal" = ./khal; # TODO: create custom service
    "dunst" = ./dunst; # TODO: create custom service
    "khard" = ./khard; # TODO: create custom service
    "touchegg/touchegg.conf" = ./touchegg/touchegg.conf; # create custom service

    # TODO: declaration
    "mutt" = ./mutt; # TODO: declarable in home-manager
    # "sioyek" = ./sioyek; # TODO: declarable in home-manager
    "mpv" = ./mpv; # TODO: declarable in home-manager
  };

  homeFilesToLink = {
    # TODO: custom
    ".local/share/fonts" = ./fonts; # TODO: write nix package for sf font
    ".xprofile" = ./xorg/.xprofile; # TODO: autostart declare in home-manager (find a way)
    ".xbindkeysrc" = ./xorg/.xbindkeysrc; # TODO: declare in home-manager (find alternative)

    # TODO: declaration
    ".newsboat/config" = ./newsboat/config; # TODO: declarable in home-manager
    ".newsboat/urls" = ./newsboat/urls; # TODO: declarable in home-manager
    ".mbsyncrc" = ./mutt/.mbsyncrc; # TODO: declarable in home-manager
    ".tmux.conf" = ./tmux/tmux.conf; # TODO: declarable in home-manager
  };

  # Function to help map attrs for symlinking home.file, xdg.configFile
  toSource = configDirName: dotfilesPath: { source = dotfilesPath; };

in
{

  # Symlink files under ~, e.g. ~/.xprofile
  home.file = pkgs.lib.attrsets.mapAttrs toSource homeFilesToLink;

  # Symlink files under ~/.config, e.g. ~/.config/alacritty/alacritty.yml
  xdg.configFile = pkgs.lib.attrsets.mapAttrs toSource configFilesToLink;

}
