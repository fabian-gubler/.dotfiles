{ config, pkgs, ... }:

let
  # TODO: should be imported from initial flake
  user = "fabian";

in
{

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
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" "docker" ];
    initialPassword = "password";
    shell = pkgs.zsh;
  };

  # Set your time zone and locals
  time.timeZone = "Europe/Zurich";
  location.latitude = 48.1;
  location.longitude = 9.1;

  # Display Server
  services.xserver = {
    enable = true;
    layout = "ch";
    modules = [ pkgs.xf86_input_wacom ];
    libinput.enable = true;
    wacom.enable = true;
    windowManager.dwm.enable = true;
    displayManager = {
      defaultSession = "none+dwm";
      gdm.enable = true;
    };
    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';
  };

  # Flatpak
  xdg.portal.enable = true;
  services.flatpak.enable = true;

  # TODO: System-wide GTK Theme
  qt5 = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  networking = {
    hostName = "nixos";
    # hosts = {
    #   "0.0.0.0" = [ "youtube.com" "www.youtube.com" ];
    # };
    networkmanager.enable = true;
    stevenBlackHosts = {
      blockFakenews = true;
      blockGambling = true;
      blockPorn = true;
      blockSocial = false;
    };
  };

  # Use same keyboard layout for tty
  console.useXkbConfig = true;

  # Pipewire
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
  };

  # Service management
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';

  # Bluetooth
  hardware = {
    keyboard.zsa.enable = true;
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };

  services = {
    touchegg.enable = true;
    gnome.gnome-keyring.enable = true;
    tlp.enable = true;
    atd.enable = true;
    unclutter = {
      enable = true;
      timeout = 1;
    };

    jellyfin = {
      enable = true;
      user = "${user}";
      openFirewall = false;
    };


    sonarr = {
      enable = true;
      user = "${user}";
    };

    radarr = {
      enable = true;
      user = "${user}";
    };

    prowlarr.enable = true;

    picom = {
      enable = true;
      fadeSteps = [
        0.06
        0.06
      ];
      fade = true;
    };

    redshift = {
      enable = true;
      temperature.day = 6500;
      temperature.night = 3500;
      brightness.day = "1";
      brightness.night = "0.7";
    };


  };

  security.pam.services.startx.enableGnomeKeyring = true;

  virtualisation = {
    docker.enable = true;
    virtualbox = {
      host.enable = true;
    };
  };


  programs = {
    tmux.enable = true;
    slock.enable = true;
    seahorse.enable = true;
    java.enable = true;

    firefox = {
      enable = true;
      # TODO: Debug 
      preferences = {
        "font.size.systemFontScale" = 130;
      };
    };


  };


}
