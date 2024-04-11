{ pkgs, ... }:

let
  configFilesToLink = {
    # TODO: custom
    "lazygit/config.yml" = ./lazygit/config.yml; # TODO: create custom service

    # Leave it
    "mutt" = ./mutt; # TODO: declarable in home-manager
    "mpv" = ./mpv; # TODO: declarable in home-manager
  };

  # Function to help map attrs for symlinking home.file, xdg.configFile
  toSource = configDirName: dotfilesPath: { source = dotfilesPath; };


in
{

  # TODO: Delete original files before symlinking

  # Symlink files under ~/.config, e.g. ~/.config/alacritty/alacritty.yml
  xdg.configFile = pkgs.lib.attrsets.mapAttrs toSource configFilesToLink;

}
