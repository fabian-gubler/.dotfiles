{
  programs.rofi = {
    enable = true;
    theme = ./files/spotlight-dark.rasi;
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