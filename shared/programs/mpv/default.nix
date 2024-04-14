{ pkgs, ... }: {

  programs.mpv = {
    enable = true;
    scripts = with pkgs; [
      mpvScripts.mpris
      mpvScripts.uosc
      mpvScripts.sponsorblock
      mpvScripts.seekTo
      mpvScripts.quality-menu
    ];
    config = {
        osd-bar = "no";
        border = "no";

    };
  };

}
