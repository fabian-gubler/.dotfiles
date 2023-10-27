{ config, pkgs, ... }: {

  # Let Home Manager install and manage itself.
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  imports = [
    ./files
    ./programs
  ];

  systemd.user.sessionVariables = rec {
    EDITOR = "nvim";
    TIMEWARRIORDB = "/data/nextcloud/todo/timewarrior";
    MANPAGER = "nvim +Man!";
    ANKI_BASE = "/data/nextcloud/apps/anki-data";
    PATH = "\${PATH}:\${XDG_BIN_HOME}:/data/.dotfiles/scripts/utils:/data/.dotfiles/scripts/dmenu:/data/.dotfiles/scripts/tmux:\${HOME}/go/bin";
  };

  # Packages that should be installed to the user profile.
  home.packages =
    let
      pythonPackages = p: with p; [
        # ...
        pip
        arrow
        pyspark
        nbconvert
        databricks-cli
        jupytext

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
    with pkgs;

    # [ (python3.withPackages pythonPackages) ] ++

    [
      notmuch-mutt
      notmuch
      lynx
      dmenu
      sxiv
      hsetroot
      xorg.xkill
      xorg.xinit
      xclip
      clipnotify
      clipmenu
      khal
      khard
      vdirsyncer
      inotify-tools
      (mpv.override { scripts = [ mpvScripts.mpris ]; })
      jq
      python3
      obsidian
      qbittorrent
      anki-bin
      pgadmin4-desktopmode
      neomutt
      dunst
      jupyter
      newsboat
      sqlite
      postman
      flameshot
      timewarrior
      ncdu
      at
      obsidian
      firefox
      rnix-lsp
      neovim
      nodejs
      rbw
      authy
      todo-txt-cli
      okular
      pandoc
      poppler_utils
      gimp
      colorpicker
      libreoffice
      lazygit
      lf
      exa
      fzf
      gotop
      trash-cli
      xdragon
      wget
      file
      ripgrep
      xdotool
      pinentry
      zip
      unzip
      unrar
      anki-bin
      markdown-anki-decks
    ]
  ;


  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "gtk";
  };

  programs.watson = {
    enable = true;
    enableZshIntegration = true;
  };
}
