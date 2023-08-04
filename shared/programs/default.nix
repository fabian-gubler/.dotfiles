{ config, pkgs, lib, ... }: {

  imports = [
    ./autorandr
    ./autojump
    ./sioyek
    ./tmux
	./alacritty
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
