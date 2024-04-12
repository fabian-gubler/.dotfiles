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
          on-click = "swaync-client -t";
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
            "default" = "󰧞";
          };
        };

        battery = {
          bat = "BAT0";
          interval = 10;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "󱐋 {icon} ";
          format-discharging = "{icon} ";
          format-icons = [ "" "" "" "" "" ];
          tooltip = true;
          tooltip-format = "{capacity}% - {timeTo}";
        };

        network = {
          interval = 5;
          format-wifi = "{icon}";
          format-ethernet = "󰌘";
          format-disconnected = "󰌙";
          tooltip = true;
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          tooltip-format-wifi = "{essid} ({signalStrength}%) at {ipaddr}";
          tooltip-format-ethernet = "{ifname}: {ipaddr}/{cidr}";
          on-click = "nm-connection-editor";
          on-click-right = "if [[ $(nmcli radio wifi) == 'enabled' ]]; then nmcli radio wifi off; else nmcli radio wifi on; fi";
        };

        pulseaudio = {
          format = "{icon}";
          format-bluetooth = " {icon}";
          format-muted = "󰸈";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" ];
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
