{ pkgs, ... }: {

  systemd.user.services."newsboat" = {
    Unit = {
      Description = "Run newsboat service";
      OnFailure = [ "send-notification@newsboat.service" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.newsboat}/bin/newsboat -x reload";
    };
  };

  systemd.user.timers."newsboat" = {
    Unit = {
      Description = "Run newsboat timer";
    };
    Install = {
      wantedBy = [ "timers.target" ];
    };
    Timer = {
      OnStartupSec = "5m";
      OnUnitActiveSec = "30m";
    };
  };

}
