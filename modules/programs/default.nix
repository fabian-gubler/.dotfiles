{ config, pkgs, lib, ... }: {
  imports = [
    ./autorandr
    ./autojump
	./sioyek
	./tmux
	./mail
	./newsboat
    ./rofi
    ./git
    ./kitty
    ./lf
    ./xdg
    ./yt-dlp
    ./zsh
    ./calendar
    ./qutebrowser
	./vscode
  ];

}
