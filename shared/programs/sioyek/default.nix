{ pkgs, ... }:
{
  programs.sioyek = {
    enable = true;
    package = pkgs.sioyek;

    bindings = {
      screen_down = "<C-d>";
      screen_up = "<C-u>";
      prev_state = "<C-o>";
      next_state = "<C-i>";
      next_page = "<C-n>";
      previous_page = "<C-p>";
      open_prev_doc = "<C-6>";
      fit_to_page_height = "<C-0>";
      fit_to_page_width = "<C-1>";
      fit_to_page_width_smart = "<C-2>";
      toggle_statusbar = "m";
      toggle_custom_color = "c";
      toggle_dark_mode = "<S-c>";
    };
    config = {
      create_table_of_contents_if_not_exists = "1";
      sort_bookmarks_by_location = "1";
      font_size = "15";
      status_bar_font_size = "15";
      custom_background_color = "0.9 0.87 0.78";
      custom_text_color = "0.36 0.26 0.19";
      dark_mode_contrast = "0.8";
    };
  };
  # xdg.mimeApps.defaultApplications = {
  #   "application/pdf" = [ "sioyek.desktop" ];
  #   "application/x-pdf" = [ "sioyek.desktop" ];
  #   "application/fdf" = [ "sioyek.desktop" ];
  #   "application/xdp" = [ "sioyek.desktop" ];
  #   "application/xfdf" = [ "sioyek.desktop" ];
  #   "application/pdx" = [ "sioyek.desktop" ];
  # };
}
  
