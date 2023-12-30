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

      # can use ${pkgs.dunst}/bin/dunstify for all systems with dunst installed

      ExecStart = "notify-send 'Systemd: %i failed'";

      # Debug: Online Check

      # ExecStart = ''
      #   ${pkgs.bash}/bin/bash -c '\
      #     if ${pkgs.wget}/bin/wget -q --spider http://google.com; then \
      #       ${pkgs.dunst}/bin/dunstify "Systemd: %i failed"; \
      #     else \
      #       echo "Offline, not sending notification"; \
      #     fi \
      # '';
    };
  };



}
