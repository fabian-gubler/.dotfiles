{ config, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/virtualbox-demo.nix> ];

# TODO: User variable = fabian -> implement in dwm path
# TODO: xprofile declared or copied


# TODO: Configuration
# Automatic .dotfiles configuration
# SSH key generation, add to github
# Neovim clone

# Display Manager
services = {
  xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true;
      defaultSession = "none+dwm";
    };
    desktopManager.xfce.enable = true;
    windowManager.dwm.enable = true;
  };
};

# TODO: deactivate pulseaudio module
# Pipewire
# services = {
#   pipewire = {
#     enable = true;
#     alsa = {
#       enable = true;
#       support32Bit = true;
#     };
#     pulse.enable = true;
#     jack.enable = true;
#   };
# };

# Bluetooth
hardware = {
  bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
};

# Set your time zone.
time.timeZone = "Europe/Zurich";

services.xserver.layout = "ch";
# List packages installed in system profile. To search, run:
# \$ nix search wget
environment.systemPackages = with pkgs; [
  wget
  neovim
  git
  dmenu
  kitty
  xorg.xsetroot
  python
  zsh
  gnumake
  lf
];

nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: { src = /home/demo/.dotfiles/config/suckless/dwm ;});
    })
];

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

}
