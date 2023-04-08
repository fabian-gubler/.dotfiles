{ config, pkgs, lib, ... }:
{

  # Settings
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "electron-12.2.3" ];
  };
  nix.package = pkgs.nixStable;

  system.stateVersion = "22.11";

  environment.systemPackages =
    let

      pythonPackages = p: with p; [
        # ...
        pip

        browser-cookie3

        # Custome Packages
        (
          buildPythonPackage
            rec {
              pname = "fahrplan";
              version = "1.1.2";
              src = fetchPypi {
                inherit pname version;
                sha256 = "sha256-2gg1rm7hrv5k+SuC+KnffzE+QexeQpmFlhp6kpTiS2w=";
              };
              doCheck = false;
              propagatedBuildInputs = [
                texttable
                requests
                python-dateutil
              ];
            }
        )
      ];
    in
    with pkgs; [
      (python3.withPackages pythonPackages)
    ] ++

    [ hsetroot xorg.xkill xorg.xinit ] ++
    [ dmenu sxiv ] ++
    [ arandr ] ++
    [ xclip clipnotify clipmenu ] ++

    # [ bitwig-studio yabridge yabridgectl ] ++
    # [
    #   virt-manager
    #   virt-viewer
    #   spice
    #   spice-gtk
    #   spice-protocol
    #   win-spice
    #   gnome.adwaita-icon-theme
    # ] ++


    [
      # extra packages:
      texlive.combined.scheme-full
      (mpv.override { scripts = [ mpvScripts.mpris ]; })
      tree-sitter
      jq
      ncdu
      obsidian
      qbittorrent
      pavucontrol
    ]
  ;


  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    XDG_DOWNLOAD_DIR = "\${HOME}/Downloads";
    QT_SCALE_FACTOR = "1.5";

    # Duplicate: in home-manager
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    ANKI_BASE = "/data/nextcloud/apps/anki-data";
    PATH = "\${PATH}:\${XDG_BIN_HOME}:\${HOME}/.dotfiles/scripts/utils:\${HOME}/.dotfiles/scripts/dmenu:\${HOME}/.dotfiles/scripts/tmux";

  };

}


