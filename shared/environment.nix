{ pkgs, lib, ... }: {

  systemd.user.sessionVariables = {
    EDITOR = "nvim";
    TIMEWARRIORDB = "\${HOME}/nextcloud/todo/timewarrior";
    MANPAGER = "nvim +Man!";
    PATH = "\${PATH}:\${XDG_BIN_HOME}:/data/.dotfiles/scripts/utils:/data/.dotfiles/scripts/dmenu:/data/.dotfiles/scripts/tmux:\${HOME}/go/bin";
  };

  nixpkgs.config.permittedInsecurePackages = [
    lib.optional
    (pkgs.obsidian.version == "1.4.16")
    "electron-25.9.0"
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

      # wayland / hyprland additions

      unstable.swayosd
      unstable.beeper
      waybar
      swaynotificationcenter
      kickoff
      hyprpicker
      wpaperd
      wl-clipboard
      cliphist
      dunst
      bluetuith # cli
      blueberry # graphical (fallback)
      discord
      azure-cli
      grim
      slurp
      killall

      # find fix:
      obsidian # Current electron-25 marked as insecure

      # -------------

    # TODO: Isolate programming languages

      # programming
      nodejs_20
      cargo
      tree-sitter

      # go
      gopls # language server
      unstable.go # programming language
      golangci-lint # linter++
      delve # debugger

      # lsp server
      shellcheck
      nodePackages.bash-language-server
      statix
      nil
      postgres-lsp
      yaml-language-server
      bicep

      # formatters
      pgformatter

      # nixd # nix-community
      nixpkgs-fmt
      marksman
      nodePackages.typescript-language-server

      # main packages
      timeshift
      neomutt
      chromium
      unstable.neovim
      lf
      pavucontrol
      vscode
      neofetch
      brightnessctl
      nextcloud-client
      networkmanagerapplet
      sxiv
      visidata
      khal
      wlr-randr
      trash-cli
      jq
      khard
      vdirsyncer
      qbittorrent
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
      pinentry = pkgs.pinentry-gnome3;
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
#
}
