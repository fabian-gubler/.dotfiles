{ pkgs, config, ... }:
{

  programs.khal = {
    enable = true;
    locale = {
      timeformat = "%H:%M";
      dateformat = "%d.%m.";
      longdateformat = "%d.%m.%Y";
      datetimeformat = " %d.%m. %H:%M";
      longdatetimeformat = "%d.%m.%Y %H:%M";
    };
    settings = {
      default = {
        show_all_days = true;
        timedelta = "1d";
      };
      view = {
        blank_line_before_day = true;
        event_view_always_visible = false;
        agenda_event_format = "{calendar-color}{start-end-time-style} {title}{repeat-symbol}{reset} {location}{reset}";
      };
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
      color = "dark blue";
    };

    vdirsyncer = {
      enable = true;
      collections = [ "from a" "from b" ];
      conflictResolution = "remote wins";
      metadata = [ "color" "displayname" ];
    };

  };

}
