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
    MANPAGER = "nvim +Man!";
    ANKI_BASE = "/data/nextcloud/apps/anki-data";
    PATH = "\${PATH}:\${XDG_BIN_HOME}:\${HOME}/.dotfiles/scripts/utils:\${HOME}/.dotfiles/scripts/dmenu:\${HOME}/.dotfiles/scripts/tmux";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs;
    [ notmuch-mutt notmuch lynx ] ++
    [ khal khard vdirsyncer inotify-tools ] ++
    [
      neomutt
      dunst
      autorandr
      spicetify-cli
      newsboat
      signal-desktop
      # teams
      # spotify
      firefox
    ] ++
    [ python3 neovim cargo nodejs gcc gnumake cmake ccls go ] ++
    [ rnix-lsp nodePackages.bash-language-server ] ++
    [ texlive.combined.scheme-small ] ++
    [ todo-txt-cli ] ++
    [ rbw authy protonmail-bridge ] ++
    [ zathura okular pandoc poppler_utils ] ++
    [ gimp xournalpp colorpicker libreoffice ] ++
    [ lazygit lf exa fzf gotop trash-cli xdragon ] ++
    [ xdotool pinentry ] ++
    [ wget file ripgrep ] ++
    [ zip unzip unrar steam-run ] ++
    [ anki-bin markdown-anki-decks mkdocs ]
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

  programs.gnome-terminal = {
    enable = true;
    profile.nord = {
      audioBell = false;
      backgroundColor = "#2e3440";
      boldColor = "#d8dee9";
      boldColorSameAsFG = false;
      cursorBlinkMode = "off";
	  customCommand = "tmuxd";
	  showMenubar = false;
	  font = "SF Mono 15";
	  foregroundColor = "#d8dee9";
	  scrollbarPolicy = "never";
	  useThemeColors = false;
	  useThemeBackground = false;
	};
	  cursorColor = "#d8dee9";
	  highlightColor = "#4c566a";
      cursorShape = "block";
      foregroundColor = "#d8dee9";
      palette = [
        "#3b4252"
        "#bf616a"
        "#a3be8c"
        "#ebcb8b"
        "#81a1c1"
        "#b48ead"
        "#88c0d0"
        "#e5e9f0"
        "#4c566a"
        "#bf616a"
        "#a3be8c"
        "#ebcb8b"
        "#81a1c1"
        "#b48ead"
        "#8fbcbb"
        "#eceff4"
      ];
      useThemeColors = false;
      useThemeBackground = false;
    };
  };

}
