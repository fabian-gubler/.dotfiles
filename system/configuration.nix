{ config, pkgs, ... }:



let
  # TODO: should be imported from initial flake
  user = "fabian";

in
{


  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda";

  boot.loader.efi.canTouchEfiVariables = true;

  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  # remove after nextcloud setup on host
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.startx.enableGnomeKeyring = true;


  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    # protects nix shell against garbage collection
    extraOptions = ''
        keep-outputs = true
          keep-derivations = true
      	  '';
  };

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };


  # Display Server
  services.xserver = {
    enable = true;
    layout = "ch";
    modules = [ pkgs.xf86_input_wacom ];
    libinput.enable = true;
    wacom.enable = true;
    windowManager.dwm.enable = true;
    desktopManager.gnome.enable = true;
    displayManager = {
      autoLogin.user = "fabian";
      autoLogin.enable = true;
      defaultSession = "none+dwm";
    };
    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';
  };


  # Set your time zone and locals
  time.timeZone = "Europe/Zurich";

  virtualisation.virtualbox.guest.enable = true;

  # TODO: System-wide GTK Theme
  qt5 = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  # Use same keyboard layout for tty
  console.useXkbConfig = true;


  services = {
    atd.enable = true;

    # redshift = {
    #   enable = true;
    #   temperature.day = 6500;
    #   temperature.night = 3500;
    #   brightness.day = "1";
    #   brightness.night = "0.7";
    # };


  };

  programs = {
    tmux.enable = true;
    seahorse.enable = true;
    dconf.enable = true;
  };
}
