{ inputs, pkgs, outputs, ... }:

let
  # TODO: should be imported from initial flake
  user = "fabian";

in
{

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable OpenGL
  # hardware.opengl.enable = true;

  services.power-profiles-daemon.enable = false; # avoid conflicts with tlp
  services.tlp.enable = true;


  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  services.udev.packages = [ pkgs.swayosd ];
  system.activationScripts = {
    # swayosd cannot set brightness issue on NixOS
    # see https://github.com/ErikReider/SwayOSD/issues/12#issuecomment-1950581102
    fix-brightness-file-permission.text = ''
      chgrp video /sys/class/backlight/*/brightness
      chmod g+w /sys/class/backlight/*/brightness
    '';
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
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
    extraGroups = [ "wheel" "docker" "libvirtd" "video" ];
  };

  programs.dconf.enable = true;
  programs.zsh.enable = true;
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #   config.common.default = "*";
  # };

  time.timeZone = "Europe/Zurich";

  # TODO: System-wide GTK Theme
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
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

    # Duplicate: in home-manager
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    ANKI_BASE = "\${HOME}/nextcloud/apps/anki-data";
    PATH = "\${PATH}:\${XDG_BIN_HOME}:\${HOME}/.dotfiles/scripts/utils:\${HOME}/.dotfiles/scripts/dmenu:\${HOME}/.dotfiles/scripts/tmux";

  };



  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";

}
