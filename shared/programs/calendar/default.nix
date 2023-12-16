{ pkgs, config, ... }:
let
  # TODO: Make pure (remove hardcoding)
  urlStore = "/data/.dotfiles/shared/programs/calendar/files/get-url.sh";
  usernameStore = "/data/.dotfiles/shared/programs/calendar/files/get-username.sh";
  passStore = ''rbw", "get", "hosting'';

in
{
  imports = [
    ./modules/vdirsyncer.nix
  ];

  programs.zsh.shellAliases."vdirsyncer" = "vdirsyncer -c ${config.services.vdirsyncer.configFile}";

  services.vdirsyncer = {
    enable = false;
    settings = {
      general."status_path" = "${config.home.homeDirectory}/.config/vdirsyncer";

      # Description of Calendars
      "storage calendar_local" = {
        type = "filesystem";
        path = "/data/nextcloud/.calendars";
        fileext = ".ics";
      };
      "storage calendar_remote" = {
        type = "caldav";
        "url.fetch" = [ "command" "${urlStore}" ];
        "username.fetch" = [ "command" "${usernameStore}" ];
        "password.fetch" = [ "command" "${passStore}" ];
      };

      # Pair Events and Contacts
      "pair calendars" = {
        a = "calendar_local";
        b = "calendar_remote";
		conflict_resolution = "b wins";
        collections = [ "from a" "from b" ];
        metadata = [ "color" "displayname" ];
      };

      # Description of Contacts
      # "storage contacts_local" = {
      #   type = "filesystem";
      #   path = "/data/nextcloud/.contacts/";
      #   fileext = ".vcf";
      # };
      # "storage contacts_remote" = {
      #   type = "carddav";
      #   "url.fetch" = [ "command" "${urlStore}" ];
      #   "username.fetch" = [ "command" "${usernameStore}" ];
      #   "password.fetch" = [ "command" "${passStore}" ];
      # };
      # "pair my_contacts" = {
      #   a = "contacts_local";
      #   b = "contacts_remote";
      #   collections = [ "from a" "from b" ];
      # };

    };
  };
}
