{ pkgs, ... }: {
  xdg = {
    desktopEntries = {
      # sioyek = {
      #   name = "sioyek";
      #   exec = "sioyek";
      #   mimeType = [ "application/pdf" ];
      # };

      foliate = {
        name = "foliate";
        exec = "foliate";
        mimeType = [ "application/epub+zip" ];
      };
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = [ "neovim.desktop" ];
        "application/pdf" = [ "okular.desktop" ];
        "text/html" = [ "qutebrowser.desktop" ];
        "image/jpeg" = [ "sxiv.desktop" ];
        "image/png" = [ "sxiv.desktop" ];
        "video/mp4" = [ "mpv.desktop" ];
        "video/x-matroska" = [ "mpv.desktop" ];
        "audo/mpeg" = [ "mpv.desktop" ];
      };
    };
  };
}
