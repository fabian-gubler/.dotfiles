{
  xdg = {
    desktopEntries = {
      okular = {
        name = "okular";
        exec = "okular";
        mimeType = [ "application/pdf" ];
      };

    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = [ "neovim.desktop" ];
        "application/pdf" = [ "okular.desktop" ];
        "text/html" = [ "qutebrowser.desktop" ];
        "image/jpeg" = [ "sxiv.desktop" ];
        "application/epub+zip" = [ "foliate.desktop" ];
        "image/png" = [ "sxiv.desktop" ];
        "video/mp4" = [ "mpv.desktop" ];
        "video/x-matroska" = [ "mpv.desktop" ];
        "audo/mpeg" = [ "mpv.desktop" ];
      };
    };
  };
}
