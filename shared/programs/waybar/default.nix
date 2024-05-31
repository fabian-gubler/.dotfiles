{
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 38;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "pulseaudio" "battery" ];

        tray = { spacing = 10; };

        clock = {
          format = "{:%H:%M}";
          # on-click = "swaync-client -t";
          tooltip-format = "<span size='9pt' font='Fragment Mono'>{calendar}</span>";
        };


        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = true;
          disable-scroll = false;
          on-scroll-up = "hyprctl dispatch workspace -1";
          on-scroll-down = "hyprctl dispatch workspace +1";
          format = "{icon}";
          on-click = "activate";
          sort-by-number = true;
          format-icons = {
            "urgent" = "";
            "active" = "";
            "default" = "";
          };
        };

        battery = {
          bat = "BAT0";
          interval = 2;
          states = {
            # warning = 30;
            critical = 15;
          };
          format = "󱐋{icon} ";
          # 󰂄
          format-discharging = "{icon} ";
          # format-icons = [ "" "" "" "" "" ];
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          tooltip = true;
          tooltip-format = "{capacity}% - {timeTo}";
        };

        pulseaudio = {
          format = "{icon}";
          format-bluetooth = " {icon}";
          format-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          scroll-step = 1;
          on-click = "pavucontrol";
          ignored-sinks = [ "Easy Effects Sink" ];
          tooltip-format = "{volume}% - {desc}";
        };
      }
    ];
  };
}
