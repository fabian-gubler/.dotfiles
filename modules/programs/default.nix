{ config, pkgs, lib, ... }: {
  imports = [
    ./autorandr
    ./autojump
    ./rofi
    ./git
    ./kitty
    ./lf
    ./xdg
    ./yt-dlp
    ./zsh
    ./calendar
    ./qutebrowser
  ];

}
