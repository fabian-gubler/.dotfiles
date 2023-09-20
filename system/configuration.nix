{ config, pkgs, ... }:



let
  # TODO: should be imported from initial flake
  user = "fabian";

in
{
  # Boot loader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.efi.canTouchEfiVariables = true;

  # Guest Agent
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  # Enable OpenGL
  hardware.opengl.enable = true;

  # Shared Filesystem
  fileSystems."/data" = {
    device = "data"; # Replace this with the correct device path
    fsType = "virtiofs"; # Replace this with the correct filesystem type
    options = [ "defaults" ];
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "fabian" ];
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

  # Nix Settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    # protects nix shell against garbage collection
    extraOptions = ''
        keep-outputs = true
          keep-derivations = true
      	  '';
  };

  # User Settings
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "qemu-libvirtd" ];
    # shell = pkgs.zsh;
  };

  # virtualization
  virtualisation.docker.enable = true;


  services.gnome.gnome-keyring.enable = true; # required for some vs code extensions

  # Display Server
  services.xserver = {
    enable = true;
    layout = "ch";
    windowManager.dwm.enable = true;
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "fabian";
      defaultSession = "none+dwm";
    };
  };

  services.atd.enable = true;
  programs.dconf.enable = true;

  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  time.timeZone = "Europe/Zurich";

  # Databases

  # link: https://nixos.wiki/wiki/PostgreSQL
  services.postgresql = {
    enable = true;
    # package = pkgs.postgresql_15; # current 15.4
    ensureDatabases = [ "mydatabase" ];
    authentication = pkgs.lib.mkOverride 10 ''
      local all all              trust
      host  all all 127.0.0.1/32 trust
      host  all all ::1/128      trust
    '';
    enableTCPIP = true;
    # port = 5432;
  };

  # TODO: System-wide GTK Theme
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  # Use same keyboard layout for tty
  console.useXkbConfig = true;

}
