{ config, pkgs, lib, input, outputs, ... }:

let
  # TODO: should be imported from initial flake
  user = "fabian";

in
{

  # Boot loader
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "/dev/vda" ];
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable OpenGL
  hardware.opengl.enable = true;

  # Shared Filesystem
  fileSystems."/data" = {
    device = "data"; # Replace this with the correct device path
    fsType = "virtiofs"; # Replace this with the correct filesystem type
    options = [ "defaults" ];
  };

  # Virtualization
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };


  # Nixpkgs settings
  nixpkgs = {
    # You can add overlays here from the overlays folder
    overlays = [
      outputs.overlays.additions
      outputs.overlays.system
      outputs.overlays.unstable-packages

    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
    };
  };

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Packages installed in only for system profile.
  environment.systemPackages = with pkgs; [

    # necessary for fresh install
    dmenu
    alacritty # Note: xterm should be installed by default

    # explicitly for system only
    # ...
  ];

  # Nix Settings
  nix = {
    optimise.automatic = true;
    gc.automatic = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # User Settings
  users.users.${user} = {
    # Be sure to change it (using passwd) after rebooting!
    initialPassword = "password";
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" ];
  };

  programs.dconf.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	config.common.default = "*";
  };

  time.timeZone = "Europe/Zurich";

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
    HARSHPATH = "/data/nextcloud/todo/harsh";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    XDG_DOWNLOAD_DIR = "\${HOME}/Downloads";
	XDG_CONFIG_DIRS = [
	"${XDG_CONFIG_DIRS}",
	"/data"
	]
    QT_SCALE_FACTOR = "1.5";

    # Duplicate: in home-manager
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    ANKI_BASE = "/data/nextcloud/apps/anki-data";
    PATH = "\${PATH}:\${XDG_BIN_HOME}:/data/.dotfiles/scripts/utils:/data/.dotfiles/scripts/dmenu:/data/.dotfiles/scripts/tmux";

  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";

}
