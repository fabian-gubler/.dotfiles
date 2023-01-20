{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/timers.nix
  ];

  nix = {
    package = pkgs.nixUnstable;
    # settings = {
    #   experimental-features = [ "nix-command" "flakes" ];
    # };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # FLAKE:
  # - One line install: nixos-rebuild switch --flake github:owner/repo

  # TODO: Variables 
  # <user> = demo (can set as flag?)
  # <version> = 22.11 (understand better) 
  # <hardware> = x84-64-Linux

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
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
      lightdm = {
        enable = true;
        greeters.gtk = {
          enable = true;
          extraConfig = "keyboard=onboard";
        };
      };
    };

  };

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

  services = {
    touchegg.enable = true;
    gnome.gnome-keyring.enable = true;
    tlp.enable = true;

    unclutter = {
      enable = true;
      timeout = 1;
    };

    jellyfin = {
      enable = true;
      user = "fabian";
      openFirewall = false;
    };


    sonarr = {
      enable = true;
      user = "fabian";
    };

    radarr = {
      enable = true;
      user = "fabian";
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

#    redshift = {
#      enable = true;
#      temperature.day = 6500;
#      temperature.night = 3500;
#      brightness.day = "1";
#      brightness.night = "0.7";
#    };


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
    OPENER = "handlr open";
    ANKI_BASE = "\${HOME}/nextcloud/apps/anki-data";

    PATH = [
      "\${XDG_BIN_HOME}"
      "\${HOME}/.dotfiles/scripts/utils"
      "\${HOME}/.dotfiles/scripts/tmux"
    ];
  };

  # List packages installed in system profile. To search, run:
  # \$ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    neovim
    kitty
    hsetroot
    xorg.xbacklight
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
    sqlite
    # TODO: onboard configuration
    onboard
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
    handlr
    # TODO: handlr xdg-open replacement
    zsa-udev-rules
    texlive.combined.scheme-basic
    networkmanagerapplet
    blueberry
    pasystray
    nextcloud-client
    autorandr
    dunst
    newsboat
    yt-dlp
    trash-cli
    mpv
    mpvScripts.mpris
    playerctl
    xbindkeys
    qbittorrent
    pavucontrol
    rofi
    # TODO: setup protonvpn
    openvpn
    networkmanager-openvpn
    gnome.networkmanager-openvpn
    blanket
    lazygit
    # TODO: neomutt home-manager declaration
    neomutt
    isync
    notmuch-mutt
    msmtp
    qutebrowser
    spotify
    spicetify-cli
    khal
    anki
    markdown-anki-decks
    khard
    vdirsyncer
    signal-desktop
    sxiv
    xdragon
    todo-txt-cli
    clipnotify
    clipmenu
    volctl
    # TODO: fix dmenu
    dmenu
    gotop
    protonmail-bridge
    # TODO: Fix text rendering
    sioyek
    pandoc
  ];

  nixpkgs.config.allowUnfree = true;
#virtualisation.virtualbox = {
#  host.enable = true;
#  guest.enable = true;
#  guest.x11 = true;
#};


  programs = {
    tmux.enable = true;
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

  users.users.fabian = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" ];
    initialPassword = "password";
    shell = pkgs.zsh;
  };

  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: { src = /home/fabian/.dotfiles/config/suckless/dwm; });
      dmenu = prev.dmenu.overrideAttrs (old: { src = /home/fabian/.dotfiles/config/suckless/dmenu; });
    })
  ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  # This does NOT define the NixOS version. The channel does.
  # https://nixos.wiki/wiki/FAQ#When_do_I_update_stateVersion
  system.stateVersion = "22.11"; # Did you read the comment?


  # TODO: test when logging in (probably with lightdm)
  security.pam.services.startx.enableGnomeKeyring = true;


}
