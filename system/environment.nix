{ config, pkgs, ... }:
{

  # Settings
  nixpkgs.config.allowUnfree = true;
  nix.package = pkgs.nixStable;
  system.stateVersion = "22.11";

  environment.systemPackages =
    let

      pythonPackages = p: with p; [
        # ...

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

    [ python3 neovim cargo nodejs gcc gnumake ] ++
    [ rnix-lsp nodePackages.bash-language-server ] ++
    [ texlive.combined.scheme-small ] ++
    [ onboard wally-cli ] ++
    [ todo-txt-cli ] ++
    [ hsetroot xbindkeys xorg.xkill ] ++
    [ chromium qbittorrent ] ++
    # IPV6 Bug: `nmcli connection delete pvpn-ipv6leak-protection` or `protonvpn-cli d`
    # sudo ip link delete ipv6leakintrf0
    [ protonvpn-cli ] ++
    [ authy signal-desktop protonmail-bridge nextcloud-client ] ++
    [ networkmanagerapplet ] ++
    [ openvpn networkmanager-openvpn ] ++
    [ dmenu sxiv ] ++
    [ zathura okular pandoc poppler_utils ] ++
    [ gimp xournalpp libreoffice ] ++
    [ arandr flameshot ] ++
    [ lazygit lf exa fzf gotop htop trash-cli xdragon ] ++
    [ xclip clipnotify clipmenu ] ++
    [ rbw xdotool pinentry-gtk2 ] ++
    [ spotify ] ++
    [ wget file ripgrep ] ++
    [ zip unzip unrar steam-run ] ++
    [ anki-bin markdown-anki-decks mkdocs ] ++
    [ xfce.thunar foliate blanket ] ++
    [ pulseaudio pavucontrol brightnessctl playerctl ] ++ # TODO: pulseaudio replace with wpctl (combined-sink)
    [ bitwig-studio yabridge yabridgectl ] ++
    [ portfolio ] ++
    [ leetcode-cli exercism ] ++


    # TODO: decouple to templates
    [
      rust-analyzer # Rust
      nodePackages.prettier # Javascript
    ] ++

    [
      # extra packages:
      # ...
      # jdt-language-server # Java
      dpkg
      patchelf
      binutils
      colorpicker
	  openssl
	  notmuch
	  watson
	  sqlite
	  cmake
	  ccls
      (mpv.override { scripts = [ mpvScripts.mpris ]; })
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


