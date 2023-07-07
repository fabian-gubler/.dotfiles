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
    PATH = "\${PATH}:\${XDG_BIN_HOME}:\${HOME}/.dotfiles/scripts/utils:\${HOME}/.dotfiles/scripts/dmenu:\${HOME}/.dotfiles/scripts/tmux:\${HOME}/go/bin";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs;
    [ notmuch-mutt notmuch lynx ] ++
	[ python310Packages.pyarrow ] ++
    [ khal khard vdirsyncer inotify-tools ] ++
    [
      neomutt
      dunst
      autorandr
      spicetify-cli
      newsboat
      signal-desktop
	  playerctl
	  postman
	  flameshot
	  blanket
	  ncdu
	  conda
	  jetbrains.idea-community
	  # bitwig-studio
      firefox
	  jdk
	  lazydocker
	  gradle
	  tree
    ] ++
    [ rnix-lsp neovim nodejs cargo gcc gnumake cmake ccls go ] ++
    [ nodePackages.bash-language-server ] ++
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
}
