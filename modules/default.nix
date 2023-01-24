{ config, pkgs, ... }: {

  # Let Home Manager install and manage itself.
  home.stateVersion = "21.11";
  programs.home-manager.enable = true;

  imports = [
    ./files
    ./programs
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs;
    [ neomutt notmuch-mutt msmtp lynx ] ++
    [ khal khard vdirsyncer inotify-tools ] ++
    [
      rofi
      dunst
      autorandr
      isync
      touchegg
      spicetify-cli
      sioyek
      qutebrowser
      newsboat
    ];

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };



}
