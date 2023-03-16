{ config, pkgs, lib, ... }:

# TODO: Remove dependency on user <name>
let
  user = "fabian";
  homeDirectory = "/home/${user}";
in
{

  imports = [
    ./github.nix # push repos daily
  ];

  # Refresh newsboat in background
  systemd.user.timers."newsboat" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnStartupSec = "1m";
      OnUnitActiveSec = "30m";
      Unit = "newsboat.service";
    };
  };

  systemd.services."newsboat" = {
    serviceConfig = {
      Type = "oneshot";
      User = "${user}";
    };
    path = with pkgs; [ newsboat ];
    script = ''
      		newsboat -x reload
    '';
  };

  # Empty trash more than 30 days old every week
  systemd.user.timers."empty-trash" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly";
      Unit = "empty-trash.service";
    };
  };

  systemd.services."empty-trash" = {
    serviceConfig = {
      Type = "oneshot";
      User = "${user}";
    };
    path = with pkgs; [ trash-cli ];
    script = ''
      trash-empty 30 -f
    '';
  };

  # Trash Downloads on boot
  systemd.user.timers."trash-downloads" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      Unit = "trash-downloads.service";
    };
  };

  systemd.services."trash-downloads" = {
    serviceConfig = {
      Type = "oneshot";
      User = "${user}";
    };
    path = with pkgs; [ trash-cli ];
    script = ''
      		trash ${homeDirectory}/Downloads/*
    '';
  };


}
