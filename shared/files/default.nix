{ pkgs, ... }:

let
  configFilesToLink = {
    # TODO: custom
    "dunst" = ./dunst; # TODO: create custom service
    "lazygit/config.yml" = ./lazygit/config.yml; # TODO: create custom service

    # Leave it
    "mutt" = ./mutt; # TODO: declarable in home-manager
    "mpv" = ./mpv; # TODO: declarable in home-manager
  };

  homeFilesToLink = {
    # TODO: custom
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
      ${pkgs.xorg.xsetroot}/bin/xsetroot -solid "#252A34" &
      ${pkgs.xbindkeys}/bin/xbindkeys &
      ${pkgs.clipmenu}/bin/clipmenud &
      ${pkgs.spice-vdagent}/bin/spice-vdagent &
    '';

  };

  # TODO: Delete original files before symlinking

  # Symlink files under ~/.config, e.g. ~/.config/alacritty/alacritty.yml
  xdg.configFile = pkgs.lib.attrsets.mapAttrs toSource configFilesToLink;

}
