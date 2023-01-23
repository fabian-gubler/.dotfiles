{ pkgs, ... }: {
  programs.yt-dlp = {
    enable = true;
    extraConfig = ''
      # Add YouTube Chapters
      --add-chapters

      # Subtitles
      --write-auto-sub
      --embed-subs
      --sub-lang=en

      # Best Resolution (1080p max)
      -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]'
      		'';
  };
}
