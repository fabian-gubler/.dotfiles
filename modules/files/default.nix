{ config, pkgs, ... }:

let
  configFilesToLink = {
    "khal" = ./khal;
    "khard" = ./khard;
    "mutt" = ./mutt;
    # TODO: declare in home-manager
    "qutebrowser/greasemonkey" = ./qutebrowser/greasemonkey; 
    "qutebrowser/stylesheets" = ./qutebrowser/stylesheets; 
    "qutebrowser/userscripts" = ./qutebrowser/userscripts; # TODO: put menu to rofi dir
    "qutebrowser/config.py" = ./qutebrowser/config.py;
    "mpv" = ./mpv; # TODO: Check if watch-later works, auto download fonts & scripts
    "dunst" = ./dunst; # TODO: create nix service
    "sioyek" = ./sioyek; # TODO: overlay, replace config files
    "rofi" = ./rofi;
    "touchegg/touchegg.conf" = ./touchegg/touchegg.conf;
  };

  homeFilesToLink = {
    ".xprofile" = ./xorg/.xprofile; # TODO: autostart declare in home-manager (find a way)
    ".xbindkeysrc" = ./xorg/.xbindkeysrc; # TODO: declare in home-manager (find alternative)
    ".newsboat/config" = ./newsboat/config; # TODO: declarable in home-manager
    ".newsboat/urls" = ./newsboat/urls; # TODO: declarable in home-manager
    ".local/share/fonts" = ./fonts; # TODO: write nix package for sf font
    ".mbsyncrc" = ./mutt/.mbsyncrc;
    ".tmux.conf" = ./tmux/tmux.conf; 
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
