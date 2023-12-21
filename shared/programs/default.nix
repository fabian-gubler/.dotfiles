{ config, pkgs, lib, ... }: {

  imports = [
    ./autojump
    ./tmux
	./alacritty
    ./mail
    ./newsboat
	./eclipse
    ./git
    ./kitty
    ./lf
    ./xdg
    ./yt-dlp
    ./zsh
    ./calendar
    ./eza
    # ./vscode
	./firefox
  ];

}
