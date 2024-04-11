{
  programs.waybar = {
    enable = false;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 22;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "pulseaudio" "battery" ];
        tray = { spacing = 10; };
        clock = {
          format = "{:%a %Y-%m-%d %H:%M}";
          tooltip-format = "<span size='9pt' font='Fragment Mono'>{calendar}</span>";
          on-click = "swaync-client -t";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "left";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#d8dee9'><b>{}</b></span>";
              days = "<span color='#d8dee9'><b>{}</b></span>";
              weeks = "<span color='#a3be8c'><b>W{}</b></span>";
              weekdays = "<span color='#81a1c1'><b>{}</b></span>";
              today = "<span color='#bf616a'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
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
            hands-free = "";
            headset = "";
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

        privacy = {
          icon-spacing = 4;
          icon-size = 18;
          transition-duration = 250;
          modules = [
            {
              type = "screenshare";
              tooltip = true;
              tooltip-icon-size = 24;
            }
            {
              type = "audio-out";
              tooltip = true;
              tooltip-icon-size = 24;
            }
            {
              type = "audio-in";
              tooltip = true;
              tooltip-icon-size = 24;
            }
          ];
        };
      }
    ];
    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: "Terminess Nerd Font";
          font-size: 16px;
          min-height: 0;
      }

      window#waybar {
          background: rgba(28,32,35, 0.8);
          color: white;
      }

      #window {
          font-weight: bold;
          font-family: "Terminess Nerd Font";
      }
      /*
      #workspaces {
          padding: 0 5px;
      }
      */

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: white;
          border-top: 2px solid transparent;
      }

      #workspaces button.active{
          color: white;
      	background: #285577;
          font-weight: bold;
          /* border-top: 2px solid #5e81ac; */
      }

      #mode {
          background: #64727D;
          border-bottom: 3px solid white;
      }

      #clock, #battery, #cpu, #memory, #network, #pulseaudio, #tray, #mode, #pulseaudio.muted {
          padding: 0 4px;
          margin: 0 6px;
      }

      #window, #workspaces {
          padding: 0 4px;
      }

      #clock {
          font-weight: bold;
      }

      #battery {
      }

      #battery icon {
          color: red;
      }

      #battery.charging {
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: black;
          }
      }

      #battery.warning:not(.charging) {
          color: white;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #cpu {
      }

      #memory {
      }

      #network {
      }

      #network.disconnected {
      }

      #pulseaudio {
      }

      #pulseaudio.muted {
      }


      #tray {
      }


    '';
  };
}
