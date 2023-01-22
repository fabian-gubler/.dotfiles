{ config, pkgs, lib, ... }:

let
  user = "fabian";
in
{
  imports = [
    ./hardware-configuration.nix
    ./modules/timers.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixUnstable;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # TODO: System-wide GTK Theme
  qt5 = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # DEBUG
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    stevenBlackHosts = {
      blockFakenews = true;
      blockGambling = true;
      blockPorn = true;
      blockSocial = false;
    };
  };

  # Display Server
  services.xserver = {
    enable = true;
    layout = "ch";

    libinput.enable = true;
    modules = [ pkgs.xf86_input_wacom ];
    wacom.enable = true;
    windowManager.dwm.enable = true;
    displayManager = {
      defaultSession = "none+dwm";
      gdm.enable = true;
    };

  };

  # Use same layout for linux console
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

  location.latitude = 48.1;
  location.longitude = 9.1;

  xdg.portal.enable = true;

  services = {
    touchegg.enable = true;
    gnome.gnome-keyring.enable = true;
    tlp.enable = true;
    flatpak.enable = true;

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

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    XDG_DOWNLOAD_DIR = "\${HOME}/Downloads";

    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    PAGER = "less";
    OPENER = "xdg-open";
    ANKI_BASE = "\${HOME}/nextcloud/apps/anki-data";
    QT_SCALE_FACTOR = "1.5";

    PATH = [
      "\${XDG_BIN_HOME}"
      "\${HOME}/.dotfiles/scripts/utils"
      "\${HOME}/.dotfiles/scripts/tmux"
    ];
  };

  environment.systemPackages = with pkgs; [
    alacritty
    wget
    neovim
    hsetroot
    brightnessctl
    handlr
    xclip
    arandr
    python
    cargo
    nodejs
    lua
    gcc
    gnumake
    lf
    fzf
    stylua
    rbw
    pinentry-gtk2
    spotify
    spicetify-cli
    sqlite
    onboard
    flameshot
    exa
    ripgrep
    unzip
    unrar
    gimp
    chromium
    xfce.thunar
    foliate
    xournalpp
    file
    # TODO: xdg-open declaration
    zsa-udev-rules
    texlive.combined.scheme-basic
    networkmanagerapplet
    blueberry
    nextcloud-client
    autorandr
    dunst
    newsboat
    trash-cli
    mpv
    mpvScripts.mpris
    playerctl
    # TODO: Declare keybindings in .nix format (e.g. services.actkbd)
    xbindkeys
    qbittorrent
    pavucontrol
    rofi
    # TODO: Make fully touch compatible -> uninstall blueberry
    rofi-bluetooth
    # TODO: fix protonvpn-cli (ncmli -> ipv6leakprotection)
    lazygit
    neomutt
    isync
    notmuch-mutt
    msmtp
    qutebrowser
    khal
    anki-bin
    markdown-anki-decks
    khard
    vdirsyncer
    signal-desktop
    dmenu
    sxiv
    xdragon
    todo-txt-cli
    clipnotify
    clipmenu
    gotop
    protonmail-bridge
    sioyek
    zathura
    pandoc
  ];


  security.pam.services.startx.enableGnomeKeyring = true;

  virtualisation = {
    docker.enable = true;
    virtualbox = {
      host.enable = true;
      # guest.enable = true;
      # guest.x11 = true;
    };
  };


  programs = {
    tmux.enable = true;
    slock.enable = true;
    seahorse.enable = true;

    firefox = {
      enable = true;
      # Preferences to set from about:config
      preferences = { };
    };

    java = {
      enable = true;
    };

  };

  nixpkgs.overlays = [
    (final: prev: {
      # TODO: fix absolute path (not pure)
      dwm = prev.dwm.overrideAttrs (old: { src = /home/fabian/nixos-config/config/dwm; });
      dmenu = prev.dmenu.overrideAttrs (old: { src = ./config/dmenu; });
    })
  ];

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" "docker" ];
    initialPassword = "password";
    shell = pkgs.zsh;
  };



  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  # This does NOT define the NixOS version. The channel does.
  # https://nixos.wiki/wiki/FAQ#When_do_I_update_stateVersion
  system.stateVersion = "22.11"; # Did you read the comment?



}
