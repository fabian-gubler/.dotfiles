{ pkgs, lib, ... }: {

  systemd.user.sessionVariables = {
    EDITOR = "nvim";
    TIMEWARRIORDB = "/data/nextcloud/todo/timewarrior";
    MANPAGER = "nvim +Man!";
    ANKI_BASE = "/data/nextcloud/apps/anki-data";
    PATH = "\${PATH}:\${XDG_BIN_HOME}:/data/.dotfiles/scripts/utils:/data/.dotfiles/scripts/dmenu:/data/.dotfiles/scripts/tmux:\${HOME}/go/bin";
  };

  nixpkgs.config.permittedInsecurePackages = [
    lib.optional (pkgs.obsidian.version == "1.4.16") "electron-25.9.0"
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

      # --- TODO ---

      # have only on home-manager:
      beeper
      nixgl.nixGLIntel # Only needed for Non-NixOS

      # find fix:
      obsidian # Current electron-25 marked as insecure

      # trying out:
      smplayer # mpv frontend for touch
      (nerdfonts.override { fonts = [ "SourceCodePro" ]; }) # fallback font

      # -------------

      # programming
      nodejs_20

      # lsp server
      shellcheck
      nodePackages.bash-language-server
      statix
      nil 
      # nixd # nix-community
      nixpkgs-fmt
      marksman
      nodePackages.typescript-language-server

      # main packages
      timeshift
      xorg.xinit # find built-in alternative
      dmenu
      neovim
      lf
      pavucontrol
      microsoft-edge
      sxiv
      clipnotify
      clipmenu
      visidata
      arandr
      xclip
      khal
      trash-cli
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
      pinentry
      foliate
      okular
      pandoc
      gimp
      libreoffice
      lazygit
      lazydocker
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


  # fonts
  fonts.fontconfig.enable = true;

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
