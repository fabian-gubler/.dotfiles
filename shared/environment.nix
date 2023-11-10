{ config, pkgs, ... }: {

  systemd.user.sessionVariables = rec {
    EDITOR = "nvim";
    TIMEWARRIORDB = "/data/nextcloud/todo/timewarrior";
    HARSHPATH = "/data/nextcloud/todo/harsh";
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


      unstable.obsidian
      nixgl.nixGLIntel # TODO: Only for Non-NixOS

      (python3.withPackages pythonPackages)

      # xorg.xinit # validate need of a package
      dmenu
      neovim
      lf
      sxiv
      clipnotify
      clipmenu
      arandr
      xclip
      khal
      khard
      vdirsyncer
      (mpv.override { scripts = [ mpvScripts.mpris ]; })
      qbittorrent
      pgadmin4-desktopmode
      dunst
      newsboat
      postman
      flameshot
      gcc
      timewarrior
      ncdu
      at
      rbw
      pinentry
	  nil
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
      nodejs_20
      anki
	  thunderbird
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

}
