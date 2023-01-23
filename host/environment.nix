{ pkgs, ... }: {

  # TODO: fix protonvpn-cli (ncmli -> ipv6leakprotection)
  environment = {
    systemPackages = with pkgs; 
    [ texlive.combined.scheme-basic ] ++		# TODO: shell.nix latex projects instead of global 
    [ python cargo nodejs lua gcc gnumake sqlite ] ++			# Programming Languages
    [ onboard zsa-udev-rules ] ++								# Keyboard
    [ newsboat todo-txt-cli ] ++								# Productivity
    [ hsetroot handlr xbindkeys xorg.xkill] ++					# Xorg
    [ chromium qbittorrent qutebrowser ] ++						# Internet
    [ signal-desktop protonmail-bridge nextcloud-client ] ++	# Privacy
    [ networkmanagerapplet blueberry ] ++						# Applet
    [ dmenu sxiv dunst ] ++										# Suckless
    [ sioyek zathura pandoc ] ++								# Documents
    [ gimp xournalpp ] ++										# Graphics
    [ neovim lazygit ] ++										# Editor
    [ arandr autorandr flameshot touchegg ] ++					# Display, Gestures
    [ lf exa fzf gotop htop trash-cli xdragon ] ++					# Navigation
    [ xclip clipnotify clipmenu ] ++							# Clipboard
    [ rbw pinentry-gtk2 ] ++									# Passwords
    [ spotify spicetify-cli mpv mpvScripts.mpris] ++			# Media
    [ wget file ripgrep ] ++									# File
    [ zip unzip unrar ] ++										# Compression
    [ neomutt notmuch-mutt isync msmtp ] ++						# Mail
    [ khal khard vdirsyncer inotify-tools ] ++					# Calendar
    [ rofi-bluetooth rofi ] ++									# Menu
    [ anki-bin markdown-anki-decks ] ++							# Anki
    [ xfce.thunar foliate blanket ] ++							# GTK
    [ pulseaudio pavucontrol brightnessctl playerctl ] # TODO: pulseaudio replace with wpctl (combined-sink)
    ;

    sessionVariables = rec {
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";
      XDG_DOWNLOAD_DIR = "\${HOME}/Downloads";

      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
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
