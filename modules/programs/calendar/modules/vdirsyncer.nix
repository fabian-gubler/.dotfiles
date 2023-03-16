{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.services.vdirsyncer;
  formatToUnknownFormat = settings:
    let
      quoteStr = s: ''"${s}"'';
      mkKeyValue = name: value:
        "${name} = ${mkValue value}";
      mkValue = value:
        if builtins.isList value then "[${concatStringsSep ", " (map mkValue value)}]"
        else if builtins.isString value then quoteStr value
        else (toString value);
      mkSection = title: val: ''
        [${title}]
        ${concatStringsSep "\n" (mapAttrsToList mkKeyValue val)}
      '';
    in
    concatStringsSep "\n" (mapAttrsToList mkSection settings);

  # Remove this once we can use the new config format
  cfgFile = pkgs.writeText "vdirsyncer.conf" (formatToUnknownFormat cfg.settings);

  configFileContents = formatToUnknownFormat cfg.settings;
in
{
  options.services.vdirsyncer = {
    enable = mkEnableOption "Enable synchronization of calendars";
    settings = mkOption {
      type = types.attrs;
    };
    # Modify this once we can use the new config format
    configFile = mkOption {
      type = types.path;
      default = cfgFile;
    };
    onBootSec = mkOption {
      type = types.str;
      default = "15min";
    };
    onUnitActiveSec = mkOption {
      type = types.str;
      default = "30min";
    };
  };


  config = mkIf cfg.enable {

    xdg.configFile = mkIf (versionAtLeast config.home.stateVersion "21.05") {
      "vdirsyncer/config".text = configFileContents;
    };

    systemd.user.timers.vdirsyncer = {
      Unit = {
        Description = "Timer to synchronize calendars";
      };

      Timer = {
        OnStartupSec = "1m";
        OnUnitActiveSec = "15m";
      };

      Install.WantedBy = [ "timers.target" ];
    };

    systemd.user.services.vdirsyncer = {
      Unit = {
        Description = "Synchronize your calendars";
        After = [ "network-online.target" ];
        Wants = [ "network-online.target" ];
      };

      Install.WantedBy = [ "default.target" ];

      Service = {
        ExecStart = "${pkgs.vdirsyncer}/bin/vdirsyncer sync";
        Type = "oneshot";
      };
    };
  };
}
