{ config, pkgs, lib, ... }:



let
  # TODO: should be imported from initial flake
  user = "fabian";

in
{

  # Boot loader
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable OpenGL
  hardware.opengl.enable = true;

  # Shared Filesystem
  fileSystems."/data" = {
    device = "data"; # Replace this with the correct device path
    fsType = "virtiofs"; # Replace this with the correct filesystem type
    options = [ "defaults" ];
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    firefox = {
      enableTridactylNative = true;
    };
    # permittedInsecurePackages = [ "electron-24.8.6" ];

  };


  system.stateVersion = "22.11";

  # Nix Settings
  nix = {
    package = pkgs.nixStable;
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
  };

  programs.dconf.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  time.timeZone = "Europe/Zurich";

  # Databases

  # link: https://nixos.wiki/wiki/PostgreSQL

  # TODO: System-wide GTK Theme
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  # Use same keyboard layout for tty
  console.useXkbConfig = true;

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    TIMEWARRIORDB = "/data/nextcloud/todo/timewarrior";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    XDG_DOWNLOAD_DIR = "\${HOME}/Downloads";
    QT_SCALE_FACTOR = "1.5";

    # Duplicate: in home-manager
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    ANKI_BASE = "/data/nextcloud/apps/anki-data";
    PATH = "\${PATH}:\${XDG_BIN_HOME}:/data/.dotfiles/scripts/utils:/data/.dotfiles/scripts/dmenu:/data/.dotfiles/scripts/tmux";

  };

}
