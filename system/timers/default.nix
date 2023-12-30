{ pkgs, ... }:

# TODO: Remove dependency on user <name>
let
  user = "fabian";
  homeDirectory = "/home/${user}";
in
{

  # Refresh newsboat in background
  systemd.timers."newsboat" = {
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
    path = with pkgs; [ newsboat ]; # necessary?
    script = ''
      		 ${pkgs.newsboat}/bin/newsboat -x reload
    '';
  };

  # Empty trash more than 30 days old every week
  systemd.timers."empty-trash" = {
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
      ${pkgs.trash-cli}/bin/trash-empty 30 -f
    '';
  };

  # Trash Downloads on boot
  # TODO: exit 1 status when Downloads directory is empty
  systemd.timers."trash-downloads" = {
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
      		${pkgs.trash-cli}/bin/trash ${homeDirectory}/Downloads/*
    '';
  };

}
