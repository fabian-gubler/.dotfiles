{ config, pkgs, ... }:

let
  configFilesToLink = {
    "khal" = ./khal;
    "khard" = ./khard;
    "vdirsyncer" = ./vdirsyncer;
    "autorandr" = ./autorandr;
    "mutt" = ./mutt;
    "qutebrowser" = ./qutebrowser; # TODO: declare in home-manager
    "mpv" = ./mpv; # TODO: Check if watch-later works
    "dunst" = ./dunst;
    "sioyek" = ./sioyek;
    "rofi" = ./rofi;
    "touchegg/touchegg.conf" = ./touchegg/touchegg.conf;
  };

  homeFilesToLink = {
    ".xprofile" = ./xorg/.xprofile; # TODO: autostart declare in home-manager (find a way)
    ".xbindkeysrc" = ./xorg/.xbindkeysrc; # TODO: declare in home-manager (find alternative)
    ".mbsyncrc" = ./mutt/.mbsyncrc;
    ".tmux.conf" = ./tmux/tmux.conf;
    ".newsboat/config" = ./newsboat/config; # TODO: declare in home-manager
    ".newsboat/urls" = ./newsboat/urls; # TODO: declare in home-manager
    ".local/share/fonts" = ./fonts; # TODO: write nix package for sf font
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
