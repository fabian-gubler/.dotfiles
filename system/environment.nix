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

    [ python3 neovim cargo nodejs gcc gnumake cmake ccls go ] ++
    [ rnix-lsp nodePackages.bash-language-server ] ++
    [ texlive.combined.scheme-small ] ++
    [ onboard wally-cli ] ++
    [ todo-txt-cli ] ++
    [ hsetroot xbindkeys xorg.xkill xorg.xinit ] ++
    [ chromium qbittorrent ] ++
    [ protonvpn-cli ] ++
    [ authy signal-desktop protonmail-bridge nextcloud-client ] ++
    [ networkmanagerapplet ] ++
    [ openvpn networkmanager-openvpn ] ++
    [ dmenu sxiv ] ++
    [ zathura okular pandoc poppler_utils ] ++
    [ gimp xournalpp colorpicker libreoffice ] ++
    [ arandr flameshot ] ++
    [ lazygit lf exa fzf gotop trash-cli xdragon ] ++
    [ xclip clipnotify clipmenu ] ++
    [ rbw xdotool pinentry ] ++
    [ spotify ] ++
    [ wget file ripgrep ] ++
    [ zip unzip unrar steam-run ] ++
    [ anki-bin markdown-anki-decks mkdocs ] ++
    [ xfce.thunar foliate blanket ] ++
    [ pulseaudio pavucontrol brightnessctl playerctl ] ++ # TODO: pulseaudio replace with wpctl (combined-sink)
    [ bitwig-studio yabridge yabridgectl ] ++
    [ portfolio ] ++
    [ leetcode-cli exercism ] ++
    [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      win-spice
      gnome.adwaita-icon-theme
    ] ++


    [
      # extra packages:
      texlive.combined.scheme-full
      (mpv.override { scripts = [ mpvScripts.mpris ]; })
      tree-sitter
      jq
      obsidian
      eclipses.eclipse-java
	  qtemu
	  ncdu
	  etcher
	  gparted
	  looking-glass-client
	  ventoy-bin
    ]
  ;


  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    XDG_DOWNLOAD_DIR = "\${HOME}/Downloads";

    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    ANKI_BASE = "\${HOME}/nextcloud/apps/anki-data";
    QT_SCALE_FACTOR = "1.5";

    PATH = [
      "\${XDG_BIN_HOME}"
      "\${HOME}/.dotfiles/scripts/utils"
      "\${HOME}/.dotfiles/scripts/dmenu"
      "\${HOME}/.dotfiles/scripts/tmux"
    ];
  };

}


