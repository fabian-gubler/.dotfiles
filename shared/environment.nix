{ config, pkgs, lib, ... }: {

  systemd.user.sessionVariables = rec {
    EDITOR = "nvim";
    TIMEWARRIORDB = "/data/nextcloud/todo/timewarrior";
    MANPAGER = "nvim +Man!";
    ANKI_BASE = "/data/nextcloud/apps/anki-data";
    PATH = "\${PATH}:\${XDG_BIN_HOME}:/data/.dotfiles/scripts/utils:/data/.dotfiles/scripts/dmenu:/data/.dotfiles/scripts/tmux:\${HOME}/go/bin";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # Obsidian 
  ];

  # nixpkgs.config.packageOverrides = pkgs: rec {
  #   myEclipse = with pkgs.eclipses; eclipseWithPlugins {
  #     eclipse = eclipse-platform;
  #     jvmArgs = [ "-Xmx2048m" ];
  #     plugins = [
  #       plugins.color-theme
  # plugins.vrapper
  #       # (plugins.buildEclipsePlugin {
  #       #   name = "myplugin1-1.0";
  #       #   srcFeature = fetchurl {
  #       #     url = "http://…/features/myplugin1.jar";
  #       #     hash = "sha256-123…";
  #       #   };
  #       #   srcPlugin = fetchurl {
  #       #     url = "http://…/plugins/myplugin1.jar";
  #       #     hash = "sha256-123…";
  #       #   };
  #       # })
  #       (plugins.buildEclipseUpdateSite {
  #         name = "adt";
  #         src = builtins.fetchurl {
  #           # stripRoot = false;
  #           url = "https://tools.hana.ondemand.com/latest";
  #           sha256 = "sha256:0m13nb6r0bxh82magfvsvw6mrf3sp62ydsmnrqy11r7bhgx15gdw";
  #         };
  #       })
  #     ];
  #   };
  # };

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

      obsidian # Wait until unfree issue is resolved

      # lsp server
      shellcheck
      nodePackages.bash-language-server
	  statix
      rnix-lsp

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
      # postman		# FIX: currently no mirror found
      flameshot
      gcc
      timewarrior
      ncdu
      at
      rbw
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
      nodejs_20
      anki
      markdown-anki-decks
      thunderbird
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
