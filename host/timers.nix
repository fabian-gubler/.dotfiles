{ config, pkgs, lib, ... }:

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
    path = with pkgs; [ newsboat ];
    script = ''
      		newsboat -x reload
    '';
  };

  # Trash Downloads on boot / daily
  systemd.timers."trash-downloads" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "1d";
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

  # Push dotfiles to Github on Boot / daily
  systemd.timers."push-dotfiles" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "1d";
      Unit = "push-dotfiles.service";
    };
  };

  systemd.services."push-dotfiles" = {
    serviceConfig = {
      Type = "oneshot";
      User = "${user}";
    };
    path = with pkgs; [ git ];
    script = ''
      	cd ${homeDirectory}/.dotfiles 
      	git add . 
      	git commit -m 'automated update' --allow-empty
      	(git push) || exit 0
    '';
  };

  # Push nix configuration to Github on Boot / daily
  systemd.timers."push-nix" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "1d";
      Unit = "push-nix.service";
    };
  };

  systemd.services."push-nix" = {
    serviceConfig = {
      Type = "oneshot";
      User = "${user}";
    };
    path = with pkgs; [ git ];
    script = ''
      	cd ${homeDirectory}/nixos-config
      	git add . 
      	git commit -m 'automated update' --allow-empty
      	(git push) || exit 0
    '';
  };

  # Push neovim configuration to Github on Boot / daily
  systemd.timers."push-neovim" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "1d";
      Unit = "push-neovim.service";
    };
  };

  systemd.services."push-neovim" = {
    serviceConfig = {
      Type = "oneshot";
      User = "${user}";
    };
    path = with pkgs; [ git ];
    script = ''
      		cd ${homeDirectory}/.config/nvim
      		git add . 
      		git commit -m 'automated update' --allow-empty
      		(git push) || exit 0
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
      trash-empty 30 -f
    '';
  };

}
