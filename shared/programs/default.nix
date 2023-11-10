{ config, pkgs, lib, ... }: {

  imports = [
    ./autojump
    ./tmux
	./alacritty
    ./mail
    ./newsboat
	./eclipse
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
	./firefox
  ];

}
