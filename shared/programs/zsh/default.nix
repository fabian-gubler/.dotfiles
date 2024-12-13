{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = false; # impacts startup time by ~ 0.4s
    syntaxHighlighting.enable = true;
    shellAliases = {

      # Shorthands
      sv = "sudoedit";
      v = "${pkgs.neovim}/bin/nvim";
      gpush = "${pkgs.git}/bin/git add . && git commit -m 'manual update' && git push";
      k = "kubectl";
      lg = "${pkgs.lazygit}/bin/lazygit";
    };

    envExtra = ''
      export DIRENV_LOG_FORMAT=
    '';

    history = {
      size = 10000;
      path = "${config.home.homeDirectory}/.config/zsh/history";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "Aloxaf/fzf-tab"; }
        { name = "mafredri/zsh-async"; }
        { name = "chisui/zsh-nix-shell"; }
      ];
    };

    initExtra = '' 
	source ${pkgs.pure-prompt}/share/zsh/site-functions/prompt_pure_setup
	source ~/.dotfiles/shared/programs/zsh/prompt_fix
	PURE_CMD_MAX_EXEC_TIME=99999999999999
	zstyle ':prompt:pure:prompt:*' color "#D8DEE9"

	source ~/.dotfiles/shared/programs/zsh/lfcd.sh
	bindkey -e 
	bindkey -s '^f' 'lfcd\n'

	'';
  };
}
