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
      # spicetify-cli
      newsboat
    ];

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
