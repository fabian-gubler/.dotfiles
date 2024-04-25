{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    settings = {
      monitor = [ ",preferred, auto, auto" ];
      input = {
        kb_layout = "ch, us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "yes";
        };
        sensitivity = 0;
      };

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(81a1c1ff) rgba(c2c7d1ff) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "master";
        allow_tearing = false;
      };

      decoration = {
        rounding = 5;
        blur = {
          enabled = false;
          size = 21;
          passes = 3;
          ignore_opacity = true;
          new_optimizations = "on";
          noise = 0.0117;
          contrast = 1.0;
          brightness = 1.0;
        };
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = "no";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      master = {
        new_is_master = true;
        new_on_top = true;
        # no_gaps_when_only = 1;
        mfact = 0.55;
      };

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        disable_hyprland_logo = true;
        vrr = 1;
        force_default_wallpaper = 0;
      };

      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "kickoff";
      "$browser" = "firefox";

      bind = [
        "$mod, Return, exec, $terminal"
        "$mod, W, exec, $browser"
        "$mod, A, exec, $menu"
        "$mod, Q, killactive"
        "$mod, P, exec, swaync-client -t"
        "$mod, V, togglefloating"
        "$mod, F, fullscreen, 0"
        "$mod SHIFT, F, fullscreen, 1"
        "$mod, S, exec, pkill -SIGUSR1 waybar"
        "$mod SHIFT, Q, exit"
        "$mod, N, layoutmsg, cyclenext"
        "$mod, E, layoutmsg, cycleprev"
        "$mod CTRL, N, layoutmsg, swapnext"
        "$mod CTRL, E, layoutmsg, swapprev"
        "$mod, Y, exec, swaync-client -C"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      binde = [
        "$mod, I, resizeactive, 20 0"
        "$mod, M, resizeactive, -20 0"
        ",XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ",XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ",XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
        ",XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
      ];

      windowrule = [
        "float, file_progress"
        "float, All Files"
        "float, confirm"
        "float, dialog"
        "float, download"
        "float, notification"
        "float, error"
        "float, splash"
        "float, confirmreset"
        "float, title:Open File"
        "float, title:branchdialog"
        "float, gnome-font"
        "float, org.gnome.Settings"
        "float, file-roller"
        "float, nautilus"
        "float, nemo"
        "float, thunar"
        "tile, Spotify"
        "float, title:^(Picture-in-Picture)$"
        "float, title:^(Firefox — Sharing Indicator)$"
      ];

      blurls = [ "swaync" "wofi" "swayosd" ];
      env = [
        "QT_QPA_PLATFORM,wayland"
        "XCURSOR_SIZE,24"
      ];
      exec-once = [
        "nm-applet"
        "swayosd-server"
        "waybar"
        "wpaperd"
        "swaync"
        "obsidian"
        "gammastep -l 47.36667:8.55"
        "nextcloud --background"
        "beeper --hidden"
      ];

    };

    extraConfig = "";

  };
}

