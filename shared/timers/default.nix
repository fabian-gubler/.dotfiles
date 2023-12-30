{ pkgs, ... }:

{

  #  Call with OnFailure = [ "send-notification@<service name>.service" ];
  imports = [
    ./trash-downloads.nix
    ./trash-empty.nix
  ];

  systemd.user.services."send-notification@" = {
    Unit = {
      Description = "Send Notification";
    };
    Install = {
      wantedBy = [ "multi-user.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.dunst}/bin/dunstify 'Systemd: %i failed'";
    };
  };



}
