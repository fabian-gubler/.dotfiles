{ config, pkgs, ... }:
{

  # Settings
  nixpkgs.config.allowUnfree = true;
  nix.package = pkgs.nixStable;
  system.stateVersion = "22.11";

  # TODO: fix protonvpn-cli (ncmli -> ipv6leakprotection or openvpn configuration file)
  environment.systemPackages =
    let
      pythonPackages = p: with p; [
        # ...
        (
          buildPythonPackage rec {
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

    [ python3 neovim cargo nodejs gcc gnumake ] ++
    [ rnix-lsp nodePackages.bash-language-server ] ++
    [ onboard wally-cli ] ++
    [ todo-txt-cli ] ++
    [ hsetroot xbindkeys xorg.xkill ] ++
    [ chromium qbittorrent ] ++
    [ authy signal-desktop protonmail-bridge nextcloud-client ] ++
    [ networkmanagerapplet ] ++
    [ dmenu sxiv ] ++
    [ zathura pandoc ] ++
    [ gimp xournalpp libreoffice ] ++
    [ arandr flameshot ] ++
    [ lazygit lf exa fzf gotop htop trash-cli xdragon ] ++
    [ xclip clipnotify clipmenu ] ++
    [ rbw xdotool pinentry-gtk2 ] ++
    [ spotify mpv mpvScripts.mpris ] ++
    [ wget file ripgrep ] ++
    [ zip unzip unrar steam-run ] ++
    [ anki-bin markdown-anki-decks mkdocs ] ++
    [ xfce.thunar foliate blanket ] ++
    [ pulseaudio pavucontrol brightnessctl playerctl ] ++ # TODO: pulseaudio replace with wpctl (combined-sink)
    [ bitwig-studio yabridge yabridgectl ] ++



    # TODO: decouple to templates
    [
      rust-analyzer # Rust
      nodePackages.prettier # Javascript
    ] ++

    [
      # extra packages:
      # ...
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
      "\${HOME}/.dotfiles/scripts/tmux"
    ];
  };

}
