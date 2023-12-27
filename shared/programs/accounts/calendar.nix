{ pkgs, config, ... }:
{

  programs.khal = {
    enable = true;

    locale = {
      timeformat = "%I:%M %p";
      dateformat = "%Y-%m-%d";
      longdateformat = "%Y-%m-%d";
      datetimeformat = "%Y-%m-%d %I:%M %p";
      longdatetimeformat = "%Y-%m-%d %I:%M %p";

      firstweekday = 0;

      weeknumbers = "left";
    };
  };

  services.vdirsyncer = {
    enable = true;
  };

  programs.vdirsyncer = {
    enable = true;
  };

  accounts.calendar.accounts.main = {

    local = {
      fileExt = ".ics";
      type = "filesystem";
      path = "/data/nextcloud/.calendars";
    };

    remote = {
      type = "caldav";
      url = "https://220624z6bmfrl5nztze.nextcloud.hosting.zone/login";
      userName = "fabian.gubler@proton.me";
      passwordCommand = [
        "${pkgs.rbw}/bin/rbw"
        "get"
        "hosting"
      ];
    };

    khal = {
      enable = true;
      type = "discover";
    };

    vdirsyncer = {
      enable = true;
      collections = [ "from a" "from b" ];
      conflictResolution = "remote wins";
      metadata = [ "color" "displayname" ];
    };

  };

}
