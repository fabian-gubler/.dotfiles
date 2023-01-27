{ config, pkgs, ... }:
let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;


in
{

  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  # Settings
  nixpkgs.config.allowUnfree = true;
  nix.package = pkgs.nixStable;
  system.stateVersion = "22.11";

  # TODO: fix protonvpn-cli (ncmli -> ipv6leakprotection or openvpn configuration file)
  environment.systemPackages =
    let
      my-python-packages = p: with p; [

        pandas
        selenium

        # (
        #   buildPythonPackage rec {
        #     pname = "jupynium";
        #     version = "0.1.0";
        #     format = "pyproject";
        #     src = /home/fabian/demo/jupynium;
        #     # src = fetchPypi {
        #     #   inherit pname version;
        #     #   sha256 = "18701f247b96a3b4daccd710834cbf1c6d8218c136df114a0965aea888c02198";
        #     # };
        #     # Specify runtime dependencies for the package
        #     propagatedBuildInputs = [
        #       setuptools
        #       versioneer
        #       pynvim
        #       coloredlogs
        #       verboselogs
        #       selenium
        #       packaging
        #       sysv_ipc
        #       psutil
        #     ];
        #     doCheck = true;
        #   }
        # )

      ];
    in
    with pkgs; [
      (python3.withPackages my-python-packages)
    ] ++
    [ python3 ] ++
    [ texlive.combined.scheme-basic ] ++ # TODO: could use shell.nix environment for latex projects
    [ stylua cargo nodejs gcc gnumake ] ++
    [ onboard wally-cli ] ++
    [ todo-txt-cli ] ++
    [ hsetroot xbindkeys xorg.xkill ] ++
    [ chromium qbittorrent ] ++
    [ signal-desktop protonmail-bridge nextcloud-client ] ++
    [ networkmanagerapplet ] ++
    [ dmenu sxiv ] ++
    [ zathura pandoc ] ++
    [ gimp xournalpp ] ++
    [ neovim lazygit ] ++
    [ arandr flameshot ] ++
    [ lf exa fzf gotop htop trash-cli xdragon ] ++
    [ xclip clipnotify clipmenu ] ++
    [ rbw pinentry-gtk2 ] ++
    [ spotify mpv mpvScripts.mpris ] ++
    [ wget file ripgrep ] ++
    [ zip unzip unrar ] ++
    [ anki-bin markdown-anki-decks ] ++
    [ xfce.thunar foliate blanket ] ++
    [ pulseaudio pavucontrol brightnessctl playerctl ] ++ # TODO: pulseaudio replace with wpctl (combined-sink)
    [
      # python3Packages.selenium
      # python3Packages.versioneer
      # python3Packages.pandas
      # (python3.withPackages my-python-packages)
      # hello
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
