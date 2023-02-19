{ pkgs, config, lib, ... }: {

  programs.rofi = {
    enable = true;
    font = "SFMono 20";
    theme = ./files/spotlight-dark.rasi;
    configPath = "$XDG_CONFIG_HOME/rofi/config.rasi";
    extraConfig = {
      kb-row-up = "Up,Shift+Tab";
      kb-row-down = "Down";
      kb-accept-entry = "Return,KP_Enter";
      kb-remove-char-back = "BackSpace";
      kb-row-last = "Shift+End";
      kb-row-first = "Shift+Home";
      kb-move-front = "Home";
      kb-move-end = "End";
    };
  };
}

