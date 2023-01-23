{ pkgs, ... }: {

  environment = {
    systemPackages = with pkgs;
      [ python cargo nodejs lua gcc gnumake ] ++
      [ rbw pinentry-gtk2 ] ++
      [ spotify spicetify-cli ] ++
      [ zip unzip unrar ] ++
      [ mpv mpvScripts.mpris ] ++
      [ neomutt notmuch-mutt isync msmtp ] ++
      [ khal khard vdirsyncer ] ++
      [ rofi-bluetooth rofi ] ++
      [ anki-bin markdown-anki-decks ] ++
      [
        wget
        # TODO: try to replace pactl with wpctl
        pulseaudio
        pavucontrol
        neovim
        hsetroot
        brightnessctl
        handlr
        xclip
        xbindkeys
        arandr
        lf
        fzf
        stylua
        touchegg
        sqlite
        onboard
        flameshot
        blanket
        exa
        ripgrep
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
        playerctl
        # TODO: Declare keybindings in .nix format (e.g. services.actkbd)
        qbittorrent
        # TODO: fix protonvpn-cli (ncmli -> ipv6leakprotection)
        lazygit
        dmenu
        qutebrowser
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

  };
}
