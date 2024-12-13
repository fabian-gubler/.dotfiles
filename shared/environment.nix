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
    "qbittorrent-4.6.4"
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

      # programming
      nodejs_20
      cargo

      # lsp server
      shellcheck
      nodePackages.bash-language-server
      statix
      nil
      postgres-lsp
      yaml-language-server
      bicep
      nixpkgs-fmt
      marksman
      nodePackages.typescript-language-server

      # main packages
      unstable.beeper
      unstable.neovim

      gnomeExtensions.pop-shell
      gnomeExtensions.appindicator
      gnomeExtensions.just-perfection
      gnomeExtensions.night-theme-switcher

      waybar
      eyedropper
      kickoff
      google-chrome
      wl-clipboard
      wally-cli
      bluetuith
      discord
      killall
      obsidian 
      timeshift
      neomutt
      chromium
      lf
      pavucontrol
      vscode
      neofetch
      brightnessctl
      networkmanagerapplet
      jq
      qbittorrent
      gcc
      timewarrior
      ncdu
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
    ]
  ;

  # fonts
  fonts.fontconfig.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

}
