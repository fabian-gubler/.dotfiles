{ config, pkgs, ... }: 
# TODO: Inherit these from default.nix
let
  user = "fabian";
  homeDirectory = "/home/${user}";
in
{

  # Push dotfiles to Github on Boot / daily
  systemd.timers."push-dotfiles" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "12h";
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

  # Push templates to Github on Boot / daily
  systemd.timers."push-templates" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "1d";
      Unit = "push-templates.service";
    };
  };

  systemd.services."push-templates" = {
    serviceConfig = {
      Type = "oneshot";
      User = "${user}";
    };
    path = with pkgs; [ git ];
    script = ''
      	cd ${homeDirectory}/templates
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

}
