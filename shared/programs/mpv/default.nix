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
      osd-bar = false;
      border = false;
      gpu-context = "wayland";
      slang = "en";
      save-position-on-quit = true;
    };
    bindings = {
      tab = "script-binding uosc/toggle-ui";
      ENTER = "script-binding uosc/menu";
      DOWN = "add volume -5";
      UP = "add volume 5";
      S = "script-binding uosc/stream-quality";
      C = "script-binding uosc/subtitles";
      O = "script-binding uosc/open-file";
      A = "script-binding uosc/audio";
      P = "script-binding uosc/chapters";
      L = "script-binding uosc/playlist";
      t = "script-message-to seek_to toggle-seeker";
      "0" = "seek 0  absolute-percent";
      "1" = "seek 10 absolute-percent";
      "2" = "seek 20 absolute-percent";
      "3" = "seek 30 absolute-percent";
      "4" = "seek 40 absolute-percent";
      "5" = "seek 50 absolute-percent ";
      "6" = "seek 60 absolute-percent ";
      "7" = "seek 70 absolute-percent ";
      "8" = "seek 80 absolute-percent ";
      "9" = "seek 90 absolute-percent ";
    };
  };

}
