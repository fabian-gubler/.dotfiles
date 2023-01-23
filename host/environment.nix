{ pkgs, ... }: {

  environment = {
    sessionVariables = rec {
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

    systemPackages = with pkgs; [
      alacritty
      wget
      # TODO: try to replace pactl with wpctl
      pulseaudio
      neovim
      hsetroot
	  at
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
      touchegg
      rbw
      pinentry-gtk2
      spotify
      spicetify-cli
      sqlite
      onboard
      flameshot
      blanket
      exa
      ripgrep
      zip
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
      # TODO: Make fully bluetooth client touch compatible -> uninstall blueberry
      rofi
      rofi-bluetooth
      # TODO: fix protonvpn-cli (ncmli -> ipv6leakprotection)
      lazygit
      dmenu
      neomutt
      notmuch-mutt
      isync
      msmtp
      qutebrowser
      khal
      khard
      anki-bin
      markdown-anki-decks
      vdirsyncer
      inotify-tools
      signal-desktop
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
  };
}
