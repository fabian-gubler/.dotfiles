{ pkgs, ... }:

let
  configFilesToLink = {

    # Leave it
    # "mpv" = ./mpv; # TODO: declarable in home-manager
  };

  # Function to help map attrs for symlinking home.file, xdg.configFile
  toSource = configDirName: dotfilesPath: { source = dotfilesPath; };


in
{

  # TODO: Delete original files before symlinking

  # Symlink files under ~/.config, e.g. ~/.config/alacritty/alacritty.yml
  xdg.configFile = pkgs.lib.attrsets.mapAttrs toSource configFilesToLink;

}
