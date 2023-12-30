{ pkgs, config, ... }:
{
  systemd.user.timers."trash-downloads" = {
    Unit = {
      Description = "Timer to trash downloads on boot";
    };
    Install = {
      wantedBy = [ "timers.target" ];
    };
    Timer = {
      OnBootSec = "5m";
    };
  };

  systemd.user.services."trash-downloads" = {
    Unit = {
      Description = "Service to trash downloads";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.trash-cli}/bin/trash ${config.home.homeDirectory}/Downloads/*'";
    };
  };
}
