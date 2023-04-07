{ config, pkgs, ... }: {

  # Let Home Manager install and manage itself.
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  imports = [
    ./files
    ./programs
  ];

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
      teams
      spotify
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

}
