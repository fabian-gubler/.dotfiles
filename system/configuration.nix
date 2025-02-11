{ pkgs, outputs, user, ... }: {


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Desktop Environment
  services.xserver.enable = true;
  services.xserver.xkb.layout = "ch";
  services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.displayManager.gdm.enable = true;

  # Hyprland
  programs.hyprland.enable = true;

  services = {

    # Extras
    atd.enable = true;
    flatpak.enable = false;

    # Power
    power-profiles-daemon.enable = false; # avoid conflicts with tlp
    tlp.enable = true;

  };


  programs = {
    zsh.enable = true;
  };

  # Sound
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Virtualization
  virtualisation.docker.enable = true;

  # Nixpkgs settings
  nixpkgs = {
    # You can add overlays here from the overlays folder
    overlays = [
      outputs.overlays.additions
      outputs.overlays.unstable-packages

    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
    };
  };

  # rtkit is optional but recommended
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

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
    extraGroups = [ "wheel" "docker" "video" "input" ];
  };

  # Use same keyboard layout for tty
  console.useXkbConfig = true;

  environment.sessionVariables = {
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    TIMEWARRIORDB = "\${HOME}/nextcloud/todo/timewarrior";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    XDG_DOWNLOAD_DIR = "\${HOME}/Downloads";

    # Duplicate: in home-manager
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    PATH = "\${PATH}:\${XDG_BIN_HOME}:\${HOME}/.dotfiles/scripts/utils:\${HOME}/.dotfiles/scripts/dmenu:\${HOME}/.dotfiles/scripts/tmux";

  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
