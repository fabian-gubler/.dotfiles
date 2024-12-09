{ pkgs, outputs, user, ... }: {

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hyprland
  programs.hyprland.enable = true;

  # Desktop Environment
  services.xserver.enable = true;
  services.xserver.xkb.layout = "ch";
  services.xserver.desktopManager.gnome.enable = true;
  services.displayManager.defaultSession = "hyprland";

  # Working Display manager
  services.displayManager.sddm.enable = true;

  # TODO: GDM Not starting
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.gdm.wayland = true;

  services = {

    # Extras
    gnome.gnome-keyring.enable = true; # required for some vs code extensions
    atd.enable = true;
    flatpak.enable = false;

    # Power
    power-profiles-daemon.enable = false; # avoid conflicts with tlp
    tlp.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };


    # OSD
    udev.packages = [ pkgs.swayosd ];
  };


  programs.zsh.enable = true;

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  # Virtualization
  virtualisation = {
    docker = {
      enable = true;
      package = pkgs.docker_26;
    };
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
  system.activationScripts = {
    # swayosd cannot set brightness issue on NixOS
    # see https://github.com/ErikReider/SwayOSD/issues/12#issuecomment-1950581102
    fix-brightness-file-permission.text = ''
      chgrp video /sys/class/backlight/*/brightness
      chmod g+w /sys/class/backlight/*/brightness
    '';
  };

  # rtkit is optional but recommended
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  # Packages installed in only for system profile.
  environment.systemPackages = with pkgs; [

    # necessary for fresh install
    dmenu
    alacritty # Note: xterm should be installed by default

    # explicitly for system only
    at # home-manager requires: services.atd.enable 
  ];

  # Nix Settings
  nix = {
    optimise.automatic = true;
    gc.automatic = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # User Settings
  users.defaultUserShell = pkgs.zsh;
  users.users.${user} = {
    # Be sure to change it (using passwd) after rebooting!
    initialPassword = "password";
    useDefaultShell = true;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "video" "input" ];
  };


  time.timeZone = "Asia/Bangkok";


  # TODO: System-wide GTK Theme
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "adwaita-dark";
  };

  # Use same keyboard layout for tty
  console.useXkbConfig = true;

  environment.sessionVariables = {
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    TIMEWARRIORDB = "\${HOME}/nextcloud/todo/timewarrior";
    HARSHPATH = "\${HOME}/nextcloud/todo/harsh";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    XDG_DOWNLOAD_DIR = "\${HOME}/Downloads";
    QT_SCALE_FACTOR = "1.5";
    NIXOS_OZONE_WL = "1"; # fixes vscode/obsidian/beeper blur

    # Duplicate: in home-manager
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    PATH = "\${PATH}:\${XDG_BIN_HOME}:\${HOME}/.dotfiles/scripts/utils:\${HOME}/.dotfiles/scripts/dmenu:\${HOME}/.dotfiles/scripts/tmux";

  };

  # Extra hsots
  networking.extraHosts =
    ''
      127.0.0.1 synchat.internal
      127.0.0.1 synchatapi.internal
    '';

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
