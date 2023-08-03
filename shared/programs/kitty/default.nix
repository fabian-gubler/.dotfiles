{ config, pkgs, ... }:
let
  kittyColors = import ./kitty-colors.nix { inherit (pkgs) lib config; };
in
{
  programs.kitty = {
    enable = true;
    extraConfig = kittyColors;
    # theme = "Nord";
    font = {
      size = 14;
      name = "SF Mono";
    };
    settings = {
      enable_audio_bell = false;
      open_url_modifiers = "ctrl";
      window_margin_width = 10;
      cursor_shape = "block";
      cursor_blink_interval = 0;
      confirm_os_window_close = 0;
      listen_on = "unix:/tmp/kitty";
      allow_remote_control = "socket-only";

    };
    keybindings = {
      "ctrl+2" = "change_font_size all +1.0";
      "ctrl+1" = "change_font_size all -1.0";
      "ctrl+0" = "change_font_size all 0";
    };
  };
}
