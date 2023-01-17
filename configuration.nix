{ config, pkgs, lib, ... }:


{

  imports = [
    <nixpkgs/nixos/modules/installer/virtualbox-demo.nix>
    <home-manager/nixos>
  ];

  # TODO: User variable = fabian -> implement in dwm path
  # TODO: xprofile declared or copied

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # TODO: Configuration
  # Automatic .dotfiles configuration
  # SSH key generation, add to github
  # Neovim clone

  # Display Server
  services.xserver = {
    enable = true;
    layout = "ch";
    libinput.enable = true;
    modules = [ pkgs.xf86_input_wacom ];
    wacom.enable = true;

    displayManager = {
      sddm.enable = true;
      defaultSession = "none+dwm";
    };

    desktopManager.xfce.enable = true;
    windowManager.dwm.enable = true;
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

  location.latitude = 48.1;
  location.longitude = 9.1;

  services = {
    unclutter.enable = true;
    touchegg.enable = true;
    gnome.gnome-keyring.enable = true;
    # tlp.enable = true;

    picom = {
      enable = true;
      fade = true;
    };

    redshift = {
      enable = true;
      temperature.day = 6500;
      temperature.night = 3500;
      brightness.day = "1";
      brightness.night = "0.7";
    };

    cron = {
      enable = true;
      systemCronJobs = [
        #Ansible: sync mailbox (every 5 minutes)
        "*/5 * * * * killall mbsync &>/dev/null; mbsync protonmail"
        #Ansible: trash downloads (at 5 AM)
        "0 5 * * * trash $HOME/Downloads/*"
        #Ansible: push dotfiles (at 5 AM)
        "0 5 * * * cd $HOME/.dotfiles && git add . && git commit -m 'automated update' && git push origin main"
        #Ansible: push neovim (at 5 AM)
        "0 5 * * * cd $HOME/.config/nvim && git add . && git commit -m 'automated update' && git push origin main"
        #Ansible: empty trash older than 30 days (every week)
        "0 8 * * 0 trash-empty 30"
      ];
    };
  };


  # List packages installed in system profile. To search, run:
  # \$ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    dmenu
    kitty
    xorg.xsetroot
    xorg.xbacklight
    xclip
    arandr
    python
    gnumake
    lf
    fzf
    stylua
    rbw
    sqlite
    onboard
    exa
    ripgrep
    ncdu
    gimp
    chromium
    xfce.thunar
    foliate
    xournalpp
    handlr
    # TODO: handlr xdg-open replacement
    zsa-udev-rules
    texlive.combined.scheme-basic
    nodejs
    rustc
    rustup
    networkmanagerapplet
    blueberry
    pasystray
    nextcloud-client
    autorandr
    dunst
    pandoc
    newsboat
    yt-dlp
    mpv
    mpvScripts.mpris
    playerctl
    xbindkeys
    qbittorrent
    pavucontrol
    rofi
    openvpn
    networkmanager-openvpn
    gnome.networkmanager-openvpn
    blanket
    lazygit
    neomutt
    isync
    notmuch-mutt
    msmtp
    qutebrowser
    spicetify-cli
    khal
    markdown-anki-decks
    khard
    vdirsyncer
    zplug
    signal-desktop
    xdragon
    todo-txt-cli
    devour
    clipnotify
    clipmenu
    volctl
    gotop
    spotify
  ];

  nixpkgs.config.allowUnfree = true;
  virtualisation.virtualbox = {
    host.enable = true;
    guest.enable = true;
    guest.x11 = true;
  };

  users.extraGroups.vboxusers.members = [ "demo" ];

  programs = {
    tmux.enable = true;
    autojump.enable = true;
    # seahorse.enable = true;

    firefox = {
      enable = true;
      # Preferences to set from about:config
      preferences = { };
    };

    java = {
      enable = true;
    };

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      histSize = 100000;

      shellAliases = {
        ll = "exa -a";
        build = "sudo nixos-rebuild switch";
      };

      #     zplug = {
      #       enable = true;
      #       plugins = [
      #         { name = "Aloxaf/fzf-tab"; }
      #         { name = "hlissner/zsh-autopair"; }
      #       ];

      shellInit = '' 
		source ~/.zplug/init.zsh
		source ${pkgs.pure-prompt}/share/zsh/site-functions/prompt_pure_setup
		autoload -U promptinit; promptinit
		zstyle ':prompt:pure:prompt:*' color "#D8DEE9"
		source ~/.config/lf/lfcd.sh
		bindkey -s '^f' 'lfcd\n'
      '';
    };
  };

  users.users.demo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" ];
    shell = pkgs.zsh;
  };


  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: { src = /home/demo/.dotfiles/config/suckless/dwm; });
    })
  ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  # This does NOT define the NixOS version. The channel does.
  # https://nixos.wiki/wiki/FAQ#When_do_I_update_stateVersion
  system.stateVersion = "22.11"; # Did you read the comment?

}
