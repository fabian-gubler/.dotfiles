{ pkgs, ... }: {

  systemd.user.sessionVariables = {
    EDITOR = "nvim";
    TIMEWARRIORDB = "/data/nextcloud/todo/timewarrior";
    MANPAGER = "nvim +Man!";
    ANKI_BASE = "/data/nextcloud/apps/anki-data";
    PATH = "\${PATH}:\${XDG_BIN_HOME}:/data/.dotfiles/scripts/utils:/data/.dotfiles/scripts/dmenu:/data/.dotfiles/scripts/tmux:\${HOME}/go/bin";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # Obsidian 
  ];

  # Packages that should be installed to the user profile.
  home.packages =
    let
      pythonPackages = p: with p; [
        # ...
        pip

        # Custom Packages
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

    [

      (python3.withPackages pythonPackages)

      # --- Experimental ---

      # temporary
      pgadmin4-desktopmode # This Semester's Uni Course

      microsoft-edge-beta # beta for better wayland support
      # todo: chrome://flags/#enable-webrtc-pipewire-capturer -> enable
      # after fix: use pkg 'microsoft-edge'

      # only on home-manager
      # beeper
      # microsoft edge (teams)
      # myEclipse
      nixgl.nixGLIntel # Only needed for Non-NixOS

      obsidian # Current electron-25 marked as insecure

      # --------------------

      # programming
      nodejs_20

      # lsp server
      shellcheck
      nodePackages.bash-language-server
      statix
      nil # replaces: rnix-lsp
      nixpkgs-fmt

      # main packages
      timeshift
      xorg.xinit # find built-in alternative
      dmenu
      neovim
      lf
      pavucontrol
      sxiv
      clipnotify
      clipmenu
      arandr
      xclip
      khal
      jq
      khard
      vdirsyncer
      (mpv.override { scripts = [ mpvScripts.mpris ]; })
      qbittorrent
      dunst
      newsboat
      flameshot
      gcc
      timewarrior
      ncdu
      at
      pinentry
      foliate
      okular
      pandoc
      gimp
      libreoffice
      lazygit
      fzf
      gotop
      xdragon
      wget
      gpick
      ripgrep
      zip
      unzip
      unrar
      anki
      markdown-anki-decks
      thunderbird
    ]
  ;

  programs.rbw = {
    enable = true;
    settings = {
      email = "fabian.gubler@protonmail.com";
      pinentry = "gnome3";
      lock_timeout = 2419200;
    };
  };

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

}
