{ config, pkgs, lib, ... }: {

  imports = [
    ./autojump
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
