{ config, pkgs, lib, ... }: {
  imports = [
    ./autorandr
    ./autojump
	./sioyek
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
