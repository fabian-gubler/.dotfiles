{ pkgs, ... }: {
  imports = [
    ./autojump
    ./git
    ./kitty
    ./lf
    ./xdg
    ./yt-dlp
    ./zsh
  ];
}
